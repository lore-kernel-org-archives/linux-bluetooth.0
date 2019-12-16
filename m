Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C7C2D0C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D827920717
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NZbQnkTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfLPS2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:28:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:60335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbfLPS2W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 13:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576520888;
        bh=pvmpFiX4d9YHZ7Vsh/G0m1JXfvyx/v5IGwK4o0cHQAs=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=NZbQnkTf7jk85/R0oOJy3oNwRz1gt7vCTlSh8GUtpCFJ7JF062frFOw9SAZDFHN50
         SZ0krEQD/WC9Z4JyDaC8K3aM+61ZMaMkUdeLwpA9VBndexZQSXDNCo8D2QX/KTVA8o
         6QbQ6tg6SdlqX2cxyWMwasG0FoCs6zr2i7dTDzEs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.154]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1iK33b0jdj-00MqUS; Mon, 16
 Dec 2019 19:28:08 +0100
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
 <20191216132509.ofqcdpwxsd7324ql@core.my.home>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
Date:   Mon, 16 Dec 2019 19:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216132509.ofqcdpwxsd7324ql@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:Tu/M2bgQiADbiwQeIjgGIYBpqIJmQI8GMRK5NioWdvcQ4AMDg3B
 hDPX+HmurOZiRtSL7Tw54NOG+GoJGgB3KHazHOpC4BwEn8JHHPArQo3u7DiIZ4AzNwh+MHq
 sKZj5P5yBnNASd9I50URa09iWx1qj7SfbqmIdXs4Qybr5OFHsa6eg3wz+pXydBLUGIsOzRs
 C803bdJd7LsfEM6iVjdoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FMjcJg0p3l0=:JBaVgbdupvnCvoblpnnjn2
 /WUOnDX9J07vO/X7eTOxjYYTzz1g2EHHp6L3aXGwn+KRTPc9QMca5DPZFbZwuoqezLIkZaYQr
 PWmK+cf6SaRv3wmwfkAubRz4+YK5ON3UA3Wzlfiav91Eyq04opYZvCobfSjLgp07Pzrpv7IG2
 8PuQON7FaC61TewSI8nhqyv6cPbsBYmPUkFJogX2s59f76AzOv5Fzampy+lJYMMySnUlOYjH2
 ortwA1BQU81HaxVb+XairpUonlwdUK5OfZsRAaL2unP6CEiLn5vRYzpRURfq00MZtnKPYtoh3
 0cbHnu85hOD8umrOGGCB1YDxk4+hhx5RN8u69SXoAKgcu7KIisgE4bWnVfM2qhH8TJI0oguyY
 DWojVBThotOspSSVJHEgjdlvSv4uj7cM6N0W1OSh0kRMJ/vn4AML5GpTpJFCwESwfotVRZRoS
 bfyDiclcSPTM0Gwc0OhwOw3zhD7e11W9WYlwU8lwdd3Ub3ZoCJz2W95dobF82rpOhIrRrtDJO
 6Da4n4EqBmT2GlL1bPpSV1bZ4Oq/vIMBfzXYc/O5Ojkbk/PnKWzbbDDvnxS+CLCy4bgMieZsf
 sQW26CqjR7K/foyMpPY2PkJPtLYe3bl1IrVjClqs/bdyV11C7Bc2W5zdn4UA6RgKOTJaS3wsW
 gFeisJiL2NS4V15BC68aq71JabcBJJ8YQ0OsFRhga9p1Bq6Ua36KP1IdXm1PDNN05+7tCjwun
 ClbbIKjU06E6dklwODaQQcSLCU6erLsWu1xWQgaWttI6A3Juuhi6TlfGunLVrtRmJKfcm5SYt
 F0hF1wUTFam1qUD62cxe29EA54XNMkAytdSsNzSJUkkEMwFLA5qnAjdINv+pML1J3R+6pApnh
 fbR6MsffFADwgZMQkniA6pngqWR0Syvmbun8AxWutYoyWOPjoUNx+ixYTqC5gSLU6tFXulxeu
 NG1kEW4QUWvV3ob1DKV6IAUvx/Ir0+vimK1qMtHQKmcn1YciROloDOad9AUqs4tpOhzLTt8jq
 UvgxxfoLv+CEdZ52SQ8kjEkKb4Gdry7QV5kuKDZrvqP4/CilXRs1Ezbp0+zReGZUb3nkejBz6
 GyvrW6beb59KXjgB4whfUk4EqK7V9W428dlXo6spAixsFTxgd+0nkUC/xiFtjZiMRspk4h5O3
 i1xCh83BTRCyFopAs/BFlbRtPRbPyBryl+ZI6OBfw7CFOfb3A8LxLR6AZZu54/OiySm01TouR
 P79uYqrVrYOPQyObB9yQw5dJ7YTdV6U/Vj9oIyDDPSkR56lKwCDCc0t9hzdQ=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ondrej,

Am 16.12.19 um 14:25 schrieb Ond=C5=99ej Jirman:
> Hello,
>
> On Sun, Oct 20, 2019 at 11:17:28PM +0200, Stefan Wahren wrote:
>> Hi Marcel,
>> hi Johan,
>>
>> Am 06.10.19 um 17:28 schrieb Stefan Wahren:
>>> The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
>>> doesn't react to HCI requests during DT probe. The reason is the inpro=
per
>>> handling of the RTS line during startup. According to the startup
>>> signaling sequence in the CYW43455 datasheet, the hosts RTS line must
>>> be driven after BT_REG_ON and BT_HOST_WAKE.
>>>
>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>> ---
>>>  drivers/bluetooth/hci_bcm.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index 7646636..0f73f6a 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -445,9 +445,11 @@ static int bcm_open(struct hci_uart *hu)
>>>
>>>  out:
>>>  	if (bcm->dev) {
>>> +		hci_uart_set_flow_control(hu, true);
>>>  		hu->init_speed =3D bcm->dev->init_speed;
>>>  		hu->oper_speed =3D bcm->dev->oper_speed;
>>>  		err =3D bcm_gpio_set_power(bcm->dev, true);
>>> +		hci_uart_set_flow_control(hu, false);
>>>  		if (err)
>>>  			goto err_unset_hu;
>>>  	}
>>> --
>>> 2.7.4
>> would be nice to get some feedback about this.
> I started seeing failures on Orange Pi 3 in 5.5-rc:
>
> [    3.839134] Bluetooth: hci0: command 0xfc18 tx timeout
> [   11.999136] Bluetooth: hci0: BCM: failed to write update baudrate (-1=
10)
> [   12.004613] Bluetooth: hci0: Failed to set baudrate
> [   12.123187] Bluetooth: hci0: BCM: chip id 130
> [   12.128398] Bluetooth: hci0: BCM: features 0x0f
> [   12.154686] Bluetooth: hci0: BCM4345C5
> [   12.157165] Bluetooth: hci0: BCM4345C5 (003.006.006) build 0000
> [   15.343684] Bluetooth: hci0: BCM4345C5 (003.006.006) build 0038
>
> Switch to higher baudrate works again after reverting this patch.

sorry, i don't have access to a Orange Pi 3.

I looked at a=C2=A0 AP6256 datasheet [1], but i couldn't find any helpful
information about flow control during power up.

Are you able to analyze this issue more further before we revert this patc=
h?

I would like to know if this is some kind of timing issue, since in
patch "bluetooth: hci_bcm: Give more time to come out of reset" you
introduced a huge power on delay.

Meanwhile i will play with modifications of original patch on the
Raspberry Pi 4 and come back to you.

Thanks
Stefan

[1] -
http://www.sparklan.com/p2-products-detail.php?PKey=3D4984FVukjcpylzifQiM-=
TGFE-IKXD--BCwf4P15KfrU&AP6256

