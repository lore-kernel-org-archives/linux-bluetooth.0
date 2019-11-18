Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726DC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937862073A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPbkbyeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfKRIUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:20:40 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54837 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfKRIUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 03:20:39 -0500
Received: by mail-wm1-f54.google.com with SMTP id z26so16285497wmi.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mb29loYoB4Y663lLoIYeqHFFVeqbPYv8JqOLFAiWrO0=;
        b=ZPbkbyeKK5MUoNAFZrrlQNBNAyiuFtIhRdKBugJDmUqnoCXYoHlh7v076vr00hfdwM
         cA+8XoeAJUCqTo0JbmyzS3LLN2iqSTMCRVyqM2XsjTH4QRk+o79gt5yOLnQwz/RDD+Kw
         shI5Ssh12tqhehsGiSe8hCTrFVbLNqLu71UUGvxcxHYK6Y3CHTbJHuKY2cqSsNk2GeDf
         sFN3vN6wPe5eUJPlpgioIIQh+5V288zGG+1MxEh3oVuFPmAykCt8h7gqrsi66wtoMRgK
         IcAl45uyjfIGHYfiEB1W9rBtPDtXe6mCQHTzJybYp96fR3WH3AWhB47UHnGvJg9RHu70
         RTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mb29loYoB4Y663lLoIYeqHFFVeqbPYv8JqOLFAiWrO0=;
        b=RhojnMNEMKsGIMnjXa2YDSe4Kc2rjw67j/4Tkwp8VDtrwy4wPCds0l8JblLPtIg610
         bqJu7eSRvBtjgvDn//1CgrJMagLE5zzStkoX+q+fc9a223F5OrcpuRU8rfgB22RTIJyN
         +Eeqyulqur4tqp/mKFZYscbezgQHMk4iAPaQAcTssQSztoq7t7JwDCDhqi9uEupfNUSa
         25yaAefFv5Kpcw/S+1OrMVlpxljtMMYvVKInCwdjQx2gId6quic15U+o3sjgqmgo3MI/
         4FJAsBtKDp4FBe/DaTMAEZH9AVOXbw9rOv8nd+MjlnfYrWd8J8mXwFl3vQaL9Gp9AkGO
         MI9A==
X-Gm-Message-State: APjAAAVfmDqogY1hNWz6aj0U1wVvV2jgkDxMdsaRUJhprDFu+YsD+wvP
        oLnVxdzi2SmTvPbNio/HM7wTa+03
X-Google-Smtp-Source: APXvYqyCjlT3nO9Ok18PBn2bTfQ0g4DSpZCU4qDEpDzO0WMvxtcp1MBuJ2jwUyzr6EbYUSI/n7NAMA==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr29262949wmi.64.1574065237529;
        Mon, 18 Nov 2019 00:20:37 -0800 (PST)
Received: from mamamia.internal (a89-183-43-109.net-htp.de. [89.183.43.109])
        by smtp.gmail.com with ESMTPSA id a5sm21581506wrv.56.2019.11.18.00.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 00:20:36 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>
From:   Andre Heider <a.heider@gmail.com>
Subject: "local-[bd|mac]-address" inconsistency?
Message-ID: <57775d51-7de2-a32c-8b23-aba611483f51@gmail.com>
Date:   Mon, 18 Nov 2019 09:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

when passing both addresses through device-tree in the same way:
$ hexdump /proc/device-tree/soc/ethernet@5020000/local-mac-address
0000000 0702 3d96 53d4

$ hexdump /proc/device-tree/soc/serial@5000400/bluetooth/local-bd-address
0000000 0703 3d96 53d4

I get this for eth (which is consistent with u-boot):
link/ether 02:07:96:3d:d4:53

But for bt it's in reverse order:
Controller 53:D4:3D:96:07:03

Is this intended? Do I really have to pass the bdaddr from u-boot in 
another way?

Regards,
Andre
