Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB744A3E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990964; cv=none; b=Jeje1VSv8dGS38E1aNsKmfkMfKzkntwlbKV2Uv+6m/81KfGOH4Y5M8Q2//B5lzlkuBH6eXU6V+VmjUdfo70LmfJuXxZxBH8rPZ6KZ8yOona3+gI/Qu7T63jLB9xwYJziqFMNtmPDfpd62ExGRrqkhfdmpsbcfFhdeyfGec5tXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990964; c=relaxed/simple;
	bh=aJDx7LcrYksmNsmRE/A6JsdBWCS5UUfOXF09n3MRe7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ggeaFDGrgkIL3/hqyifzQT13PjwvtvG+F0BTevhuUT0w/uSSWPaRvbEmt1500WREigPsbzJUzkPdouBie7IQXENavV27SJmihGGLbkwOg3gFCDyhTs1fn3njr2jomCLw11OiwbXWBq8KRd9gdEa6lKUkniCrFEBRBQf+zXOVLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXD0jhjK; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXD0jhjK"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so1834325b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990962; x=1790595762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQbxkqYzxejT8pK3benmla1cFlEVULvOROnPxxopYGg=;
        b=jXD0jhjK4UHho3f8jh4CH8Q1AbC46n38EkrsrsvDf3VxrRKQUORGfebuMhkq5516w1
         i9tibBNayCwNr/stw1QfqUUIyPDcR1lYNzGlx9m0qvHuIB8Hqy3sWc1eLQKg5QBVHwcq
         hTx93yl457xNV0Vi8on/HElYQw/O3v7rFuszS9D/qn/aGBO7Rz682j42iUwrkmxjQA1d
         juXue6WGD2G8CMnu+xY5EPIloiRvk6if/Leckd62FkBN+DXc+pgOTbDIUGahXwjWuLeS
         w0lhdk4OcEqJX3OxwyuEUNZ01kMswMRNqAALlaHX21ZJ3iSze1NdkuHUkCdPUFVSNw1S
         WiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990962; x=1790595762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LQbxkqYzxejT8pK3benmla1cFlEVULvOROnPxxopYGg=;
        b=PY01qJvM8tWW/f+GYRDyIwQt20yFyAZpzEbWh3pmG+ldi8FUTg40264rTQoxpiNH9P
         Up1o90Dq3sOXd0yx67KA4r7WJShFYt243sLWv71cPP6Q2rmhz5WCEGkQbRH8RBEPZn0m
         Wgl+GZXNX4K967fvaqk5yloKMA1TVCN/ooE3BSaB2o/c+vipbXyqCvL3ZAAdNHlFuabL
         smxRsnmZdKjuGJ/uoQLnEjYpdFaSwyii3Fl45bFsctauWObFVZ+4Td1I4uGvpMZx0ovA
         XWMu76R402lbXBVLyXYxHgqAT260fg3oxwZFN1Z8Tw7u3icQ9Dj1w4n3820c/YiNefcz
         wqGA==
X-Gm-Message-State: AFuF++nM17rQDYcvXUSVKhNq7pSx3/e46E78y4KXvCagvfucS3ajnqfb
	TW313rHfG5qCK6tMhJ6ipoB3Xm8qLMX5YkbKLasvTNx6jmQF+8RulQNm6yq3YQ==
X-Gm-Gg: AYBFou1wy41kAmlbqB13poWObrMldyTY5SKioMTlOTUBryCPHokZLCOcEFihXuGk97C
	6MDQRimAI2mK3kUQ1/guVcDAIqBprar5F3afJjlF3YcJBMDbAXyl+/M0LBoGBLMUkGo3nKaD7TI
	oLbm4BAyh+WPcCpDu9SOGT7Y20MEC1q3BYPIiF+r2f4CBEMrDFOIA9oq9Zyoe3gDjItVosSQwuE
	IWcBPSvuLPX5538cP7RtwZh7bt0SsDquWp3yYj0cbAiOqszrG4ckdsXtH6hcjri7V6p39teed+g
	sfjfegYlalpMc2Qqcslg3UFSQoe1leiHJ9ImZj/JmfH4zHL+839G658hb8J2raLGWt4A6t0UgR5
	9YgRVUeNTZfbxUjb6nGOrUt0h7Il5rEIue6aPuHnmNe/jY+5aV3hhD9dkIQbQB1JF9W7nLJJmed
	rB/xxBx+K8wHp7W8eWpU9kT9UHGlJeP058lZTf/AeRPE6gbnC6cLJy0kNNewK7fPdsFd3QK7qsZ
	jlbFPwf
X-Received: by 2002:a05:6a21:6b05:b0:3dd:85a9:559f with SMTP id adf61e73a8af0-3dd8c5960dbmr18735906637.33.1789990961824;
        Mon, 21 Sep 2026 04:42:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3318c49dsm18991154eec.22.2026.09.21.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:42:41 -0700 (PDT)
Message-ID: <6ab11831.98a076dd.29d9d3.b8d0@mx.google.com>
Date: Mon, 21 Sep 2026 04:42:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8530060378698035367=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v3] Bluetooth: btintel: read ROM debug registers on FW download failure
In-Reply-To: <20260921054830.2770046-1-ravindra@intel.com>
References: <20260921054830.2770046-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8530060378698035367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170015/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.91 seconds
CheckAllWarning               PASS      34.05 seconds
CheckSparse                   PASS      37.61 seconds
BuildKernel32                 PASS      30.12 seconds
CheckKernelLLVM               PASS      34.46 seconds
TestRunnerSetup               PASS      793.74 seconds
IncrementalBuild              PASS      28.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btintel: read ROM debug registers on FW download failure
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#94: 
  Bluetooth: Intel get rom debug info: dr0:0x80000001 dr1:0x00000000 dr2:0x00000001 dr3:0x00df0071

total: 0 errors, 1 warnings, 94 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14833867.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btintel: read ROM debug registers on FW download failure

17: B1 Line exceeds max length (98>80): "  Bluetooth: Intel get rom debug info: dr0:0x80000001 dr1:0x00000000 dr2:0x00000001 dr3:0x00df0071"


https://github.com/bluez/bluetooth-next/pull/806

---
Regards,
Linux Bluetooth


--===============8530060378698035367==--
