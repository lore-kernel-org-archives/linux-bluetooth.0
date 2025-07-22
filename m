Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEE26A0FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222922; cv=none; b=J5RNN0mfzCdwAsLmP68dF7Iv6FSTKsQuVfWzLw1Ko4f72dogED/YUCjFyvsJQtUHB8M2tx7l4Eu4SccszaJAEguEcAB69Q/cOt6rilTdDPnYMUNdKpn/9f+Cs8fpKzr4TA5s368sBUnlYm6zXYTfO+dmNkzjxnSE3TQaWRoXz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222922; c=relaxed/simple;
	bh=1dJmo39fzQq0g/EPj1dnyFzvwio5+7CCpT7sPX4rmT8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pM/BPyy9mKvhHQVW/sg5t7rh7ka9ahsxB9FSK9cm2oV62X4m5gcfnOcBYAZZwgpqQkmSMHC6/ik6ThhPuGzkMmjGqQNYs+ovVn4aFgpQJ2FIzDNrnpuntk7WMzmCSkIkTTG5ScLMV+JaYYBpkUQWPpjz/RZaTply6r8P8MNiR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaWKDU9Z; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaWKDU9Z"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e2e3108841so711643985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753222919; x=1753827719; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aozYmj5eJx1/sJTNJVMXHIN88snRGtGo947XtWIGLUU=;
        b=BaWKDU9ZA80AJ7t5+G8e4/iwn6i5w622ZJ6M99uh2O2Ug3KwzalzhEpbHxUlwEaRki
         eFutPshAK1xowVeQsSYsSzZowAL7NUCH+ZYrnCnfyFbK3bl7WC9aUUtVwzpk67+7Znfz
         UwwIXMkg0NmhcuQvHL4LQk6QOipxOv5DUmaFfmymb7+D9ld6onxa82OgUttpVAAqwyK+
         JvvSo/cxavRybhh2Pz55JvYXb3kSFzCOaaWAbuegqQOssH1utnJ6NutSv/FKsrvS2m+H
         Wa8RInHRSU4I2v/UMk8jJowu71TEfpShvHiUHNbxN5YWdUF+qR5YUxihZABGN3Z3+JgC
         juEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222919; x=1753827719;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aozYmj5eJx1/sJTNJVMXHIN88snRGtGo947XtWIGLUU=;
        b=uanekMpD/QoWMavpftO/+TSk7PVldXm4Srpa4pTTpbqlhXxyM7aomKJlSuhZNaCB72
         N667tvcOVDnwIRWu4z+tZMxK3ltzJlUqHw87iwzZRTi1sguu0hZqqmBckPHROB94huqb
         vZOkpNkgp14mF3XcpJjsoRyRypYcflH+nRU8fPCm1GOBps/U9BahaEbALqfqHBVl3DZb
         ebKdPZFMgNxg2IBJRd8FcxF8w4TaF8nEx+HaLw73r8aSz3saUVcXr+KpRbAi5xVm/cit
         C9uky00o2H1h1kw5pm9jP6g8x9e5pmoQk6ZIf4qXfzY5ks2qgnwQroWSAB8VB0+hUCd2
         RNWQ==
X-Gm-Message-State: AOJu0Yx7SC6QHNM/kfZQUeIbE53SBvDLGMlpE61pmXhr4oxWoYqPaplk
	wKfuHYSCoghlAwhmJ0SRJ4Vluy04NEiNOm0urHDtrbX+QAVstJBn1ascSu9iuw==
X-Gm-Gg: ASbGncvoiPn/0BDjCS06T9MlE3fQtmxCasxLfbRSZy4anj6wz+fsKIc9qTHRPIFa791
	MfM38dFYNd8I000+yDIzJG/RRkCVmB6w1MzZt5Wj64e5QqYyh/uN3G6Ci+Hgi1vQ84zOVrDU40w
	HyiJHr/xLKBr1qr/lw8ZuDhv6kTEIDMm2wXYM+gTVVMgu4c+mBeM5q7QgS2xh3b/VbvNUhfLNKa
	/ppa+4iFqGe6OJRrRrc9HXqlpLZ86ZsAUgJJT+hUI+3Yg8yuFahaUs5JnGtU6z2Eh3W/50E8fJ2
	Z19QdloUHxQ9iHxn1ctrguW0Zhl4bZuTj16HSRzldsdo4QLv5fWjNVq9y4RAJc44afEK1KKTGbH
	AA74sWV/WdbMAsQXW4QnsT/Atuhx51A90okWdkcEo
X-Google-Smtp-Source: AGHT+IH6+iQj/o9p/oyOORDg53nPMlzjkIXE+hz9pyKMbtJm5ja/M7esbMgFeSHp79sNk0m/mpeQlw==
X-Received: by 2002:a05:620a:5bc9:b0:7d4:4596:d6a5 with SMTP id af79cd13be357-7e62a21b5e0mr105941585a.55.1753222918653;
        Tue, 22 Jul 2025 15:21:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.94.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b469cesm569166485a.36.2025.07.22.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:21:58 -0700 (PDT)
Message-ID: <68800f06.050a0220.1dcac2.3eed@mx.google.com>
Date: Tue, 22 Jul 2025 15:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6798381915008661826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] transport: Add write support to Metadata property
In-Reply-To: <20250722203508.1311750-1-luiz.dentz@gmail.com>
References: <20250722203508.1311750-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6798381915008661826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984872

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.86 seconds
BluezMake                     PASS      3681.91 seconds
MakeCheck                     PASS      20.70 seconds
MakeDistcheck                 PASS      190.18 seconds
CheckValgrind                 PASS      241.29 seconds
CheckSmatch                   PASS      310.08 seconds
bluezmakeextell               PASS      131.48 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      931.45 seconds

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


--===============6798381915008661826==--
