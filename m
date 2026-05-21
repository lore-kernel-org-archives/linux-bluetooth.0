Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D13D47C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367653; cv=none; b=TKKn0h7cuzjdxnwjO/IMCSwL+VAZGaXPNxnpYm2uGbmAXUBigkQXs1fN16mFFP/rOHIQAtPV8nPoTsqBlFMLD0aCP3x5USxrvjT5NErDT2D6pRGKisgcgTfK82RkOtHWOH33tU3/X8diok5buxAO8LJ7hCp/k8NUsCwKu0Wx8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367653; c=relaxed/simple;
	bh=4sZkVYFqgKlfh//WSyH3FBuVfikYe3oshmVn7cU3iu8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uFyCzGKyrDgnoJby9dSCrxc4e/D7AgCOChWE5NCCagLaxTCyqZXHo/cuhMiOiTPWU2NsSmUhFWJ/VJuNfXJ53ksXYRQ3UhSE8AlhX2tBMReeAd1CnAkMckEMiegA5dlNa4AqL0vDwNi51Z5fH8LCukE/f+e55T5YIQHeiQUPrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PccqnGwo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PccqnGwo"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-911796e9885so584660985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367651; x=1779972451; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BAQ4BjFSZA+6x7uJ/EyNR1qZlM8NZfa9OvJ5oTJVVuk=;
        b=PccqnGwoaPwTb23ZkzjBrk/lmPKpfkCuVvYlJKG8ro5trAbHu8+SoVQVr7uKJdp2Z8
         NznXDZ3gLOJJw+qNnzyaEF/nBWbpL3BEcdYkKAXKfGkMbse2zfqYq4VemPYSuGPJmuzi
         jeOgIFGymXyoQVbcM0T959ube+LRITn4wtdNijklw/4lNwpkh6+vImcbY0yoG6X+UGaH
         Tkt7tKFmNO6cXs842flBKbK7yksJ9wcqpE9S55d38DIfeL1K7L4XM3NqgAheW10tfXub
         wdr2Pv2wunVE0Lp9KwOL9Pqn+/P6glEAuLzJsx1DJNv3t9cC3VIx98wJPsakk2D92g+U
         i8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367651; x=1779972451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAQ4BjFSZA+6x7uJ/EyNR1qZlM8NZfa9OvJ5oTJVVuk=;
        b=ZWsBxT4BiN1hKe+YySKXPUKuGxOW91ADWiYfZ0zeD+H84/5JkJ74xcrCTk6WpppDpC
         fRp8FDsPjRKKO8ivfFeherjbhPk7oLJpKZXZ5pmcA6LVuRv6+rhha7wtQ8zBaLYeQvTa
         DluO/lnPlf3t+EG1GwUpdK3N96LoBtegNK+eNaM7SfSu6qlo76KgLanvVq08UvERBEur
         SmPJXKcQJVI0PcF5IAXw33bMH/iMxDwAoAJ9IiiHCrLlAhdoG4jflLJiwVpQS5cT6Ns5
         Q1BJoX43fM928uNt98Iy8URtxV0zRSZFlS/nJvNuIBn35B8Wi89yHiQGWFF2yex25J44
         EpxQ==
X-Gm-Message-State: AOJu0Yycq4StuE+hjj9vJEgA5JCY8xK+UzLcd202YO6cnFPau8RqHPDh
	7OsfL8zkD6k33HMYkZP0YqQ8OPNI3YdkReQtO55vo2OodPoZs1ocP98u5uigiQ==
X-Gm-Gg: Acq92OH1ZkJr2tWcBooJJiDkLL0jg4wk9wmvgeW9eVRqglqA1HPQxYAivj3bSb8oowc
	pIU8kK90oKOILbR3Sds5J21Y5HTCAC4Dq7Q8fAEshxnKroa6P5CsqvqZdk1bugaPsVGB5lLXNBH
	iFRQABI+beLqfRYZevUkeWVKBSkO+nVOoqMPHQ5bQkL+Y7GwDxVTFFqs3AzvyDPHC3i9S1iEC11
	5PdFAqEZjeJGoQdjiwPUcSEMZMWX5Qa+6L9RdMBSzRprfIHizKlpSlX1JAF3lkrzSgMr/mLPjHX
	dwQDyYLV97fLGpN9SnolODeareOrSR9EOsQlwsYQEe5T0X7iz9y1ate5e13WgOCeOvN8H4as9qR
	TdOpIE0ea1I7XkzbnCBG1f9v9OX61Mqr/RVukRrXJol7jh2WqHJeHOUI/MWR6W9Fz2erKqcuZan
	yOq+T+6aCfyhwqSMMkUdwVwMlGRi8yPWHR8TETocYxPTQ=
X-Received: by 2002:a05:620a:1a0f:b0:8cf:d5ca:adf8 with SMTP id af79cd13be357-914a27bc578mr322519085a.29.1779367650969;
        Thu, 21 May 2026 05:47:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.253.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914aba3d31fsm81794585a.17.2026.05.21.05.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:47:30 -0700 (PDT)
Message-ID: <6a0efee2.35fd6435.87d0d.f56e@mx.google.com>
Date: Thu, 21 May 2026 05:47:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2897974425606189666=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v2] shared/rap: Add client ranging registration and notification parsing
In-Reply-To: <20260521103227.2479443-1-prathm@qti.qualcomm.com>
References: <20260521103227.2479443-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2897974425606189666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098658

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.90 seconds
BluezMake                     PASS      601.40 seconds
MakeCheck                     PASS      0.99 seconds
MakeDistcheck                 FAIL      216.80 seconds
CheckValgrind                 PASS      202.65 seconds
CheckSmatch                   PASS      323.03 seconds
bluezmakeextell               PASS      165.37 seconds
IncrementalBuild              PASS      604.56 seconds
ScanBuild                     PASS      918.98 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1


https://github.com/bluez/bluez/pull/2142

---
Regards,
Linux Bluetooth


--===============2897974425606189666==--
