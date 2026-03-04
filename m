Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31633BBD1
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661079; cv=none; b=BoN2ccP5OpN8s9obprtI9Gr6j+QDuIhxLab1V8h9Ej+lRR3hFmo4KY/+Xxig12mVL3vWotokX5dvaGmLbPB9i5eWQ4iCU5FGKzUCWTBK2j1U099KbUYyStTLAQOSDPxNcz4GXVkTL6sjzJ600sCEba8aB4dZlddMHP/iNvkK0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661079; c=relaxed/simple;
	bh=koMAHpO8RCDB8BmeKMTwCV0DvPpsAFSp0F9yn0+W4Qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tR1MOpeQFrFZcOYV7X6MNtJjK6N/75Dt97Il7k501Q6nnB7DUfHzDPj2aUJGKvls8lS6z4XjsbHAynHK92pW5i9kiPG5YxJG4HbWqHeJ7Zj00YdVWM+03/pXOyGn0i8dc3MyztXtLVWJhweMYiyp6rgBuc4Tz9yEQc4ipa10ubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTLn70vf; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTLn70vf"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8458391eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661077; x=1773265877; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5w9eCCTPo8yMcmjJPm1S49/iyAFgQIdSph63ePwW0/o=;
        b=NTLn70vfZhwDMMRAu1i7OPbxPXJHkooVqKUqCIZFBNYgYQojPgZeY1mf8YqYHumEaa
         mUyWx313UJpk3Uhk7S4714HQiMfgCsdm7JbBEop5QFXIzRVJ9+kF97txAAsYf8jitaFV
         JUmFGovgWOvJTHI3Dbq7+SbS0PWx3DtlIdbBE5uyAp7VDnw5xDg5Re8RZCC61bO6jbPA
         0Gh25NGhoAiAhGp4bHs1RGjxTDuKQhuPTSoYz2GteD50mNqsZdvaODuLSbW2FILMDNDA
         JPbkswEIziQseUejzgvTwba3NMP4VoRQ6NumirqN5eACRiAdpplsk6+IlTEhclSavSIV
         nN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661077; x=1773265877;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w9eCCTPo8yMcmjJPm1S49/iyAFgQIdSph63ePwW0/o=;
        b=WTF6NffzO5Di5eoBndjZ5x2ugPIp/e5E2d9ogmWr22meYutCURuFB4rz7T9s6r4Yrs
         rm7mt4nTAasqQRkym8u0te70lUntSmS2Z5nNkF2Fzc1hBtdw4z64v+YXVZXKG2Cwbr4g
         9ud+D4JFcEYZzoIDfYvsowT7kMeTZ/yyGskKWmwgJSsf+rnVo/gUH15JyY3/edqGEBBt
         VEW7jrkUkvh5sDMUPoshkjJ96RWJiKR+HrEAqNAG7mpBjCda1Eub8n8MynIcijZHPB+z
         u15UKxI2L4+cVTL5it3px5aHKvjEHLi9yZ0D9tNt+1dav2piWiR7McjHZanFxTHROT0P
         7TKA==
X-Gm-Message-State: AOJu0YzLge3Zqj61KJHT0ZWdFcWHbB9JtgrEbbjASArl/3NQGLaBHK8V
	mgrJfuJYpb+TsgDPi1XpZGuwdtckH6gKyDhN+2xS4JPu5fo1WGOJGo/mI5StGg==
X-Gm-Gg: ATEYQzwIhUd3EgpjiKFcAD8ISqGyx73tRiuBrNRQ+9sK6vAJeNne6voMrD2ygpPXG3Z
	XUCaTiSCjdOIRZ4CUyfjfrBYkTk+NIJZjQkBUno/hh8vWroq70jbOCQ6litmCvyIakRxKmoTbGn
	Ro1NllBEJNIBiNgWOHsZIb4YsOewxZbe0qkVGKHQd+xVCXkc9ZFzCBBbmUPwEGXaEfcYti+erPK
	8HFrRDZZ1vLWAAvbhfPB+4MbfjiX+6aKpqGglCGFSQZ14rUEmpsmoynS9ERRy5v2Pp8QXW55A3C
	mLwPrcg1oOPx7ne6VICB/3fDUK/VPOZEGCtyJSbjby5fIqAqIKCkPGJcdOCkF6DPWG/g3Btak2x
	258ma2LNOcg+3d9JZJxbLSTwflmBeLVRiyyRcWIHv5WSxD9+skEIy7XvlGxx/rGRJNRDnbbKPtQ
	B+bi4n9egKLxifNEe9nYoAFjs9Y1Q=
X-Received: by 2002:a05:7300:4307:b0:2b8:6ae5:79c3 with SMTP id 5a478bee46e88-2be311df800mr1279272eec.38.1772661077217;
        Wed, 04 Mar 2026 13:51:17 -0800 (PST)
Received: from [172.17.0.2] ([20.25.153.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2056acd1sm4675637eec.22.2026.03.04.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:51:16 -0800 (PST)
Message-ID: <69a8a954.050a0220.204e62.686e@mx.google.com>
Date: Wed, 04 Mar 2026 13:51:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4137119203981961606=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Fix -a/--analyze printing wrong connection type
In-Reply-To: <20260304204649.309362-1-luiz.dentz@gmail.com>
References: <20260304204649.309362-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4137119203981961606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061563

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      21.31 seconds
BluezMake                     PASS      776.60 seconds
MakeCheck                     PASS      19.31 seconds
MakeDistcheck                 PASS      251.25 seconds
CheckValgrind                 PASS      307.01 seconds
CheckSmatch                   PASS      366.42 seconds
bluezmakeextell               PASS      184.94 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1035.79 seconds

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


--===============4137119203981961606==--
