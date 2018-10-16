Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E361C04EBD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B70120866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 13:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B70120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=condalo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJPU54 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:57:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPU54 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Oct 2018 16:57:56 -0400
Received: from null ([172.19.249.22]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MDhth-1gKLZ628XP-00AoF3 for
 <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 15:07:31 +0200
Received: from null ([172.19.249.22]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MDhth-1gKLZ628XP-00AoF3 for
 <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 15:07:31 +0200
Date:   Tue, 16 Oct 2018 15:07:31 +0200 (CEST)
From:   =?UTF-8?Q?Martin_F=C3=BCrst?= <martin.fuerst@condalo.de>
Reply-To: =?UTF-8?Q?Martin_F=C3=BCrst?= <martin.fuerst@condalo.de>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <1807385296.119430.1539695251426@email.1und1.de>
Subject: Bluetooth Advertisment Notifications over DBUS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:GwTuMZvZO52+N58xUBgcFzPmqXfDK9VDA1K0UwGzrQq5uNuAHry
 G/5dKxMWDqGFEwqG21pd6TT8NgfOs+MXrij7v7YmlaUQfK4/7vECUUXdDPQXdmHAQrKS3hN
 yFLH/ScTgT+XJjA3bgQDVthh1LIb8HwtMWGrZBOfmihhgpRb0xikISErV8CraqFD2iVj7Th
 IpCVGG0ztb6PfWWekhpmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fm9lHL8ZokA=:Mw70R4dnfQWVVPGFpNKsEr
 0R4SLCEc5KsqHzp7ee4V2YC6Aadbh8BEuta/blwRrO0RYUNZuYO+MSqMpJ//UbOZZbI28iqPB
 aJL7Re780iJawn+p+MgxZUT0rgl2coN7Oz9eXpy+DbiAUqcGjGF6/5GgmebsNj/9/Hy47rU3V
 KBy3z7zJ+MCrdxMPplSig06H2lcB+iUegV3he+GBpuONEMkoImMQMfJxkUm901FQryppp0oHj
 YSgWjtwV8FJ26Q261uui7DVcdjhcW62mY1r7CinTblI/ng8Bsm0RprL+IeTLrOAUUHVe/77cr
 YlCBJnymmRvuNtO5FkNYIAmgcxRGhTcIZvTYZKgWRV3rpMxpeN6X0I7SPQAea3JjdeDnwP45B
 At4P8Tz65mvKAK38DxYtNWixatna2+j4HuuZU1naW45zWgS8dhpbpai64qg5UO2H44UTScgm9
 zEZ24H9a6UFDUeATGuDdnc/u1dtiPegGPMruGqueJGEBDqe3vMg9fiQkPgsyew07wlw/tcrej
 TxabD88WWkDLbdqlj6MGVZ7a5jD4pyOCk7Q4BCbW6AAx9eH0FqCLhIZlwbJxQOkTi5RCXesMN
 pPbMl99rP9wjk7WkktW2TIb1z6gz9cpQrrx0KNvlrTdvGDweccCA5ZEedj0wFJLo55Pgm2b2i
 3nluv2Z23WTc8eXSIhqluzt3MYJQTxCqKXZ8lvSj21GVEESsQYDTD3oL+JOBcO+4JyRQ2sKCu
 EBS0GmznKDM19xVT
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

my Bluez-Version: 5.50
we wanted to have all advertisement data available over D-Bus connection. Up to now only manufacturer data is available via "ManufacturerData" and "AdvertisingData" Properties. I now modified bluez 5.50 in "eir.c" to call "eir_parse_data" by default in "eir_parse" function and send the list with "AdvertisingData"-Property to DBus. I dont know if this is the right way, but for us it is neccesarry to get notified if an advertisment packet is received. As far as i could see the "AdvertisingData"-Property is introduced to get more information about advertising over DBUS Interface.

Cheers
Martin Fürst
