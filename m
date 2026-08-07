Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695C21ABBB
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076133; cv=none; b=RcIHT9ySnoFGjGGBg4sF+ttwZHCh5xZAd7oXUI8QiaE4Yc+FucvUjF63LI/09eW8/e7sIaICPDN90l2KDTJ1/NBr4rHsW4tmrOb7KU2OKhU8vWmG3GVbd3d17JZwvwWJ5HE8Iqsz+M/GEUmEcpaPn/dAOJYsbwxjiP/GYUNtmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076133; c=relaxed/simple;
	bh=IwvEk0asAGHi3nT5IUb+IXJFMA02WJ1gxSGLahZh3SU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p5srmYbQzGFkj2nvv7JrCyVAmtO9aNtGTwm7PM06P30Z1bzeg94ntmWKV5RcfGXBa5/gaJAfQLKQKd0qS4zYrdaOpJ+Ul8ox0EfekYv7or56kJ3Ec4RFYqDz++3weL3D+5yBORV2McQaIQRfAHTHfo90nEFU/I/+PpUWWKf6n94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+xYD9il; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+xYD9il"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0cea8883so14317481cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076129; x=1786680929; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ib6O/16cRJLduWzxHi01MnkhvT2PEgIKy+KIVpr/JVM=;
        b=Y+xYD9ilkGlOxS8wYrKr4U+T1jJeAONqbH6P2/a68G/XM3xlExifmMBRzIxjwzBge1
         Lrqe3zY7ddv94+mBdSrOOxjjm2IiKQN9CTHlatleqhnTDRMGZ2eANEE9cbLqKGpw8RlM
         w9Fs+6/WPHQU19RVHdFUyyEuAXl0VRs6FOxX8Y1ACr5Mr7qMV2j9OiN7Cf4svpBDXd4J
         u32CPnTLu0CjyOvC7g4E2KnDr4J1iMQKwV8HnYWha0ejR/s/UfmMfmKibQEW6TjGHibZ
         Oir7KYRB2f+mbUHO+9QDP+uzGI2BSSWurDIxRd2Yp2hLfFW1/L/bm3AJYAo8DDhXM/5d
         uf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076129; x=1786680929;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ib6O/16cRJLduWzxHi01MnkhvT2PEgIKy+KIVpr/JVM=;
        b=lsKghlijjVwCnKLSnNp0e7DTY2ZwCMTUt540ukknW28y3qBaRfHyJxcW5FEoGSr4Xi
         KlYUilnytSLAUlpFB2y8Aj4zWbFTfOG6MiOOOEokqESuFUlpTDJdFSIvlbWs9wG2SKFE
         +Ol5ih1uYKv6svHcjnWh1E2lWJ1oJelTtLkvH8YK6M+cUOz8zmTo44b/I/3fWEOJpPmd
         0TC1vWq9lOX9cF+MYjeQHeBBaw5lgyKHy943eLH7PV9WfXJO71bdvCTHnGmzuM/0oMSD
         Xo0zRdd74Ifx0+mQ42pIwTdT7jf52ZE6zL9bLZbb8kWupePa4d/wVu5UBA3Qk3NZxZJ4
         cCxA==
X-Gm-Message-State: AOJu0Yw9tBES07AaxGsR7Bmswmnu+856N4ygNN8KjIsipQbLEXYRpqkV
	vpbfgO4iAWfIwqrfjIoNjwDcNSZoBCWGtAez7SMgxvVyqAjqNSbVDgVvwd6PSg==
X-Gm-Gg: AR+sD12+05TZreYNoahyfFkjw3RsyR1SzMV5hXbJhLVCr7UwewGxd2+25e/Td5RKILM
	rTtGFA5zREP5wDJ1sfbYVY9CULXkSUNuL2rprJULq+3ouNzxVXLyaLHow1ipn0BZHug4sx+z4Du
	Ms/3lje3OlTFc1rMHcnP+AX6M75bPbLxvrqNEu44ckmWMbPubO18IUtw7lR7q7Djecbsw8VpOU7
	VO1AiTr6ssRK4EKuOuaRERg3FVg+HQ7A1564FVX8qFmrEqLpnr5jyIVzrxF7ypxACehnr8uVUhW
	W6XTIh9gr1B+9bw7waUAuBF53jLOlBb12UdI7yTaFzZYTrLoVDlaZRSfXR0LoKfzad6wSnWfiFb
	GAfMk3g6TKgXyJa6rwv0jjYQQcTqSzTZhGrIo23ZiMzqS8Zxphy1quEC/JKrLV66u+rTImMxVN9
	lR9igNJOFMupoPK+qQTHSBzEvIYUTS4T3xRNHRgi5/0kRSN9VzCXgta794xPEGlYPoXObp
X-Received: by 2002:a05:622a:986:b0:51b:fcc1:a0b7 with SMTP id d75a77b69052e-52cfaf34ad7mr137129771cf.8.1786076129305;
        Thu, 06 Aug 2026 21:15:29 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.121.195])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d163400a1sm4277541cf.4.2026.08.06.21.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:15:28 -0700 (PDT)
Message-ID: <6a755be0.3c73b1f2.398a74.01b6@mx.google.com>
Date: Thu, 06 Aug 2026 21:15:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8322385395283372635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
In-Reply-To: <20260807010003.85655-1-ali@iusegentoo.com>
References: <20260807010003.85655-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8322385395283372635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141845

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      27.57 seconds
CheckSparse                   PASS      29.54 seconds
BuildKernel32                 PASS      27.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      523.00 seconds
TestRunner_iso-tester         PASS      97.77 seconds
IncrementalBuild              PASS      27.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync

7: B3 Line contains hard tab characters (\t): "	release_sock(sk);"
8: B3 Line contains hard tab characters (\t): "	iso_conn_big_sync(sk);"
9: B3 Line contains hard tab characters (\t): "	lock_sock(sk);"
11: B3 Line contains hard tab characters (\t): "	sk->sk_state = BT_LISTEN;"
21: B3 Line contains hard tab characters (\t): "	hci_le_pa_sync_lost_evt()"
22: B3 Line contains hard tab characters (\t): "	  hci_disconn_cfm() -> iso_disconn_cfm() -> iso_conn_del()"
23: B3 Line contains hard tab characters (\t): "	    iso_chan_del()"
24: B3 Line contains hard tab characters (\t): "	      iso_pi(sk)->conn = NULL"
25: B3 Line contains hard tab characters (\t): "	      sk->sk_state = BT_CLOSED"
26: B3 Line contains hard tab characters (\t): "	      sock_set_flag(sk, SOCK_ZAPPED)"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/544

---
Regards,
Linux Bluetooth


--===============8322385395283372635==--
