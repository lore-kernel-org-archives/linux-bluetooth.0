Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB31A5B9A
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521646; cv=none; b=U+KHP/HYfColBdKxVn3URiHCQx0F9wNbTTFzgoPZ+N99yYXcQMe85IlQn1CTFlsKj7sK+l24zDs7VI32npkP6bjZTcCp2+MShbBu7AlqhEoskUB+Q33XZThdcrmKapSv/3yZ8FwKnzwW6ybU52GJhYLVdIBBFgsfp7X4g2WOCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521646; c=relaxed/simple;
	bh=dFR4ZxRi2LKfTtrb0AHHlnGZd/yF8H96A6GiIhkPfDM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JOpiRwZbN5qlgKe6PSUj0i4GT+Lg2zvaoWrVaRTWWNBKvhzq6Rv/Vri+zsMwM5Cd6Pjtbe/EF/XavclTSni1gHMEwPfGjtS/1qiEriGmwZgszCoBLqfVWUTtzGwr2quttfrgF9/s7OVNtKfp/lLrf6K/DNIxtXnN0T8XOyaUfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIYgiEPF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIYgiEPF"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5568355ffso495454985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743521644; x=1744126444; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hKXJbDNNQlYK4PlzuvR3+/T8g0y+a4B3NuIylOXNx2c=;
        b=EIYgiEPFpNic6kUVXj16Sq3yrwYy4lV5C59jL9pgnssBWe2XwjFpy376o1Mc4lW6Q+
         G93XSDTrMeiV67uJKsksAt7XzO6SyK73+cCBQWo1EkGzpGVPt0alDTLL+W59ghaKNQO/
         y1CTKAsufLYJw3onkksNn7fGE8lJ3WO4tNO0yI5oF9KIcLNREsIzQD2QSyaNEpaT1W1J
         QmYxhBwbm7QWkAUiHvD2mhfYru6vTc+z/Pc+wn8FDD8XHroxPF8NlOnJ8FQpC+kwwQzI
         Iou1ZTmXQ7RqzMC+QIUK59OWjUa4AsAFrEEq9JGQuD3VMFMfzyUqy6xelWOoIoiH66Nl
         xdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521644; x=1744126444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKXJbDNNQlYK4PlzuvR3+/T8g0y+a4B3NuIylOXNx2c=;
        b=fs7isCE9J2TzQVh4MXL/JYUCkDrl4J2Ph+hhnnur8u7A0sk3msd2dS/aTWjAOTqlut
         5AIrPrMHxtv2/oWMf0QlNDPTK4OUUN+oZI3Uom+uMQQx303Pk6lOfw9v1PF5R/68jSXu
         /arZZbE2bnJRflg+a/J5lozMMDCVJhy9y5V5Boa2CYa5Bw8ciED0WqGElFrQ1d5fzFws
         4vQjOjj0lAH8ZOVLmH4IB5eryvhJLwJLPtvPn/2Xs50ZpgSb+cmhOp7nXBJw4zq+qIY1
         VI3eUzePQGVw/KnBLHUmXNjFFRyzJqLDH91wX3pz7i312TCoGGcA/1Sv1v05cqHBFHRX
         tAFw==
X-Gm-Message-State: AOJu0Yyt0clngS0smwBE/dtW4r5wGzd1Lc613tJ5SvkVvEdeoXUVKwQg
	OLZOOE8sR8ndaE7KVprktgi+e8BZuVNY8/nsOMpUUY2ghrJYjuJ+O1LpUA==
X-Gm-Gg: ASbGncuewMxzwoMbWrnS+CaS6OYMKs9Y9dL8/wk3nlIFqKjwcsyYOM8hQkO8uLffPCZ
	Xfq0+omUTyIzBqYUV2oNzb/itVDN9lZIWd9kfA/8SJFr2GaGNxUx77sUhf37hqIOB5PnQiz5JoH
	FazPzKcLDduUdU8WSlUEz4Aj7MnsxjLgL2zMp2grmKynSzYT/6PiY0QseOq5LPTf3/K6S4ErjEh
	/FTpXbyDFLmfORyHkxSLnPlOhR+JquJzIsFwc3ZR09bTgvA+pVlfhxAq8Zwiq3F9MR72aCyVvBf
	W3kRsNr9OcAOGF8EqCWGZlEQpjFvNs+MXYrdZlAxxGVbLZkiIEM=
X-Google-Smtp-Source: AGHT+IHwI4nwTNfzXCUM6T7rdoBduzUe5VshkXEl+41IRQjlvPkYlU19uJfOIuzXOpclyN6MvsmaZQ==
X-Received: by 2002:a05:620a:488f:b0:7c5:4738:8a0e with SMTP id af79cd13be357-7c75bc6ab00mr511062285a.44.1743521644021;
        Tue, 01 Apr 2025 08:34:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f765ada7sm675785785a.9.2025.04.01.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:34:03 -0700 (PDT)
Message-ID: <67ec076b.050a0220.272156.86c0@mx.google.com>
Date: Tue, 01 Apr 2025 08:34:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0349440519492645749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: Bluetooth: qca: fix NV variant for one of WCN3950 SoCs
In-Reply-To: <20250401-fix-rb1-bt-v1-1-0d140c583a06@oss.qualcomm.com>
References: <20250401-fix-rb1-bt-v1-1-0d140c583a06@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0349440519492645749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948999

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      26.75 seconds
CheckSparse                   PASS      29.99 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      430.98 seconds
TestRunner_l2cap-tester       PASS      21.07 seconds
TestRunner_iso-tester         PASS      33.11 seconds
TestRunner_bnep-tester        PASS      5.63 seconds
TestRunner_mgmt-tester        FAIL      120.89 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      12.49 seconds
TestRunner_ioctl-tester       PASS      8.33 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   0.54 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.169 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0349440519492645749==--
