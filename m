Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA23F23AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600106; cv=none; b=u9UPpB0LlxpwWJV2KBdPoZBUkQBdz59+IselVWFftenybzYXADWqIJmwbzSqhEzhVmNamrO5WeYc5CsoxyI806JSpg/syRRR57ZeDw/7rnALI57qdKYPd6p9DgHK+56IcqWeGhEiLpj8zgTzpksO+c5eKbs8E5VSIF/OKrUKURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600106; c=relaxed/simple;
	bh=uYQf5c0BQoHX6DBg7Groisb/ulKzUj3hF4pVgEjeWTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci8LwsattD+w21hpwLFfsAWrk4SZ5FKNgenJot5obV6aWnZAxRAEqhbLNWEyWAtLXPLmLeIGmfFfROK1tcbXuiBfn9l9wdFbnKhiBRnlVPTMfZNHnQY+jxmS6QDgEsctm9qePL8/QnJ03YR8LLjRL55niHYKPjaKpovpcVcVYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8CIlOSR; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8CIlOSR"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb545db3afso1033662a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600104; x=1784204904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+0scXORZJfAFimY9Y8Fd7n7er05lMNqpmWecxRPQPtE=;
        b=X8CIlOSRLa6f4ggbAwCIBRx6HmtuVgrCH4kEB2QhQxOtjKwhbaYUpzcQ9050o0avOh
         9+RNaLb+b7dp5QyJ7pb7OCI43fp1kni7zSsOP00UAa8iMkEKed8O5g+SFm7eRQCWi69F
         9T70JIROMHaV/gukhp3Y223UBnNFw7XAL9RNyz8oXKl8TrxlUg8k2PNk1OwoLsGn96pQ
         /XmIadXLS4lOcKhwQP+d0quc4f60FMm1HNx3BiwINTdXGUDrYnkwoHl/kS8sCJeDU/h4
         daoRtk+mV8LdKLBJnj44VtvO0X0Zjj6Q0KHjDHkLDVKtgXSwXlJmO9P2udzyGysldOmO
         AQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600104; x=1784204904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0scXORZJfAFimY9Y8Fd7n7er05lMNqpmWecxRPQPtE=;
        b=MzH7qUbpee+y9AdNC5L2lwXxjr3+LkEsGHlG/FBHIprmQz4cNbPNA0O6UFknFvo1Qp
         Le32Bg+3RgvwxIZK4RP6gwf2PqehkH+RhDcDY3tDRTD8gVYNoZ8HQbmiqCuAuU2gWA41
         Sl6IKa1RWdeKqWZJKeyrvtYZRPlCxJDXhrWIXaEBeGy6wcx6IbziWlenb2mJ2jF6TiDS
         dHsX5Z8E1sZy6iff35/b2Re1A+SZiyc3i4/t7HP6PR6jRcRLde2UTkUlm0L0dVAbTW2C
         9F3WXCuaIQm9P59xa2REdudbFm4+oCYzqyWw41jMj6tqQOYXqe2rxU+C8pMG980By8Dd
         fgfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pk15GxpgOQmPUWoJ0yK0lW1QEiVqEFhqAkehwJIV9fsTaawJaKdSoq1EsbjRG/WxcoCQx4MFDFzQh19/GhtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+9YBMuRcAsNvusxUUv+ROxDac2DncUSIZzEGL0NcQuFnB93L
	u+n4TkK76G3XSq7sQsBeRO19QG6pqbs/0/GoD4tywCUERVfPD2yC+A6j
X-Gm-Gg: AfdE7cnuXjQ/+TmytuWGUfcIkvZ6Yxy9RKteSAuTlaUPXbCna8wftVm8E5vW0y1C+BT
	pEn/6ld2ji6+i6TeqQHjhk3bnS4Yz2mCu6/ZWJEqVM8UPaZaJXQgsFIElfM5/AW6fnQvBTRVKt3
	TadWxjB1tpSUyDfffhCiaQzoFnxfkxmxy+C38SB/4VWI6RdkbLIxeV/ObgJb0CJh92rXEYpnIaU
	naZNdZGv/DqUIHrmKiQw4nZQ0EEMER9jJtv7rwH55Coe17wsurjrEvkXKbzXnO6cXVKyzwqFgId
	PheP9sRcEpL6kruJnnh4iq2GUJg8bLyYfD9/70cYKs5iQJKR6elpqf+GO7EIPeJ27RHL4eEYpCY
	a6CPFhy6lUV4kJlKItkQG/nU5bwgAIM86sfmStiLXhZ2Pnzb8T5JQFn+ncIc4TBro6Q15mAwUAe
	sDk4TD
X-Received: by 2002:a05:6830:6aae:b0:7dc:d0e3:5bc1 with SMTP id 46e09a7af769-7ebcfe7da83mr5106525a34.13.1783600104075;
        Thu, 09 Jul 2026 05:28:24 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm3947846a34.13.2026.07.09.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:28:23 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:28:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	mst@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <ak-T4SMxr4rw10jP@stanley.mountain>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709114745.4030794-1-haoxiang_li2024@163.com>

On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> virtbt_probe() allocates vbt before setting up the virtqueues, but some
> failure paths return without freeing it.
> 
> The probe path also registers the HCI device before the virtio transport
> is opened. Since hci_register_dev() makes the HCI device visible and queues
> power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> so the transport is ready before the HCI core can use it.
> 
> On failures after DRIVER_OK, reset and close the virtio device before
> deleting the virtqueues and freeing vbt. This also cancels pending rx work
> before vbt is freed.
> 
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing it
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove().
> 
>    Thanks Dan for the suggestions. The blog is very helpful.
> 
> Changes in v3:
>  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> 
> Changes in v4:
>  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
>  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!

These are Sashiko warnings.  To be honest, I would feel really
uncomfortable blindly applying them without testing.  If someone
can test, then great.  Otherwise, I would probably apply v3.  The
stuff that Sashiko complained about was all pre-existing issues
even though for the last one it said it wasn't but it was.

regards,
dan carpenter

