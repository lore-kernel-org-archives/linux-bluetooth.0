Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341232C94A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676936; cv=none; b=FU/B3FOpDorUdvOl9hvdQlj+Lzc6B64WX53tSaC06BUCB2DAFih9RWph6/Sqlj4TYue+lg8N7hQ4Mj2v/WRGdgEF9qcR3WAa7BNy/WVbxIwjDrygbWbvAKV5C7tcqnPycx8kUK9FfQrPGsvaGITg+t3/rYKJhOAKyeb36RGdhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676936; c=relaxed/simple;
	bh=AYQoZ1XwT+zTEKqnXzx/D65ULYXhnBtSwTGlVrJ7gHw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HRQIsKoY0Z4jUOfvLV6vifaeiPSC8TrqpLtpuM58moTLghyXgG1te6UKQi+zgyHNvJgQhpP6Zy0gkgh2YQ3qlfpocd1kTcsrn6aaz15NnhVtam8kK7Bz9m1SEkBaFIlgr+u3d5VfbjeK5IA7B8J2oFpA6dR/zQIXchhvZypnjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWkHgOuD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWkHgOuD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52d5bfa4bafso37421cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787676934; x=1788281734; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=63VCsygqamIYgKMa0ezuusT+UwPWe7cutD104pBzTyg=;
        b=pWkHgOuDg3txnZXhVrQeWIBtW+ssQxW2RMg/8MaZtYJMQOOZICHWCn9EWKemNCmuBJ
         PaCjaWNFmi2nRqNB01RpfbdkOYlziDg68iv2OKffrwzLGOCu1bYiWpDkH9zRzC1cQXBQ
         Iv/Vf62tIw4P3lDiGSebXgcd9Adp1ywqPVhw6VBA5sKWbOoBK7bt5K/EfkqXdCRGgwho
         ftNFBGIVacJtmc5oA6+k4eBbqKqHLXp1+qxKDGrrpQl9SLgYes66/aXKGyE87i2HvJI5
         K3vNHUkLy/+bbNRNSsTm16wkoFtY0vE1Y8hVj9yLqBE4CIFL1jCluYbAwBuHuWUrgNj/
         9tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676934; x=1788281734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=63VCsygqamIYgKMa0ezuusT+UwPWe7cutD104pBzTyg=;
        b=jMaHDfwX9PujfTzmxxwixNzcic7gNcbDDQiHeyaMzrXAMGHYVL6mU6Wm4KVz+MSuN5
         szuFEJnymVNtSrle+ngluKr605cRtI74mJZ1ZkkVbhMIRruAkDghFgt5BGA6zx2G6FTH
         hNJb+wRR3fR3g8GoRTsrXNJI8P5/xntNHg+CJEEJthfdkSbJ/QOX50/beF9UG+lX2RSR
         Y7+6JbFEebiQRgs9Zulm7wOMJof0TZIUjt0+IaGvBIBii/p4RMyAHEFOosvtemVWOD3A
         SZ7CMh3ez3dgkeUp4ZTiEERh8qhxpGFN4EklzEMhyA5KQZ8nQ1D41YGWdPZilDIJkfHZ
         vc6Q==
X-Gm-Message-State: AFuF++mOIBPkxF7tqTfnlXt1NaYomGLALIYSIMWjFPt4iidnJTVhA1s4
	tJltc0+iICYxabBQwa5V3GZojjc6PM6x8FJfXCiwzq2W6mZV+ITptsdxgXUrzw==
X-Gm-Gg: AR+sD12vaCni+HBAORAxaUYszqvLhmzS1M4pn3F2E/d3iC66i8IVPEv9fsEVCv9pX/d
	7O5KmKlKz3Wa2hcs19w4nW/Z3vou83SRV5+eDDnAkf6AS7bNJMnf4xXY1Xiekc30TxioVqs7BPd
	gqAuYMzneWCZGNw8fb3y1ZvTej2dRjcFadHY5r0yhpFYopqVfi+SmJayur3s6QyuCgrC6eCvmUD
	SRumMa1rFLfS5/2UfaCZQFQ7Yq8EBP4PLChWaGYD2FxFJeLtRazc2/wDQ6mrMLckFS44u1IyZwL
	DLS/eSM1MPrytlUCHOGlmWazZFOtEEANAp2YmJgrHIxnIT8R/kfUwofIgIGBvoBtYqPxnmltegk
	5oYUkyUk2swEmY9Pl9u7oSf61G6Z1XlZey333/d+bbR2jCOwQdNmSQmhialeRHGFchxGTD/yB4D
	UVNnYEX3VFk2cecETrqcWpGdH4dqvMZw6wn18YmRhO9GL4uKGdDehkvI+gva0n+z/oj3A=
X-Received: by 2002:a05:622a:4d08:b0:52d:cc1a:a02d with SMTP id d75a77b69052e-52e4241c79fmr1134301cf.41.1787676933653;
        Tue, 25 Aug 2026 09:55:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.47.28])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e42598d83sm31881cf.11.2026.08.25.09.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:55:32 -0700 (PDT)
Message-ID: <6a8dc904.1ecb6a99.38d13.0b36@mx.google.com>
Date: Tue, 25 Aug 2026 09:55:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2863723398637265735=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
In-Reply-To: <20260825162512.143965-1-kiran.k@intel.com>
References: <20260825162512.143965-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2863723398637265735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151620

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.01 seconds
CheckAllWarning               PASS      28.15 seconds
CheckSparse                   PASS      26.88 seconds
BuildKernel32                 PASS      24.61 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      472.27 seconds
IncrementalBuild              PASS      24.34 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/653

---
Regards,
Linux Bluetooth


--===============2863723398637265735==--
