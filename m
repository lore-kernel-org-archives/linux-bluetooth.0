Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0C2BDC1C
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220257; cv=none; b=f8BEYqakBZHo0KgcKMxu6Z8ozwlTTGyaw1jfmfJyaVI0Btx0SDDVxEEFKD0yd7knF3le5J+VMyFfhoIftiYO4Dsyzs9acOGgr80bWxnjuA6DSFXC1cjrvuzuAbHfM5rkkwo/Ik8nf8ABWH/9k/3/BeUjKWDPQKzJx9HeQkDeGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220257; c=relaxed/simple;
	bh=LqkKJCL0elgzIHL0lN9uReB29DLgLlZBtpA4RMcJi2k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LjQu58gob0YWom2sjZaOQ4gFv6oRyHQ0t0gP3Hn7xgk90W3yI1Y6BsN/1zB8hC0hbTAhpnUGQ+V/f8ic4fgC0sVLpNqXIXpdbZuzOk8tD35avsvRCfWxtg/DYIICIWda4fIkfDPpdzVt2qj4UxsaHlkMhqtZoMPyTzodbwozbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pywe/i4F; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pywe/i4F"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9116861f004so947497085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779220255; x=1779825055; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VQI3187Pa6nxNiUZYrw2Z8kdnMPEHCkRSEVOJeQarE8=;
        b=Pywe/i4FId7xO50QCQbo6vtflmrBGL3iTgz2K6BmfQD4UpYU8cIVzCx136k5rpiP28
         pkJ1cjumkSOTyT6JMaDXlawUGnb/Knp5VFZujXrvYWHkTLj3OlvXrnmLcaTwjtMkqfoC
         JPrJKQiHchTNPkGuFdquOTPEiUgiTGQmpriePd17f/BSfSfg7apTZS+olN9r/RTI4iG+
         iOGKQ53ZWNfhrlVZYtwPj0Lo6O/a3RJMf2qFRV+nXXkIb8J3e+lUn7sGKRbQWgh1wkd5
         FC/vyQKhbInbO6ifkyiVpK4BV+6TdxEZy2fwCGRavatjOsFubDdjMFBqhcKtTNMJDEb3
         Bsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220255; x=1779825055;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQI3187Pa6nxNiUZYrw2Z8kdnMPEHCkRSEVOJeQarE8=;
        b=EFWc5reGH5BTLqKwW/4NQIBwLypVam3viyIZNqXNYeqTQ55Oe7PfwDor4DU6jrVXm2
         7uaBuz7RGReB5UxDl/90DEZvCgCLUs2ZfMez5o0DgnBqETmjQqb201ZNzdhKSqndpp+W
         yNO/CIt13y993YZpOx05/dGBJabYKFFCEkxu4QMwJ6R75cmaZ+jEfQQRnKKtyJYEgetS
         FPhPjJj5nl1o8pVRyzRY6Tyk/ewBz+zZb+CPMEwVLTwziqwIq66nfe7HHU6Oy3ciAwTU
         etLJsLo6Shj7QfA1G/JpXvfGsaDFDW6eAcfqGpjZY+iJSLiZvk8H+5SA57w6LU2RKm1t
         zuvQ==
X-Gm-Message-State: AOJu0Yx+Szi74b9Z4jOrXDdI4xQK09qezVV0Z6YUGus5z/iUzXOXHlRl
	SvPRtnP7WzPGTQI/EFM1ODn0Ka7o1tfioHKuxpym658/WMnP7n0dnJSihe/iig==
X-Gm-Gg: Acq92OG9/vIhsMG7izK++P/d1/ZJive1L1dLb1dRxioAvnxkxAZSBNqsaNfV5383buK
	McdMHIsikBCbuSQA6s9JHkN/rJ6j1ev4bcLJsp6e+iXUzGIz9gxzYp+Qg0K3Kr+sz5tD+TLDdgr
	R6bRQOHJRhWVxi8kaXvvzl5bMbhD3AjpgTIAoF1id90/PZ3WsA5j1UWjsdbatmjMwLWFdcT6t1l
	Sq/qaT6X7Ck0wNIPDJImfLAhiMBamozRKahKezrtzbUWYUAt8FXBYtaKZ2kNsYrxntjkZ75/yEu
	tLaeOFS5n3cWZGcXL36pt3JvkkFTJhQifqBh+sNQBbluU56JFNyQeqoItztdGaV+iHqBuhDJLcY
	pTOdFBi6PSeKCwWd59M3xn+QMPzRKIhhhc9Wu27dSXEfuMjyhbXABEv3IC6pYLtjEpbSWE9dyi6
	xhZ2jfEnRMOpT/6gXNvmlphK8K0NOw+w==
X-Received: by 2002:a05:620a:1714:b0:914:7e9a:2704 with SMTP id af79cd13be357-9147e9a295amr654966985a.23.1779220255121;
        Tue, 19 May 2026 12:50:55 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182535sm1931184385a.8.2026.05.19.12.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:50:54 -0700 (PDT)
Message-ID: <6a0cbf1e.c589b5ed.11922b.147e@mx.google.com>
Date: Tue, 19 May 2026 12:50:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8775050007464314306=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v4] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
In-Reply-To: <20260519184821.18925-1-meatuni001@gmail.com>
References: <20260519184821.18925-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8775050007464314306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097567

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.91 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      26.90 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      526.66 seconds
TestRunner_rfcomm-tester      PASS      63.53 seconds
IncrementalBuild              PASS      24.66 seconds



https://github.com/bluez/bluetooth-next/pull/218

---
Regards,
Linux Bluetooth


--===============8775050007464314306==--
