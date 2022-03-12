Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 01:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiCLB5a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 20:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLB5a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 20:57:30 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BFA2738CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 17:56:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g8so4912048qke.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfi+bTCXfqpw9uvIqrCKiFAYx08ePpQMftNlWEai8GI=;
        b=mmi7xLeMizQ9pqcmQrTJGMiaIqx7payr8WRD5COB9uOq5Rl6SSEc+fMBAAj+/z6ZiT
         brWs4DqIBz2pRGQcGP9nCuZoT43l00LGmAo7BUFILFNG9x+MdbB+DqxmBc+k6qfzHGok
         Taiw2rXQtxxYg1HxnAGxJiWzVLCwYlVUUeYTz5i/kBZwcPeGgdI2HaIYOMnnUZc0un9x
         phfCJkdOrOv5d+a6n463OvPH8/N9vxKziFEHXxveumuQYk6HGMEgUSRThTQ5HSwlR8qX
         FqcAUSHKpUvy82CBVYdczzAA6xryKl9ao/SkoqKdBAoWNNZhBitp31Smo7kytZYGI8Rv
         5ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfi+bTCXfqpw9uvIqrCKiFAYx08ePpQMftNlWEai8GI=;
        b=GOFO+RUAyUOUHGO00rbRCD/TKw9+ZrT7sfKrICLFujwQcFG/8K810PULiCjFxj8c1D
         7qRAHJUBVB0srq3F4H+dtdOVOS0ltJ7sPweOkcwMw9pdM8FBILoRbAzVgd6ujTiqwG3a
         nQ520LfSFJMmmGI7jSPNqo6QifxEGDU74e65zsFnhnocxlRO+ge5mNDvZgkIyEmI7KmH
         zYzdUGIxPEiogSM86VVTlFLVfSzon6vswk8u3JeJ+JIZrvhkQ+rAwc0FTGl63Keicofc
         A62qzlaIWeutvRocuZ7z0CSQgDC3z4M2biNxShE5xffjp5BoLWZjQmI2SZ7/uliGWjDn
         9v1g==
X-Gm-Message-State: AOAM532IUDsvSkpTrGxHbCmun/0tvPgl+1rQYxqpilLsRAYXNDJNTvPF
        HD4uQRviMuoIUYMPckLFNTLpwmpbVIpx3JfF2rYA/2NeK3E/lw==
X-Google-Smtp-Source: ABdhPJyDiBjfvy+DNPABDeJ8lQGZ/K1AJn+0jatIIIY6cpB4OWf7W40ok8GNidb/Vcxwmg2+MC6g3kJjZH+3FAe27Gg=
X-Received: by 2002:a05:620a:16c5:b0:67d:47db:8b50 with SMTP id
 a5-20020a05620a16c500b0067d47db8b50mr8486422qkn.77.1647050183941; Fri, 11 Mar
 2022 17:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20211201000215.1134831-13-luiz.dentz@gmail.com> <20220125144639.2226-1-mike@fireburn.co.uk>
In-Reply-To: <20220125144639.2226-1-mike@fireburn.co.uk>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 12 Mar 2022 01:56:13 +0000
Message-ID: <CAHbf0-FEVZZYg7U__YXqPmS=XETb2pObB-8CX+vh8=-HivppJA@mail.gmail.com>
Subject: Re: [PATCH 12/15] Bluetooth: hci_event: Use of a function table to
 handle HCI events
To:     luiz.dentz@gmail.com
Cc:     dan.carpenter@oracle.com, davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 25 Jan 2022 at 14:46, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> This patch is causing a lot of spam in my dmesg at boot until it seems my wifi connects (or perhaps the bluetooth manager does something)
>
> Bluetooth: hci0: unexpected event 0xff length: 5 > 0
>
> Thanks
>
> Mike

Hi

Has there been any movement on this issue?

I'm currently running with this patch locally to make the dmesg spam go away

From f786c85baac0ee93730998fa52cbd588c9f39286 Mon Sep 17 00:00:00 2001
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 25 Jan 2022 14:52:00 +0000
Subject: [PATCH] Remove excessive bluetooth warning

---
net/bluetooth/hci_event.c | 8 --------
1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc30f4c03d29..aa57fccd2e47 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6818,14 +6818,6 @@ static void hci_event_func(struct hci_dev
*hdev, u8 event, struct sk_buff *skb,
               return;
       }

-       /* Just warn if the length is over max_len size it still be
-        * possible to partially parse the event so leave to callback to
-        * decide if that is acceptable.
-        */
-       if (skb->len > ev->max_len)
-               bt_dev_warn(hdev, "unexpected event 0x%2.2x length: %u > %u",
-                           event, skb->len, ev->max_len);
-
       data = hci_ev_skb_pull(hdev, skb, event, ev->min_len);
       if (!data)
               return;
--
2.35.0
