Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCF491B2A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420932; cv=none; b=Y7tnM1BD8bhVVtuvSXwfjqeTVfr38f41sKCWbue0k2jJKYAbdWEw3aTWcdayHbsfmRIGDZmaj6q1QHF/2f4m9Vk2m9HCltf37Jp9LnyGq0Bw7hf6aN9/Ov1a8Q5Hy96uZKOYKRo3FuS9ZLwBG9RKfHZpPYprxdappC+D7D9614s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420932; c=relaxed/simple;
	bh=3i0WqGlR2Xp4HYBhgVSAAzbuB8VObW+oJUCTu9tyCdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KY64x6mlsiNLzZzKun1LD/qphSTPeqB0FKhNYiclBnd5JyTLR/seCNBli1du5IwFC3D9FW2GPtBVMBa7VrJNX7lVzUVLqEyXF0gHWjN8TUFRzLK03FFXk9AJ/7z0RrbMZGu+cuxXyMcV/4f/YUbTYriCQgTWUlUMzkt8ELf/4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIlJOt1J; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIlJOt1J"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dd7070699eso1268262eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420929; x=1793025729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/5/7/XpVWjzkl+0v8TQUu5WoacXmzs0ftenMBvgD+nw=;
        b=rIlJOt1JTAVdp16bYUNF5WfsTB0zY04Fqv2D0qn4/Mf/3qq76nKx577ATTDX2QOBYu
         oDMs6NmtoUxAIcqLqzowmmhv6ydLUw7BQkm42MoNNhGwvMvB0SwX2u1ETjIe2o7mGsPd
         /dZQ7HEnNCCxYHVcBuzyMRRGVd5GJVwssh6lUOtUiAdsq+ky09lp4+taEwedv5/QLcii
         jHuHiVKyCDNH/0fqVDsgN8ZnFHzFKGsjvv3cnrjYl0TsN3lfd1tJaM9Xi01QgIJUQP10
         Jr7o++GY74qADUCSg7jj969Khqso7dHrbByTcAIp0XgNm87JRKhSVQae4wNgBVBq28z7
         548w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420929; x=1793025729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5/7/XpVWjzkl+0v8TQUu5WoacXmzs0ftenMBvgD+nw=;
        b=uIcw5T2sgQTYOSqKt3G8DCTFFX/wCbrRto/C5j+poxOCVbpr30dbIojI4VPcPFOdYD
         cmm9FM8IQOy1lqkTmI8zYepTjTEkdIv9BCQINEo5x/3T6/VNxSAb+h6N9/ZhPJjNgdDa
         j7AONMXOK0aUiPmWwIWp5KvIEi6P8WwAn/2ptRLonaJ6FGnZXziLqLXA6ZrO9lWuhkrx
         UvUIqAIi2E9Va4XXk46aXTtVUSFV7Ak39rWxvjwyeU+AFasI85HuWcQvQ0rlhtDgZyLp
         i4MfQUGi5hujQ4jZNvLqlvAHam9GEFn0MeWmFrtIf+PJroaU2GMdzWE9HwMhSLtKerBd
         YWlg==
X-Gm-Message-State: AFq9FYJL/cTMsYqiul8Xojzv9f8m/3jewh9UnUGQ/jj02mHjUqfLo8jf
	51WLp2+tdoPL3h51NhdmOoFVMUPGMUrOSj6IhEADsCmQg0IwhVgOUaEwtkiDgw==
X-Gm-Gg: AYBFou3flqPTxzJxHkIPcGEfeoBO/R0qPMrkE+My/LMDi8H0ah/Vs5LCz7uyA1TG/kj
	WKysHMnuqrPgMfcEjZ0K8cOEO/3pLKLQEFyddlDkUzajz84oHwAK2F0VBg0c3Ep35Z1mHmLHrvV
	zRvqS/aFIDlHuvSspvDRMhUVr69mIpMYFYIWmsFx7l2V/hkzh6fShyq8sQZxAtXJ969KVs//OsA
	sFNm7tCnT1oXjMogEN0JvVDdKUFaeSts2GEVCjHafwd/xoDG4yefGN6HrfFfaC5IINvNvNBtFLP
	zOTtsKaHc41GaadtgBvoWYWPDTQsDucvp45mBqmajrNyRkGzcJj2Z2SqmxyjkQxLyPsgV53Fv9V
	i4itDbWvrIA1BRsE2JHdZ45BvbRTjTTkZU9RsYxpL6gyyn9txjV2jeB1wY9caplT/HDzCJSycz3
	rQb2iVXI40vVNSaLZbj+Fm5p5FoPYvYLoL8FfdnRaQcYAPodZBaO3hq5+YW0xlCHy3R6ZJ1MfCC
	0nTKeXQH/oNJymv
X-Received: by 2002:a4a:e849:0:b0:6dd:4a4b:1843 with SMTP id 006d021491bc7-7035609134cmr5841720eaf.14.1792420929350;
        Mon, 19 Oct 2026 07:42:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.162.41])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b2e59sm8455573fac.3.2026.10.19.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:42:08 -0700 (PDT)
Message-ID: <6ad62c40.efea58c9.1b422d.d369@mx.google.com>
Date: Mon, 19 Oct 2026 07:42:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1942827867213073308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v7,1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
In-Reply-To: <20261019124128.48159-1-valentin.kindschi@fiveco.ch>
References: <20261019124128.48159-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1942827867213073308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188896/

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      28.92 seconds
CheckAllWarning               PASS      34.88 seconds
CheckSparse                   PASS      36.18 seconds
BuildKernel32                 PASS      29.23 seconds
CheckKernelLLVM               PASS      33.36 seconds
TestRunnerSetup               PASS      701.91 seconds
TestRunner_l2cap-tester       FAIL      12.55 seconds
TestRunner_iso-tester         PASS      10.79 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      87.83 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      30.65 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 111, Passed: 109 (98.2%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client, Direct Advertising - Success        Failed       0.021 seconds
L2CAP Ext-Flowctl Client, Direct Advertising - Success Failed       0.023 seconds


https://github.com/bluez/bluetooth-next/pull/966

---
Regards,
Linux Bluetooth


--===============1942827867213073308==--
