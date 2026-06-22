Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BF37DAA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114561; cv=none; b=oKSFKuUBUR15sfTcLVZI7YfuCyI0E2lHi4lONW+x1smazoaKKhuOCJMuP/AjA2uGmu1FqFUjmhQX9FJ2o2Mue9WcvoFQcjXwRNcwf0yqOcpEpVj0SR3KumnINizjeDN3RbJ/7ao2m4kVLn8pVCXKArDYYRR6F4kkFU6k5VkxHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114561; c=relaxed/simple;
	bh=7MaCvUXlCyN+TKGVcyK2By0CuMw987zHjypdVQK/WfI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gWSNCguOZKMLeOrxXvhrGKxp9pU8XCkZsgyyUlbJeKB2noLqgzTkQUW7qHcq7AAuvjYOw5dxSbw0G+4dYB31huxd8PT89P4S+PMiigos8lJ/KFGUrtzECkgUp0IfRdR//Y3sEddAW6mSrH3p+DAc1vD5dCJ4xuoiG34kk9S6MRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxC3GZR6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxC3GZR6"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8dfdfe27ba0so37261046d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782114559; x=1782719359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDuEjauVTPg0BQz372Ju6ucKgTCr8jY2juGOOucEKb0=;
        b=rxC3GZR6lLPHPIgz9EAPqdTKx8+kDqv8c6jq/57EJA8UTSv3sHMa4YTeKj/kIcvlyU
         AMV046bnQFEcRbPGdZGcyKkp9HSpEuclHJ3cO8yNCMdxQoGBxBfpZULrHHUf6P1uGTLP
         yVo+MRMLrB5Sr3TFgKPnsBzi194TkxeAWTAAuxB+7XgXZJNAWSbx+Bhxj66J1Ryn4tYO
         vKE7ZXf3qinu8AG+UuZiVtuPYHKE07/C+p8lf5oQzAkmv4gRZjdJ2mDMT66X/Djz7fbc
         gDN/yWm/d/cB3pzsrF8v0e1UTjWxsA5tO0PNiPsxxy2mIYH6Y12E5JHulAH2kWl6cA0V
         nLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114559; x=1782719359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDuEjauVTPg0BQz372Ju6ucKgTCr8jY2juGOOucEKb0=;
        b=HuBWQ8hN9Xx/HmK5gGApTXLYV8uOijNJvAmzxZTzZJRBhUVDHee42yX/PRbT3t9bgR
         PfFg9WwxNwBeQmOqFHUljwhzqrR8S7QqebSUxeam93gx7nYtlbRAlUjUlU3DDEAJSMar
         Z95wDcP6njF/SxIe/BIi7a/qmJkdcxR/yQ/DuUb5r28Tdy/zo3S6MlByOXafBO5hR5Zr
         62gCV7+I/r+cpLBZEs1LxbghdeAvThHGHBtXoaU1cnIt8Vn6m1GxJFqhWVYUsaY1lr5a
         u98CMg7+Yr9lsLxNs6QHXCXPmn8WNDtJvHlv0Kj11nnjkc1wi0ibjP5CitHJXV5TvUFV
         EwmQ==
X-Gm-Message-State: AOJu0YxuvDJmsgLiepV0XA1zwT4Bk13FNbXwwmjbmt+NbjFjmvnl0V8/
	eVqL7JR7sWNj/hQ694txfcitGPDLqJOoWxi8kKXFxN75c59Ht8ARvWI0gcL70g==
X-Gm-Gg: AfdE7ckJ0LI93OGqaFYAUThsitmHYJZZDwd5u2qr3tw5hXmq0CrSiaA33IqYhXMpqIz
	geJZhSQdX7hcTYcEan0ZQNjz2Kb2/TtQ7DhTkklw9nQchfAKXK8r59JH6hwHExZV0bu36qJwFtH
	/spuzvlze9EZaWpPLfT3aSlUM8VYUDgO6R5NSkS6FdTlmxAAhiLIa1W+wVmZ9Udsgk5wsKAVc0E
	QAIjIVIGZBw8eMLrtlcKATqWJkx2VB5rCMZ1WyUo84x5jnAt4Elk/cd2FIL0E2z9xV8xJa259EU
	k7l9f7n2aZpipszSCnKwVt5VrnlQRlGO4DrLqZEqGMyVOc7x8VXDPy9g7g2Z4g/i5lLGs3CfYGS
	Gg5BtcDrKQ5m9/wLjp9KEvZkd/Db6/p7yzT/4z6PtVYQSgzb0CvmTGkxvGZD3mhUC6llZUuC5IO
	uAXzkFshXpnaUuSODlMko=
X-Received: by 2002:a05:620a:ac06:b0:922:3929:dae8 with SMTP id af79cd13be357-922393920efmr1053125585a.5.1782114558947;
        Mon, 22 Jun 2026 00:49:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7f46046sm887969985a.15.2026.06.22.00.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:49:18 -0700 (PDT)
Message-ID: <6a38e8fe.a342f677.2e83b.0427@mx.google.com>
Date: Mon, 22 Jun 2026 00:49:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5281895326881677132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: [BlueZ,v1] shared: rap: Defer CS Event registration until connection setup
In-Reply-To: <20260622062905.3525480-1-naga.akella@oss.qualcomm.com>
References: <20260622062905.3525480-1-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5281895326881677132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114528

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.73 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      616.98 seconds
CheckSmatch                   PASS      326.97 seconds
bluezmakeextell               PASS      166.59 seconds
IncrementalBuild              PASS      619.54 seconds
ScanBuild                     PASS      932.12 seconds



https://github.com/bluez/bluez/pull/2250

---
Regards,
Linux Bluetooth


--===============5281895326881677132==--
