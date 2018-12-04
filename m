Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FAC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4662082B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 19:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYGTsLPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4662082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeLDTwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:52:04 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34012 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDTwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 14:52:04 -0500
Received: by mail-ot1-f47.google.com with SMTP id t5so16413798otk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIHG6BFvRmqx61ngPQw26JTUezuj178TfwAKVUUmRQY=;
        b=BYGTsLPVKJIaYB0DCb75cL/MocqRi4uaK8r9Rs/z4Y9ftyjXd9J1xS1Rqy/BhCmL61
         33qO1JmMxfjrx2Zr7HedpTCYzaTMC6kvi/yRj0rj0BNiQGAPnAF7i+71xJg3pVQ1Z6wW
         s7IJTP5VqjmvBuo6gYDzXNU7ecI4ApLn8qwkpNiBDU0VtHd4P6WI9eUK18gM1vlJ4rRL
         yfwMIUzmXkUZBV+5QpQDzgnwK/O1Zi70Oj/1IPFT+WM5+Hg2RBmEVPx5/xN5kvmEwh0U
         XVqkNIZPz1ADxrMXrQxvA+VG08oX9ohroTXuhFceRo7WzdgVfwuRNP0nAHOpxK7oVaDQ
         WdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIHG6BFvRmqx61ngPQw26JTUezuj178TfwAKVUUmRQY=;
        b=j2mC+IaecgylpWs0oiPUdm+yk+sO9YH7gmT9e8AJ7C4NqtqpY7LbroFyTU5TQhZDjY
         r0+2SVdzkky/MW71NxtSw/LUNn1G47vWomuTXrdc9YwtruEgAqhaqcOU45EnFD6OrY3p
         GgizJqSKbi/WV2pRe0zm5W62UDGdqE1+wojeSHhNFY94hRp4a3nbHea5DCFksGjr4YJu
         TpPNpg1DFKIb5ZTMI26D6vuZhTsLBpTvmz9iXM0Ul/WRzTiis57z93JpQ/8YL0TTCV2w
         rfI0QC1FUEbPNb2H188avEMR2jMfJ7zQNXzfhpPwlL9VvPr6SQenui0932wtkMAJ7xtt
         TE8w==
X-Gm-Message-State: AA+aEWYbpOBXmGkqWMDzx195UTgjrgvkYyJW1Yb/gQKB+eJWf+PPpiKL
        K1gxveA93QdlgAGPxNxle0vSkN4q/VmO+ZH4WHG0mPF/
X-Google-Smtp-Source: AFSGD/WwYE/6FKCkcacoXXxa8bjDKYWCBnaW8OrfPac4lz6G3mibfGf42jyN3bW7XlWtvSupVygXSxJHST5Xo/cH+8s=
X-Received: by 2002:a9d:3213:: with SMTP id t19mr14732623otc.71.1543953123342;
 Tue, 04 Dec 2018 11:52:03 -0800 (PST)
MIME-Version: 1.0
References: <BN6PR19MB0050F4179F4EF725CF779C3DD0AE0@BN6PR19MB0050.namprd19.prod.outlook.com>
In-Reply-To: <BN6PR19MB0050F4179F4EF725CF779C3DD0AE0@BN6PR19MB0050.namprd19.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Dec 2018 21:51:50 +0200
Message-ID: <CABBYNZKgUygfM=AjwrfWpJ2i_Nrot2QQbyzsvjQguRw5Ww6=1A@mail.gmail.com>
Subject: Re: BlueZ 5.50 not including GATT and GAP UUIDs in SDP list
To:     TSutter@efji.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Trevor,
On Mon, Dec 3, 2018 at 8:06 PM Trevor Sutter <TSutter@efji.com> wrote:
>
> Hello,
>
> I am using BlueZ 5.50 on Linux 4.12.0 running in dual mode (BR/EDR and BLE).
>
> I recently upgraded from Bluez 5.46 and after doing so, I noticed that the GATT (1801) and GAP (1800) UUIDs are no longer getting added to my SDP list.
> I looked through the source file history and, as far as I can tell, changes made to /src/gatt-database.c for commit 109b9fa51bfcd8d15143003729cf4c730c39fe72 (gatt: Add all services as records) are responsible.
>
> On startup we call:
> btd_gatt_database_new() , which calls register_core_services() and gatt_db_register(), respectively.
>
> register_core_services() needs the gatt_db_service_added() callback to be registered by gatt_db_register() in order to add the GATT/GAP services to the SDP list, since it is called first, no callback is executed.
>
> See the following call stack:
>
> register_core_services
> populate_gap_service/ populate_gatt_service
> gatt_db_service_set_active
> notify_service_changed -> gatt db will not be in the notify_list, no callback.
>
> I am not very familiar with the gatt/db code in BlueZ, but as a quick test, I inverted the order of the register_core_services() and gatt_db_register() calls and I now have the GATT and GAP entries in my SDP list.
>
> I would like confirmation that this is actually a bug, and that I do not have something else misconfigured.
> And, if it is a bug, I would appreciate input on whether or not this is the correct fix.

Thanks for the report, Ive sent a fix for it, let me know if you have
any feedback about it.

-- 
Luiz Augusto von Dentz
