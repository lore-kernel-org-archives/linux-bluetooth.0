Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387A40855
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767096212; cv=none; b=EISuByrdlXRD8EZhmAtTgW9d52XlQBXXv11+UQPhT6a560QnmGSHrPDpenSjTj/4U69PghHh/VIvK+VW9HhzpcZj6bkddFg4huHK0N4/+xmJrYJpRVIGVn/PWteuoG218EkwUYYx0KcEjJWgUZkx/WfaUXZ1/85fbNBrvfOUQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767096212; c=relaxed/simple;
	bh=G3guGeVX9zEizC5tHYW6R6PfWeyexMj4hoKEFoYcpus=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e5BHXOiJDiSqYiv/R0QQWUzgTVTJn/Q07FF3H1eq7q1K7/KF8ilysyR+i+ulVnahb8n9bFSTKLzSbDcRZ0C8X0Oey1g34IN2p8EeAEkOrpbkOJdbMR09W03b/zZNhBQa5fv8TXchvGH8mGqMbNdRn7KbLcy1aynbsQBwEWNgCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFXPheVs; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFXPheVs"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-888310b91c5so89577996d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767096210; x=1767701010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=044rCYa0E+cecufM523wPTKTKROqVYTcdQqYAMM/SNs=;
        b=aFXPheVsum3/Kc06spOcn+WX/CsyubVRUQ2jOLKfPzIjaMTMT7UC2qVXmcUYGDVdv+
         nBRKXt8gKvGCr1l1Ib1S4aiUy+DQBZydpdz/u/HN/QGkpXJfaV1DstHyMV6yIXcHLIdF
         IA6zSiFZyj8BgG9rLovI3fLSMsIvyOpel32S91ibdvGuWnWnoABVWhgMgCXuMW3tV42i
         GlxQaiqyZMPBEwNldl9WpzRBXkhOkhKOOAj6EPObRaY+XGKf+aVYPB+Evt5hyEYpXswE
         WUbcbAtkZKN5BISNzquE560RgMDnKoeFp17KsQyfL1+zZ9XYCVTqBOTag/2Uxms72Br2
         z/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767096210; x=1767701010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=044rCYa0E+cecufM523wPTKTKROqVYTcdQqYAMM/SNs=;
        b=DOe7sGTV8Yp+cYX4l2l8GLb/3kA5Nn0rTyj0ahxDMOY4O4AJMwiExHuAh8d2wzNJ+Z
         0dQxugMpRHL3M/WMxAUSbAtCX37LewQfxVJoO/5AHuQp3FHuYjVh38mjug1NQEq8C7/5
         ZzART2qeMNJGKLgX5dqg/6Es6SiiKWLIJmoNieZyBw2P2SZVoPbPGEIottmsD4khh4aF
         uHZ3wa+fiRzlpJszIH6N6tPH5Gzl4YapCjsytd6Vk/7295/0SlPbUNlR1wJ2ZKv+dGga
         paJP2R9qHSybKiAV6falQWZnOMFM24NnnVpNZs98T4Xj3NPCwupGb9S9ecYCU+/+w6ss
         rn+A==
X-Gm-Message-State: AOJu0YyBObf+BejK16n44Ms0FYl4ixj6Aaz9slzwCgEEVQO7fPyGxBvv
	X1v0RH2Z2Wy8fqE+eK1Gb41Z5D6OHCWa4i4zxzUZaCRllIVvY2Z9xGYxFWrlosnt
X-Gm-Gg: AY/fxX4GsLCa7dau40hXccILH9AZvyJyNi9G6qj2szybcYZd2DqrfrHOtel3JmgxDOc
	D/eXYUxWsvOFvmsAP19Eyaz6E6ldMM2A/Y/IrJGCU2COSpXdSIUVkxKEtHSOW/ktDTBSeu/tqwK
	L3gv8IvF64eMBeFHg2r1IjBAyycvA+UFx2Ii9cIs1+L4BrouJUDAj8uk+gzUzHKf8v3+qY6Mp+I
	/g0s5NagpAivg/uVAzhPEDLnPS+xaa3QrGH5npK8jbLREdOVNcCeSj0Kvsab5rU4fh9yTl5DNY0
	17bzB4bYryan7SYcY3wmrg3SpHLkEaWSaiwN1hQQzkGIxuN4jwzngnbfXKhNq/ejXIWO3NhNVxG
	NlSJXIaf4zCVGruOCIEFoMjZxCDBx2s6L9GFEkQO+fIhR389lg1zXk1WP/RAZ7MaIu3aPFrKMak
	wzrtIOYQ2/bsd/oIm8
X-Google-Smtp-Source: AGHT+IH8xOYw4x4cuvGEr7WpCoBaP22LWcVIUpp8oC1TzH6Lss4tR/bKo3ALOD3txLZX/5mHzlLGkg==
X-Received: by 2002:ad4:5b8c:0:b0:888:7b01:2839 with SMTP id 6a1803df08f44-88d82236cfcmr586019746d6.16.1767096209802;
        Tue, 30 Dec 2025 04:03:29 -0800 (PST)
Received: from [172.17.0.2] ([20.161.45.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a254849sm248080726d6.44.2025.12.30.04.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 04:03:29 -0800 (PST)
Message-ID: <6953bf91.0c0a0220.3b8172.9a6b@mx.google.com>
Date: Tue, 30 Dec 2025 04:03:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6922825721368508620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: remove setup from bcast_snks when freed
In-Reply-To: <968496f3bffd44598c7dde7460a4aaa38a7916ff.1767092564.git.pav@iki.fi>
References: <968496f3bffd44598c7dde7460a4aaa38a7916ff.1767092564.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6922825721368508620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1037326

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      646.71 seconds
MakeCheck                     PASS      21.69 seconds
MakeDistcheck                 PASS      242.45 seconds
CheckValgrind                 PASS      303.18 seconds
CheckSmatch                   PASS      351.13 seconds
bluezmakeextell               PASS      182.51 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      1028.12 seconds

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


--===============6922825721368508620==--
