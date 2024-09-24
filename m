Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF114F124
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Sep 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183542; cv=none; b=Rfws45uv8ohQ7ROgMDvjtlkgEXBaxc1Oap5ISxxRu6YfSqBmSm3rTuSgeA0qg57Y2oqg2dyRfKa8ilO5MsRI101jOFx2hADPSTFfcLlcV9CzB84+1jdP6t3K3J+fx6fsv/jRlnPDJQ6SjCJ+58BLKF/T92ibVSjOXiBH/XlJ8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183542; c=relaxed/simple;
	bh=6o+Kyyx7tkf/BtLXLZtz/W/w1HPI5hZRpVuqWP+EwTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQUwi2338BQOrtyBvflaVxJsvZx2Z4Nv8KM7dqQ55PIMtyiORuSVZx3Q/Tvnhlzn3Q8swkIGkaueKd0G1LmJVVn55A5Auvw+N0cu+O7ofZp8zUnxmvhKiWHVrYgp1Drvl2VCQAx52kNFPIPxH4/j5QHPXSorO3eB0++A6OcERW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rcUcRIav; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rcUcRIav"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7E95B881C1;
	Tue, 24 Sep 2024 15:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727183532;
	bh=LYR5I6AIo7oyKlfXUaLMgwNto2wn/s8/lyga7UDdws8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcUcRIav6ZaDS6s3KuXTc6TxGtF4xnbrpervazsUlFINaDLf84RAPXaBObaU/yKL/
	 qpSNpWiKdPFyZ0ph+pHibLVQjy/5EzWhafkm2qqq8TVkUTKKwjQHw7nHdkO2t/p3/2
	 68MY3KXoH73CC1SHOAdPxhey1q8F9vcQ2w3f2DoQfvrUpH1J5Cc5ILS/8vatcwq9IY
	 xTilt4try1W+usZ9/1Z1jBd56xqiqkau30pINntzwdD4zdMZDjxHJQnvHQXBLXotUY
	 Vb3gPd0zjyMwTs4JtEJrp1Kv39PfTJeuzRZQM/lZEQcqD+meA0nMS4Jm2XDnqlgk8h
	 fph6QaT6Qnjgw==
Message-ID: <5d87b6c1-8709-4d20-849f-34c191722f08@denx.de>
Date: Tue, 24 Sep 2024 12:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bluetooth-next PATCH] Bluetooth: hci_bcm: Configure sleep mode
 on RPM suspend/resume
To: linux-bluetooth@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, kernel@dh-electronics.com
References: <20240629172235.29901-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240629172235.29901-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/29/24 7:22 PM, Marek Vasut wrote:
> The Infineon CYW43439 Bluetooth device enters suspend mode right after
> receiving the Set_Sleepmode_Param sleep_mode=1 HCI command, even if the
> BT_DEV_WAKE input is HIGH, i.e. device ought to be awake. This triggers
> a timeout of any follow up HCI command, in case of regular boot, that is
> HCI_OP_RESET command issued from hci_init1_sync() .
> 
> Rework the code such that during probe, the device is configured to not
> enter sleep mode by issuing Set_Sleepmode_Param sleep_mode=0 instead of
> sleep_mode=1 in bcm_setup(). Upon RPM suspend, issue Set_Sleepmode_Param
> with sleep_mode=1 to allow the device to enter the sleep mode when the
> BT_DEV_WAKE signal is deasserted, which is deasserted soon after in the
> RPM suspend callback. Upon RPM resume, assert BT_DEV_WAKE to resume the
> chip from sleep mode and then issue Set_Sleepmode_Param sleep_mode=0 to
> yet again prevent the device from entering sleep mode until the next RPM
> suspend.
Is there any feedback on this patch ?
