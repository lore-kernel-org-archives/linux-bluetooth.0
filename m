Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD64908DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728480; cv=pass; b=rbfXHRU9PMX8MnHkfOQgq49ADjLQmItg7dRWfx464u++zDGsxcXBdT/e+iFK30zEQUhdjqQYKjaRLNysAA0Ptg2jBts903597caufEuHZEWx7GAzHm1RI0QHgxtcCEZnjTCd4/tgQhBiRxaOcH2YNTx18nGwBmU2Kmpi85kuYDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728480; c=relaxed/simple;
	bh=cMAhXTxKST+BbN19sMnWBii6J7NPHNBohpo0/gnXSX0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b+XttCEjcp9raoiNWkg+O68F5VBEjonIKD2mj0GXSZuRAwwkgRMGHmVfWF62skH5iiZfIEY7ZEOuZT8K5ZqeMsGu20cSMNObMLi1kYiKJkhaJjWD2/AX+ZJfSr3m6+1PffHej4ETL8W1KlYse4wtCA8AX92YGwzFI3QojRY0744=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0rIcgQK; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0rIcgQK"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c2d726650so1890017d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786728476; cv=none;
        d=google.com; s=arc-20260327;
        b=o9PPDSkdR8A7vjwuo34odnqY9IaJjtYxe+98Ohbt/tnQP8OXXuHUFpyJAhlWOYvhMr
         kQktJbMbDSlJY5TTnjMDmOxUfSiXzRPojtmyoreA+0VOtlH5iYwZXajLBzAf2Ol4Zmll
         1Dp6vVbmFvq31d/tevIo8DHtWmv3usZVA1qkk0chdkUoISclBj4dC75+T7p82BmFGaPK
         g81aIbOofVWPFhv+qaWagzJmcvCS1RZ+lUa/oKxHRcawXfjgeKoqzzrI/aIU8Rhzd58U
         i/RCoaF55o3zlVTESZOYhKBgpqTeJS9KG61mwAe6W93QnohiS0HuvrwCeqqIVo7J4sNa
         fF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=k+GpNRQmLMU/jRcK9JduMLFA6fhCK37AT4JMXUBACeo=;
        fh=74rkiHhO6SD5qTdxKi330AKT6NU0go0atxeLVF5TEsU=;
        b=s61yfFOW5csyUv7WG5YWZFVCNG3lBNwPvo/IjwgSlbO3rTkQ3XOm589XO6dHaHrVNy
         nlGQwNIcOUlFJ2CfFaU16ibu81zGEVhFKQvFf94u4tcHQyI2slABYVjoDM82xG3T1JF2
         6Hfhno0pK5zl3Xm45c7uasRtqZ+jAOQtULGbhep4NeJ0UdRffEwbr1vzhkHSzqszOGa4
         08CINwFyMFV4UUQXIYy/wl6MSZOu5nLUXQ/SKi+vkp8n2/VmxhdlsNs1HgxMqiDr5YBD
         MD83xlRCpwERNdJZ8D4SPHjQe+t0gLI10HoraWNMc9ufdQm9qyzZ+8XYtaYxWG9mmkim
         Wfog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786728476; x=1787333276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+GpNRQmLMU/jRcK9JduMLFA6fhCK37AT4JMXUBACeo=;
        b=p0rIcgQKomdWfuhS5mm7BErwtGXqMKXI3AWgP1EwbE7z+pKwaKH8qAkUbvy5gRl1u4
         oAFCn2fn5gGpoqev5K1SExA8ATCB9nr5jWXLusYJTMRutg80+ETB2QaZGetu6TxB2LNr
         0twGHToCroSlIdqvjHgNTC/Dg15aYxzbC/tka7aDyP1aEGC3ytVvbYCfM/O/4ALKE+hD
         5/DfC4hKIp4ShUBUBW22sSOS3yM+QTyQz6iZSNXp/zzhJ6z1gMQ9cMVucapYpbfPKuyq
         vhmtgCuwNyT0T+WWnvWjs4EI5/kKGUPjGmnMLSXGtub8PSNkq4O7peSk/YSRDDEbjOKA
         vbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786728476; x=1787333276;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k+GpNRQmLMU/jRcK9JduMLFA6fhCK37AT4JMXUBACeo=;
        b=HP2Sj1Txftegs1QdO9klJAXdUDgYBDj9AlabeQpLbqLdQMzz6zgffxSOKv8xKsi1AO
         +nTs9PAI5Hv5VC1LNfct01/m9RDqfvey1RWwLF7CrfLqnk+0e+a+veSTn5P2BGrXJzJh
         WjxI4lSne3cehM3aYpPv/co1TSkHedvZXXYKQpVIGqjcoOsfWvO87/NsJ5NjDkThgMo/
         awjbamTc/Yz8M723qTsjHi9UFG2RavJ5zufqyxN0gONTBPRHh6pd73dUHf4wqk/LHBk8
         kMd0JTzUGpEv2Ccvcg23uxNgiinpFa+76MG5LUIzPNSpWGq3ZEbHZYwbIpZlDYx44QWm
         ahfQ==
X-Gm-Message-State: AOJu0YyEePmv5/H4ou0vB4vuy1xbyBi0/WgLnSiPBfCWB0jmZrn0TLnm
	bc+eSiLyG6lTruvysvuBekH6MPBWuA+gnWI6ihxnaE/CN1hHlE+TumMPMZMtGPIEgGviVf2aYG+
	uRlsDQmkETNbjin+OKsJQy9kMvlrQoUT0eU0wwp3U0IUg
X-Gm-Gg: AR+sD12Pc23SXaAiTq1r6DVmuDJGL9TZhcH92uCDeSyuVdYf8BSVXDgg3dJWB1qlamd
	6Jwqen3b4gOEBMZb0r/xI4U3tEW/aD1C+ps7DDfCUhcdgoNBbI3o+wP7k9e0x2fUIAlBSRfnPwu
	SXrkmk0KmRzl8m9H5cpj3kpjZTJGH2ebT3GgSKUtK84e/jfG7S2+l92IU1C3TUlW0ftNRu1T9Sy
	99zl6l3O8jO9qCjILSEIC0hGg+QDN+V1gsGjBgnHQZegH4qD022UvTG2rMlAlnZe4gJgg6ljS/4
	hoJw2WXiilKjavW6Snbv+GjSijefMEZ7THv1RsIy4WwtmQ==
X-Received: by 2002:a53:d3c3:0:b0:668:4a0f:a5af with SMTP id
 956f58d0204a3-66c72d21550mr2366259d50.40.1786728475716; Fri, 14 Aug 2026
 10:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elman Shahbazov <shahbazovelman97@gmail.com>
Date: Fri, 14 Aug 2026 21:27:43 +0400
X-Gm-Features: AUfX_myhhqK5Nbq0XDtHVLM0u2ISrLPhuNOKNhpYWcf8SxT-4VzV30DO3lHfo_I
Message-ID: <CADE-WFd0FhWa=cc-w1_cm3C8kRdc3PE5HaFJ+uSM+99jjr_wjg@mail.gmail.com>
Subject: CVE Request: BlueZ AVRCP Out-of-Bounds Read (CWE-125)
To: oss-security@lists.openwall.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to request a CVE ID for an Out-of-Bounds Read vulnerability
(CWE-125) that was recently fixed in the official BlueZ Bluetooth stack.

Vulnerability Type: CWE-125 (Out-of-bounds Read)
Component: profiles/audio/avrcp.c (AVRCP GetFolderItems parsing)
Impact: A remote Bluetooth device acting as an AVRCP controller can send
  a specially crafted response with an inflated name length field but a short
  packet size, causing bluetoothd to read past the allocated packet buffer
  (Denial of Service / Information Disclosure).

The vulnerability was discovered by me, and the patch has been officially
accepted and applied to the BlueZ master branch by the maintainers
(Red Hat / Intel).

Fixed Commit:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=bd8989620ed6

Discoverer: Elman Shahbazov (shahbazovelman97@gmail.com)

Thank you,
Elman Shahbazov
