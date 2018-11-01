Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B566C0044C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B5E20821
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 02:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B5E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.zabtrans.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeKALpF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:45:05 -0400
Received: from ns.zabtrans.ru ([195.39.228.131]:54078 "EHLO carat.zabtrans.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeKALpF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 07:45:05 -0400
Received: from proxy.zrw.oao.rzd (proxy.zabtrans.ru [195.39.228.154]) 
        by carat.zabtrans.ru ASSAMail sm-mta  with ESMTPS id wA12hxcc031428
        for <linux-bluetooth@vger.kernel.org>; Thu, 1 Nov 2018 11:44:04 +0900
Received: from [10.123.236.115] ([10.123.236.115]) 
        by proxy.zrw.oao.rzd ASSAMail sm-mta-lst  with ESMTP id wA12hwHC009017
        for <linux-bluetooth@vger.kernel.org>; Thu, 1 Nov 2018 11:43:59 +0900
From:   =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Re: Serial communication over BT using the DBus API
Reply-To: ProklovAV@mail.zabtrans.ru
References: <5B7F662D.5010903@mail.zabtrans.ru>
 <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <5BDA76AF.1050202@mail.zabtrans.ru>
Date:   Thu, 1 Nov 2018 11:44:47 +0800
User-Agent: Microsoft Outlook Express 6.00.2900.5931
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KLMS-Rule-ID: 7
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, 2018/10/31 12:54:24
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, bases: 2018/10/31 19:15:00 #8918321; khse: 2014-01-23 rollback
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sylvain Leroux,

Some time ago I also asked this question here.
I think no one knows how to do it without rfcomm util.

I use dbus-send for read dbus properties and now work non-interactive 
mode bluetoothctl.



> I tried something like that:
>
>
> ----
> busctl call \
>     org.bluez /org/bluez org.bluez.ProfileManager1 RegisterProfile \
>     'osa{sv}' \
>     /bluez \
>     "00001101-0000-1000-8000-00805f9b34fb" \
>     3 'Role' s server 'Channel' u 1 Name s 'SerialPort'
> ----


-----------
Best regards,
Aleksandr Proklov
