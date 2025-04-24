Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1B1B4227
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510188; cv=none; b=WwTpcYLvQpRrzdkGukEENlfN2HX+ZuoTjUso9hhAGR1T0prwVEOUy+AqiKp/YOIduc8d9GwnOD93VBUuN1Z1jPwjBXOEVorsAnP8RIJ5TslrdPROusfcqVxXtApo0mxyehZ4zwcoIr9O2wyQR73q5OZz6XDUmnQy3necamDovfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510188; c=relaxed/simple;
	bh=hAtWCo2twW+q56168HlpOUnNJv9Ena+nP+WZhNTI0/M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WhdWLZCJMNyFn1uQSn1gMUINMm/OQr3YLnGBkTxqfgju4YaSjNFOgY8ano5NEHxnwo4DlL++l2DRcrPvFyt+19NbF/LsnYtxuYzU4M61MpnFjN7maaJiyPCmP6epmaIvaERs6t84Fj/qOJhWkJrJCrXSZMePPs58RnhGpNWi2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSlKM7+Z; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSlKM7+Z"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476f4e9cf92so9104721cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745510185; x=1746114985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAtWCo2twW+q56168HlpOUnNJv9Ena+nP+WZhNTI0/M=;
        b=PSlKM7+ZXq0Gtfde5w4X0TNFolwAXx+ogexOtfgfdOCVxM22hv8tvI9bJU/BBdOc8u
         OMwhsg0wEHLwcvmOBxVDVCvBrQEcOhJXzeEgJX3173QLdVaZw4gWelSQHS8yULNUhgRl
         dHIEYZnjUZ20ADta859tDbm//ya03fDNIaOhTRXGVt29T5ccBQHlc9Ha2IX+Mw7zGzG8
         YPltDhVa8fLNOvIGwqNKMub6Q/wAJjrtVxpf++0gBXEMwafmBDVWE4cRWNmz3syytt8I
         I9ZgEpEdfUPSfIl7cp8wUUDH7i5dLtT03yvuZ6afScwn2CYmHtOlgC21gOmE/pY1n2DA
         LnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510185; x=1746114985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAtWCo2twW+q56168HlpOUnNJv9Ena+nP+WZhNTI0/M=;
        b=bgsgtqjmLJeqzlSZzvd8JK01eL3DiRHjtCO8pgWZAadTewI2sqkBIJaJqniTKF91ka
         vEybXomL2EmjMMOytOJ8B3qlFAJz9LbHyVN8Ya+FCwHor7HRlgLfg4AJqvKhszQyJqIV
         NhkCNHvk8LxyD/hHF+s491hWmT53f6pT7nT2hWJ7NYu4fdvmfWTAcbhZ+olDHwY5U4st
         vAMwaNTm+CuG3xDQWrRrifaxUqcXMcc7Rj8WM1kYFZ7WKdv5Lzqi4hdcztcXz5Kyqy8s
         7PHcwqBmbi3e3dP2t7Ryj/iIGv0PiOAreBVcPpxRcDh3JVnUbHkiEg5+rS2LMESmWDUa
         s6Aw==
X-Gm-Message-State: AOJu0Yxc+rivW6OdlKSBDDcQl2Z3kPEYY4cTFF389zFAAOtb3sh5U/ma
	w42Mu0mln44kHqMTBE2ps4dUccHLWjh/CL2SyAe0GNfRJcgr7aZm2c9BuQ==
X-Gm-Gg: ASbGnct3u/x93+E9ACEjkm7h3DNDXzOgXZv9GWyPgC4qM94Gt0BK8szyhTMuRYXTJN0
	iUoVLu96fkuU/mX/VC0vYsdz0mHO8V/K45HiH8aO4fLxQZi1AnzbYUDID/KMR42kVdrXX85Gs7x
	TuAQhkADVRF+JgDsVI429EiURP3KuFGcZbSXJPsc/9JKWJY6xQGmIbeoUkb1iKr+nsAVSTRxavQ
	qoqsCx5hwkvMU073EppjWDXySM/07PCQaxiB/l1zwBwZ9rIdnNvgI/smiFt/1sqljrVHEies3tj
	boQYvD3c7yYuqDsBoWPBLcnHtHwx5zNcLlolrfZD1XwAfWWI
X-Google-Smtp-Source: AGHT+IG52D0udnGp+S78DIn5NuXROt4EXOtV12xV1BoHKh4uTL0f4F7Qx5VPZgO8aqm/fEN/yba+tw==
X-Received: by 2002:ac8:5aca:0:b0:476:903a:b7f1 with SMTP id d75a77b69052e-47fb96e40e3mr3136281cf.11.1745510185159;
        Thu, 24 Apr 2025 08:56:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.79.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea16938e9sm13131091cf.57.2025.04.24.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:56:24 -0700 (PDT)
Message-ID: <680a5f28.050a0220.78df2.666c@mx.google.com>
Date: Thu, 24 Apr 2025 08:56:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3580183605333152322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] workflows: Add sync action
In-Reply-To: <20250422214935.993192-1-luiz.dentz@gmail.com>
References: <20250422214935.993192-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3580183605333152322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: .github/workflows/sync.yml: already exists in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3580183605333152322==--
