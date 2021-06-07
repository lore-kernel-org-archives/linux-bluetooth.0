Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10949C47082
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 22:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57CB610A1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 22:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFGWzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:55:53 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:40741 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGWzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 18:55:52 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 18:55:52 EDT
Received: from [10.0.20.6] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AD0851F5FD;
        Tue,  8 Jun 2021 00:46:51 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress
 one.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
Message-ID: <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
Date:   Tue, 8 Jun 2021 00:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz, Sonny,

On 6/7/21 11:16 PM, Luiz Augusto von Dentz wrote:
> Hi Sonny,
> 
> On Mon, Jun 7, 2021 at 1:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>>
>> SetAbsoluteVolume command may receive late response for Target Device
>> that have high latency processing. In that case we may send the next
>> SetAbsoluteVolume commands before the previous SetAbsoluteVolume
>> response is received. This causes the media transport volume to jitter.
> 
> You have to explain better what is the situation here, does the upper
> layer queue several volume changes in a row and why? If this is coming
> from different entities then there is obviously a conflict, but I
> think we only allow the volume to changed from the entity that is
> handling the A2DP stream.


We've been running into a similar issue with PulseAudio.  There is no 
way to track a Set call for the Volume property back to the 
property-change notification, running into both jitter on quick 
successive volume changes and the inability to reflect peer hardware 
volume in case the peer rounds the requested volume to a coarser scale. 
  This rounded value is supposedly returned from SetAbsoluteVolume 
according to AVRCP spec 1.6.2, section 6.13.2:

    The volume level which has actually been set on the TG is returned in
    the response.

I would have proposed a new DBUS function SetAbsoluteVolume that accepts 
volume as sole argument, blocks until the peer replies, and returns the 
actual volume as per its namesake AVRCP command.  This should address 
both issues.

Note that it is also impossible to distinguish Volume property changes 
from an action invoked on the peer (ie. the user pressing physical 
buttons or using a volume slider on headphones) or the result of an 
earlier Set(Volume) call as these to my knowledge all happen async, may 
be intertwined, may involve rounding (on the peer) to make the resulting 
number different, etc.

> 
>> The solution in this patch is to not send any SetAbsoluteVolume command
>> if there is an in-progress one. Instead we should queue this command to
>> be executed after the in-progress one receives the response.
>>
>> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
>> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>>
>> ---
>>   profiles/audio/avrcp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index ccf34b220..c6946dc46 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -256,6 +256,11 @@ struct avrcp_data {
>>          GSList *players;
>>   };
>>
>> +struct set_volume_command {
>> +       uint8_t volume;
>> +       bool notify;
>> +};
>> +
>>   struct avrcp {
>>          struct avrcp_server *server;
>>          struct avctp *conn;
>> @@ -275,6 +280,12 @@ struct avrcp {
>>          uint8_t transaction;
>>          uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
>>          struct pending_pdu *pending_pdu;
>> +       // Whether there is a SetAbsoluteVolume command that is still waiting
>> +       // for response.
>> +       bool is_set_volume_in_progress;
>> +       // If this is non-null, then we need to issue SetAbsoluteVolume
>> +       // after the current in-progress SetAbsoluteVolume receives response.
>> +       struct set_volume_command *queued_set_volume;
>>   };
>>
>>   struct passthrough_handler {
>> @@ -4252,6 +4263,24 @@ static void target_destroy(struct avrcp *session)
>>          g_free(target);
>>   }
>>
>> +void update_queued_set_volume(struct avrcp *session, uint8_t volume,
>> +                               bool notify)
>> +{
>> +       if (!session->queued_set_volume)
>> +               session->queued_set_volume = g_new0(struct set_volume_command,
>> +                                                       1);
>> +       session->queued_set_volume->volume = volume;
>> +       session->queued_set_volume->notify = notify;
>> +}
>> +
>> +void clear_queued_set_volume(struct avrcp *session)
>> +{
>> +       if (!session->queued_set_volume)
>> +               return;
>> +       g_free(session->queued_set_volume);
>> +       session->queued_set_volume = NULL;
>> +}
>> +
>>   static void session_destroy(struct avrcp *session, int err)
>>   {
>>          struct avrcp_server *server = session->server;
>> @@ -4295,6 +4324,8 @@ static void session_destroy(struct avrcp *session, int err)
>>          if (session->browsing_id > 0)
>>                  avctp_unregister_browsing_pdu_handler(session->browsing_id);
>>
>> +       clear_queued_set_volume(session);
>> +
>>          g_free(session);
>>   }
>>
>> @@ -4486,6 +4517,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
>>          struct avrcp_header *pdu = (void *) operands;
>>          int8_t volume;
>>
>> +       session->is_set_volume_in_progress = false;
> 
> I rather have a volume and volume_pending with the respectively
> current volume and volume change in progress, if notification comes
> with volume_pending then we are done otherwise we need to send another
> command, only the last volume_pending is tracked so we don't have to
> queue anything since changes done in between would be override only
> the last volume change matters.
> 
>>          if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
>>                                                                  pdu == NULL)
>>                  return FALSE;
>> @@ -4495,6 +4528,13 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
>>          /* Always attempt to update the transport volume */
>>          media_transport_update_device_volume(session->dev, volume);
>>
>> +       if (session->queued_set_volume) {
>> +               avrcp_set_volume(session->dev,
>> +                                       session->queued_set_volume->volume,
>> +                                       session->queued_set_volume->notify);
>> +               clear_queued_set_volume(session);
>> +       }
> 
> Here it would be something like:
> 
>    if (session->volume_pending != -1) {
>      if (session->volume_pending != volume)
>        avrcp_set_volume(session->dev, session->volume_pending, true);
>      else
>        session->volume_pending = -1;
>    }
> 
> Though there is a problem with the above, if for some odd reason the
> device don't notify the exact volume we requested this will lead the
> an endless loop since the volume would never match.
> 
>> +
>>          if (player != NULL)
>>                  player->cb->set_volume(volume, session->dev, player->user_data);
>>
>> @@ -4570,6 +4610,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
>>          if (session == NULL)
>>                  return -ENOTCONN;
>>
>> +       // If there is an in-progress SetAbsoluteVolume, just update the
>> +       // queued_set_volume. Once the in-progress SetAbsoluteVolume receives
>> +       // response, it will send the queued SetAbsoluteVolume command.
>> +       if (session->is_set_volume_in_progress) {
> 
> Let do something like the following:
> 
>    if (session->volume_pending != -1 && session->volume_pending != volume) {
>      session->volume_pending = value;
>      return 0;
>     }
> 
>> +               update_queued_set_volume(session, volume, notify);
>> +               return 0;
>> +       }
>> +
>>          if (notify) {
>>                  if (!session->target)
>>                          return -ENOTSUP;
>> @@ -4589,6 +4637,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
>>          pdu->params[0] = volume;
>>          pdu->params_len = htons(1);
>>
>> +       session->is_set_volume_in_progress = TRUE;
>>          return avctp_send_vendordep_req(session->conn,
>>                                          AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
>>                                          buf, sizeof(buf),
>> --
>> 2.31.0
>>
> 
> 
> --
> Luiz Augusto von Dentz
> 

- Marijn
