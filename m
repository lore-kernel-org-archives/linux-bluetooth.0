Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF608C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E22075E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 10:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1rFC3N+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKRKFD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:05:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKRKFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 05:05:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so18652816wrp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uHDOMZ37yNgCR7vTGPsGK7epgcWZ/WmdIAqGlnpnBD8=;
        b=1rFC3N+s0Tubu8STaAwRxgoSAy2c+Js/SotPR7rhzKjy51lyPInmz4/gWcbZUS28KL
         lOIkzf6WP4zOQntrgTMrfMp45cllMkJt27I563cLtyaCqL+f0QrONW4nI/t8OewZHVLS
         wwUZL6D8maNkaCYaarSUyIYV7hzLUEMraICw021RqpkdurIvpfkddV1XegZNpTCr/8+c
         3EDKgyA+LU8cOFhvV4m4Thjp/m7saUjNuJP7obvA892/Dmw28BVQybWBBA1Kh/pbmKHN
         MhPXnDi6nbff/Cic8pctB/11r1JyfxEh7dFU/eeh3aST7CAg7gdDDYxSxidjA1INfYf5
         RcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uHDOMZ37yNgCR7vTGPsGK7epgcWZ/WmdIAqGlnpnBD8=;
        b=VauPKMz2mQIOp3EH5a4suisDS2ueJC7JebvvwWpfY1iSpLBktSV0moJlvzGfZGmKXi
         lopz4eBjw1So8Hjjs9Gnfr2GgSIlWjxmFdM1IMRHoqC//2uJ7h5dPvTWP9UpDkjXkvYa
         T8LGQgEO+BaTN1T38SaFE67KLLCjvyunpYXS0nVqWrp7X9A+8giI8petWFp2hf2hvh8d
         YHWaVVRvHoDuDMUoqaIUE+sVJjfmyJ4h9cbyj9nH2/5wPjaiStJCXhsi0CJLjc7Tix2T
         lvU8Z1Ix+i+DiPdDS6yNXwhvDPVupQCcQnp5BByL2l7sRrBX04JvSGSe6ASNbXiyjcet
         j9YQ==
X-Gm-Message-State: APjAAAXd7tOeMdoci2pZpGIKbbxcRl3iNdt/uDA5k84cjOnEU3ACmYBg
        lqgUBPxZFkyHAUYwDHoJ6N77/w==
X-Google-Smtp-Source: APXvYqxXUJhjPMRUsqsGwHWXoxs7Q5d+PyVeqZ3q38j9rR1PrZt9Hem+eKHzwFtwZ/a0J7jCfXXaiQ==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr20165524wra.246.1574071498805;
        Mon, 18 Nov 2019 02:04:58 -0800 (PST)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g11sm20029644wmh.27.2019.11.18.02.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 02:04:58 -0800 (PST)
Subject: Re: [RFC PATCH 4/4] Bluetooth: btbcm: Add entry for BCM4335A0 UART
 bluetooth
To:     Mohammad Rasim <mohammad.rasim96@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20191117175606.5050-1-mohammad.rasim96@gmail.com>
 <20191117175606.5050-5-mohammad.rasim96@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <de37f562-77eb-755d-5f27-c534ec028356@baylibre.com>
Date:   Mon, 18 Nov 2019 11:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191117175606.5050-5-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 17/11/2019 18:56, Mohammad Rasim wrote:
> This patch adds the device ID for the BCM4335A0 module (part of the AMPAK AP6335 WIFI/Bluetooth combo)
> 
> hciconfig output:
> ```
> hci1:   Type: Primary  Bus: UART
>         BD Address: 43:35:B0:07:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
>         UP RUNNING
>         RX bytes:5079 acl:0 sco:0 events:567 errors:0
>         TX bytes:69065 acl:0 sco:0 commands:567 errors:0
>         Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH SNIFF
>         Link mode: SLAVE ACCEPT
>         Name: 'alarm'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Version: 4.0 (0x6)  Revision: 0x161
>         LMP Version: 4.0 (0x6)  Subversion: 0x4106
>         Manufacturer: Broadcom Corporation (15)
> ```
> 
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  drivers/bluetooth/btbcm.c   | 1 +
>  drivers/bluetooth/hci_bcm.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..22464bf8cda3 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -339,6 +339,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
>  	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
>  	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
>  	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
> +	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */

Ack for this one

>  	{ }
>  };
>  
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 7646636f2d18..7eba10b0ae6c 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1422,6 +1422,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>  	{ .compatible = "brcm,bcm4345c5" },
>  	{ .compatible = "brcm,bcm4330-bt" },
>  	{ .compatible = "brcm,bcm43438-bt" },
> +	{ .compatible = "brcm,bcm4335a0" },

This could be omitted if the I/F is the same as "brcm,bcm43438-bt".

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> 

Neil
