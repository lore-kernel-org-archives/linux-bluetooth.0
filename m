Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06F1854
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670100; cv=none; b=QlwZXkZtzL5mysGdwxm4XjbKLU1B3cW5ZJPaagxyM9qd8TN4ESqDeohXRNhSa7zVJBY88ser69vKm0r1pET6F9Cz2Vi5Yy+o4Tap3rB66Yi1chnomGw/u7G2M1VbU30iEhKu0PBh4k2fKWrSSUA+XCW+QNTlXM6kD589eD/TmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670100; c=relaxed/simple;
	bh=Explgz7yMQsD6VnKqYyqV8k9Z0dyez7RJ+UJ4jvgfZc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r166y0sBU5fyJ2IBVO6w6Y9HjvlAhHofPpfxNQd+mhMyl3GgmtL6thdFFY1d0N5c9ntFHRNBnwWlvX9Y9jy1xY/R1bXucyStkhlsL1o6pP94pHBY6yykEzzItuzlHSyT+s8kWK6ksGrPIjSkg+I4PklJs2bIB0SHphOrVqzPrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVoYitMF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVoYitMF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8d8fb211eso9047566d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747670098; x=1748274898; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WzIHVMPsWfDV31hJDazKqtU/L4OlLMh/2lk6Vq4G3YI=;
        b=OVoYitMFLYC8J9KLHhyfYSqs5EZKCfVsfHM9lrNEL5AtpQNrLePgdNtFOnAe5O7E8z
         0XxZLb/sGLdpk9OPRFmVHDmawFXuXv9hTUntQvFXmReRVOVhy+O3LJVrqd3maKYpyjYZ
         dkthDQ0AjrwR9FUH+hfgUMStFpqyNhBsceMnCRwTouM8oYru3wTD5FBuCpJ7JKdVdkHF
         Ld2Tu70ym/5gVJqRNdoSplCicuozoeUjpEM8clIiHO05XZljl7QJbIqmgwD15Oid4Uvk
         1awqpPnoBf38YBb5AFNYwJQFimBfhJ80Yv6OD+E8VzKpd531u0lL1D9phDX23B3B8XdV
         XEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670098; x=1748274898;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzIHVMPsWfDV31hJDazKqtU/L4OlLMh/2lk6Vq4G3YI=;
        b=WUnkxC8pxUggzLDaCIDSWZ+fnyvDHgrVFYIsVhQ6pnMS7l989R+0wfEaG9mmSFjsiU
         RKyxz0C7u4kwZywRRuK2bAVDnhJNQwX0TF9D3JvBZRv26vfGvRjxvCQCrWQpm9r7iVnr
         w5unlwrDlbTjrZulPaxfEYDjaIBEOtDmXoW0NnH8JAj7IL+7X6j+N3IOCyv1kDgZpncv
         txFxDRRt5EAdq4DHcfZ1lVxQmtMUX57t3nvK3RxasuMtxxBUbND6N7f6NNxP84d9N+KF
         14j/A70TuJ7kblCLIUpMRcr7aGQheoQAOdvSkEzvrJxG/eivkt+k3FV64ArsSS9dS3Bi
         mTiA==
X-Gm-Message-State: AOJu0YzBcMlyGthFYO1XnjK0C3m1hg1hIyi3Mvr894HNe9uwfyORErY3
	bQy7QZNwoY+uxaOD5ma2NBr/zO/QV1oY5AnyBlXyM8t1ZghBdNtysOyA7iN83OtF
X-Gm-Gg: ASbGncsAxVs3Dv6fM9HGHy5b0TvVTwLDFMXTaR/S2s5pK7I4+pYdp8bZvapjC9lMPIa
	cBBMKrAnG64t8e/4Dw1tcu55hHVRWmg/OpHn3usoHaRiNiawksIRkJsNfpsBoniaEJ2ByhJ1j22
	Wh/Xx79jtaChWrquN5kjNxbhOfGTlc1U5q79aU6DDB0XJpZ6YMIcyhTSKzz1OrhlRVIxHtwSI9g
	Z33R7bUnxGAgN4MZFYLA76UjEPJ+Umq9o2tDdabchEOU74eExHp+ZW0+ELA2EHmvmVeTYVr12B8
	A/84opDuf0nPFM+YNJPEKjNxcv8rlcEKqa4sJfpWOEOVqMM6shRlS6FUKRxZ
X-Google-Smtp-Source: AGHT+IFtaGwwBXYMGjYT3TN8KDo1o02xBjxS1cleq5jOwkpiXVYJ54WpMuBsZqNLe0/u0nW2jQxhdA==
X-Received: by 2002:a05:6214:cc1:b0:6f8:d223:3c14 with SMTP id 6a1803df08f44-6f8d2233e2amr94207176d6.25.1747670097612;
        Mon, 19 May 2025 08:54:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.174.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0883f2esm59125976d6.25.2025.05.19.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:54:57 -0700 (PDT)
Message-ID: <682b5451.050a0220.1cf49.7dc0@mx.google.com>
Date: Mon, 19 May 2025 08:54:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5586947394944563458=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Fix crashing command info
In-Reply-To: <20250519142009.2493740-1-luiz.dentz@gmail.com>
References: <20250519142009.2493740-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5586947394944563458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964210

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      2741.00 seconds
MakeCheck                     PASS      20.66 seconds
MakeDistcheck                 PASS      197.23 seconds
CheckValgrind                 PASS      272.58 seconds
CheckSmatch                   PASS      299.74 seconds
bluezmakeextell               PASS      127.64 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      913.75 seconds

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


--===============5586947394944563458==--
