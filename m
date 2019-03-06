Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36629C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD8220684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 13:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3KVCIhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCFNsk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:48:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCFNsk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 08:48:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so5989276wmj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uLOdgv1MuXzIgX0Xy8/LMcULoICiekYSYRcBghZYwXk=;
        b=n3KVCIhd/8DKlIrtHzky2A3sbGNNhO8CC4izMnWpHXPVYEiDKZkOAa6ktneoFWeYOW
         E24I/OtWLj8uE+dc5w+0TubR3wr3dM7lvrgFHIBxGM/74v+kzI1+2pLSqVczjrwzyuUB
         SdTsR+TKuKhLpfmA2gkLSltRmfju7UJg8kYhv2NC0ofmMKLUyxYJH/9AIlUexJchwKeO
         X703lc69MTDPTUuJHtQ4qUBmnzDoLuMSYqqEAie0gXd9oxeVRRO/OlHqxYDIUBEthFmt
         ILTJrr4xsWb4P5utZuJpLdRk41MWvq59VwPrndioiZZP1C8lRM6XvaFKlpd8PvyukrXn
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uLOdgv1MuXzIgX0Xy8/LMcULoICiekYSYRcBghZYwXk=;
        b=V9rRqTuFqoKvTBCmby2Ga9PnveQo5LvNBNbqjKFvEQ61OLsUEwGpeID7u1xn5TEVuX
         n64f9ud8VMt6Eyo+iqMyk7V9DIhlrD94LcuK7zZPUyD+mL20pbpsxOclLvM/cu7VEMLN
         RrTDZNTWP7/cNF4xzF0sdJN4HDxLJA3Nvg6eOQyCOrZ3zl9UhOAkl/o29+BJqOa/8qLX
         uKgfQvLfBvREicf0Sj07jwNXPUQNHlUT7f4b89bilXwR8DJa+n9BOR7WuxZLSsmiKV9P
         SHxCcPZE7qlWa7ssyQAYicVdl619rVBseIvDIgNpp+1tgiCAX6CbVQ9RJzTVH1KsYEdG
         8gow==
X-Gm-Message-State: APjAAAV1iWS4wjbaqXzc23j/JGkq+QE0/3MHQ/GyGeMm6/ppkB4GATCq
        6umYu0GCIBtBEKZqzpbn7/0Ub5gh
X-Google-Smtp-Source: APXvYqzc+d4eMAJi4oiRro1bx6ZV8yRW3u6ZbHYIBMZEPYpg/vX+QpGq+j/QSqDjemj1yteat0VkGQ==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr2321401wmj.130.1551880117467;
        Wed, 06 Mar 2019 05:48:37 -0800 (PST)
Received: from [192.168.0.1] (cpc149624-rdng29-2-0-cust819.15-3.cable.virginm.net. [82.15.3.52])
        by smtp.googlemail.com with ESMTPSA id n189sm2003699wmb.28.2019.03.06.05.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 05:48:35 -0800 (PST)
Subject: Re: Error setting UUIDs discovery filter on big endian systems
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
 <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
 <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com>
 <b6ae709c-e62a-9c03-7abb-a8b4800361e6@gmail.com>
 <CABBYNZL2F3JaZA27azU8Z2OZ_4CsnosT+Scsrhn9YAA-3i=iaQ@mail.gmail.com>
From:   Matt <mwtaylor@gmail.com>
Message-ID: <a90cfd1f-95aa-6b2e-9aab-66d5b950bb59@gmail.com>
Date:   Wed, 6 Mar 2019 13:48:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZL2F3JaZA27azU8Z2OZ_4CsnosT+Scsrhn9YAA-3i=iaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/03/2019 11:10, Luiz Augusto von Dentz wrote:
> Looks like the kernel is indeed assuming the length is in LE:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3958

Thanks for pointing me to this line, removing the __le16_to_cpu() does 
seem to fix the UUIDs filter scanning on my big endian hardware, I'm not 
sure why it is needed, perhaps removing it would break LE hardware or 
some other case but I would imagine __le16_to_cpu() would do nothing in 
the LE case anyway. I have made this patch to my kernel (4.9) that seems 
to be all is needed for me to fix the issue (no changes to bluez):

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba24f61..507d996 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3599,7 +3599,7 @@ static int start_service_discovery(struct sock 
*sk, struct hci_dev *hdev,
          goto failed;
      }

-    uuid_count = __le16_to_cpu(cp->uuid_count);
+    uuid_count = cp->uuid_count;
      if (uuid_count > max_uuid_count) {
          BT_ERR("service_discovery: too big uuid_count value %u",
                 uuid_count);


