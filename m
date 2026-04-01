Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A23E92BC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048238; cv=none; b=itWlWVVb6XNMxzb8MzjPL1j7XPDWDOHDotp5vU4MsfWDrSmIBvhK2nQlPfMhd/dBHDhdHoPnLcjoDSGszU1prD4ye69qgcAU5Q8fG4kq0WtXQr1SN3IBiMueU/YAz6VBtz3Q9LVeQg5Mu5Ea265BFueXpSbJYl2noKyi+DpCKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048238; c=relaxed/simple;
	bh=igWuzOmbkXkaX/rlMAWszr7IPIz2hr2AEcHn+Kklfo8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mGNcnGmsgG4AjYDGTbF3VUjp36Aj5C2q0NR3dfoJeBtcTWQvJfeMPxqrFs1OKa6PA/MPs6EH2utsR9YRoOMfz9KH7cvX0j1QhmlCE4ocV5kMHuR/wfXwZaNg5tf/uq3t6wwBDyVzOFbpS6N5AGrtOtUFRW7bdTiIta2Hb5jQz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO8egXAJ; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO8egXAJ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1274204434bso834986c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775048236; x=1775653036; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6EJExwJkscdjTlRaJesnIQE265w4lZXrqz1CDUk4n80=;
        b=GO8egXAJVlazHtW7EzluKMgNBqcdetRlARpTuBk7MhDxXn9hbvDEGOp34crxj2qtXp
         Kth6EXbkT/zCZxnX9Ba8hxtCIenxcD9JiqigesDV83CRu+ZHlc+n1OYNH5AuOCVxbJcn
         NCe5uCD/MEkYw3DhUTlai4gB73XaaJsB1OXQSws/5KFf4oqmhSK3S6ioxx44nuSUZdnF
         gz4zX/O4ZuKEh9g3vMOJ1t+uTZ5uaPHibdQ5kfngvEdOChVSejZ+sSQ+O0WBpCkKwJyd
         b2lpHRtjnkdasMRZxJCfNCqvcBRRP3Kszn/r5iVExew8FdWKCXh9N5epx4ZEkZfno3EL
         ChnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775048236; x=1775653036;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EJExwJkscdjTlRaJesnIQE265w4lZXrqz1CDUk4n80=;
        b=Ty5uLbmcA7+xmyGLJ8p76KpkVG82lbWyromad8QqeCpyxwUJG+Sd72tRZOlA51XUci
         gaTkO752XrGqoVBlhU2l0ZxTLA7yv+YNBmhpSAgAFbUMWXtVmfCugAqq8/ptmJVpCrsq
         pqnymQ0C5poBGZXHdWntcVUObggr6ZNbYAjgWKuZ/Cp1r1ZRm0m31t16/CPuuIo5/TQ/
         hoAjYuj/JVBMyb3M8/6R5AVlgJtaq4BClbm1dgqAStJCdkIfNGWrcqSBTHJAqqIC4YXI
         yziwASqSHa3+fqodayYGV06rVmQ00fbyP8gc+OtVyB5B+2Uy3VOBk2mP/sdDDsV4CHAs
         PySg==
X-Gm-Message-State: AOJu0YzXZGyOmnw2JSeYWaLwa3HUZkLBDSZXW9Pk9M68YNPgUqbGnxqZ
	SgVRAopuKZ3pO4qSj/YSgzwG6s4iruZ7rA8kH1U0k0WB+XrcJv/p/8yq3UBf3g==
X-Gm-Gg: ATEYQzxxBn9re13g9lgbGGs9zxFy9ud91eoEEbjQgtOPWzdBW/rrRX0ErxsqS8fCIoV
	iTfru0/2yUXSpeBQTMBE/xc8LaEkO6wBmcqKznFtLV14WlDIB1hWiq+wBZfRYBOqxxQRYRdXuLf
	ptMQE0vmmIp0r7FjBg0O5Pc6sdubyqfrAi2J2sIlSdjXT5pVOb1gshMdSVMnfHmOmoeIIykj4Oi
	P7e3K0pBRBMKlilii9AkOM+TLGY9zYh9xcXQiMJXVoNrOv0wah7y06fHONO20lMJeX/NesXLTnE
	Uq6n9+bjnzzLMKQCaoUnu654gzCwaW8GBmBm+hEoZ90MACALn4s0+BrCnqCR57Lbll64A9c0VvE
	+GsKtISuwI1eY19CcJKxYKLp8oYbxnKk34WgO5/hrBdyNfhsRISlqxWEB5pX1+Xb2mFX97qn2If
	Ee9Vjiy1o7MX7Kew+ODf5HBFORVBi5UIE=
X-Received: by 2002:a05:7022:307:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-12be687e353mr1489854c88.19.1775048236320;
        Wed, 01 Apr 2026 05:57:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f904sm18320552c88.9.2026.04.01.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:57:15 -0700 (PDT)
Message-ID: <69cd162b.050a0220.23749c.b108@mx.google.com>
Date: Wed, 01 Apr 2026 05:57:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4005648406089501173=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: [v1] src/device: Fix stored gatt cache DB Hash value not update
In-Reply-To: <20260401113930.1430598-1-mengshi.wu@oss.qualcomm.com>
References: <20260401113930.1430598-1-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4005648406089501173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075787

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      641.23 seconds
MakeCheck                     PASS      18.36 seconds
MakeDistcheck                 PASS      246.04 seconds
CheckValgrind                 PASS      295.39 seconds
CheckSmatch                   PASS      350.55 seconds
bluezmakeextell               PASS      184.26 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1028.84 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1998/checks

---
Regards,
Linux Bluetooth


--===============4005648406089501173==--
