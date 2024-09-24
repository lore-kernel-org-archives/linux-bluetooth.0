Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFD1B85D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Sep 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193316; cv=none; b=C6TuFsoL6c7xgjLX+NZ+fe+/TfuHV6uKTQWcbhK2k2ik1848e7MG4rjhdSWgRX2wE1qNYNcHkORfWdwmV2YesLsZqpeJ4TRSmPnozxxTNZ6lRCQfzDh/QoTx3z5OFVMxdkdfS/+vLNnHaMCNMR9n55LjlyVh7AuEhYGN4FjLdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193316; c=relaxed/simple;
	bh=qvOnv/4caXuxKlGydA2/0zESSdBZffBx+SmYmb/MChw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+KN4vYhNFtnV567C7kX+2EYMlTztVbBCAjMnYvXhRh8jHmwR1vV3korV1qOphMvixuX3r4Hw2XzmJKM1+VHEH8qzg13ZeQpIyMcgNlNdEih15NxI0SpgMNBAa6tfhfQObSQXq7zT7dItYuxDxvGLqQYt9MiDuA+phH54EbhXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX1SQSps; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX1SQSps"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f758f84dfbso45428811fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Sep 2024 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727193313; x=1727798113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kcpsjb3fQaijuhxyiIH9i9Beqj/c0lkQ3I/ye+XTp04=;
        b=LX1SQSps105ut/lxt1HqTIfXxhhLrxc7Ujy/kJWBRYvBCoVBXpyPSrE5JxeFKbpZ5r
         HB7uRvxQbdMs/5xV2nGONDXVeeu6TIXXADkE/rcWQgYH9cD6Mamb5Y8C+0hsbnRCSOk2
         mh9+0GKdKfp2IbXMF4k7HPHF7mIZXn0djPfbNuBCji0CVVcgDE1pI+tc/iefOOdJhHhH
         /s3Sx/pUy7t8w56j7o6Lxd0BtGlPg8HpVVj6Ax02OrKiLznGCO3tEP+Vv6XbXCkkDLsS
         3u4dWU5oUKDXbZdn4ehnTl25t5ncTrJQfIAU66ZP+zj6mZegItUToi74gURI3UGKv6Qb
         pomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193313; x=1727798113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcpsjb3fQaijuhxyiIH9i9Beqj/c0lkQ3I/ye+XTp04=;
        b=HgOPUFJ1IpyjQsTjGlHJ1KPwGXO1BE3+6+ttiEQhVmaHAt73yAwJPVawqXLbeukfbe
         LpKw6kbUjpyLP1BHXI/NL2dwoeAWLba7BBWfetI+DRvQeHuhy8PYHoZm/t0sCr3uS35M
         vpU3T0+NCBXgEHZFX/CQ/hgImHmOhML91j6gvrIp6PhWaqrfICmtA6GENK+2LBnocYgU
         I6+/CudthipNnE7hMxF73hRklYsoqd37YgQTj8eWU2/PFi5+TC7HZHfXIBV1+2woxBNr
         UvNbwBlPGkcodmxv8XNYUlJDftuJZr4hTY1oLYtRLOMoSp/kvrpnqhrPDisz6mNS0D8Z
         EzuA==
X-Forwarded-Encrypted: i=1; AJvYcCVeUNlQvT6yaQOy4K7Vgl0Y3t8sWT30hxR2aU7igHi8JAkNH9OyU/d2BonRcYRQb8AvsGba1qJlv0uTbBEmu8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tWh8XMOwA38IoyGfAq4xhoxMQ5uZ7gl4nTT0BjM+dpf0NVzI
	AoT3S/nkE0P+ZVxLPTCWbD0QTwinr6nZ6y3LtVfrSmLo/JenrKRr
X-Google-Smtp-Source: AGHT+IHEO4c+PlLkhXG3qM3qkpyjWS1QDbj29mWEBMEGr2J9TMaywmV5C4Htout6e36x0QPXdmFCYA==
X-Received: by 2002:a05:651c:1509:b0:2f5:2ba:2c99 with SMTP id 38308e7fff4ca-2f7cb301399mr82781891fa.9.1727193312814;
        Tue, 24 Sep 2024 08:55:12 -0700 (PDT)
Received: from [192.168.0.249] ([176.196.131.103])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b710sm2719571fa.114.2024.09.24.08.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 08:55:11 -0700 (PDT)
Message-ID: <fda1cccc-06db-46f5-bc48-1696de2a7f83@gmail.com>
Date: Tue, 24 Sep 2024 22:55:13 +0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: Add new quirk for broken extended create
 connection for ATS2851
To: Markus Uhr <uhrmar@gmail.com>, luiz.dentz@gmail.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org, raul.cheleguini@gmail.com
References: <CABBYNZJgf0HobQqRR8orizGM-adToJaU20_NXfC-+jrc1efyxA@mail.gmail.com>
 <20240826202129.446112-1-uhrmar@gmail.com>
Content-Language: ru, en-GB
From: =?UTF-8?B?0JTQsNC90LjQuw==?= <danstiv404@gmail.com>
In-Reply-To: <20240826202129.446112-1-uhrmar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!
Any news? I'm also interested in getting this patch into the kernel.

27.08.2024 3:21, Markus Uhr пишет:
> On Mon, 12 Aug 2024 11:17:20 -0400
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
>> On Sun, Aug 11, 2024 at 5:05 PM Markus Uhr <uhrmar@gmail.com> wrote:
>>> I'm interested in getting this patch merged. Was this just
>>> forgotten, or is there still work to be done before it can be
>>> merged?
>> It might need to be resend since it is no longer listed in patchwork.
> This is a resubmission of the patch, rebased on current bluetooth-next
> master.
>
> In addition to the original change, this revision also disables
> 'enhanced connection complete' when the quirk is active. This
> eliminates an ugly kernel error log
>
>     Bluetooth: hci0: Opcode 0x200e failed: -16
>
> when the controller connects successfully.
>
>
> Best,
> Markus
>
> -- >8 --
> Subject: [PATCH v3] Bluetooth: Add new quirk for broken extended create connection for ATS2851
>
> The controller based on ATS2851 advertises support for the "LE Extended
> Create Connection" command, but it does not actually implement it. This
> issue is blocking the pairing process from beginning.
>
> To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
> This will avoid the unsupported command and instead send a regular "LE
> Create Connection" command.
>
> < HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
>          Filter policy: Accept list is not used (0x00)
>          Own address type: Public (0x00)
>          Peer address type: Random (0x01)
>          Peer address: DD:5E:B9:FE:49:3D (Static)
>          Initiating PHYs: 0x01
>          Entry 0: LE 1M
>            Scan interval: 60.000 msec (0x0060)
>            Scan window: 60.000 msec (0x0060)
>            Min connection interval: 30.00 msec (0x0018)
>            Max connection interval: 50.00 msec (0x0028)
>            Connection latency: 0 (0x0000)
>            Supervision timeout: 420 msec (0x002a)
>            Min connection length: 0.000 msec (0x0000)
>            Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4
>        LE Extended Create Connection (0x08|0x0043) ncmd 1
>          Status: Unknown HCI Command (0x01)
>
> Signed-off-by: Markus Uhr <uhrmar@gmail.com>
> ---
>   drivers/bluetooth/btusb.c        | 1 +
>   include/net/bluetooth/hci.h      | 7 +++++++
>   include/net/bluetooth/hci_core.h | 9 ++++++---
>   net/bluetooth/hci_sync.c         | 4 ++++
>   4 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 36a869a57..31f39e68a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3883,6 +3883,7 @@ static int btusb_probe(struct usb_interface *intf,
>   		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
>   	}
>   
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bab1e3d74..4c942db4a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -328,6 +328,13 @@ enum {
>   	 */
>   	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
>   
> +	/*
> +	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
> +	 * disabled. This is required for the Actions Semiconductor ATS2851
> +	 * based controllers, which erroneously claims to support it.
> +	 */
> +	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
> +
>   	/*
>   	 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
>   	 * inside the LE Extended Advertising Report events are discarded.
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e449dba69..a7a03ab13 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1876,7 +1876,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
>   
>   /* Use ext create connection if command is supported */
> -#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
> +#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
> +			   !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
>   
>   /* Extended advertising support */
>   #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
> @@ -1890,8 +1891,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>    * C24: Mandatory if the LE Controller supports Connection State and either
>    * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
>    */
> -#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
> -					 ext_adv_capable(dev))
> +#define use_enhanced_conn_complete(dev) ((ll_privacy_capable(dev) || \
> +					 ext_adv_capable(dev)) && \
> +					 !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, \
> +						 &(dev)->quirks))
>   
>   /* Periodic advertising support */
>   #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e79cd40bd..160f260a7 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4800,6 +4800,9 @@ static const struct {
>   	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
>   			 "HCI LE Set Random Private Address Timeout command is "
>   			 "advertised, but not supported."),
> +	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
> +			 "HCI LE Extended Create Connection command is "
> +			 "advertised, but not supported."),
>   	HCI_QUIRK_BROKEN(LE_CODED,
>   			 "HCI LE Coded PHY feature bit is set, "
>   			 "but its usage is not supported.")
> @@ -6427,6 +6430,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
>   	if (err)
>   		goto done;
>   
> +	/* Send command LE Extended Create Connection if supported */
>   	if (use_ext_conn(hdev)) {
>   		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
>   		goto done;
