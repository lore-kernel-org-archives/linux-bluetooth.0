Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B833ADAF;
	Thu,  3 Sep 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420007; cv=none; b=KzwvCicqU2BwAdjCzfN2lMG4/BALaXdI9t8pGYK9AOQJZ/CxBWdlUoKzA5PreX1uwOo/exp7OG5Aq8opuo302VllCN8kuMqRsQZJc+KX60zccwz63Sk9VOQT8hi9/yIEKqxN1jbFx+LPqXjz9EvT+9B+UXv2zsesbsaGR0nYYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420007; c=relaxed/simple;
	bh=5yCJxk7XyTAGZALDZmPej6wVP3vozfbuEK5nEJ0wL7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjOKyReJgHAAtVC27jkPERhRIuvB7cRB/duo1MpHpLulc6CWyORiRMU/fe+TlYQ1ZGKDM5Mgyq7/SWCtnX56l0WWediKKNJKmr6m4PvkmZ++KFbnUNgn1YAS9tZtsJsru7pmvVXMDXyv1la6UwRbIoJzuYgFWjCTo8QJf8h4xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af1de.dynamic.kabel-deutschland.de [95.90.241.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3EC924C2C37F01;
	Thu, 03 Sep 2026 09:19:38 +0200 (CEST)
Message-ID: <d2546a2d-938d-4980-94ab-6bfe434edf3d@molgen.mpg.de>
Date: Thu, 3 Sep 2026 09:19:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Intel Otter Peak2
 (OrP2)
To: Catherine L <catherine.l@intel.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kiran.k@intel.com
References: <20260902190037.259487-1-catherine.l@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260902190037.259487-1-catherine.l@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Catherine,


Thank you for v2. In the summary, I’d add a space in *Otter Peak 2* 
before the 2.

Am 02.09.26 um 21:00 schrieb Catherine L:
> $ lsusb
> Bus 003 Device 003: ID 8087:0043 Intel Corp.
> 
> $ cat /sys/kernel/debug/usb/devices
> T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0043 Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 
> Signed-off-by: Catherine L <catherine.l@intel.com>
> ---
> Changes in v2:
>   - Fixed review comments of v1 and changed name format.
> ---
>   drivers/bluetooth/btusb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 03039ceaa77d..3e9db818a740 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -488,6 +488,7 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED }, /* Otter Peak 2 */
>   	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak 2 */

It’s still note sorted. 0x0043 should go after 0x0040.

Regarding the line length, the CI test passed, so the line length wasn’t 
complained about. Luiz needs to decide as maintainer. Maybe wait with 
sending v3 until his verdict.

>   	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>   	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |


Kind regards,

Paul


PS: It’s too many iterations for such a simple patch. What could have 
been done, that sorting would have been right from the beginning?
