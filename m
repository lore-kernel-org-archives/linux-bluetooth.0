Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCA3AB272
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018005; cv=none; b=bu1kMxwoGQ3gLKuaMwzsVKCaCljPNBoMXMhRNP7sKMWvqnt5FjAXSR59yVsep3bQBiK2Hdqzk8dDbuB89ZgrIR/VDjBYI5jHZMRvwDD4xAff7SDJs1mRgkGx19aZT3bTAcB0kElLlI0jTzJQjG/y3It65xvbdf3pwhA7WrY7WXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018005; c=relaxed/simple;
	bh=LizRBnGyvBEQbh85YMsh0aBgQ+ZvuNEJdjUIcvkmdto=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qa0BaluS+wqB37KCiJ1OY83ZJSAVCzNSUe2JNbBvxbO+8RxrTl/fP4Tl9YQspj7bj5rkPqVGlayC4LXeQ3qDCg2eWpEJSHQ8HPT4kWUQO6TAWbCvHbYsLeim7vYsCmd2neiUG4IJCGps29c7DLEeX4ugGsL4E4RDsUQgFzxYK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Q+uZ6M; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Q+uZ6M"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so90656eec.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2026 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791018003; x=1791622803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KUJ3AKlR0hTqdHtppFVIVcNF3uwR+tngMcAnQuX+aco=;
        b=Z8Q+uZ6MNlygesUUR84JCcf5GpP1xh3puL9sr4Sp4Xo1lGt3p9n3+anIXhVj1YPPQE
         LhehtdFW95j3EEa87CgvaU/b/JyTWtvLUnn7oZqAr9vsh0jNy265JREsQmz4JYcM7Jsv
         hSNP4hrAFDg0hm7LktA4E5asEyw7yQnv4EyYNQRESYwQZF+uDloPtp9U4beg2N3eU4Ik
         ckZyN79Z6zYZwJYheMaTAbPltJjiJRW1GemgrPHIH/IJzTqdA5arwK3VXuRDT4Wr3sVD
         O79uDlX6/azkVNkHHsUD0cFR3QqkzeNuOTn+SRJd2x3RRuNd5ynKmjrUfl3OF+aRKrOv
         EyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791018003; x=1791622803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUJ3AKlR0hTqdHtppFVIVcNF3uwR+tngMcAnQuX+aco=;
        b=rRTF7gLdFkQpqZ4Zit9jZIomSNepc8Ejuxhv6xykOaN6Awr29iciFE5euQLm954L8z
         X/qdbFFehCNtV3Yby4AkRlpi2CiAOcBWWLHn4LnKeNKMxJy1XZxukWMg4QZj8O8Pvam6
         Fj9pYUGDr9O5+/96VqYx5RpNr/f0TA0wqSPreMvBi4l/6yY9Jt/oLYhL0haoTBO2W3GS
         CySb/dnW5Kxv2o5nlpC+ZTCuZ72y5xSFA75fsncZKyXRqL3E8U8eIfcyKBWZOAE3eifV
         kpSVoQbgPzA4kwoMfyVBU1dgVSIuzS6CpJP45p3htNNETDCd8jwquE/+yxU4kKkbVECB
         MXYA==
X-Gm-Message-State: AFq9FYIJt5hPNl7kXaiveQ42E18+PrpSXekM76F4i+V7dVvgfgFsutW8
	8+awSF9wGPS8rPRP63buRXpah9u0fagLBzhPQZi8V8f/vamhuWkH3pcv0D4TpA==
X-Gm-Gg: AYBFou3WS+DJvYBsPbN+PajzR4bV6YcBB4WRQ2qi5l5smondt//9ZE7IGzXzXiHFNTd
	xVmPkuKnvPvnl0t2tsKwfQ47/hxjHjFTrOE/N7UI1EyFgkj0zfaZ7SQAQ7r696VEQk6Qfkwdbwe
	YJtj6Xbmeg9hd+HBDCc7URDLJf0fPFMPbZQ/57x02/WmszTfvpRRlTLhrfp1hzLvqRyXUlMlxA5
	dP5A/Rf1/B/vGWCuQuUEmisPX3jO2qyHhpeq02zetnZzlPJoqBi+N+98+yPlTdwmP3XY940LQUe
	gMuEGihb/eeSgYs4ldQj/brvaIXXlJgyAdlKTUOLlrtWZVrw5Ajd/AiOG0bVSP/k9vh5Ji2HoB6
	NFYqVvNMQJCYYVVKVq0vTIWYIe+3hUQJnM+S+qbCMkwMMoP+36Ess5t0C0wBq5mbporYKYuHq0B
	w2UfoJnp2Ggg5JzSZ9Kl/D84dkLVcMt0fuwwcJCJ7PY9uostkl+ZSsaKCoCvh/ZLNE9PFJEhdgt
	XdQjg==
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr5720342eec.38.1791018002851;
        Sat, 03 Oct 2026 02:00:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.31.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f150248b4sm12405489eec.30.2026.10.03.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:00:02 -0700 (PDT)
Message-ID: <6ac0c412.f4d35ac6.bf5a8.3b89@mx.google.com>
Date: Sat, 03 Oct 2026 02:00:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4021457631671165759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: mgmt: handle mesh send completion queue failure
In-Reply-To: <20261003081205.433725-1-yaojiale02@163.com>
References: <20261003081205.433725-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4021457631671165759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178770/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      33.30 seconds
CheckSparse                   PASS      36.28 seconds
BuildKernel32                 PASS      29.98 seconds
CheckKernelLLVM               PASS      35.50 seconds
TestRunnerSetup               PASS      808.94 seconds
TestRunner_mgmt-tester        PASS      61.27 seconds
TestRunner_mesh-tester        FAIL      7.79 seconds
IncrementalBuild              PASS      27.07 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.424 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/854

---
Regards,
Linux Bluetooth


--===============4021457631671165759==--
