Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080162;
	b=gQBqnkyswcQkofvI/0bFmi359fIq4vAA4aYb1xqPNQ4JOu1gcUhNpMxKQRyX13QhpUCJ
	 B3/F6Lvkv7d8u8UWljayKMgrPA6eG/L8G28DGVn9WgZvVVrxzpDzZqgOSQiSZK4oxSr5W
	 Hfv3GOUJJaSOtb1clYZFtnkmHJmGuvrXtmEA8FZHdr0/wYl0D+PVVb1cRLJC14nHmwoBm
	 ORzIC0KXZNC6BQGNahcVC+9zVFh1mFNhw+6E+orsvRWx/BY9gAeEUscDg+cJZOcZ2+LLC
	 DT5rzSVyfZxEQUVAwvmrYzCwHyMH7zBV7vvLkhD3jNR7wpAirNDTQK50MMYPAwL8vTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Z2mkzdEe7rkSTOPzGg+4cqtf3PvDpQ03m+QKClVDejs=;
	b=pNuNzGG/vtBhHOQIDqhMpjTbD0HSdzVml84tHVStzQNfL5iUyN1/k6nc34eYizgWdOL1
	 Hx+kwAabEIVUPOdFKws21lUzr2R8gOSsfXFGIq63xosYmt0XkHJ4VUxz5LIx0l9FtAX6q
	 GkxCJHTR2boiC7Rz4Ek22xt+uQ7m9SMcfgQpCAqvqHAaz+iZsjkfHMFQWV16+1uXGY4LW
	 3TuBPaHUJtfb+IzQmXg2FgjDlxZn+wyFMDxa+jFDdcm+p66tzR5fThGCXgF0vooBNGfGo
	 crcp+t+FxhJvl2T8w2Ev3LPMW54IoYH+arL/9gEnFQ4D0kM4DnEEB1wekvm+qRZ9ovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Er4wr0q7;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064A606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 19:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9064A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Er4wr0q7
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6e560e00a86so1014869eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794080161; x=1794684961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z2mkzdEe7rkSTOPzGg+4cqtf3PvDpQ03m+QKClVDejs=;
        b=Er4wr0q7QZ+GtqCvvlVBuNrAs7qfycWT/tSe8jI2h/rVP8wAdgmwf31e2DaCnleDzB
         KWEtTxE198XPv8K6DaJv+1foYZtxD80fVHRLIYSg7tIMbuS4sNgLpj81TftOH1toX4T8
         YimRE0cR7erevAwIC6Tp62q+WmVpG0z+xW44uSuBvmDH+06OsHO3wEe9VsqB8LmhH6c7
         d7u2LE+FTgjgU3UBoXYDwZ0+9EqptpxO1NF6is4cEudt6Q3dC6aJykAtO5T6sbaK1Hem
         D0owDJ/B3pmZOLG9MBwKgOcCTQzsMmS7O/dwWO4Jvn9T2N99KVyw8mPv8GY/5NsMZrJF
         3A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080161; x=1794684961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2mkzdEe7rkSTOPzGg+4cqtf3PvDpQ03m+QKClVDejs=;
        b=uHY6pS2xJ0bYN/kYNVgJT6ttUZXB8Pxr/e2FhBKWqYQKCJ94QfIunsgf9VX9zDAXVv
         uNyA1UHDnU7ZUjMATf8lXwBH3dXA7mGIDP+4WO8Hvbby9NEmgP8Brc9FI1ApGS/xyNtj
         MsAc+A/LU1nXMwn8uCpYu4+8qvorWvOQtkRxKDORnYhI/vYmWiCxKCxPOSe50XzGG40T
         1r3Lfx93DJRu2XCGRXDzf2S5POdgb9H7CQpAzwD7TofTHnQREutYgwnimyERHjenvPdC
         dk1h701n//aHXdK1J1ngPkDkSAWBDtEfkfxfjktXewAROucehLC2zzxFUudjwWq8UaLN
         rFgA==
X-Gm-Message-State: APuU4Z86jJwHaWAXQswT63uWTVFaoL1GklG1xlopsdE7sXvCzuNTEyRL
	NHSsouyK3VzSuo/3BlfP3sMMzOYBbOwRlWhHwFtAEc60NlO0iBcnSR0e2AIo7PJc
X-Gm-Gg: AYBFou1dwC9TP7iES8l5+yxIyDW8qARiRZTGxUnLcBP1AcTWPybF9MXXomllJuq4Buf
	ZQVf/FqJeww1loeJbYC7xUzyZ22wWLBjv8Sf7xMxDgbJnXvCszsaCsQ7VFV1co8/nz3NQH7DVDx
	8wdGAlO6DaVhWt+zihujS7f/UWaZMTX13H70esO+6wcyzyhyGn3Jho+ohRXHXWM+Zv9+aVOURd1
	rNg8uj8g2YWj/V4/SI3rjxr0G7Nj4oRN62n0DrPGUX/WrsQ+Ot1CXbMeqmrn+Dg/49Hr20lYvSQ
	JkwF52QkDTkhXMhhOf7SCXHu7Kt9SnWOxSk7Ir11Ym5qVaWaC53ikAQOxzldc9XVCbyOhC666qB
	+mRnMBqxxndEgZDCoGPBJo7ARRmEYHvDBfqARiJ0zWYfLS1E7u1ZtCNGNHZrfyzeyTOK+WVmG9o
	ub/XGacC0Pi0rAihW6XCTl9JsklwIoT60i5N1gouPYOVvjZGE/JitjGM1f9N1jBX2g8rb9r5rZw
	KkFHpr/N6cwdg7yY6B1JX1rBncJWSq+6A0jooxU56i7y+lSJiyr1GvJNWo9X4fRAmob5X9sK0lO
	mQdh8pQ=
X-Received: by 2002:a05:6820:2206:b0:716:d5d3:b77c with SMTP id 006d021491bc7-716e78e4875mr3776667eaf.19.1794080161422;
        Sat, 07 Nov 2026 11:36:01 -0800 (PST)
Received: from [172.17.0.2] ([4.150.182.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e9fa704dsm4540470eaf.4.2026.11.07.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:36:00 -0800 (PST)
Message-ID: <6aef7da0.3a67f976.1a5ced.5b23@mx.google.com>
Date: Sat, 07 Nov 2026 11:36:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4007857026200132695=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: hci_bcm4377: resume after ACPI S3
In-Reply-To: <20261107154839.89941-2-dev@deq.rocks>
References: <20261107154839.89941-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4007857026200132695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204959/

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      27.70 seconds
CheckSparse                   PASS      32.92 seconds
BuildKernel32                 PASS      23.90 seconds
CheckKernelLLVM               PASS      25.36 seconds
TestRunnerSetup               PASS      566.09 seconds
IncrementalBuild              PASS      24.43 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns as errors

1: T1 Title exceeds max length (86>80): "[1/2] Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns as errors"


https://github.com/bluez/bluetooth-next/pull/1086

---
Regards,
Linux Bluetooth


--===============4007857026200132695==--
