Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F35224AFA
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548642; cv=none; b=o96LTZyGdVTaCJYR6SY+mCgyyvpQpq2/G/pQOQICqQ4JATBVYbofel6Lt3Kfs3KhhRDUmNlgTEk3NKlV3d7ECJNb9WnH/uFELyXgRpHWA5P6vBARwod3LkIlQ0yohoKf6lYOmjMzwVuXN4AOxTOun6kC5Y8ycxLo3+iE0LXoLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548642; c=relaxed/simple;
	bh=pu9i6WJObbHafMlfQ/apNudxYA59T7cct+2Y8MPMJ7M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UqpQxAYR9DtLpJyV5CdxdSEqD0HPvR6JLnVsKVWnSigM0/qcbmuz2fqQ/6Gi0w9k5K1sEUNbkcAuwYi86/QxTKjOl6DmMXDp3DWZPJclOTHHwFUacYYR/L6pjQN12WgvL7M4EAv16awx0yBNAfdrM29ZvQcOZ7iTKxIhi4EmYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1DM0kKs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1DM0kKs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237311f5a54so25596635ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548640; x=1754153440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pu9i6WJObbHafMlfQ/apNudxYA59T7cct+2Y8MPMJ7M=;
        b=B1DM0kKski2H667zSx2kHpBVkYq6Z2PXWHObw/flZod7QtJmCMINL3zFERcTExGh7L
         Mj3jLFusoijjNg7md4HoFFY61juD437BYEkm0ZfIK+UDKC7MyDeI3FhDQbzJ5p8SHLIO
         ZfISjnb7NoA7NFJu+vYNLRYU2aw5/uoNpMpTYxrEN8k8wyddAFthy4SNP8uotSjDCXk9
         L9GIGzeoPaAZmWyblzREYa0G3M8qnFru+ej7xhP2o5vk3akiejjLJLHoyqtPaAvmDnMB
         Qh9ojrbfi0eNkoAuIsfd4Bna/lxpyyXkTggPPlh51wdTZgV5gU4utOxgcgq3BETbiM5c
         TI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548640; x=1754153440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu9i6WJObbHafMlfQ/apNudxYA59T7cct+2Y8MPMJ7M=;
        b=D71nAqfixEdQUxHsTAbjw95nk8b4VUPxHinW1IfzE6e6ADH3LcwYzLbcCejP2UdWgH
         TMBTQTqb0Us5s3ts+KWRemyc9Ts3a+A774uZ96stgXMD03N7am8GUbbg3LKGgFqXBvhs
         ezH+nObKF4UukHdMP8HkkmBADJQnxtGedvz/XHI7ypMv71GBWAAiTPUzVkJA0OSypP+3
         Y97VYoYY4gLgA2fPi809RmfqlEdvzeCCV77PdbVmgnlPbzmno6VcCJmX7BBQEZh7ADQ2
         /rGj/ZE4ykXVH1Al8kHUYc8GaaW1j2lmcQ3fsa4zvl5u2l2y3+nIJoqu5xdDzYC6VYgM
         I7zA==
X-Gm-Message-State: AOJu0YxpW5eLnTLVrwfMTK0QDvWKGJmZsjHIlzXmd4fVg1CM2dN85KF1
	BK0JDQddb3MxIPnI1HS5kQK1PDAw/QwbQcqlgZcBPGUyGnC4g/TK6dgUO2ooPA==
X-Gm-Gg: ASbGnctUucFraUEN4r+6vupyPjbhfmIoRDxXmIkfYdPnxlsYlDdx8RpeWm/EDwYQjGw
	HoLtrsbwQ7bEIJc98YgQ+gjOhfg/o2Mr7e+EaAt5MwolXbbDAyZNclhxywY+GYZAuVHCQie3kV7
	aQYUwC/2g86d/O++He+cUOONQVzHSAjkUcclsvmSeB9rC9+fNdCWQMEChqoVBtAZILI7UQpDC8Z
	p4bW27YA0H2abpcxgiQnTbXlVXFIBz96FrDhJg1bjNYhyNRupAv2DY5/b3GQtSJ7T8fBpxlg6oR
	xFAZ2J4ZlkGS18D0hV164kKJlMn+EYYYstFwAPlBa95IQI6wHsvpAbcXMHI7g4oBkJzfy2ChR+2
	uRU82TDsU8pxYup5JW12aOIaF7uCCdw==
X-Google-Smtp-Source: AGHT+IGOxROIOS+k5kf13nWoUcCU8FnvnObZ2q3dICk8fuOgCubQ/gdRFlXiCjs9NiBfzsW7UxawtA==
X-Received: by 2002:a17:903:2452:b0:232:59b:58fe with SMTP id d9443c01a7336-23fb307c7camr87073575ad.1.1753548639852;
        Sat, 26 Jul 2025 09:50:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.196.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fc73dsm19919135ad.108.2025.07.26.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:50:39 -0700 (PDT)
Message-ID: <6885075f.170a0220.13d533.88cd@mx.google.com>
Date: Sat, 26 Jul 2025 09:50:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6299020882453882299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v7] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
In-Reply-To: <20250726164012.1395970-1-kiran.k@intel.com>
References: <20250726164012.1395970-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6299020882453882299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2574
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6299020882453882299==--
