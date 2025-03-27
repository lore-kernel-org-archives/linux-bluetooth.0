Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD501DC99A;
	Thu, 27 Mar 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113695; cv=none; b=jZjm9O+neiUSsyyufknuSCinckd8C9cnNiJkK1g5EbAHgex2dotZNN1Wd6i6ZaFRbSQytU++I4GMQHMXlNEvkHy98SwG0NxGdMZjkOI3lB8TjgLPPTfrnkbWXp0JRYZC8/NN/4WweNJxYd20Rkb37uhQvGHk1PolJwa8CW/TR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113695; c=relaxed/simple;
	bh=gkT2TWhSQY2wtcVKWhByG9vHOSTaP155ks4mn7sQoyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkatFkd4Sl96cXtK+hZ3l07wZLRR0NKa8L8dGnMM/1WjZcVFPcCJLoR2Mlegfq0glhwx+dAgyiq9iFzrUoeOc2lj7HrKOYi36KPCWUhrUaJPdcc6azzaj4GZdhXWRNtu6G/yHTZ6XPQc+eb6xji6545rav+kAwk8sxCn0SesKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=nU6Ul9l0; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="nU6Ul9l0"
Received: by m.b4.vu (Postfix, from userid 1000)
	id DEAD7667609C; Fri, 28 Mar 2025 08:44:49 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu DEAD7667609C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1743113689; bh=IHQ+yFIFcBzJGlVKVB+l/7/pXuJ8szx633NJGV6gumg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nU6Ul9l0J39x6GQcmG1H/4nMbSTesZU2JqpeSveQRQ4FWtxRPAde0YeVLbUThMi5S
	 xuIYNWF/v6ssi+lZtdwD8PQvWrOqNX/W7IXI3bBxAKkOZclFhE/b8WyEDxmAUQZ/TP
	 dDZCS5pY0MwPDE0YHhXaWn165OPP9G9GUa3Qhb73XUVDJeZXLQHxCSJYo3klhRI+hx
	 K1EmMxaCyRddft8AZ111LaWYSJJO+ugiekQ3bf2Fn9bB9gYYmNc3EObK/hnPW34NZI
	 MnwMG1PEAlNSyOF0ow8Df7ziJAyOv1eTZA/tWVfme61+jkoCrUviQpPVAsaOJF6Qyo
	 MZcyFEDLyt5yA==
Date: Fri, 28 Mar 2025 08:44:49 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>, pmenzel@molgen.mpg.de,
	tiwai@suse.de, geraldogabriel@gmail.com,
	regressions@lists.linux.dev, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] Revert "Bluetooth: btusb: mediatek: reset the
 controller before downloading the fw"
Message-ID: <Z+XN2a3141NpZKcb@m.b4.vu>
References: <Z+W6dmZFfC7SBhza@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+W6dmZFfC7SBhza@m.b4.vu>

Hi all,

Sorry, I see that an identical patch has already been applied to
bluetooth-next
https://lore.kernel.org/linux-bluetooth/20250315022730.11071-1-hao.qin@mediatek.com/

While I'm glad the issue is being addressed, my original patch
https://lore.kernel.org/linux-bluetooth/Z8ybV04CVUfVAykH@m.b4.vu/
contained useful context and tags that didn't make it into the final
commit.

For getting this fix into current kernel releases 6.12/6.13/6.14, I
think the patch needs the "Cc: stable@vger.kernel.org" tag that was in
my original submission but missing from Hao's. Since this is causing
significant issues for users on kernels 6.11+ (audio interfaces
failing to work), it's important this gets backported.

Hao, is this something you can do? I think the instructions at
https://www.kernel.org/doc/html/v6.14/process/stable-kernel-rules.html#option-3
need to be followed, but I've not done this before.

Thanks,
Geoffrey.

On Fri, Mar 28, 2025 at 07:22:06AM +1030, Geoffrey D. Bennett wrote:
> This reverts commit ccfc8948d7e4d93cab341a99774b24586717d89a.
> 
> The MediaTek Bluetooth controller reset that was added increases the
> Bluetooth device setup time from ~200ms to ~20s and interferes with
> other devices on the bus.
> 
> Three users (with Focusrite Scarlett 2nd Gen 6i6 and 3rd Gen Solo and
> 4i4 audio interfaces) reported that since 6.11 (which added this
> commit) their audio interface fails to initialise if connected during
> boot. Two of the users confirmed they have an MT7922.
> 
> Errors like this are observed in dmesg for the audio interface:
> 
>   usb 3-4: parse_audio_format_rates_v2v3(): unable to find clock source (clock -110)
>   usb 3-4: uac_clock_source_is_valid(): cannot get clock validity for id 41
>   usb 3-4: clock source 41 is not valid, cannot use
> 
> The problem only occurs when both devices and kernel modules are
> present and loaded during system boot, so it can be worked around by
> connecting the audio interface after booting.
> 
> Fixes: ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller before downloading the fw")
> Closes: https://github.com/geoffreybennett/linux-fcp/issues/24
> Bisected-by: Benedikt Ziemons <ben@rs485.network>
> Tested-by: Benedikt Ziemons <ben@rs485.network>
> Cc: stable@vger.kernel.org
> Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> - Updated commit message with additional information.
> - No change to this patch's diff.
> - Dropped alternate patch that only reverted for 0x7922.
> - Chris, Sean, Hao agreed to reverting the change:
>   https://lore.kernel.org/linux-bluetooth/2025031352-octopus-quadrant-f7ca@gregkh/T/#m0b31a9a8e87b9499e1ec3370c08f03e43bfb54bf
> 
>  drivers/bluetooth/btmtk.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 68846c5bd4f7..4390fd571dbd 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1330,13 +1330,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>  		break;
>  	case 0x7922:
>  	case 0x7925:
> -		/* Reset the device to ensure it's in the initial state before
> -		 * downloading the firmware to ensure.
> -		 */
> -
> -		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
> -			btmtk_usb_subsys_reset(hdev, dev_id);
> -		fallthrough;
>  	case 0x7961:
>  		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
>  				      fw_version, fw_flavor);
> @@ -1345,12 +1338,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>  						btmtk_usb_hci_wmt_sync);
>  		if (err < 0) {
>  			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
> -			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
>  			return err;
>  		}
> 
> -		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
> -
>  		/* It's Device EndPoint Reset Option Register */
>  		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
>  					      MTK_EP_RST_IN_OUT_OPT);
> --
> 2.45.0
> 
> 
> 
