Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="QrKoYOyM";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="XA/4VWr4"
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC16171F
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8X/rG85tFwBMLr8RWEkzExxUAraV8iuIXZPdEh5RREQ=; t=1701418745; x=1704010745; 
	b=QrKoYOyMpRlepv6O2Py0ELH2KVRnfkJha88ct1e68MnNmlAwwevSJ6rmVKSQonYLDXs9HVIEciF
	EIMVGQAhgdLuK60lvkKWyaqSPfcuWvccTwWYI2rdvu4O68jIgijQJErUQilpgAx/0u2jtAZLZDvKw
	p3yR/ZZ18A+onAPmajdrWf+of+8X7Mt/Tq6pxRLqrKobQrFxooBXgtf1AXCUAYiC9EKXPh1bvgxuv
	m2jMEnumQzPITbI6UayknQ5paULaIREuOB7QEhYMKs7giCmOqvm5j0K3+c8BWvf2MXwh7SN78hGOh
	VOcTzpL48DA/Me3Cl4NvlWNX96p8y426l3Mw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8X/rG85tFwBMLr8RWEkzExxUAraV8iuIXZPdEh5RREQ=; t=1701418745; x=1704010745; 
	b=XA/4VWr4M+GTJRKJX6gBmbxTeyMTLHVp+ASoSfl8upmAdNARAsGWlIA6QNtKdfGp1C5eXxV2rEZ
	fC2g4PR0IAQ==;
Message-ID: <115e819b-0271-403c-b034-ef3aebbb85cd@moonlit-rail.com>
Date: Fri, 1 Dec 2023 03:19:04 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zach <zacheryvig@outlook.com>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <ZWl82n695TIC7nUO@archie.me>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <ZWl82n695TIC7nUO@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bagas Sanjaya wrote:
> Kris Karas (Bug Reporting) wrote:
>> I have a regression going from mainline kernel 6.1.62 to 6.1.63, and also
>> from kernel 6.6.1 to 6.6.2; I can bisect if patch authors can't locate the
>> relevant commit.  In the most recent kernels mentioned, bluetooth won't
>> function.
> 
> Then please do bisection; without it, nobody will look into this properly.

As only a few people are reporting this, it must be pretty 
hardware-specific (or perhaps Kconfig/firmware specific).  I'll do a 
bisect.  A bit too late here in Boston (03:00), and kiddo's birthday 
"later today", so will probably get to this on the weekend.

> You may also want to check current mainline (v6.7-rc3) to see if this
> regression have already been fixed.

Just tried 6.7.0-rc3, and it is also affected.

I hadn't git-pulled my linux-stable since May, so that gave me a good 
chance to test the very latest.  :-)  And conveniently I'm now set for 
the bisect.

Kris
