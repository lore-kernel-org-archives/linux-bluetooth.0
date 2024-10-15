Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA221E3D6
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028602; cv=none; b=kgthsAnT4wcJpQMsYo6/jiXse29f4L6ZCcmq9tgVmUeoEo846ZgiEH+o78tITTNasIhVOSg6B7eTHFiO6t0UrkozT3N8YzCDryxrKbPycNlo22MnIjjddHIRxrRYQJApk3mUF8v96U8xu15DhI5FdZNno+lTh5ch+fQOu1IOS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028602; c=relaxed/simple;
	bh=6ro5+0Jlr1JnGngNpf9Q/r5jlmZp9av1/0ui4T1QND8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XIll1+9lQouIL+C1G+LDYKCeMCiSngYt0q2GmrqGzKbiF75AP0IW1CERwu2IONxsWO7kkzy/mcKIwVmE3EeKOa8KlQZQ/9G0IcXW8NiswTNTrpmEHzn4bU+0H21VeOLtY/my8AIA26QWlAfKiXiQF2XGNhHB6Y8SJooAtXsgYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAnwfA7x; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAnwfA7x"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so5628854276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729028599; x=1729633399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Dl19kaEp6cgjuIK9vRdV6Abt/YV57iwOJc5oSQ898=;
        b=MAnwfA7x4hGKRLliEJxTgN2OdRb7atGVPMEG7Gu4tQF7tfRiy4UWn7UtebdvMqtm1R
         gSdSh5U0qZ2hslyhsh3za/4mk7OxuJVI+AbabklLCS6doaOVlWscEX4Taz1GK7c8Rv5q
         UDOEgQUY0vTsavKxGBC/Y5nb7fxg+2XFONkD0HIXf+Ox47HC/3D1vIUZiPB9B43BaV56
         yQrI3LirROuMMX+ijklSzThMylHLZKyYL8Twr87+qok6x0K55e5Tmd2bbi1vf4pENHWc
         cRvQdwy8jU2rctQkMu4N3vqZaXUoo3atgbxOem630VwIQCrdf/w8WGR051p6iQQHWetT
         1teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028599; x=1729633399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9Dl19kaEp6cgjuIK9vRdV6Abt/YV57iwOJc5oSQ898=;
        b=k90NnOFM15U0Kzp1wgYe77ZxSbQ4UsHgXVdo9cO6VuXJCbh3fRhzP2KFToC0wWSDpo
         uTw+R1TlJP6rqfn3K+S8i50W21YRXq/imRfW061cQrgVeCwm1vyWp6+TvlXpwWR/ZFap
         IUVkTIduN4q9rtPty1wDdAveNrxODJCSmGIZ/edH+gCJFRzavrZiupMXKWDK0jY1Fmnl
         m5jUmIPZ0cBfQRPpgLix/SaerDPqYQ/w9INR8wpGpqYTY6X1uUyECrNErPZeBnz2GDWp
         h+hIAHK0NQO8BL1rBjWziASJW+JlzOF67Q+bIZq45EJBq0wa7iPf880/BN7V6XS8wwCD
         oA9A==
X-Gm-Message-State: AOJu0YyvsDNGN/uCRgCL6M1a5vWLlRwRzaJlXOh4G8uLY7JzmmBPdcE0
	7//BGypED2i0eXL+fqAP/jI7cm7OrEqZFjSGj02RI701YAgD5fHTKJJ0cA==
X-Google-Smtp-Source: AGHT+IHb4AFuNtlhPOXvhSv9t0mjG3JkUTruzgz0cSZ5qlJuCg4CRCdzu9LQf/Xw9DkuKB6Ox8yPWQ==
X-Received: by 2002:a25:d84a:0:b0:e29:2466:c821 with SMTP id 3f1490d57ef6-e292466ca74mr10745084276.34.1729028599267;
        Tue, 15 Oct 2024 14:43:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295acd5sm11018686d6.97.2024.10.15.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:43:18 -0700 (PDT)
Message-ID: <670ee1f6.d40a0220.211c63.5523@mx.google.com>
Date: Tue, 15 Oct 2024 14:43:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0318850145048346027=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] avdtp: Fix triggering disconnect_timeout while discovering capabilities
In-Reply-To: <20241015194254.543683-1-luiz.dentz@gmail.com>
References: <20241015194254.543683-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0318850145048346027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=899479

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      27.53 seconds
BluezMake                     PASS      1671.68 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      182.32 seconds
CheckValgrind                 PASS      256.64 seconds
CheckSmatch                   PASS      360.94 seconds
bluezmakeextell               PASS      120.32 seconds
IncrementalBuild              PASS      1424.95 seconds
ScanBuild                     PASS      1010.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] avdtp: Fix triggering disconnect_timeout while discovering capabilities

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,v1] avdtp: Fix triggering disconnect_timeout while discovering capabilities"


---
Regards,
Linux Bluetooth


--===============0318850145048346027==--
