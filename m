Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D783A3821
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648402; cv=none; b=VJ2kFCIb3+I7ijzSWJfFpjD/jgnxMs4k+aePKfe9KpdmPFwwk5e4KXhhl9rN/UnHa15XIKn2S4OdgTshm4p3qR+eU1vU10DtSKl5ZyT3BzAUv5EdRFrp4x+7E7NKSS3JF3h2h9IVcY82SeVCIrbm7LgBh9zrcQlD8HdJ0T73GlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648402; c=relaxed/simple;
	bh=XtwqWWQFfpr+e+VYoYYPuYX32tcTydj+FPxNBaUJyKY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n//ZDR6+S8+ffnr1Fq3MHu06oK7Yli9l3elG3DXHExJerMpDHsNFmng8PiICNKxLIFas0fcySJnUhoOCXinfjFxzfVhCGCh9/AAB8SOdDaJ0GSNWlUoqzRjaufU/PTl45uqnK3JdimA+HRZ5DxXpVIWdhJPk/m5XCGBua5pdxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdzhp0Dj; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdzhp0Dj"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-53331a61f71so26341421cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790648399; x=1791253199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8n+hB7NHiPk+7y6biO38Qq/C1IyJ23Xp1FMU/7Jeqac=;
        b=Tdzhp0DjVyKiqPRPfVL+KFYhCVdCqBk6TzLCIb4SkcXeVnhu23jYN8e1gl18mpgH9f
         fjg5ZvPJsIj5g3UK0UG395I4CdLclHRayOS+JFwrn1cv/M/rQg59v6fpwcZQ/mfV0CVg
         Bs2+6czt4ZNyJHbqGciwJoE2xDyLDNvFUOgvzy0jzZx4IU2nBssF0JL2dW2VmU6HwsNI
         fxQfHGShzmkNL3IW12sonWruHZYI9VprLH65MVOARRYv5NmmPw1AM9g3DQMcevccXE/1
         X8OMkE2Nsme6zrnCbb79dFUIiu/sGy/TmAa4X7qJ30TLkIoQ9LrGJTubJXYJN740Lqa5
         lMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648399; x=1791253199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8n+hB7NHiPk+7y6biO38Qq/C1IyJ23Xp1FMU/7Jeqac=;
        b=pfOfFgI1xP9xpqDONgpY/7QffT2ftGkOFmoGw+0wcBqRj6YSqWoFacRUgpCo7t7z8f
         7DwnTIKXOk+Y35L0mT6Q2mehDUEJNu6YgO4RcLJ+z2vvkC+UA6AY6Ru/9IG4tTUIjR8R
         mF809J7+pmUNjqPGGRlq0g6/FuokK3NUS5vHx660sPx9dZcuw3HJ6Pdj1uYyimVSO5Zq
         3UwKs00kA4n2N0ki7PKSLANOLowAdWyazxjqXI0PVCGmTPVUZrLrvtYL9wkn3c4cWh3N
         3Yf3L9zG7pR0ogmPfqk+mWw3tfd73LBf3BfM3XxH7Ie/EPA0TaCc2L3XRyGEByPaqEf0
         u7yw==
X-Gm-Message-State: AFuF++kuOyO6CClPc3LaMge+0sLFAFmVsNF8+syQ7nDNpAKg7NTZ1l+m
	vH1lPRk0Ycl9ruYHcB/getxQAR+BK2SvUhuoT2Lf3tRhfUqMN/2HweMyXG59JN9q
X-Gm-Gg: AYBFou1Fj++ifiGGiudgHDEF2bV1JQWRUa+0R+7+2FMpp/DdJ8eeHC2bVva62np69rQ
	J5OFbrEM35aYC2qpxHl7UnGiAE4NfcEeOVyJ2oMlI1j5aQErrfvP+w8AljYFRyZHCThLpu5ikbr
	1b56OOPs3sZ5WUKHoZXP6AJ75oq9ykTlc9w0Koj/r5fAr+H3QWDtV9XL7jDh1Sx18FP8Hv4uCky
	dVr750tIMsQYBbg1DvsOSx/a42jXMcgavCCu5pysLBdpr/TJjxN4diSMLZeDqBEJ1OGdcO8Dcv1
	j/Ao0mSnMFOVtnmvrnefFdd7Xs0eMsiq3HujEOUKprUF3thJkEtq6GdGnGuDqzxwGPn9YtG93XK
	mLx9YvOAoPWMuqH+N2QrHpSUyjKDR6VaVwfVJCF5w7/m9WHIqFI1xxVrrwFgiIglzCVMowEkMAH
	eaJJrW8EsDpw4m/logRnVyhabPG9OVC6L3r0bBt5yGAAi89cb2RIkHr92wSELL750WvUf9IElQx
	l/BVw==
X-Received: by 2002:a05:622a:2615:b0:530:dab5:d43a with SMTP id d75a77b69052e-5330b5ed42amr227775091cf.24.1790648399527;
        Mon, 28 Sep 2026 19:19:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.67.217])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914472260cfsm69050776d6.44.2026.09.28.19.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:19:59 -0700 (PDT)
Message-ID: <6abb204f.e7582247.21b08d.b135@mx.google.com>
Date: Mon, 28 Sep 2026 19:19:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2961797945439550241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Connectable property to org.bluez.Device
In-Reply-To: <20260928223815.11936-2-kevin@simpleble.org>
References: <20260928223815.11936-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2961797945439550241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175652/

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       FAIL      1.03 seconds
BuildEll                      PASS      19.46 seconds
BluezMake                     PASS      384.18 seconds
MakeCheck                     PASS      15.41 seconds
MakeDistcheck                 PASS      144.68 seconds
CheckValgrind                 PASS      233.64 seconds
CheckSmatch                   PASS      292.40 seconds
bluezmakeextell               PASS      93.89 seconds
TestFunctional                PASS      1111.71 seconds
IncrementalBuild              PASS      392.97 seconds
ScanBuild                     PASS      1134.60 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,3/3] client: Print Connectable in info

7: B3 Line contains hard tab characters (\t): "	Connectable: yes"


https://github.com/bluez/bluez/pull/2602

---
Regards,
Linux Bluetooth


--===============2961797945439550241==--
