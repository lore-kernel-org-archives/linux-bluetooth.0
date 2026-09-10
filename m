Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5658497F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065612; cv=none; b=kBg1m1JReSgKN6dsUA5OIPvF/K0GCe7Fs82U3Nli9i86L10+qu2Tj5XUlv76ogtUt4dVvI52sQE5ViPcSLjPWcrVEXjOaZt9N307fQuIus6032U0FwDoM8xLr7uYZM7RExeJI5bEVLZrEbvieRe/8ejjavZE7ST3tlgWbUx1f0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065612; c=relaxed/simple;
	bh=E51Xha+EOqqlldehfcSjds7ja6JwHFoiVa7TAQgiUTs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dn1vbIiZm6NrqrFHjx7PC45SNxsjSFU1bgcWsJwTcSQw2kJx1K3n7IR+zflZqoO6ZGzdiGB9fBzX/gg2yhTfVeWPMlV8awj7CH5oMOFmXLzUAfo7Zu4IplyEGy3uznQ+Hq7MD5t5+FH4Gwh0jm5ocU4ePRmOK4tkGIzwn7B4MNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS8g+6gO; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS8g+6gO"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-80032c08611so59942a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065603; x=1789670403; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=By+ZaAv2AdsRps8FdbYBDu2g1HwZTLkdf4BCAnUDnJk=;
        b=aS8g+6gOHZQG/5Y5NASlzwNeE/fDdDvJRuBQ22AoA9FhDHVXdCuPhpHbdrysjsjYeV
         oNCEM2CYsct2i92rdGxr1u+jSaRTgy0Ce0BGewdTf/B+dIQWa93U3SEuu0gcRJyH2DcK
         hNQKNoIkQFnaCgjyJJptbKxYkDA29sK/ofLkLNx009w3m26KxY87XoRQ3PskXGiTMdJR
         ahYaW+RP9wKZR94ASQ5adDR6nBtnXukqBE8IGddylWpHrsoS8tuOhyhLPaILVBuhV6CO
         1qRDsPe5rv6+qV/RzTj/SB74kS+j13/gsSJ+WDV2sqXCoMhF6FhdCtbtKhF2Ag3D0SU5
         FFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065603; x=1789670403;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=By+ZaAv2AdsRps8FdbYBDu2g1HwZTLkdf4BCAnUDnJk=;
        b=s3lM4JR4wu5xhZOwv3O7QC2osUSZMCX68yh9nSFLVxB6b+Z9FFswacSfBDeeyYSSYZ
         pPh4iCsCMwIHO7NK0eJ7cIVoFHWfmB4I6tdS4N78SJTcAyeX/GpDc4U5k0nqHTu0rq7H
         VJtsqzUZDXhy/CavWCkmhymYdwB97yigT3JWv0DIjjIkVRs4i1moTDh2TKbyPMKbgm4Y
         11BTYYosN70/xG5+UCaNt7ZeUGzPeLjJRMu7bRV4bQ3tyYDyzM5zarTg5dvcGK4Sl+EA
         VVUUegCPAFVhBXmxVN0/WnVyXzy0TPichXJN3cIDfknfqBXh4vy8BMpKKKa3df5BcAyw
         jU6g==
X-Gm-Message-State: AFuF++kM9ViaB+EzRKUWGUeqLOwRczXfVpWNlC3GZvASgBiYR6yYOORG
	Q8QUoVB6UOcOeE8G86+xClBs+B0eCt8z01yovvsEvuf29uvJ66mEfBZmn4OPIA==
X-Gm-Gg: AYBFou3oQMlcOsD66CBANlgdgyKqQr6eZd/mG1EhAuXLd8Q+SnNeVdaMlhDhCFv9pm3
	rErPXHNNCbIBXvWNnGh4a/gYiIts2e+TfhUmljrtPixrYvmDXfMGc9en/VrvHPVWpx6RatVxYdH
	Hg24e4yTCQvjSxakNzZikjKF0W7ikA98XEk2gQh55iIVizfAEkyAhxOemJE0Vl2WwCxnvxH3Fd+
	h5bXduaaFYWquNcqtUmif06izUuTJZ99mYXZvYVIJ9qdvzrZ+cx/mzbK7cPvVlDNTSlMHYh5AML
	hrNi9qG9orrZWg3+HaOdXnVJ9ysUPvy3rmb3xK/iL27V8Lnd1rPScz4URlhpxu0xerUEB/sOUSz
	/JsT7mMSeEJQwMMXUGudLuFw+2sSPUs/OH6N+1ArAq6JMfCtTdXUKO383hZoDU8Z5FosphWAVDE
	zFc1RakpaWD7g4erhFHx1LoEZvIOZz6VfEyv4sh1IX2fNk8K6IOwBzGJnTZSYeBUFVjEigfKD8O
	0Jwzw==
X-Received: by 2002:a05:6830:378c:b0:7f4:ec2b:e8c5 with SMTP id 46e09a7af769-803ff2274b4mr198780a34.13.1789065603445;
        Thu, 10 Sep 2026 11:40:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.237.143.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d2c08asm178256a34.27.2026.09.10.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:40:02 -0700 (PDT)
Message-ID: <6aa2f982.bb286e2c.10a32e.81fb@mx.google.com>
Date: Thu, 10 Sep 2026 11:40:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0320286637264270940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
In-Reply-To: <20260818080104.563675-1-ali@iusegentoo.com>
References: <20260818080104.563675-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0320286637264270940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1147625/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
VerifyFixes                   PASS      4.71 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      41.92 seconds
CheckSparse                   PASS      32.51 seconds
BuildKernel32                 PASS      27.20 seconds
CheckKernelLLVM               PASS      30.26 seconds
TestRunnerSetup               PASS      674.60 seconds
IncrementalBuild              PASS      26.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
ERROR: Unrecognized email address: 'Neeraj Kale neeraj.sanjaykale@nxp.com'
#100: 
Reviewed-by: Neeraj Kale neeraj.sanjaykale@nxp.com

total: 1 errors, 0 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754788.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/732

---
Regards,
Linux Bluetooth


--===============0320286637264270940==--
