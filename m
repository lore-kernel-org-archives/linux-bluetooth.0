Received: from nx200.node01.secure-mailgate.com (nx200.node01.secure-mailgate.com [89.22.108.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605D266581;
	Mon, 17 Nov 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.22.108.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379070; cv=none; b=ldHabMc36K1t9m/lHlsqxb/mM9Ztra9F0/KxwZvaLJNxlNiQefO2ytlA+kp+76oFhzi/xZNzsmB8WWE0ZKMRzEOLCgvcVszEZEj2VYLixhlHJKrQhwOWyzdhhYzEqmr/ZXUdTABv6fjmVFdsAl/ub5ltCmMm0S5bybtE1fGIY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379070; c=relaxed/simple;
	bh=dMPLPEo7NeoT5P5gpZhhrtUcLPahyTrxmVKRhKpw/NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U70SkY3gIUoCvRO5FOy1HXsq/ibVeGUyraLPrV/cr2M653Pl2S2S8IMdhNfCHU0ARuf2He1RGZgmeKDbXqwEWLwJkJklxtLK9fdhAc3Tbk4p+PYBanoV+Ag/nq1oLxGXzp+vuYXzjs19u19WVHTnOHXi/9eWv+zYn5IcRTUbTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neukum.org; spf=pass smtp.mailfrom=neukum.org; dkim=pass (1024-bit key) header.d=neukum.org header.i=@neukum.org header.b=fA79ULLv; arc=none smtp.client-ip=89.22.108.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neukum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neukum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neukum.org header.i=@neukum.org header.b="fA79ULLv"
Received: from web268.dogado.net ([31.47.255.48])
	by node01.secure-mailgate.com with esmtps  (TLS1.2) tls TLS_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <oliver@neukum.org>)
	id 1vKxRb-003uMv-I9; Mon, 17 Nov 2025 12:30:57 +0100
X-SecureMailgate-Identity: neukum_org;web268.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neukum.org;
	s=cloudpit; t=1763379050;
	bh=JI+QvdjGVyITEA0RfWzECN2xWvs6UXPR+6ZncK26C4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fA79ULLvj1hcQd9DG2SL6JDwFLGuHdDCE9VhxR+dIvPKRDUBAEwrcEPl8czwSi78s
	 25uiA2G/+b9wcFGAvW3xdcu/3HfpRqq/cL7TV5kw1p6EpdiUlNMabZQ7DN3YF86FM2
	 v9TpHC4RURnyPcsyCVDZg2x68DLKq3R6FWk89Jio=
Received: from mailproxy6.dogado.net (mailproxy6.dogado.net [31.47.255.222])
	(Authenticated sender: neukum_org)
	by web268.dogado.net (Postfix) with ESMTPSA id 752EB28170E;
	Mon, 17 Nov 2025 12:30:49 +0100 (CET)
X-SecureMailgate-Identity: neukum_org;web268.dogado.net
Message-ID: <dd8f4ffb-23b7-4dd7-909f-923ffcceddec@neukum.org>
Date: Mon, 17 Nov 2025 12:30:48 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issue with devm_ methods in disconnect and freeing memory in
 btusb
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 Sachin Kamat <sachin.kamat@linaro.org>,
 Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>
References: <aee37797-a280-47ea-91ac-487ddc124ac7@neukum.org>
 <aRdwvZdbCEap6vuP@rpthibeault-XPS-13-9305>
Content-Language: en-US
From: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <aRdwvZdbCEap6vuP@rpthibeault-XPS-13-9305>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SecureMailgate-Domain: web268.dogado.net
X-SecureMailgate-Username: 31.47.255.48
Authentication-Results: secure-mailgate.com; auth=pass smtp.auth=31.47.255.48@web268.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.21)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuW1MC2l0615hdYB4XqNvq6PSnwhGbMFMlwY
 UjyOy0WUYCu2SmbhJN1U9FKs8X3+Nt2xp4kjpLhmBfm/1jJBevzt8RFB30Ars0yTQ/BrMn+JnS9N
 dw2t5iMEflZxRNqEOiZizSh2f1rWsE3ZhyRR3OEyCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYvhIO3OPuApEENzBIwyefYO48PjF2L3GVxHSajlUCf0ZlwxsU2jMuBNCauY+qeVRqcM2HNV
 91gBZQ/1Pbs8eo64MUJTS2Jsxpkx+IHIsDarm2U3gyy0nlbakKK22WPBaizjKzb+JrnOTbl8FYp7
 CIWjverajYy2yB71RZy29b9HL7yliuqXZvH3i216cQum166kf/ld9xdbddNOGSuUXWv94PtbjLq6
 i876g4nLFuIm206wm4jyRZgLX3JeO1DimxffguuWRCT69XJD0VIf1Sv/utspepH656ibybPLqHoc
 HvpVQ/LHxirsNla37u2pHVFz3YiTLViM/bE4mY1qNrjcLCp1LDNBgpe9gGVcAseQ2CVZSXmdZ20d
 kJlKTM6tEuf8vTtpnDhFVFAXN/ieSgx2ezpFj0BqG/t3fGWq+iiriGm2Olw7NFWD50jbuEX0mdKm
 jhaG/t7hemlhJ+woX3OFSK+6iFsnJVr4u5Itb4fUJJQp+axrkf/Hwt0r5Ay1T6TlgTl6fJxyntEf
 hZCKje4ZOPJmqKySiclosAYjq5HhmyPxWFVH+H26km3T4pig7/wWquhQPjfO5uXT7j9W7u8qTfD6
 cxsdFKDXY5IAQfIM9f4GlAB0wMVfGTDZkKNlJZ7r2RGFJqPDOmAQctmh3zCCQYCC8/tQPot8U0pa
 WNjxskVSyyHYFz3ke8hj2G27QEzg7f7w8jy1FzdiCx53QuIcgpyfZlw7Bq0We+9rBz5aplVUjpsk
 cK4Q8fRu49B7wJHz9p/e5RuxqdsdqZOMXNAdnRq2H0n9jhG+7muBS1X+VskYoN/g2a11WysdYadd
 IKZKTPmNuL7Typo2qFGjUhbtexo0PPTHzQ/IcgTHsStfGQmWU3DLBa/Iqb9nb/10bMgJueOkx1xF
 stQZshD/AdZEOcH0BPQeQFSwUcz39j/B+9lut0mbmApkjKY46fp6K4xHLjrNjqR2xLJfNZLtGdAq
 lVubB2rCMF6RoS5UV9u3bLZbcIJ0GR+Pe2PV4kBmHm8qxX2+VcRHEBh0q9VNLRGJDNhzVfdYAWUP
 9T27PHqOuBMcaL/3sdQ+aU4L1Br+MEtb1ej7FoCtQ+x7KqtJIKKlUnGMDHzvLQLaIP9xF4j6wA==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com

On 14.11.25 19:11, Raphael Pinsonneault-Thibeault wrote:
> On Fri, Nov 14, 2025 at 09:03:45AM +0100, Oliver Neukum wrote:


>> We must always be ready to handle any arbitrary order.
>> The code in the second branch of the if statement used to be perfectly correct.
>> The actual breaking commit was 98921dbd00c4e by introducing devm_kzalloc()
>> for memory allocation. That ties the lifetime of memory to the binding
>> of a driver to an interface. In hindsight in a driver that binds
>> to multiple interfaces, this is problematic. Hence I would propose
>> to just revert 98921dbd00c4e. It seems to me that we have discovered
>> a design limitation in the devm_ methods. What do you think?
>>
>> 	Regards
>> 		Oliver
>>
> 
> Hi Oliver,
> 
> I was under the impression that tying the memory lifetime to the INTF
> interface was intentional since 98921dbd00c4e was from 2012, hence my

No, it was not. And it would be kind of defeating the purpose
of a devm-method. You use them to not have to free memory manually.
In the disconnect() method of btusb we do free memory manually,
only that we do so implicitly. And that is dangerous.

> commit message in 23d22f2f7176:
> 
> -- quote --
> 
> There is a KASAN: slab-use-after-free read in btusb_disconnect().
> Calling "usb_driver_release_interface(&btusb_driver, data->intf)" will

Was that obvious to you?

> free the btusb data associated with the interface. The same data is
> then used later in the function, hence the UAF.
> 
> Fix by moving the accesses to btusb data to before the data is free'd.
> 
> -- quote --
> 
> However, it seems that support for other interfaces was added
> later, e.g. by 9d08f50401ac7, and out-of-band wakeup support even later
> by fd913ef7ce619.

ISO support is very old. It is necessary because you cannot
change the altsetting of an interface that is in use. It is
a design flaw of USB.
> So, maybe it just wasn't considered?
Indeed and hence I would just revert it.
This is an accident waiting to happen.

	Regards
		Oliver


