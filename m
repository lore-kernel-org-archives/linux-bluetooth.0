Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375AEC2F3A1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088E92085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQiWXgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfAUMeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:34:20 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35459 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfAUMeU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 07:34:20 -0500
Received: by mail-ot1-f50.google.com with SMTP id 81so20425210otj.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7m8ivCsbM5PykLuhiK4CiNU6fqL97SimaS/2fT/R4NI=;
        b=cQQiWXgqN5Hi7EhjcB9wcpA/KI1n+xIeBuGNFQ/ixWcyp83JjLkkJnAkUbG/aRy1gB
         qeCAaKRaS1ESSODTs6KpcMFaepBMn83o5SM4g8KO18xdubju8up5c5Z5d274FSrleL9E
         oO678eH+DpipGQndgK2NYJ6I4Ay+VeDXq0IpEOrbeCImc1qpAMEDptVyUcRALWsWl1FS
         5uwg3fAP9EOr7A7i6ICRPluBit1tUcdNKwoYo3YkwJK+K4O1Eb16mDbNptaL2Y4rmEw+
         35XffkYNdi0HDRojcq4qYEfDcF6sTmnxJdph72t89DfB/mOBaerPB+8L7b9Dt0Cuu48V
         UDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7m8ivCsbM5PykLuhiK4CiNU6fqL97SimaS/2fT/R4NI=;
        b=nqbNUOdl5SdJVTa9t/31Nr/MiwkA5GBalG68NvMyHAltbPIQl9JhiUtNtfGXPaqT3x
         9YX7jpf28YKPQ5U2ylTtEHT0NcU3OgorDJue4eGrEC3baN/WC/uMq75XKwZ9qhwj7ZFF
         0Qit8wKM8dr83Rscff6Wc46lDab+fFc6D8c1Nu/D6wRqHmVT4XgNQVQw8WdhFxQatqVB
         gdtEVu7cyPeGPpzxAYezD9vej8FGmHFrCxeIBKTjGLG+EmIXGjXtFS15Jm8wStvvC8Oh
         7fMRPph9tAawJKFJK7U113ajpKSy5upBDSzxTz1miEIfTzOaGT07ipLvUzeC99Ka6ZJL
         UBAQ==
X-Gm-Message-State: AJcUukcEmLKHHHEHnOTrFC4mrOD0fh/GZ2taL500J4SIqsemhTso3pLB
        WZ0UkyMd8jaQJG7bWN/TbWEwBrU72HTwNDXU0S4=
X-Google-Smtp-Source: ALg8bN7nks/57u/qRBe7bYvy9mdC+lsXGUJNkLfRjbdx108LYeKtrB3X+Ak3jbEoqzNaHDDmqdgGhcxSiun26IqpgDM=
X-Received: by 2002:a9d:3426:: with SMTP id v35mr20886817otb.71.1548074059410;
 Mon, 21 Jan 2019 04:34:19 -0800 (PST)
MIME-Version: 1.0
References: <e66fded8-91ee-6cb9-11be-162dd5c436aa@cisco.com>
In-Reply-To: <e66fded8-91ee-6cb9-11be-162dd5c436aa@cisco.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jan 2019 14:34:06 +0200
Message-ID: <CABBYNZKhXUBp6e6DLxb4ZPZ66scScUU4N6CbzYCJ=dqQmakVXg@mail.gmail.com>
Subject: Re: Disconnection of signaling channel after AVDTP close
To:     =?UTF-8?Q?Per_Waag=C3=B8?= <pwaago@cisco.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Per,

On Thu, Jan 17, 2019 at 9:19 AM Per Waag=C3=B8 <pwaago@cisco.com> wrote:
>
> We have a product that implements an A2DP sink running bluez 5.50. I'm
> try to qualify this product with the Bluetooth SIG using the Profile
> Tuning Suite (PTS), but I am having trouble passing a test that verifies
> reported delay value (A2DP/SNK/SYN/BV-01-C).
>
> In that test, PTS configures an AVDTP stream and verifies the delay
> report, then opens the stream, streams some data and closes the stream.
> This is repeated. The problem seems to be that after the stream is
> closed, bluez immediately also closes the L2CAP signaling channel.
>
> I have pasted the problematic sequence from btmon at the bottom of this
> email, the problem is the last L2CAP Disconnection request.
>
> This was introduced with commit 7ece89b0b6 between version 5.47 and
> 5.48. Before that, there was always a one second delay before the
> signaling channel was disconnected,
> which was enough for PTS to configure a new stream.
>
> What was the rationale for always disconnecting immediately? Could there
> be circumstances where it would make sense to keep the signaling channel
> open a bit longer? Is there any other way we can force the channel to
> stay open?

Could you please try to check with the patch Ive just sent? That
should track who has closed/aborted the stream so in case the remote
have done it will set a timeout before destroying the session.


> Best regards,
> Per Waag=C3=B8
>
> --
>  > ACL Data RX: Handle 12 flags 0x02 dlen 7                #329 [hci0]
> 48.732441
>        Channel: 64 len 3 [PSM 25 mode 0] {chan 0}
>        AVDTP: Close (0x08) Command (0x00) type 0x00 label 2 nosp 0
>          ACP SEID: 1
> < ACL Data TX: Handle 12 flags 0x00 dlen 6                #330 [hci0]
> 48.732775
>        Channel: 64 len 2 [PSM 25 mode 0] {chan 0}
>        AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 2 nosp =
0
>  > ACL Data RX: Handle 12 flags 0x02 dlen 310              #331 [hci0]
> 48.736692
>  > ACL Data RX: Handle 12 flags 0x01 dlen 337              #332 [hci0]
> 48.771536
>        Channel: 65 len 643 [PSM 25 mode 0] {chan 1}
>  > ACL Data RX: Handle 12 flags 0x02 dlen 12               #333 [hci0]
> 48.771963
>        L2CAP: Disconnection Request (0x06) ident 30 len 4
>          Destination CID: 65
>          Source CID: 65
> < ACL Data TX: Handle 12 flags 0x00 dlen 12               #334 [hci0]
> 48.772019
>        L2CAP: Disconnection Response (0x07) ident 30 len 4
>          Destination CID: 65
>          Source CID: 65
> < ACL Data TX: Handle 12 flags 0x00 dlen 12               #335 [hci0]
> 48.772960
>        L2CAP: Disconnection Request (0x06) ident 4 len 4
>          Destination CID: 64
>          Source CID: 64
>  > HCI Event: Number of Completed Packets (0x13) plen 5    #336 [hci0]
> 48.778131
>          Num handles: 1
>          Handle: 12
>          Count: 2
>  > HCI Event: Number of Completed Packets (0x13) plen 5    #337 [hci0]
> 48.953264
>          Num handles: 1
>          Handle: 12
>          Count: 1
>  > HCI Event: Disconnect Complete (0x05) plen 4            #338 [hci0]
> 50.167143
>          Status: Success (0x00)
>          Handle: 12
>          Reason: Remote Device Terminated due to Power Off (0x15)
>


--
Luiz Augusto von Dentz
