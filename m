Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73E280024
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081618; cv=none; b=AjzPnWgrVAKicHiSgO1cCAGxEMvSMy97Wnhp4DLlXk3NtCXfF+udCR5Ct329mt4YiZEYy+WWl/adJArp0eqsLy4JS4Znq1gRDGTHh9p65mfmESMpJHHcw8rFyf7TAkETMXWjyll1sd5vImufl23IT2Ii8LZEKQ9Sw7wGc7S2wyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081618; c=relaxed/simple;
	bh=d+JgfX7f+chDjmnMm5X4qjo+aMhbpyauVERzrs1GJsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFDEuwJcHauXEeov7zUZAz6AOI8oCqx392OEtv5/sEz3zzrp4ghpRoYDhmILJI9GoMV5+zdW0BS0o2Q8Gg+2PgyQ/+t5zEh6Ul1XvfcuTaoq+0H24iD2jL1dSK0p7876kZTvDrbL5YPkAtw+hd9PxOLgqesREhahM6haArU6NWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PDCyzPdo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PDCyzPdo"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4261026a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761081615; x=1761686415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKBpLJe6dQK72erPWdp1puVpkmn6KWf/pa47Xj36tzc=;
        b=PDCyzPdoAcpczZytXqY37LK21YrZ/0RQv5XO14ufgTKJzJTcFjVr3LQtK/wSKjqbBb
         OhNeRm1mbniRmP0yWFD71HGWACJEbLT3BfFbPWAvAhIQWl5k/PkymuSEy7LrX0IFuyMJ
         abJRcNhoQyontR+b+VLU6G1KQhIaSiHYZMf217Qm/L+G/5fM9gIV7zq/HJVWef4FVxJw
         UGeQ9mCsEOI6J2wU79H1hDw/nrdth5v5eerEKe21dq4uV9NNPtzjtGt0oVthH5LlyBTu
         K8Km+XTlVkwaosFANyEzmlHCJwTg3+E7zdKd2BsEVz5qBWmSE6mlBdtbxqoPnj2Y0MCF
         U/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081615; x=1761686415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKBpLJe6dQK72erPWdp1puVpkmn6KWf/pa47Xj36tzc=;
        b=bepN2y9drPHbpUjVuwefwwdcnryPX4czOnQC+Hm+57KvaMgWxGoxmdjSPqnHFWaBLx
         wva4isHtI3YWQWZpZSYCBsrhfRKhVzbO5VO3rjgIc4T+3R+q19iANUH0zcC07IcwyQch
         jDOnmZZS7LhrZS9CyPJfM0XKsuDsMkh06wfMb3Dfmn8NTNzaigfGgODSPvIPxHEwRAL5
         zhWYWp6xlgO1WLx8fw6iWLkXLKPmFtB+SFJlt/tIrMUgHzIMSCBjzy9weemwi2YNxiYE
         1oRPvVloZNgsg6dld4x7cjs+nOi0eYi6hs+ORkH6qwVcs63IulddNHRn5ipRTyMcY6e1
         TfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIFQhg2L8RmbSm+et1Kr7TF5y3bumeTujlLfCLROI8985J6EadOZ51sdAcXGvFKx415vu2gvKqkz8SjHMub0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0GKdD+bcGfIfX6KiCmEyZTDDnbvpPolH2RQC8FNoy9MOPnax
	0tgL0YvTZJCYpfmS9sGogi0OvqUDUiVJWEBQGWgthSgdf19CmjJ1QvTTbre35KiyeH9qBWu/X6i
	NrlKE
X-Gm-Gg: ASbGncs5gDWbIE72Q/em7eWHEGkjPVXOPW3TZEO0TX3mKKdTZ0BMyILfXZ0AbsRf1LJ
	dR8wi9pJK9eq6SHri/oDoCC8ZOzk0NiJs6lmoqgeCXrvSwIC/w9274hN+9IecLAX6uL90uQwX//
	YlvnKKzTP77eBg2PJWn6V85ucRZhRSuPD2QozFQ8KXTPYMCcVmPb9xAPLtzXik1QWs7vGfRBr+X
	RGCBpsBUrVkrkoAE5qpbpVQBKnD5+N4QyOZ75/XOhRp/ytCu6z1QFhISYD11a9gSLdS/zscAWze
	OCUOxtFsvdKHVM4W5U0cm16DigmHch4PY4tbfyjdCr1QOsRQXF8A5AVJ2QvibJL3VYZ9y7rxclQ
	4+czOKsjDRSMzLNgCF3OnB2dAR/vCJZQv4DWbz+WWb0sUJaphAd3ql8MNe+Lin6v95jvt5c00lB
	Ig8A==
X-Google-Smtp-Source: AGHT+IF7SOcnQpWdfQ59cqPsx+uS0pX16PxatoEuSqjtpKrk7k2OwEb2NGWnYl5hAvgls3IoLhSOIw==
X-Received: by 2002:a17:902:d587:b0:269:8fa3:c227 with SMTP id d9443c01a7336-290c9c8a5f1mr191001155ad.8.1761081615550;
        Tue, 21 Oct 2025 14:20:15 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm11102371a12.29.2025.10.21.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:20:15 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:20:13 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPf5DZVYrc2YAXXT@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6837167.ZASKD2KPVS@fedora.fritz.box>

On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> Hello,
> 
> while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> 
> While the firmware download always completed without errors, subsequent HCI
> communication would fail most of the time with:
> 
>     Frame reassembly failed (-84)
> 
> After some debug, I found the culprit to be this patch that was integrated as
> part of the current (v6.18) cycle:
> 
>     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> 
> The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> that the private drvdata for the input struct hci_dev is a pointer to a
> struct hci_uart, but that's not the case for the btnxpuart driver. In this
> case, the information about padding and alignment are pretty random and
> depend on the content of the data that was incorrectly casted as a
> struct hci_uart.
> 
> The bug should impact also the other platforms that were touched by the
> same patch. 

Hi Francesco,

Thanks for investigating, this makes sense to me.

Funny enough, I specifically tested this on btnxpuart and saw no
problems. I suppose some kconfig difference or some other innocuous
patch moved structure fields around such that it triggered for you?
Not that it really matters...

> For the time being, I'd then propose to revert the commit.

Adding back all the duplicate code is not the right way forward, IMHO.
There must be some way to "mask" the problematic behavior for the
drivers which stash the different structure in drvdata, right?

Any thoughts from anybody else? I should have time to spin something up
tomorrow, if nobody beats me to it.

Thanks,
Calvin

> Thank you
> 
> Regards,
> Francesco Valla
> 
> [1] https://lore.kernel.org/linux-bluetooth/be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org/
> 
> 
> 
>  
> 
> 
> 
