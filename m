Return-Path: <SRS0=GU2S=7H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 17:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E4C20776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 17:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbgEYRK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 May 2020 13:10:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 May 2020 13:10:29 -0400
Received: from [192.168.178.27] ([5.10.6.45]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N8XDT-1iz8fi3l9V-014Sha for <linux-bluetooth@vger.kernel.org>; Mon, 25 May
 2020 19:10:27 +0200
To:     linux-bluetooth@vger.kernel.org
From:   =?UTF-8?Q?Johannes_Nie=c3=9f?= <linux@johannes-niess.de>
Subject: High number of writes per second to
 /var/lib/bluetooth/..../cache/..../
Message-ID: <a15907db-4894-e4f4-3854-2ac5dc9717de@johannes-niess.de>
Date:   Mon, 25 May 2020 19:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Provags-ID: V03:K1:KycNyUPENAs9Cb/7w76OEdoJJj7sIgKBregLjaGwdniHnueqgRm
 aMW8UZqjpSTkIO22qn1Y2/NoBz7GqHnMAsFUi7ALOpREtE4vNND4ijJkcpn0h74L5RrlkFD
 PzJ2+26TkBXJ4ZKyfY7bTWPnmf3vkyY1tCgc1F/Ed+FFBhlJ5sLTSwkqN8WaPsN5hdsjQLq
 QODAnLdyGJQzUsqHpyNGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s8MBM7UZC5I=:M6aSykFiu5XdfWcjGny0Ef
 IxPWHajlJMiZ3U1GDHkoiLEz4ceByoMPGiQpW/ksjCEkSejAFMG2kwyNQc+JpFGYJyhqW2tl/
 4EzfqgerDTpGi2fHoKo7C+YQloIn4SM5oDAuuC5NbF/LaPJdiE7cBLAw+GHVKy5BkhD9R6JUx
 KqsufnSUM/brujeFL/6JQz4t0vlapf063xJArXLWwodvCp24TPYfc4SltDfr5y0pu6SAO8f91
 u86BZSm+3hr/SPqNsF+jMFFCwry+IpCVJECOPOOKKVoKtO8gCe16CTBdf5mf1D41E9KV2oRHA
 h5ly2hXZzKRHbwJMzYyMbDkJLqBBxyKMjZYfFmkJBguUX3GPNqhu4mjzUAi5MUNfi8Qks7C/E
 4/dhGBSG+39jDLHTnhwdV05qMYnfNAeWoHQig6p/WduUN22Upu9oLJ04UQtfszcNe3JdvSMDM
 68DHWM1I1UjfJ3jQdseL5wFv62Ce66doWLX3iY08hu6pwqVc/FV21ZN42Fo3VljL1fu/CUjsQ
 VzpDkmb41dlrxhyvdbsimtfvcjrqRXeo2VdEERbFXOJPdVt6p6EvGjC7XNQYshRar9YxMz9Qu
 fqFUSHtBW89wiL+LVEG1dXIzKdvBFpr/DvdCnLHLM/h/mLFn2u8iQfx0LTGx6wJ8Ozaj/AZr4
 0RU9mDZompU2qpe0vfgOdHPiQx1vT9CXiUgXnhd0zapNsfQu2AtOzTapTv3exqD6INGYGexh7
 VxRLLE5k4FPaQpXTwz7wqcCQe1wwRjlkAV3+/SHHvAIOn4UN/6GruV8wQXMjLMhAVrYzPRxPh
 M1tFWUoTEs6XO54HVN433WrWtjuFBLhYp0NDnqVxganmfmTnRN0mx9HN6p+7AYVs0E2wC6q
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear developers,

My system with bluez-5.54 writes at a rate of 0,5 MB/sec to 
/var/lib/bluetooth/00:1A:7D:DA:71:15/cache/30:24:32:45:BF:77, slowly 
killing my SSD. How can I help you to diagnose and remediate the root cause?

The bluetooth device is a common USB dongle, the other end is a Windows 
10 laptop (currently in sleep mode, no pairing). Looks like (almost?) 
the same file content is written about every 30 seconds. A snapshot of 
file contents was uploaded to 
https://bugs.gentoo.org/attachment.cgi?id=640424. Files in the same 
directory for a headset and an Android phone do not show this behaviour. 
I am puzzled as I could not find any other mentioning of what should be 
a very common scenario.

Best regards,


Johannes Nieß

