Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6ABC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiFGHon convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiFGHon (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 03:44:43 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86262ED4A
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 00:44:40 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AFEF924002C
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 09:44:38 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LHMnH6QLKz6tnP
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 09:44:19 +0200 (CEST)
Date:   Tue, 07 Jun 2022 07:44:18 +0000
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_BlueZ_1/2=5D_a2dp=3A_disallow_mul?= =?US-ASCII?Q?tiple_SetConfiguration_to_same_local_SEP?=
In-Reply-To: <CABBYNZJ4f-wxZwPdYWzxQWHfG+x46HMiPZ=TmG7S74DGhPVW2A@mail.gmail.com>
References: <20220605122927.110627-1-pav@iki.fi> <CABBYNZJ4f-wxZwPdYWzxQWHfG+x46HMiPZ=TmG7S74DGhPVW2A@mail.gmail.com>
Message-ID: <4869E0D3-587C-4361-ABDE-12FE73C16390@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

7. kesäkuuta 2022 8.33.46 GMT+03:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com> kirjoitti:
>Hi Pauli,
>
>On Sun, Jun 5, 2022 at 9:47 PM Pauli Virtanen <pav@iki.fi> wrote:
>>
>> Using the remote SEP SetConfiguration DBus API, it's possible to make
>> multiple remote endpoints use the same local SEP, if they are endpoints
>> from different connected devices. This is invalid: successful
>> configuration shall prevent a different device configuring the same SEP
>> (AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the
>> AVDTP code that each SEP has at most a single stream, and causes
>> misbehavior later on (subsequent transport acquires fail with EPERM).
>
>Not sure I follow I follow why it would be invalid for a stack to
>enable connecting the same local SEP with different remote SEP, afaik
>this depends only if the underline codec does support multiple
>streams, as far I can remember the folks at BMW were actually the ones
>proposing such a change back in the days so perhaps something broke
>the proper support so we should be able to fix it. If, and only if,
>the codec itself don't support multiple simultaneous stream then it
>should reject the SetConfiguration by replying with an error.

My understanding here derives just from AVDTP spec 5.3 stating that "On successful termination of the configuration procedure, resources in both Device A and Device B shall be allocated (locked), and neither SEP v in Device A nor SEP z in Device B could be configured for another stream connection e.g. by a third device." which seems to forbid it. Maybe this reading is not correct?

It however doesnt't work (see below), and the SelectConfiguration mechanism explicitly skips in-use local endpoints (see avdtp_find_remote_sep), so it appears current code is not consistent on whether to allow it or not.

Technically, the problem is that struct avdtp_local_sep has only the struct avdtp_stream pointer, which just gets overwritten on every SetConfiguration. This later prevents acquiring the transport for the stream whose pointer is not there. stream_free will also set the pointer to NULL, so disconnecting one of the two devices breaks the other.

In principle if this is intended to work, the streams could just be looked up from the streams list instead, and one could just remove the reference in avdtp_stream. Also things like the inuse flag etc. shouldn't be shared, so it seems it needs a bit more work.

Things work when connecting to different adapters, as then the lsep is not the same.


Best,
Pauli




>
>> Fix this by first checking the SEP is free before proceeding in the DBus
>> API call.  Also add a sanity check in avdtp_set_configuration, to reject
>> configuring an already configured SEP similarly as in avdtp_setconf_cmd.
>> ---
>>
>> Notes:
>>     E.g. trying to set the same codec for two simultaneously connected
>>     devices for the same adapter in Pulseaudio, causes the A2DP
>>     connection of the first device stop working, as its transport
>>     acquires start failing with EPERM. Disconnecting the first device
>>     also breaks the second device connection.
>>     This patch fixes it so that only the invalid SetConfiguration fails.
>>
>>  profiles/audio/a2dp.c  | 5 +++++
>>  profiles/audio/avdtp.c | 3 +++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index 6f5b13711..f3e2cdd9e 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -1843,6 +1843,11 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
>>         GSList *l;
>>         int err;
>>
>> +       /* Check SEP not used by a different session */
>> +       if (lsep->stream && chan->session &&
>> +           !avdtp_has_stream(chan->session, lsep->stream))
>> +               return -EBUSY;
>> +
>>         setup = a2dp_setup_get(chan->session);
>>         if (!setup)
>>                 return -ENOMEM;
>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> index da4114e0f..bc7afad81 100644
>> --- a/profiles/audio/avdtp.c
>> +++ b/profiles/audio/avdtp.c
>> @@ -3523,6 +3523,9 @@ int avdtp_set_configuration(struct avdtp *session,
>>         if (!(lsep && rsep))
>>                 return -EINVAL;
>>
>> +       if (lsep->stream)
>> +               return -EBUSY;
>> +
>>         DBG("%p: int_seid=%u, acp_seid=%u", session,
>>                         lsep->info.seid, rsep->seid);
>>
>> --
>> 2.36.1
>>
>
>
