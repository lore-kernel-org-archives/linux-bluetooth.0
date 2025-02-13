Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7C23F405
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453353; cv=none; b=loQyKGYTUnH0+VrfU0Ml3wMz3Q8Z5kn/a01u8jiPuPsOpVmIYtuy/NLX/0zZSMlYTqgl0iQIkq2SlOGD6P3ONc8BeOKd/TPzRsU0vInyni+6FRGyAFqeO2FMpPO6VC6eiq3jCsfEwZLq9yLG/HkuY3atzMsLK7/xbBDb7j5aZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453353; c=relaxed/simple;
	bh=nm6HxfW1x4bGkNGXM5H/mZCyQ5kNSEs8+vKbbM/Cl9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JgDYCxv/7rVK1uS58vcyMq182yp7gjj8GZrcilWdJ10QiaHvuDwJnOQRNX9u8R5ljYOwypUdCcTZalco2PolOvz4MJtN8xeio9kUv9+hQLtPwG2hRT3rgLs5KsorZBHlYQx50SpsYSbWQg5W84qX3e0OiI1d7vdbFaneOi+rI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPpnd25f; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPpnd25f"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5b29779d74so781611276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739453351; x=1740058151; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm6HxfW1x4bGkNGXM5H/mZCyQ5kNSEs8+vKbbM/Cl9E=;
        b=IPpnd25fyiIiFB0Os72NYG47qXUoXuvgSGGXkWu0V3o+Cf0Hff9t7F4n+FoLaJg/KL
         dz2m/xQ892gGb98+UYx8u5XA51JNqXvVQ9BBMk+0TAXitgadS6TO1ZRx0tVSZBHsKwaR
         ueU1IuY6KcopshvnykNX/3wDkFRedz4fj4O2rRRLa4QkCrFUFI9Moue+0MBgSINqHjF0
         CU+6IL21mZ0tnIaAKKyUMsbhqz2IdSXdiVIOhTA4EgbMsEs3bx9Oh2osx7UnvS+ZF/Hs
         cVlXvNayDlzqecWh2iKU6VehzhiIrbtVLCDUaYzzTrpb4qm4lMe4I7TYzhNA20axJoSn
         Y97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453351; x=1740058151;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm6HxfW1x4bGkNGXM5H/mZCyQ5kNSEs8+vKbbM/Cl9E=;
        b=fKAojNpb9z39qkPThyNr4PQ7BpSz8iqfd4qxsbw/ac5DPoUi/YPUlFv+5lvz4cgPN2
         RqcePLt1vaRd8ssxkCUlUi8m4V2q8JNaqn78UBXSjnr2xdRIuv1G0+cWm1aqGUHIDO9H
         KQ3XcRFSJyDJ3LmnTB9ifYQv84QUUztoVYJo1UMls2juHFhDK7oyzBOBhSuErBNFIZlF
         U6/494h0wqNthDiCjMpjW/3flmcnoXA5iMhJ1ESIZZHIScAHvw3//IurwERanBcSSHa4
         ML4AdEy8RuniI5wpubxodg9F4Kn1EF2klrsKkiz6c1OpWtt+2FNicTyr6D3mJ3V3H4Wt
         7o2w==
X-Gm-Message-State: AOJu0YwmE7Ly1YSZQpBpuKPWpM20qcO3hTcpXd4EiWVKURPWcGxW7oZP
	VRYbaUrFBcFPbCH7TlCmh6BgzpsZQ04WB6YpYgdmC9fQAnYTUBH4PngI6cHNd1HUC8DiTaXt/wr
	/OqH0z2PGmQXbGjpqROiPvjqNbgitastA62Vvtg==
X-Gm-Gg: ASbGncvRCGJaw9qtVaAzPqSLcIFI80lLWzOpF9WdfEbonIKP4HoQNi1XmFwKPn9whaN
	lWJp9DIkRjoQHD2fQhGKoAewhl2tpKw2SDQ2ACs1QRoIVwDuMcF3//IiPBEKwHiYT52Z7BVzw
X-Google-Smtp-Source: AGHT+IFYNI+l+VY/pmieWjb+oRXl7xc2maKQQ/ee0lQ4VlZo9HN53J/wDxkQ7a85RnOIldNR8FGmp45CgWFFrpj04a0=
X-Received: by 2002:a05:6902:990:b0:e58:3565:8ad0 with SMTP id
 3f1490d57ef6-e5d9f185eccmr7785487276.46.1739453350775; Thu, 13 Feb 2025
 05:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
 <20250212175427.131356-1-arkadiusz.bokowy@gmail.com> <CAGFh027qyNyE+h3g+nxLy8A3eXyAE3TDYZGXGg4sRwM8XUpMEg@mail.gmail.com>
 <CABBYNZKs1wZ8UfkKyq8pGXWEkV4hFbC30kWm7-SwSybp5JwKvg@mail.gmail.com>
In-Reply-To: <CABBYNZKs1wZ8UfkKyq8pGXWEkV4hFbC30kWm7-SwSybp5JwKvg@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Thu, 13 Feb 2025 14:29:00 +0100
X-Gm-Features: AWEUYZmeNmGMVDB-5XnEtoKqtX91YoXNPyUykkCeQ6mKsztgbmuayA9aSgG4U6k
Message-ID: <CAGFh0261nz9spMpzYqHdHDL7bL_SAmqSbO8o=M_sr-XG0tEn2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] btdev: Broadcast EXT_ADV packets every 200 ms
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I've sent a v3 with a couple of updates so it should now use the
> advertisement interval rather than just assuming 200ms would cover all
> intervals.

Awesome!

> So we will probably need to fix that before we can apply it, I suspect
> we are getting more events than anticipated causing the steps to go
> into negative which probably is why it hangs, anyway it should have
> stopped when it reached the end.

I think that I've fixed that in v4. The case is that sometimes the ext
adv parameters are set with min/max advertisement intervals set to 0
(which is not valid I think ?). Because of that, the broadcast timer
(with timeout 0) blocks everything and the test hangs. I've fixed it
by providing a default advertising interval (according to the
Bluetooth Core Spec), and checking for invalid values. Also, in case
of high duty cycle advertising (direct advertising), the timeout is
set to non-zero (10ms) in order not to hang everything. I've verified
that with mgmt-tested and everything passes (except one test which
always fails with my setup).

Regards,
Arek
