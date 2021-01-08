Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA904C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 01:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B220236F9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbhAHBaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Jan 2021 20:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbhAHBaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Jan 2021 20:30:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35257C0612F4
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Jan 2021 17:29:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x13so8222857oto.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Jan 2021 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1iDtnZLnMZ+LAyxFvRucm93/gMYBxqAJTeT+uP1BCs=;
        b=GZsMIRLHKiPtKK1WULLcckA45NGpH9sCBq8VWB+DvvBweioKut6d0QUF9X+D0NHRjT
         n2gdpCbkfNIHh/V2O1UwTV+q3Y5yAHlpeW9ZJMLYjk2eLYNPjYSQmQb1jjdOLUX0RcM4
         F6gloG0woc76yEKWaoyHoyYhXvJG1ruP+E5ejo1BcM97jgxrslTaCS7UmHLepvujbi4L
         d4+TT0unMcf1LBR/zGCVOXMMi6u20c+R8blsjnm2E9E4wegnyLcoNu8StNTUkJsXM4r1
         rtGksw0bNST6wPJT+CoW5S/YEis2dVAoM+35YU7exv6K9uWXb7zGAJeBJzV0EU1BtwK+
         ncww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1iDtnZLnMZ+LAyxFvRucm93/gMYBxqAJTeT+uP1BCs=;
        b=MXtLjjmjKSfMp6AH7IXqN5vXX42iIqZpVTePtYUNF8IIDqI7v2sSK62hIL+W+27idu
         F5FUjLfq+WGEKvdTtWgBPRCBYbZOl8xHwPGqjuCaHuJDv4KB/ZrKBpuP5Ss8VRHWvZXI
         NgESrhCFX7lQ62fcv8lqUhFDZiXTMWTK94wq8N8ZjmRcD1XcdMlEzO5wdNJxJvTk1xcm
         5aBHO//LUXGwG/qSN8LDyFHxZ97QrHvkSOsmANNFH28+kOC7qV+cabdVSYSVSC0XEUZH
         jgx8gAASS3QI9wiw7vGlKDyyUF3xhmuy+vdlnLiaR8sqzcUXxWOVdF+bfgg+swwPbOWi
         x2Hw==
X-Gm-Message-State: AOAM533CP54jphioTOrMwdGmlLwzdVybfEVQfqnnyJeoD4WCsx6Ibn0W
        YxgJX+LnFFTfi8CFq1gKW3LEDYHtudp9JQhkxk4=
X-Google-Smtp-Source: ABdhPJxVuNoMSlhblg8LJnPf4VtxtF3MM2HoJJpfH/j/YS9c/1qubipCOSw4lbaDO3H7l84WE3m5WpSTnm3qHivDujY=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr943607ota.44.1610069373577;
 Thu, 07 Jan 2021 17:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20201208172912.4352-1-hadess@hadess.net>
In-Reply-To: <20201208172912.4352-1-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Jan 2021 17:29:22 -0800
Message-ID: <CABBYNZ+41BSkQEGbXsemCgWQhmaEjB3KOkLrFyOjv_=_zMQy_Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not knowing options
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Dec 8, 2020 at 9:36 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> The current implementation of L2CAP options negotiation will continue
> the negotiation when a device responds with L2CAP_CONF_UNACCEPT ("unaccepted
> options"), but not when the device replies with L2CAP_CONF_UNKNOWN ("unknown
> options").
>
> Trying to continue the negotiation without ERTM support will allow
> Bluetooth-capable XBox One controllers (notably models 1708 and 1797)
> to connect.
>
> btmon before patch:
> > ACL Data RX: Handle 256 flags 0x02 dlen 16                            #64 [hci0] 59.182702
>       L2CAP: Connection Response (0x03) ident 2 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 256 flags 0x00 dlen 23                            #65 [hci0] 59.182744
>       L2CAP: Configure Request (0x04) ident 3 len 15
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > ACL Data RX: Handle 256 flags 0x02 dlen 16                            #66 [hci0] 59.183948
>       L2CAP: Configure Request (0x04) ident 1 len 8
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1480
> < ACL Data TX: Handle 256 flags 0x00 dlen 18                            #67 [hci0] 59.183994
>       L2CAP: Configure Response (0x05) ident 1 len 10
>         Source CID: 64
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1480
> > ACL Data RX: Handle 256 flags 0x02 dlen 15                            #69 [hci0] 59.187676
>       L2CAP: Configure Response (0x05) ident 3 len 7
>         Source CID: 64
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         04                                               .
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                            #70 [hci0] 59.187722
>       L2CAP: Disconnection Request (0x06) ident 4 len 4
>         Destination CID: 64
>         Source CID: 64
> > ACL Data RX: Handle 256 flags 0x02 dlen 12                            #73 [hci0] 59.192714
>       L2CAP: Disconnection Response (0x07) ident 4 len 4
>         Destination CID: 64
>         Source CID: 64
>
> btmon after patch:
> > ACL Data RX: Handle 256 flags 0x02 dlen 16                          #248 [hci0] 103.502970
>       L2CAP: Connection Response (0x03) ident 5 len 8
>         Destination CID: 65
>         Source CID: 65
>         Result: Connection pending (0x0001)
>         Status: No further information available (0x0000)
> > ACL Data RX: Handle 256 flags 0x02 dlen 16                          #249 [hci0] 103.504184
>       L2CAP: Connection Response (0x03) ident 5 len 8
>         Destination CID: 65
>         Source CID: 65
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 256 flags 0x00 dlen 23                          #250 [hci0] 103.504398
>       L2CAP: Configure Request (0x04) ident 6 len 15
>         Destination CID: 65
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > ACL Data RX: Handle 256 flags 0x02 dlen 16                          #251 [hci0] 103.505472
>       L2CAP: Configure Request (0x04) ident 3 len 8
>         Destination CID: 65
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1480
> < ACL Data TX: Handle 256 flags 0x00 dlen 18                          #252 [hci0] 103.505689
>       L2CAP: Configure Response (0x05) ident 3 len 10
>         Source CID: 65
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1480
> > ACL Data RX: Handle 256 flags 0x02 dlen 15                          #254 [hci0] 103.509165
>       L2CAP: Configure Response (0x05) ident 6 len 7
>         Source CID: 65
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         04                                               .
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                          #255 [hci0] 103.509426
>       L2CAP: Configure Request (0x04) ident 7 len 4
>         Destination CID: 65
>         Flags: 0x0000
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                          #257 [hci0] 103.511870
>       L2CAP: Connection Request (0x02) ident 8 len 4
>         PSM: 1 (0x0001)
>         Source CID: 66
> > ACL Data RX: Handle 256 flags 0x02 dlen 14                          #259 [hci0] 103.514121
>       L2CAP: Configure Response (0x05) ident 7 len 6
>         Source CID: 65
>         Flags: 0x0000
>         Result: Success (0x0000)
>
> Signed-off-by: Florian Dollinger <dollinger.florian@gmx.de>
> Co-developed-by: Florian Dollinger <dollinger.florian@gmx.de>

Reviewed-by: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>

> ---
>  net/bluetooth/l2cap_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1ab27b90ddcb..3ab95ea2cd80 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4513,6 +4513,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
>                 }
>                 goto done;
>
> +       case L2CAP_CONF_UNKNOWN:
>         case L2CAP_CONF_UNACCEPT:
>                 if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
>                         char req[64];
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
