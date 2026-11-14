Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689170;
	b=ihEVs5Ak+b/0LEchFguJTN9k+dAbVQcpFioqKChziq+hYSFRGPbjyu3FJiiVF0pbiQS1
	 Q9Yiam8Z0hTQcY1mH0fJKfU3REOcr11eK4LUiGyiamYXIJaYVtOBKT4iEVDQMi+iimxlk
	 3GgHN5AD81BLkFWWQJ/5qEWY+kRzmkKjtoQLv7/+5NYbmz1Au+aDIK/UeEvyM3c9uYoK5
	 tFz6yQ4DoudGROKNKQbcavNtmllzzfUljbepuUUWmhvwpp7QELGLnOeNcS4Q/5m+CS77t
	 BCaroxf2V2yBetP4gd7uHJA919OYRYpc6aJR35RPUXDb1i9jLXsmPSwauS42EiFiDSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NL4+Fk70yzDuuxKCUs5mVsm4MTEN+C/RypeybrB09e8=;
	b=sHKO9kRKT6+pBheQLat7GHGEMhH0jO72Bx4WEUCtewiLzcDaZ0XAoJT+P5K5H3yTorGw
	 evxEgDDdRDEqxRDDy1hVS6o2Pu1tUCQ6Ce7yG8QKu74oHW68PVoKgUuWqoc+NY3uMlC8T
	 BmnP2BMhYhuhMDzpKSqOAT1HR8N5T9qEAZB/7FjqpeZG7Wg0ds9VVesMmSNPL5yGlO0hq
	 hINJEgjzawAhhW1uCEilpxVcbTEShxG5iAME8/eR2q1S+EdoV7gOfCKZSB4ya/N2bBbHv
	 17gpzblBaR4t4ViMHjGN4JVoYFAqTFUdlNgPZYkGOfVXRc2PN8zB8QDDLKH9/qNJf8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q6Afgp+I;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43372606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 20:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43372606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q6Afgp+I
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53664b4860bso31104581cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 12:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794689169; x=1795293969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NL4+Fk70yzDuuxKCUs5mVsm4MTEN+C/RypeybrB09e8=;
        b=Q6Afgp+I8/ulVWfK4yG2QxDPJ5wNVwlx5/5HtNvzaKgj+i+Re1XEfwDUtwdYL4X/mh
         r9xabmqTP2Hq1x3IWZO3NCWllT1BR/JQMud4yJk0dGNsu9TRXN7v+yZlmuJ7pvm+rgKq
         YIeaotHAFPce/DJGX9X+4ik5gwmtUkWxf+UVZx/r9oO46JEoqyOJXc9nphsbUY6m0nzt
         9mrnN27ALN1HhxfRyRqNMrAkTOJCkumq/Isuapj/WhLA+CrSMSFKjp1xUs+sBqQbhBWz
         Ak4UaozCzOcem2QsQB+WE62PV/Ar85CJX9ZI9Ix9/cVomhL7GJ5z7OxGCTfr2L3iIcSg
         TlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794689169; x=1795293969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NL4+Fk70yzDuuxKCUs5mVsm4MTEN+C/RypeybrB09e8=;
        b=zIx7HnDlbYLbxN2rok2a2jODjsXfgJs6E2UlJezttfaSzIMN8UDxA/kq0cRjmCaQDn
         zD+vy/TzQphc256/zy7bdaULGvDahODB5g1KBoJBOAc8+gofjdP81meXb2lmX6A2Ww9T
         4G5sAI3GbD04xf0ZyheDvzDXa73/BmXKIHMq46OLVbAv8lWgNGnWWumLpkbw0MofSd/g
         hPg8jym8hnWeI7kIvvn53TFSoVDTyhkfs1lZtC3hMpOfz0Q0JTQxYwKZ5SaisZQXkbCj
         dA9avxeVOV8k4ORHfXI3dHP8ZZbeqJZckgkpJ0sbxbWw+ipsJQkqbXusua6TAWghkU9c
         1dRA==
X-Gm-Message-State: APuU4Z/XCa9NoQYjJN7+fA+9UOSxElSyJwj0/B1uqLkcrHSWbruhHdjn
	GG8qrC/z8j62w0p1julwnRIOf2lxbBJFs9W/zyA0YSQasNmB7RSHn691nrZtWQ==
X-Gm-Gg: AYBFou0UOW8b2pRl8onuZYlDzi3xYwa8VImORZ4sBRNeGO/uKEpb5Cuz9fndb1PsDx7
	x8W6vCy8UsJ/bCjIm1kgM5xVYnXkBv6gfh2//sh3H5jVM6dspQ80rWvDSGy1uTbCOHYVpP8vsiq
	i0vGZnPBgJPyq/NbNC4T5AGSDPXM12NHf3F3CDe/RRx4vvR+qbbBn/cHvgYxKqz6hj/7FCWnS4D
	756Y0uzYFbhMFTEebinQlV8ZPi3+mBNjk0XrZInVuFnAfWmoMlGJVDyIE/FmVvWCqFEgOqdH0Nr
	iaK9SGRrSwHWjcbh0k9sX/Lttf5cX+aCRZ9ifRJLyHJguATipM67qHD2S+oYCY3hfZYtULeKhcj
	0jibLwdW5aps7QdDFVJRpIKvkWuFTHwFP5Q7EQi6ASeLV26wAiUthiFbvb8fN/v6N5ZtUph2S6g
	5uo/3W7jomMqH+GKrXvMov2BH7XyXdub89qdP/3FCq0cE/s5Zpwu/CC16MeEpL6OV7tKbbcgxq2
	Bfd2UpIvDHg3ahwAhOIxQo/nmzOg+OH5DmneEFCX85IWrZmyGO9sKOwuw34jw==
X-Received: by 2002:a05:622a:494:b0:533:9381:7603 with SMTP id d75a77b69052e-55ac6d758f2mr105062911cf.12.1794689169091;
        Sat, 14 Nov 2026 12:46:09 -0800 (PST)
Received: from [172.17.0.2] ([20.57.23.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0533d7dsm47502601cf.8.2026.11.14.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:46:08 -0800 (PST)
Message-ID: <6af8c890.f21bdd07.2a9d59.a613@mx.google.com>
Date: Sat, 14 Nov 2026 12:46:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7137464748144725583=="
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
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: Bluetooth: hci_mrvl: Fix duplicate serdev open/close
In-Reply-To: <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
References: <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7137464748144725583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211439/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.28 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   WARNING   28.66 seconds
BuildKernel32                 PASS      23.36 seconds
CheckKernelLLVM               PASS      24.29 seconds
TestRunnerSetup               PASS      550.59 seconds
IncrementalBuild              PASS      22.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
WARNING: Non-standard signature: Assisted-by:
#94: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#94: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14984056.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:156:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:189:23: warning: restricted __le16 degrades to integer


https://github.com/bluez/bluetooth-next/pull/1134

---
Regards,
Linux Bluetooth


--===============7137464748144725583==--
