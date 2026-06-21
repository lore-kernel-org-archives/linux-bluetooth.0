Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC471A0712
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782066495; cv=none; b=Uqwrj3XK+xC7/pC3NC7O9ab7WwDc0Coi+yi4A1QL72QV7wsNToB9qvVClZL9dDob1NMW7/6z2lhoU3TnbRITBlyd5Q83OUYCDbHjSjcJR337jYhn6FMaqzppmDiN4ssuPRNJB3uS5wGdHRIKTACOGx4OazQrmiNOjbCLpY9kUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782066495; c=relaxed/simple;
	bh=9obaHBL+EvFAibDU77+8AMkrjuvRcqMpjLhn6tt26yM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KiSAHhM4L0VwbcChpbJVl0i7m6KJgLq4/ndopXeXgWl+/sB+fAog9En9WDja7Hg+AC0ccHU/FU6iG2lWBxmK/Squ9jn4J+T/zXor/pbV9XjFpizKik7IlWigCqOpW2hXzSjvi22oWrgw42rL3sMoD/vsfnamxdTs2n4VQOyhFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQKChAgb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQKChAgb"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9217d13c276so156070385a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782066493; x=1782671293; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+68GfSC2haTQartTCq4A5HONXR/TwNk8wP/Z5fxIWmw=;
        b=UQKChAgbcE9UaSbQr5/RjjfL2LT8gD/uxOvti8c7xP/RZhCDxwjyEc1Gvx4J2nr7mw
         CDugsSOJSacag1pYtppfDV2lQxsmCNYNvx7GpzWVTihGWwlqsVadj4QO6a7RvRgD/UBD
         DfMN4t2WKRj5Udl09ymkef6O5TBzOgGighX/AlMMR7R82FDDOhevL6MxAbMwAYZp1zND
         ntvHRsOV1ECQ47joqwrceEfl68xsP8jIT3+C6LWm5ank+/M8r99n14SinNzIQNFx53LO
         dxSF6A7p0EBOEfGh9jBJRLfZYY0luUYSx6VN5/u2dRwDP2SJ1WVNltKATMTeESwKsruY
         FDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782066493; x=1782671293;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+68GfSC2haTQartTCq4A5HONXR/TwNk8wP/Z5fxIWmw=;
        b=KMbvWQSq4rSp34HpWA+DeyFA0apaOTGxZKvNEl5oxyZndR/ONkJhnpG6qUXiNIGajZ
         2UUZlCXUg/xSxsEgLPS2djRUvOjBWxWrygJARZOawF4Xro/Ky6KfyzmJt76SEzXpdM7a
         CknECGXlwzFwl6WDMzTmyWmGWtrM0/eeeJdgWOVl4nyvdao7mhPGQCmYFcHYfQhBwbxP
         OS7cK/WQBLbrPIJ4yd4+TRZuJxDZe2c6BZyAwCefVCWcvISwRKF1bTDdLLSOZsO0tpD5
         upf3NSDioKuHvLUC//o8rKB7msoflScMWufKFyuMahimQ9FxEY1+6QbzCkonWnFzoI3U
         s0Yg==
X-Gm-Message-State: AOJu0YyRUmjawPIdGqmvgh2Srzt5SurJl7s8MqCRkW33ppFvpexkTTzH
	R8p+plpDXEgSuTQn+Xr8IuO7GkxmED9yf9fOCgx/9hjMU7kuzYCzaDWCAsGYcg==
X-Gm-Gg: AfdE7cllIB3s4Y4AV9y778AxgreXM6oZo0sVgqq0fioCfk7X+tDk9c34a7ucJB1Hc6l
	jRq8lFVlKvJH8IPAzvokmqMmkAlcmkUua5y1zcOj4KOBkZi/kQ1Ii5cccTbbXTJ++vW0tlq5pPb
	3WHJfX8mx5u0Gskx9ARhxAA/itA/Zru1NvzVMy0e3Qcx2VjlWGAZPUwb/TlOE5mJcJ8SL26EWuM
	WWRQYZ5jASjxmEkdTi81cNHVUMAeNDa0oEfEujJpRB9oAfsXSOr+/DLeehyaXPJnuRY9gWo3Un+
	h3Du+j9gCRXoBvBcMobmJWhDUlI6rsud8DBDlVF/hAZTpPdsjMPNcJQcGmjatmDhWKT9Y6nmz3Q
	dQ1l56iKZrqX1spTasjodgVTHeJKDB11JOllKZcfqsWyWVUKSGYAI6AARazMTWtD/Y8uL119BBq
	JpfjRFjVeYtxFQ+FLyCR4=
X-Received: by 2002:a05:620a:28d0:b0:915:e12d:19ed with SMTP id af79cd13be357-921d3da8fe9mr1153125485a.52.1782066493477;
        Sun, 21 Jun 2026 11:28:13 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.116.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7f46046sm704978785a.15.2026.06.21.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:28:12 -0700 (PDT)
Message-ID: <6a382d3c.a342f677.2e83b.0783@mx.google.com>
Date: Sun, 21 Jun 2026 11:28:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2177161494893747070=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
In-Reply-To: <20260621162305.219763-1-meatuni001@gmail.com>
References: <20260621162305.219763-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2177161494893747070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114372

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
VerifyFixes                   PASS      0.22 seconds
VerifySignedoff               PASS      0.21 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.71 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   PASS      27.09 seconds
BuildKernel32                 PASS      24.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      534.83 seconds
TestRunner_iso-tester         PASS      78.14 seconds
IncrementalBuild              PASS      24.42 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/336

---
Regards,
Linux Bluetooth


--===============2177161494893747070==--
