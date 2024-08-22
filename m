Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D302170A37
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318040; cv=none; b=b1HBVzfdmwunY0c5GsfSlLCUDaFYABdIUD20GTEEi2810cZKc8tjOdy5qZXwotYG/hEcXFhKynwic0A+QKLBrk1W2BL/u2fsJ5DDvc1kpxVxVTQibge8GMqbIwFnQ0DZ3EwbCCSgM0SUThd5VKHE+pgRFd0SJ3z8LS0TyThCXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318040; c=relaxed/simple;
	bh=FoWIETfj5pHb+okk/bLZneQc26QdcDTDPDgDxR0lfjk=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=C2bRXkbUwUZvO5RJxidQoJVE5qckZHOLWVixoG9p9nurAOtXMLgUb/X3cmU/l1hCCjoe0IaL0WEOE1qAXhXz0tWoe5Ovu8of5dbjF038pE0rVKJzC3Sv6jlCTR1uf5iuiZBHDybyf0MGi18/xkJwVMqbUUJCLmZpCdCCqXjXvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1E//eWi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1E//eWi"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so402404a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318038; x=1724922838; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoWIETfj5pHb+okk/bLZneQc26QdcDTDPDgDxR0lfjk=;
        b=R1E//eWiNKc0RCHmhKM3DYamw6kCKJJrSffYot/DSb/40NvQIJT/a5V/KW60uvDZDT
         ZX2/hWeiWeu5hJAyieDOFQKX1qVwt0EN1N1YK6x+mhuurn37Y2Oi3o/QWoexwmQnDVkX
         PHeo8sztYepfBHPSArAP8JydJwTtLVy652li4/xApfF0egP3G4+jVomwHqFsskf8IWmg
         ilbk6N0vPhx6nXHydOJdL5FVV/lidCLR/XYKUHhL1N/GrAa0QhPaXjrlS+IXVDbvuyId
         adpgtonM85PnpiJRWfpY2DhwgtFoUTjVl1vwODwoPgW2vVpzzfznmET9wbK3QspuzyIC
         YmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318038; x=1724922838;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoWIETfj5pHb+okk/bLZneQc26QdcDTDPDgDxR0lfjk=;
        b=e/P2r/Tovbww+iZLYvnv73EswWhRvogjlI0BPqo+Cr2S/mudcxvMt6UwhXMQ7FMSqi
         cKsS4Ql3iOw154ul4MRhf5Q1ytVvPcR0dy/zHvcST3lzoiGaYf9lj94qiFLF8v3JCrbI
         J2bFI9yZASP1zbEQUl8EVz1AXZM2HvQqyHQ1/VFTWikLckE8BOv0XNaeWtQcF9oNIIrb
         aBYcUevmmJgY2GX6AwkoyWuGn7b3P5csbINDaCZ/Ejb66JEMyq1t8a6EaSCgbKzr2EOv
         qxGeLs3P1eB1YKa6KT60iLGsGW22fFQnzPHZ2PNKP5dFSyVA0AiI7MB85+cuqXMimZ64
         3R1A==
X-Gm-Message-State: AOJu0YxEqUqTUcaTymjoACFJBUlza42FBwnxQewOh84GbO7s6EzEzCdm
	zzQ/ZY8DS/RqGdpiK1jzczkFZ88UWJjDZ/x5L7kkxdav88Rj+Mjyen/d7eue
X-Google-Smtp-Source: AGHT+IFWtkMmLg4aQdQkEbiykDIAxeE1BuvQ2WYzbeWtKUG6eXOj0tNh+oI6PJdl35RzJcDI859AQg==
X-Received: by 2002:a17:90b:714:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2d5e9a3fbb2mr5429270a91.10.1724318038361;
        Thu, 22 Aug 2024 02:13:58 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba287e7sm3505961a91.34.2024.08.22.02.13.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:13:57 -0700 (PDT)
Message-ID: <66c70155.170a0220.2e0a01.d9c0@mx.google.com>
X-Google-Original-Message-ID: <ZscBU5sn1wIroBAj@JUNHO-NEOSTACK.>
Date: Thu, 22 Aug 2024 18:13:55 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Applying Mesh Protocol 1.1 specification
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I found that the bluetooth-mesh part has not applied SIG Mesh Protocol
1.1 specification yet. I would like to update various changes to the
specification, such as SAR transmitter/receiver state.

For example, in the line corresponding to the link below, I don't
understand why it sends a segmented message for a multicast address a
fixed number of times, 4 times. This is causing performance issues with
my product.
https://github.com/bluez/bluez/blob/master/mesh/net.c#L3335

Most of the mesh/net.c code was last written 4 or 6 years ago and is out
of date with Mesh Protocol 1.1. Is there a reason for not applying Mesh
Protocol 1.1 or is anyone working on?

Regards,
Junho Lee
