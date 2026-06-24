Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49253624D7;
	Wed, 24 Jun 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288412; cv=none; b=aWnbQXnqU1X5Fy2E4n04jLRnSzyokwvCswK7XlL6PtRv5S/FqWbze2jM07mOhE0PawuvRYvTELqt6dEplNm/uLfRIQn5E0CekB4ZzpRWnHiEifz0R5lyqOvst4Z193fGG7fotY3/Q1fhnvudP0h9hZtraC9UGfEubGK7Gw1F6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288412; c=relaxed/simple;
	bh=cMChcT4jOgKyeVQMFGJCdxhCiGeJqRyFt529gsH8bhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1zwCDQSGzvDAON/+LSWAXTrxhsZdjd+XxkXZEU/Nh11WcU5Q2pu9iI0IZmoLNYevYeigbIRddz4wysJcTMwiHA09Yda9W+63Y6j7jtiNQ4q46cCzFQ7N3wxnvRO5hJLVkvaT4HmNE6K/ooIvxrS/LDD56hzubZvyadWyxq7gWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.43.73] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8D79F4C2C37D5D;
	Wed, 24 Jun 2026 10:06:18 +0200 (CEST)
Message-ID: <f0f20712-b1cb-4cf1-b199-7862eed05aae@molgen.mpg.de>
Date: Wed, 24 Jun 2026 10:06:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Bluetooth: btrtl: Add firmware format v3 support
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, jason_mao@realsil.com.cn, zoey_zhou@realsil.com.cn,
 max.chou@realtek.com, kidman@realtek.com
References: <CABBYNZ+_aocMGOdugwF3uP9h3NN4Dv5XYRyiN50W0AJ3rSETTA@mail.gmail.com>
 <20260624053334.3151885-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260624053334.3151885-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Thank you for your patch.

Am 24.06.26 um 07:33 schrieb Hilda Wu:
> Realtek updated its Bluetooth firmware format to v3.

Please name the specification document, and state whether it’s 
publically accessible.

> This patch extends the btrtl driver to recognise and parse the new v3 file
> format, including:
> - New signature string and image ID definitions
> - Extension of btrtl_device_info to store v3-specific metadata
> - Logic to extract and load firmware data out of v3 images
> - Maintains compatibility with existing v2 firmware format
> 
> This is required for future Realtek Bluetooth chips that ship with
> v3 firmware.

Please add a blank line between paragraphs or do not wrap the line after 
the sentence.

> The RTL8922D is the first IC to use firmware format V3, so the following
> example uses the RTL8922D's log as expected fw format v3 output:
> 
> Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=0x00 id=0x37
> Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=0d
> hci_rev=000d lmp_ver=0d lmp_subver=8922

Please do not wrap the lines of the pasted lines. If you keep the 
timestamp in the front, `checkpatch.pl` should not complain.

> Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version status=0 version=1
> Bluetooth: btrtl_initialize() hci0: RTL: btrtl_initialize: key id 0
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_fw.bin
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_config.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: key id 0
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id
> 55, cut 0x02, len 00007185
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 35fd7908
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file:
> rtl_bt/rtl8922du_config_f000.bin
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id
> 55, cut 0x02, len 000078f5
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 47b6874d
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file:
> rtl_bt/rtl8922du_config_f002.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: image payload total len:
> 0x0000ea7a
> Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog reset status 00
> Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0x47b6874d

How big in the firmware file, and how long did it take to load it?

> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> 
> ---
> V4 -> V5::
> - Add independent support for RTL8922D section
> - Introduce macros to improve code readability
> - Document firmware format v3 and its differences
> - Align implementation with reviewer feedback
> 
> V3 -> V4:
> - Rework skb->data access and add clarifying comments
> - Fix latent issues
> 
> V2 -> V3:
> - Address coccinelle warning
> 
> V1 -> V2:
> - Add missing symbols
> - Resolve build warnings
> ---
>   drivers/bluetooth/btrtl.c | 698 +++++++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btrtl.h | 102 ++++++

The files get bigger. Would it be good to split the firmware handling 
out into a separate file?

>   drivers/bluetooth/btusb.c |   3 +
>   3 files changed, 786 insertions(+), 17 deletions(-)

For easier review, would it be possible to split out the refactoring 
like defining the macros FW_TYPE_V0, … and using them?

[…]


Kind regards,

Paul
