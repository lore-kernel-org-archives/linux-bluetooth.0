Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95327556B85
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882801; cv=none; b=lVpIC06SN/ugoE3MQCWyjEWtZBsq3MXAGEr9aOcpkbjaw8mnqjIvw6w7tFh8i8H7NwKFBMQzWuSf2RjmMs6CD6mtxZi2D9fp0IQ8maZP7vjB9nm3wvc/trcLiTRzT/dlvnupdtdqOlJf7yq01Zzq2gywhgxhzF7krYlvSS+zS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882801; c=relaxed/simple;
	bh=thgFW3dsVbMbvxSnciXaOieK1WO4l+fSVhgCe39RkDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q1771m1PCBW4HknpuCpNI8UIZktrzmBthGUiBLb2zAaOWvntDv3peT0/nbp+nbosKZw1smZaKMUxF3lPC0UE6r9u1RyG98yb9a+kzehNzUGouk10ite9GD/MlTp6EXGPQ7iR970/sEBwNrwPev2RJtMmDbo5H+HSe/bZwG0DzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeYxNolL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeYxNolL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc439aa0078so3992129a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882798; x=1789487598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xvTMZGCYYQedMZlBDdCXupiUqV0MyP9UIm6CvvLUnLI=;
        b=PeYxNolL9O44riOgjfgmgiXbbewfbLuIN9UBGwB1Ru8eEtOcW9I3wGyxoGluyMusuv
         nBFSyy1R4+VyqgA4+OzLidZxbMH91iGQHE71KOjtV+00cWZ75+n/WWE/c3ml6N087TLV
         wm4LCpT9j1vWYX4LxC1wo4/Lz0uQZ6u1dzj3JcNDAhCWJ60wcy0kfUGqF7O2uKREc7tQ
         Ip++w2y3lhQ2G2OVTCQeshwLyzpNSVAH5IEZHT3Lc0Q1XnAL5g75HiLpviZ/+2sMw0dU
         nPceBtcZcpB7YPNGvjJqo7s9ferKTVPVWadjZ87KfAW5Zad8cFWgmzG1JfkTpgxvR+FI
         TIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882798; x=1789487598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xvTMZGCYYQedMZlBDdCXupiUqV0MyP9UIm6CvvLUnLI=;
        b=hz1abDPxPPFfNF1DD4do09/EFOsJ8eAvTn9/6+v5e5mcEjoDQT3QuKeLd8CJBA2tKT
         LP7gmemyzKqCAwboLG5pUio0815DQ94nBIMfwloxTWZEC8LUc2h6XhPRwNecUg8pUZQw
         UgQq5a14P0yjfTwhJhR0tyMopHcJ1wvpRxPp+V5j5cOKXVRHnyPDU69OcSKRJy70K9pS
         DL4NShkEuViLp+a4Twkx5KCoMy2cK2W5RZ18zAUrn0n62B8TvLKN7XpHLHNTdnl6cOVb
         JzZwF4+aBE83OukjpXsFURfIYdSBN9WjCwJBspJiAJmby+7vNxG93nx5uc9MQR9v9jEO
         aMpw==
X-Gm-Message-State: AFuF++kNLD+8V1I+B6DeVMm/lXSYU0yAhEXH/lPoWiMOZRnDPToRtPAK
	gsBX10WlpsJ6h5mMlCzrAXgJIw6r5DS9etG84Dczlbe99YhtkOfcul6WJdGRvw==
X-Gm-Gg: AYBFou2yy7dVEhVI0tPnj5FcLnbCcpb7QuXgXgCOUw4Dy9k6RUGClM98K/R3npn5KnO
	bV6THvDzxsF3o4MAuSGgD23jg4JMKxX6HEYBXCF2Lb8au+puPgV+sDNwCOfWHrqUerztgs1NdBR
	BxKUv6uJTxpeB+LKIcCI262/1jmtI8JHwCCGPgDeiXHT86lvQx27JEwP3E+4QTDF5OYMyH7I/zA
	N7vNqMokPi08LebEjDlLGS7fV+B5R+Nchn6Vd2S34HcFbWK7zQdnkwZj67jfqrVFDB0cZxeJoai
	5WLiPUE8RNk5y4tsF2HEOFWUlTO3Id5MWSZE+Js/tEnuniBvMfz1T5Yk22JIiYjv/dUa0p5Vl2T
	JYNCkrjzm7Wn9TaEE5rZcgMwQ4d1D4D3VTOWM2PcrtKGLM1vayb8QA3VhHzoQwXVElGdH4dK3V1
	cTaBKwU3Vz2jqUa2qxhNzPlxBXtz92+r00p2HIPxXEjNoAGd68MAyE1d6Q2s4PzW3S2Pw=
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr47443603637.24.1788882798385;
        Tue, 08 Sep 2026 08:53:18 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm49220893c88.2.2026.09.08.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:53:17 -0700 (PDT)
Message-ID: <6aa02f6d.8e75e0cb.3a5f1c.c9f1@mx.google.com>
Date: Tue, 08 Sep 2026 08:53:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5171689530523776401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangxuhua@kylinsec.com.cn
Subject: RE: Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
In-Reply-To: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
References: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5171689530523776401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160167/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.89 seconds
CheckAllWarning               PASS      26.82 seconds
CheckSparse                   PASS      26.30 seconds
BuildKernel32                 PASS      23.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      430.33 seconds
IncrementalBuild              PASS      22.68 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/718

---
Regards,
Linux Bluetooth


--===============5171689530523776401==--
