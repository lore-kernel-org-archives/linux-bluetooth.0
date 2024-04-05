Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA81171672
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338598; cv=none; b=NvVptbmk5QPM5+2JrDzJKalfEgmpw+gp5/mk7yRVA4xeexmmh+5iLeVoSXf4a5oRYBH/caraO8PTPn4+8q0cKwNLi4NByrkOF9D+Lzk7hkyY79Rq6Vu2/q+e5GtsQX80DHheU8hb/r0bXGJaI7FDBC1ize7i/w1Aefl4tlu48u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338598; c=relaxed/simple;
	bh=foZhaE+9tFI8slAgA+8tGEq2qT03bni5hQ79OhwBEzQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pPwIO3exSbY45nfIz6TwD3Kn8aby5+AQ1rZV8F2I8nJmNdljdf9sn1aqPYK8mIMa+tHb0nw/kiTfxJJKuQMRBqYn675oV6+3zb5gZBzZzyxUgY2P+f+OnU0x/A9GeAJ8D6jLNE1ueYrBOo0GWLylOVXn3X9KIHVkQ0Y7AKqXlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTG5qmjL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTG5qmjL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78d44fc73c5so61849985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338595; x=1712943395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3nmJvS0TkcuEwiCJkoMByaWh2YL4Ak7or88hXRvg1B4=;
        b=XTG5qmjLHHKtWf6b4f4LraSz++xZRGWpwjOKwHTZWL1Dow+emrmR4JEEjDf9PL2HUG
         UTcDwwDGM1X1z/bTMe9N58exeSuhLEagyPtsO0RobipEN9DHYGP05NHAczf0yDqBXfpn
         h7qO+f97MObQtTSI1yGb60+4F18U6NtTcko+Ds68Gsujsmpf/fVhQpnbpVtr7pIVAiDw
         SqBnOZH+iu5RyAbtr5AXMSCxQx8vrMB90SIuwSVK3i4woVOHAEYQXsPERVatjVN48QDP
         LvNdAhE6CJcsyJDvq3KFFmNz2a/iyaV6ryzkRxoAgLvYJgiROi3B6wGnA3ZvfXX4O4SX
         SKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338595; x=1712943395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nmJvS0TkcuEwiCJkoMByaWh2YL4Ak7or88hXRvg1B4=;
        b=Xb2d1qKYcY/i0MnoSAkeLl7QzUnmAfrhkOYsyrhmbAJFnYrM2I92TpEcT6RDsNf7n0
         54oyS59hBVUWHOPGkckQIBq619S8J+CVho6jgikhNVGtaS+G3ccoiDX5/MjSzEFKSRY6
         WnY8U9sKvOzldqNYU7JcVOznLTXxZhQmj7nhhVqTeJMofB9JUx1xRm+pOVV6NWmCp6qU
         Rz58F66f/iFs2NRHdDLzhBQbjwzNvaStmKCPTaGUS4W3esVLRoT8rdpKO89kMG/B/PmA
         TDx/IZQeChmcNx/bfYQ9hywU92NPaIVfAwwAegAlrnNBx9bPVmRO7QlrwKO0FS7dRzbs
         IENQ==
X-Gm-Message-State: AOJu0YyxyrjbK+ONaunMUZmH05cPVM3D7xs/2iI97ePYnvuRrX51yLBc
	BVADJL326vvYsTJRTRw1FEpgWmyCKIjvT59FNyvmpZyPfBOb88f1U5gkzOnO
X-Google-Smtp-Source: AGHT+IFJsLZftyL6dUYPEBEgKVJy92U/8HyqKtoXTGLKSyxc/hSUDnXXy67tLd9p7XPrKxu+MpUaLw==
X-Received: by 2002:a05:620a:580b:b0:78b:e738:cb89 with SMTP id wm11-20020a05620a580b00b0078be738cb89mr2250568qkn.14.1712338595602;
        Fri, 05 Apr 2024 10:36:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.2])
        by smtp.gmail.com with ESMTPSA id wk16-20020a05620a579000b0078d2ef6dfe2sm808560qkn.125.2024.04.05.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:36:35 -0700 (PDT)
Message-ID: <661036a3.050a0220.345e7.5caf@mx.google.com>
Date: Fri, 05 Apr 2024 10:36:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8669786082179438016=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5,1/3] input/device: Fix not handling IdleTimeout when uhid is in use
In-Reply-To: <20240405150432.3360157-1-luiz.dentz@gmail.com>
References: <20240405150432.3360157-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8669786082179438016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841848

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.86 seconds
BuildEll                      PASS      24.20 seconds
BluezMake                     PASS      1705.97 seconds
MakeCheck                     PASS      12.75 seconds
MakeDistcheck                 PASS      180.76 seconds
CheckValgrind                 PASS      248.78 seconds
CheckSmatch                   PASS      349.18 seconds
bluezmakeextell               PASS      120.01 seconds
IncrementalBuild              PASS      4822.98 seconds
ScanBuild                     PASS      1039.02 seconds



---
Regards,
Linux Bluetooth


--===============8669786082179438016==--
