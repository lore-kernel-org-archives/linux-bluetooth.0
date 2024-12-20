Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355862594B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704586; cv=none; b=TcxcGKs27/0BTd+llr+J9SsWjL6mhb50QF+5n+IACvjKiskMxg/ZBUqGTEDbwgTS5sZid+S0H6G4WQ9aenjs3CfrrfHkj+mVaJhKhbXSs8ZPVfbuXLIre9iy7yIZUk1IcGx720fUXNL9vCJktz+cv/ePVEU3D0HQoaEqC8ivaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704586; c=relaxed/simple;
	bh=5etX/1HBkkYrGV/S6GE7gnH04PbM6Yrik8HxJ1k55YE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pkfkdwLG96RNOsCT+1D3haoDFnEzsDQ+tW+tAjNBU4bFkG3Sw5mxPRzE7oD5JyKT0hYUCAZ8OuBb/G/UuRU4QVG969CP2w0ISL4IbcRf3z+4GQDTUBPfZzcz5KLsOuY7NCNQEJ4Luj9fM7LBlVzd0s2xgn98VfEOGnUaeO33aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVrs6m10; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVrs6m10"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d8e773ad77so15159396d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734704584; x=1735309384; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ls5EHlSa+yXIK9aMjNb/eVuTFtNo2cyThrfJQR3OfU=;
        b=PVrs6m10QX/IGOCEaGO7oASnc7t1VZIJ3fj+rHWTrp2BxDR++OWrdZDq/Bb9aMqaq+
         xS0c1z5jz8FckzZuAGl+fWirGLyMW9hNj+Dk/bTyQJqvPiay5IIvoNF805WiIiy8nefJ
         pYrMQi+LR14Skq+EUJqtvp2gsHZ4+4b8iKzfampMinCKjSV3wNRMQVTGZiFiCkqUmR07
         Q9SE4/ThIti4WmB4AlUU1n2K+vVHGSdDWvqt59PQoTMliZnl51RAzrlqgHld+7+QzGTj
         fDMRRYnSK+QDSV+l71xrxJuX0hTLRjZtZ9CawQB1KVoV0HhpQU9uXcZKC4hqDU5tiH61
         2PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704584; x=1735309384;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ls5EHlSa+yXIK9aMjNb/eVuTFtNo2cyThrfJQR3OfU=;
        b=E2N2mWdXm6OIgJoDTnCvA+6v3DjlQW2eAyLMfSG5LM/4ncHFIzEIQBPP6O5MphTL0K
         KbssukbnQHYnx9STWeJG43hi3JEwvCP+QEL3H+Qj0q43LHFqijYEW3Xmdye4oeDKIo/7
         hS4Z/WmkCGy3QvOXJ23zqi+JxOcc6NpNB9PNjvDKiwbeIebYVP1j0n+rVcBJ80/+49YI
         7Wn+l1ME3MUg+7jRWtohkhHBljbxpfOg+eCU9+m71KFaar8CqorSur99HJ4D0KecZhfE
         bT3zwXEuENYKLkA/eMK6L7VnONqj3nro+LmKmlNnr90SAkn2PRrf3y4FkwPunBr5mNdm
         wDoA==
X-Gm-Message-State: AOJu0YzCXlQFEnBwbVVHQHSvsKUsiIjRFS8XCADVpuh7gRA5D5dk6VxB
	CMlh5lEnfil/VM9L8TXazq6YeJzQxl9yEUzES4bqRbfvSg3oKotNd1wKhA==
X-Gm-Gg: ASbGncs9D21Y5MFZbQdjpBfyNFu1iTFLaEcURS/OgkSFhi86PMYmR0ClOGEMjPb6Xly
	SBT2nx/uCTNwnf0sW69ip2E0J3DAwSFCddUJRyWvYdqa8Ntw5jxAxvo0LP34X7p0qDW2en+VLiG
	R8kJ5ClUKQYuN3x747ZQxEAOUXts/AASAyeE567sE9x0MjCdaFArVfrEd9XC2GfUESY0JLKyFBy
	wnbFkmY7DSUPJOzbUB4FlgQtwiI9vWJRMKSxyh8TZ9+ROFTWgDY9XOchLMLzJxz9w==
X-Google-Smtp-Source: AGHT+IHEEoxp9nDe9TtgPPzeYHNZa63rKLf5MIMr36GK+yGREXxNsgaRFwQ/aNV0gltBm3iSLkA/Dw==
X-Received: by 2002:a05:6214:2388:b0:6d8:80e8:d567 with SMTP id 6a1803df08f44-6dd23346480mr59166986d6.18.1734704582421;
        Fri, 20 Dec 2024 06:23:02 -0800 (PST)
Received: from [172.17.0.2] ([172.200.199.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d432asm17225616d6.110.2024.12.20.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:23:01 -0800 (PST)
Message-ID: <67657dc5.d40a0220.423a7.66b6@mx.google.com>
Date: Fri, 20 Dec 2024 06:23:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6496590885685362896=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obexctl: Implement support for message listing format version 1.1 for MCE
In-Reply-To: <20241220125848.84645-1-quic_amisjain@quicinc.com>
References: <20241220125848.84645-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6496590885685362896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919893

---Test result---

Test Summary:
CheckPatch                    PENDING   0.17 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      1614.30 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      161.59 seconds
CheckValgrind                 PASS      217.08 seconds
CheckSmatch                   PASS      275.08 seconds
bluezmakeextell               PASS      100.65 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      852.55 seconds

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



---
Regards,
Linux Bluetooth


--===============6496590885685362896==--
