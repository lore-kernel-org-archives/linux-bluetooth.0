Return-Path: <SRS0=L2xa=NJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E276C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 04:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C92080A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 04:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8C92080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.zabtrans.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeJ2Nm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Oct 2018 09:42:26 -0400
Received: from ns.zabtrans.ru ([195.39.228.131]:55858 "EHLO carat.zabtrans.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbeJ2Nm0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Oct 2018 09:42:26 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 09:42:25 EDT
Received: from proxy.zrw.oao.rzd (proxy.zabtrans.ru [195.39.228.154]) 
        by carat.zabtrans.ru ASSAMail sm-mta  with ESMTPS id w9T4kMBV016129
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 13:46:27 +0900
Received: from [10.123.236.115] ([10.123.236.115]) 
        by proxy.zrw.oao.rzd ASSAMail sm-mta-lst  with ESMTP id w9T4kLD6008750
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 13:46:21 +0900
From:   =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Non intheractive request pin-code
Reply-To: ProklovAV@mail.zabtrans.ru
References: <5B7F662D.5010903@mail.zabtrans.ru>
 <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Message-ID: <5BD69EE1.7080903@mail.zabtrans.ru>
Date:   Mon, 29 Oct 2018 13:47:13 +0800
User-Agent: Microsoft Outlook Express 6.00.2900.5931
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 7
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, 2018/10/26 11:50:52
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, bases: 2018/10/29 00:26:00 #8829569; khse: 2014-01-23 rollback
X-KLMS-AntiVirus-Status: Clean, skipped
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear developers, this proposal can be implemented?



24.08.2018 16:19, Luiz Augusto von Dentz пишет:

>> May be possible to set a default pin code via /etc/bluetooth/main.conf
>> if it is available, do not make a request for a pin from the command line? I
>> think that then #bluetoothctl pair 11:22:33:44:55:66 will be able to work
>> fine.
>
> That is something I had in mind, lets see if I can come up with something.
>

Yes. Non-interactive mode needed.
But I think in bluez 3 was main.conf parameter to specify the default 
PIN code.
