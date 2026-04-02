Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC77259CB2;
	Thu,  2 Apr 2026 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163080; cv=none; b=gm4oJsea8M31ffyOyjws8AXDgRXbVlhB1p77QBwWK6lZcRH2two2XM+lBs7PwQQZ+THpIIQaKc+jBpaulwtC2TFjJFjobgudBBCK2pwBckj0iUgFZmXkyCleoGsXAhn13BdTNVGulvbPnJCHdzrW3GHVVmEvGK/jd3RsiaD/SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163080; c=relaxed/simple;
	bh=iA8ExmCCSt4geNH3RZY0kLl2CxAVWMLJtja5pKlSyiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0/npE3fVyL8k+DdtpdeH2u2u+I/PvMQYj+cgrz0hTYZVq6FFRMOkyOilc6rVbPqaYCy+RhDN3qpaBVRoi9TErwbcH6nfEFzpbtavA0uEm9emH8oh4c04+HaG9zPay2FVJRSHTQIqux7oKFCquvvk970yHRrV5/Urv11LgBqt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a32b.dip0.t-ipconnect.de [91.19.163.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 88DB54C2C37D60;
	Thu, 02 Apr 2026 22:51:06 +0200 (CEST)
Message-ID: <6398d0a2-f9ef-42a9-8761-6c924a5fb341@molgen.mpg.de>
Date: Thu, 2 Apr 2026 22:51:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_ll: Enable
 BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <cover.1771930508.git.stefano.r@variscite.com>
 <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Stefano,


Thank you for the patch.

Am 02.04.26 um 20:47 schrieb Stefano Radaelli:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> TI WL183x controllers advertise support for the HCI Enhanced Setup
> Synchronous Connection command, but SCO setup fails when the enhanced
> path is used. The only working configuration is to fall back to the
> legacy HCI Setup Synchronous Connection (0x0028).

Do you have a reproducer?

Have you contacted TI about this?

> This matches the scenario described in commit 05abad857277
> ("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").
> 
> Enable HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
> devices compatible with:
>    - ti,wl1831-st
>    - ti,wl1835-st
>    - ti,wl1837-st

Do you have an example device, that uses one of these? Also, do you know 
of TI device, where the HCI Enhanced Setup Synchronous Connection 
command works?

> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v1->v2:
>   -

For the future, if you just resend, just add the tag [RESEND] instead of 
v2, so it’s clear no changes were made.

>   drivers/bluetooth/hci_ll.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 91acf24f1ef5..6f060eec3b81 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -68,6 +68,7 @@ struct ll_device {
>   	struct gpio_desc *enable_gpio;
>   	struct clk *ext_clk;
>   	bdaddr_t bdaddr;
> +	bool broken_enhanced_setup;
>   };
>   
>   struct ll_struct {
> @@ -656,6 +657,10 @@ static int ll_setup(struct hci_uart *hu)
>   			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
>   	}
>   
> +	if (lldev->broken_enhanced_setup)
> +		hci_set_quirk(hu->hdev,
> +			      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
> +
>   	/* Operational speed if any */
>   	if (hu->oper_speed)
>   		speed = hu->oper_speed;
> @@ -710,6 +715,11 @@ static int hci_ti_probe(struct serdev_device *serdev)
>   	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
>   	hci_uart_set_speeds(hu, 115200, max_speed);
>   
> +	if (of_device_is_compatible(serdev->dev.of_node, "ti,wl1831-st") ||
> +	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1835-st") ||
> +	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1837-st"))
> +		lldev->broken_enhanced_setup = true;
> +
>   	/* optional BD address from nvram */
>   	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
>   	if (IS_ERR(bdaddr_cell)) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
