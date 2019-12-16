Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF8C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0372146E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 19:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h/o52mFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLPT4W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:56:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:60963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfLPT4W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 14:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576526174;
        bh=CNL4/ITrQyawW6Jwa7ZAkK9ujkdNN6N4djNXPY/LFy8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=h/o52mFMz6z4L2EVFIDt/pu0uYfDVMCrkIKvPvLzm0h0VP0vvOyqWLK4KW3o6mEBS
         ZJf9sGo1WU3uvvIepLMCQIVbdOSi7ReR+1hMXnuoJzJwfQM3QyRFiOGVIiCvLpvZue
         s1EFwHFD7jvH4Tmk1u8nQFK2l47uOx9e0Ri0syUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.154]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1iKtLS0PC4-00M5AL; Mon, 16
 Dec 2019 20:56:14 +0100
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
 <20191216132509.ofqcdpwxsd7324ql@core.my.home>
 <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
 <20191216194235.4pq2xpfl7nz3p55w@core.my.home>
From:   Stefan Wahren <wahrenst@gmx.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Message-ID: <ff0206e0-8290-0639-5399-5304b9454110@gmx.net>
Date:   Mon, 16 Dec 2019 20:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216194235.4pq2xpfl7nz3p55w@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:frpVMvHvuwuUjwYqcSegzPvPNdhbH3fki7ucVW2an/S2FhOx+UY
 UcSNCOk4IpNNG4W8cZ7siJs2B/tR7FLt++GI7BAMFyDi6qO7EP3tkHr7FGAW9AtzQmVHta3
 7h6zwi49JMchT2PpuBILSToHHv09DVPsduHtvCHY9Ewgo5GgBGc33Ge4kd9XG7p4Bc/wHP4
 zgmTQtird6GDCtegho8MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BNw9DSMBEC4=:bdYEcuDFgaeDTz5P1s3yax
 l13x3/Xtj+VlfUkVJg0oVPAWp2VV1ALfyJ0nzq0DExgodeXMDbpr0LoC4wEKOYc5sLE0zLsVK
 d+WG2PIrojejyuckxioWwqRuVi0fGfUH7IWWyFLCAXgSjtnZN+ff+DD/wputazvQR4kKWlKx2
 sRv2IUrGMtqVaEviTiBwlmsu7O11xRqP1vBEE+z4AwOQaSfQeU64FB4HSJEIIms2SVvMqVgML
 JqBEnINTDTaJjPSFndsLw5kUg017Az8BdPyC0TVSC/HuauLaHhoX0uztgOvUfPKO+bnmUTOTN
 JbpHc7FxR8BR1Xv6WADCs73MNeodh/WSr7RspThKY+kSXiOdLOdN8528VnECeQDLa/UQCn1Q2
 iNaLvWaPYNzoN9EcTaNlfZC/FVJVOxQvPhH02aNGPLVVCSZ7YAqodFFMglT4WhgCUq8ku8wXy
 yjXlBYa3FbuGTF/E5Pzhx1O+hf6hSLJ+0+dSmQLGSoZdTTW/M9H0Bl5fX6rLAxCGlIa2+8Q09
 OrveGtnKfVFQ4LFgaOTj6olCFDklzvyACcxdeYlop8u7PjVni33V5tkVjAzfY3ANKilrb+UVu
 s0NEJJ72nNy+VblxunKioG/yJDk+gBFcLiDYcwcx4sEyixA6y1qmTiK8nu2bCat8BgECUz725
 lgG2wrMJPzGygv2+yUzO/2y3uHklv/wyj6n244nWLcm6n2jDjczwIPeO28WG0Z0CR6GTYZ7ta
 5H3H25d1w7JGmxtKKlo/dChCGlZevicnSZcDG13nmpThwCc13vGfUn0uQH5rXhz1I8fdOZ940
 I+uJk/D3G5Nn35bAvk1i/6qqC8279TSQtpDhc5cI7Et3WzudQBM+h7neXQ+HuI7cnrnR4FBnM
 Cy93cOJGbGzWpyAoEdFojScHHz0sbL0L5JtVfeHDflsmZ31Q22uC4PT01kkPPiyeC+pW1V6d/
 d6wMkOm/6j6EmNpOpe6asvU8a4mPHBFhQtqV44WoOmfUfSlnHN4rHCu2+Rb70WC5MEfyvVosb
 mJpcjEovzpB/pFF9s/5PLuYX/BfqYhiwC5ZZ4PJOK0kYycQorhzbuLsqdyAt6TVXxjpNg7Et1
 5a1Tjbq4NIB4c/mVub1ERqIOTmPCDU9N23pUBYlTDKbAE4TbE7GmgQrp/egG4b4+GkAaBC8qm
 MZz/MK8jrNpYhtNoSnZlMlrdwZmGQdoFiHn0UGnVv1nBlpKJ0gfiJXR3oHg9FZtreuZUxLMZo
 0XmnqZ6dER1TICekvEGpR88GmuzlzFc7aZTY1fUxe2G5Q5w116fjRXxBRI2o=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Ondrej,

Am 16.12.19 um 20:42 schrieb Ond=C5=99ej Jirman:
> Hello Stefan,
>
> On Mon, Dec 16, 2019 at 07:28:04PM +0100, Stefan Wahren wrote:
>> Hi Ondrej,
>>
>> sorry, i don't have access to a Orange Pi 3.
>>
>> I looked at a=C2=A0 AP6256 datasheet [1], but i couldn't find any helpf=
ul
>> information about flow control during power up.
>>
>> Are you able to analyze this issue more further before we revert this p=
atch?
> I'd like to, but I'll not be able to attach logic probe to the AP6256
> module. It's too fine pitch for soldering.
this the same issue, i had with the Raspberry Pi 4 :-(
> I may try setting CTS/RTS to gpio/input mode and grab the capture of
> the GPIO port states in time to see what's happening during probe
> of bt_bcm module.
>
> I don't really understand what effect your patch is supposed to have
> on the CTS/RTS lines during power up from the commit description.
> Can you please explain it more concretely?
I hope a picture explain more than thousand words. Please look at figure
7 at page 22 of the datasheet [2]. The patch tries to achieve the proper
timing of BT_UART_CTS_N.
>
> I'll be able to get to playing with this after the holidays.

Okay

Stefan

[2] -
https://www.verical.com/datasheet/cypress-semiconductor-combo-wireless-mod=
ule-cyw43455xkubgt-5770595.pdf

