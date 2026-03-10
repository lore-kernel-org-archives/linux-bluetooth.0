Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECD36C9ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113905; cv=none; b=choabvv5oMNHmS5fYky+WdDBq857+BYh+ciGyJijsRgMwmxhPeRmoieBhfrbDhhJKCdxqxiEGwuKjPuNMvZ/MShQWmgbJvts6X7zqnQn25E0FZDDLC5KQtMxP/oLyixmQ2jXUWtFLPZy8RK/ozi/+uS+7XwNnNxouYfErpq2sOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113905; c=relaxed/simple;
	bh=ojgOvNA7PqWy7y+ckJNWFJpOrdeN1BF5Ovy3OoJe0Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTGo7EfNxbl/0z5w6eFDTQ8oh91jH4SN5dqeGK82QLyURz7mE7M1NiUApQM4fxg3pAE1QURCRnNQ18btWjg0ROE/kX8IhCn/OUd+itdcwF9SfbMc392HntRd1nAJNtdPQh1fwMZ4EazSsWXzl9vWzdTx2rsuHq8kXTEHGxvytvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=0kdpOAXa; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="0kdpOAXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773113408; bh=ojgOvNA7PqWy7y+ckJNWFJpOrdeN1BF5Ovy3OoJe0Fo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0kdpOAXamL6fHhuFZcacog004xcrSI5tnPxAoFb6QcOuBGWlUqRLqW5ee23JqB4u0
	 NCQVYwV02cjN9+xKwlzVvrtV8zmYehKwkohSpoaSxjI9hKSBYx4ODfMdA0RnHziZ1X
	 X1Zko0z8MONtsZTJ9GlyBh5fA+RhMyX7eYLaQr+OCp7L9FtR2QlPKt/RwBXFXeVpnu
	 jP5e1sKMjyDh6wWDeS7lfX3lD08MZQ8mFmEQudnEdZjbiTlq2LAvj58wVjJMGIUuAe
	 3X5gdlmTatmnVj5Wz3hhN/SZdXURlnCO40pDgKTIpMNM7z40pS2x520xGQOC8GkisU
	 D0kQRIA4GhQ1w==
Received: from [192.168.0.22] (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 7F9B2A0AA;
	Mon, 09 Mar 2026 20:30:08 -0700 (PDT)
Message-ID: <941e5399-be1c-4e19-b1d4-04ff9ec2a32b@endrift.com>
Date: Mon, 9 Mar 2026 20:30:05 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 0/6] Nintendo Switch 2 support
To: Martin BTS <martinbts@gmx.net>, linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net, luiz.dentz@gmail.com
References: <20260308124745.19248-1-martinbts@gmx.net>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Martin

On 3/8/26 5:47 AM, Martin BTS wrote:
> Changes v2:
> * Drop original patches 1 and 2 (tollerate ATT timeout)
> * New patches 1, 2, 3 introduce a device property skip_secondary,
>   that makes secondary device discovery optional
> * set_alias() is now public btd_device_set_alias() as suggested
> * Fix assigned numbers reference comment
> * Link to v1: https://lore.kernel.org/all/20260301152930.221472-1-martinbts@gmx.net/
> 
> v2 blurb:
> 
> The problem is the secondary service discovery. It will time out on the
> Procon2 which is essentially an unrecoverable error and we cannot
> connect the controller as a result.
> 
> This patchset proposes making the secondary service discovery optional,
> so that we can prevent dealing with the Procon2's behaviour.
> It now is a property of the device, if it wants/needs a secondary
> discovery, or not. This allows device specific plugins to make the
> correct configuration in time, bevor a gatt-client is created. The
> default is the original behaviour: do a secondary services discovery.
> 
> I marked patch 1 as a breaking change, because of how it changes the
> gatt-client interface. It appears this gatt-client is only used
> internally and never exposed so it technically isn't a breaking change
> for BlueZ, but I cannot be sure.
> 
> For the record: The Procon2 reports appearance 0x0A82 Portable handheld console
> 
> Martin BTS (6):
>   shared/gatt: make secondary discovery optional
>   device: allow skip secondary discovery
>   fixup: propagate new gatt interface through codebase
>   device: Rename set_alias to  btd_device_set_alias()
>   dbus-common: Add Gaming appearance class (0x2a)
>   plugins/switch2: Add Nintendo Switch 2 Controller plugin
> 
>  Makefile.plugins         |    3 +
>  peripheral/gatt.c        |    5 +-
>  plugins/switch2.c        | 1070 ++++++++++++++++++++++++++++++++++++++
>  src/dbus-common.c        |    2 +
>  src/device.c             |   33 +-
>  src/device.h             |    2 +
>  src/shared/gatt-client.c |   22 +-
>  src/shared/gatt-client.h |    4 +-
>  tools/btgatt-client.c    |    5 +-
>  unit/test-bap.c          |    3 +-
>  unit/test-gatt.c         |    3 +-
>  unit/test-gmap.c         |    3 +-
>  unit/test-mcp.c          |    3 +-
>  unit/test-micp.c         |    3 +-
>  unit/test-tmap.c         |    3 +-
>  15 files changed, 1133 insertions(+), 31 deletions(-)
>  create mode 100644 plugins/switch2.c
> 

I can't comment on the other patches, but I will say I think it's premature to be merging Switch 2 support, as I'm still working on the kernel side of this in ways that makes me want to not lay down any API that gets merged into userspace software yet. I left a comment to this end on the DKMS port of driver as well.

Vicki

