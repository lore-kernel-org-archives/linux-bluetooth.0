Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4426299
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952107; cv=none; b=V2m27KQxX69JlOBdY/z7zeaYzlb0hIJ0ommpP07I8hwFd18z8SSN7uTfGXooSILpnYNl096FW/WrTQwGASI9BdZVa655wRuF23qlGL5M6IwfeRLfc4PwK8TfQenQTWRPbZq9E3OeDAN0gbruATGYWiISTO0ZiOdTv5BbPAqrHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952107; c=relaxed/simple;
	bh=lg80K4cGY22Y/HaBhZAru2L4mD/f8XlIx4ghygO/0Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaqP5+zM0nGkx1g2bVgrSPX57BCVqkMsdDbSBk/3vqEQWIonqI1TWLspRv9JirxXCopH7E1muWbNb6S3F0nducj6huF0rO7czI3vhaSXDvcNtKGNRqgvSDp4Ar7LljDljjaqVErlbrCHdV82ia3hOAvJBvFDl6bqWX+6f5T1oSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmkeoyJv; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmkeoyJv"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso943067eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770952105; x=1771556905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1sMdKGyavQQwGS9RtSQHf4SQQGVuXp4sh5MqMjmUWg=;
        b=CmkeoyJvrHZ6gdyIs49ci4pgjlwVaVKmnnso7P5amrYa1Coc6R8ysARGFW+rg628bt
         oMZkRGIrOxnOOaaOEpmz3yGWoIleYzXh/UBHwYioFK9XLgXmmvhgCW2lW2CfiAEtzKyS
         s4r89HpY+Vuek6kdh/9YPtZn7zdzGftq50kmX7gHvM2Y0lhiQ1KKOyRYTuxc0IOBeE0P
         q1zZBLFzq8NES1EWFGhkVNnGFYA2ZeCvE5SaNFSouZmXk6NVzpOdY95AU1IIke0fwR7E
         Aala4uh8aP361B5p60SeZMOwRsh0YMZVLk8KVHPzmugbYD1AycWC2vS9MZUuR4W0HHw6
         E6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952105; x=1771556905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1sMdKGyavQQwGS9RtSQHf4SQQGVuXp4sh5MqMjmUWg=;
        b=gLrQFh7KOztbZuMCk+eqhRT2K6Dww1esUGKZ0cRA7DWYN8P+n5UmXOpibpJWKECVLx
         gyjrwEpUjIb/O/a3kIGTf2IeJdwo0lo/W50gWU5K0KU3XXHkuKAXERfaC6Oec3StzQK0
         MfdzQzo46GVPxfhvAsDGRqX9auKgOvcqTGXJFuRveywQfM8N3vF4Ngq1D4kjsHjgdxCL
         NcgjJErCQ530ZQnCwozpCLr6C6yILPrFqzMTmtxHEO/EmQDP++0AvuRinPqVLSMC3Tz3
         Ujqlx4Ytlht9v4iiPbThEqwOrRcq50VOnj3m6riTstbd/8XysEFShUzZDa4b3Q+3TGhr
         4u1w==
X-Gm-Message-State: AOJu0YxGVomavptzwl8r5iBx2ZMNyw5kO3kPSY9wBhExleEep9dg1S39
	0oh4Ol6xAWRDIlygwxoL/+Rjj0N4poSDX1vfZOZxlAHndkRfvYkhIwsb99Oshg==
X-Gm-Gg: AZuq6aLvoiZ7P7wuz/sH7QbXUNUUPyUk7Fu2lDc6/y6fIYv6jKMMW7bQLnxONViT6Tu
	LEg9OqDQFCO0oWN/xh7Cxcy7TlLt/elySTpnV8qJ3h4TaYWgrWb28JAfqKkkgiigz1pKbiyfiHV
	s2GLFmMfPgpw4QEipX9xt6fGJ7oolSYw6DrAXUWURoN2jEwi5utbTG09WM9Syt8K5smaShfSnbc
	/3fkHKu9f13ra0ojO9efoVoLdDNttjEG1fQyeMfINXVjeMbj4beLsgppamJxFTLNVPLmc3WLJUn
	1FnBisl+5BR6qworGVamgnsQYB5wjqtr7GL9ti+aMKSkFOyuux44BAGOiVoOsEbi7NFaWkUdovS
	AbxxTm+cbDxJBJ5EYArm0bnKbWK93mAN3TE2pUPHvreYxkQC1CIEyFZtDuEm4NLXItnSB8BZHAZ
	UsnFfuMSbnMTDFT5PrGxsKgBH2tlDtKKMi5bYzemLTvODObN1P6bHpF6MNdUP6ggQzjv5/syIOO
	rlTVXhiJhCAFMPd1u0PWKNtZcCHvNN4iP76
X-Received: by 2002:a05:7300:e108:b0:2ba:a3c5:ccd with SMTP id 5a478bee46e88-2babc4aa132mr141469eec.37.1770952105522;
        Thu, 12 Feb 2026 19:08:25 -0800 (PST)
Received: from ubuntu.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcea9b7sm4639377eec.25.2026.02.12.19.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:08:25 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v5 0/1] Bluetooth: mgmt: Fix heap overflow and race condition
Date: Fri, 13 Feb 2026 03:01:35 +0000
Message-ID: <20260213030136.5997-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves two vulnerabilities in mgmt_util.c:
1. A heap buffer overflow due to missing length validation.
2. Race conditions in list handling, fixed using the existing mutex.

Changes in v5:
- Combined both fixes into a single patch for atomic application.
- Switched to using 'mgmt_pending_lock' (mutex) instead of a new spinlock,
  resolving build errors and following maintainer feedback.

Maiquel Paiva (1):
  Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling

 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

