Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61827E1C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253410; cv=none; b=EvCIOEMxMT3aYKjJxYukphDEj2GvOPQQCkadmz0kchF75zLIgWpr3GCxChstMhd1QDaO9hiKDHAJyToSQO9bFy7o+hxlrUtM1TwdV7kBZym3w6y91qtV4XpKL3gOb1SG1eBN2i3IhSpEg/k2ZfZTghi3w5RvJHEL5lPBQq/9mzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253410; c=relaxed/simple;
	bh=bdb/G67ASBfI0/aZs8pMIgmXQmZL3nplKu+mWf1VNDw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gGTjwJCegw1np55UwbwQZVfuihm0rC5rfq8XyT0ADuM2iDXuZLPhF1JfrPz5Nx714sp35uWHjsE7T6HuHte16acobocFM29k91uVBZFltA9s+l5R0CZtugBzc56luNBaV6i2uWDebbquBCq9S5vE6tEXJsBwcyhck03kOhBXD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMnjyGW6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMnjyGW6"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a44b3526e6so90169431cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750253407; x=1750858207; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HY43N0amGqoS6Gpe6feA6ucRx4fx52/b+xfEz+fqa0o=;
        b=CMnjyGW6Tua+p6kt/oyN8AFtD/F7xBP+wzlKzjlNOcJA71b6cc2bl0x/0QYELnzabQ
         coLKgCj+DLpW0TFw7VhHifiI46WQfEp4GmnWmqJUtFvcoBkpZNgUj81HBZd+JSV/Ia2E
         4kzwdiJZ+4QEhx/yl+946ZRYYUgYjCd6a8lf8fMGEDuVwRA+bTRCoc6ZdZxz0JKs4/zI
         y0DOM+Qw6KFkT1UhmXKLbU4mLEOQhYZm9nXCAOTkOGxaV/kqHEhO/GJbpMxsgoQveEbQ
         gmoajMQSTlRrUjzx/0WPKfcd69eo5XhGfR2fiakvTE6i/tqfdoVxaArlJjFcAO+RCR7I
         VhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253407; x=1750858207;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY43N0amGqoS6Gpe6feA6ucRx4fx52/b+xfEz+fqa0o=;
        b=NjBX+WkPIunudg2RdbXr2KBGlkuAlNfZJYb/wxBgThSygSnW6Htq8NhQqN2iOJc8AB
         JQPvbGYSg91s3uEpjV9vLfOXH68fp2lLJQ7YOtsCpkLsl+s/txVSR0+ncVrgMvu1bJXc
         bzEXpMEfSNnV7N38ZlRfj7rGN/vrqA6V5rE6P3/qKKCtuJk6PI8yF6Vp5F/6fxxvuY2K
         XhIMbLcJY7Md6XtedcY09OgpQyD5BCXZBwVU4OQ6kUp8lCXXdwF7PCB1Dqxb60sH7RS8
         nCtAZ7TZ04LZfRJMKKxTLm91/iWuYj1430hIbFNMzhZQASd5H3zU3GzPxKUlc3U/YjRE
         Fb9g==
X-Gm-Message-State: AOJu0Yy1i7Nb1PskZRECkBUgCwvoQaSd+nYR318nKAMuFyBWHblnUwV2
	cG15XKB9hltkq3lZLrlBSR5IqK05jCZdWp7n64csT6FU61yLURds2dpuEST1EA==
X-Gm-Gg: ASbGncs1ZXSixJhnnKaw34AVmexq0Ihvr6ZwWD/nOd7GxP4VJuV7gtw3mJSb8qQF0dP
	D1oAFSo4d4i+k+ytmkAjbULqdYVily6ajiQkaGJNk/6rZLBnQ/DDqzfQwoL7oMYR8YuR7SXH9xS
	+JDpXma4QHhGSpRa225fMxAVs8GFqAsS2agQtW0H38QNGGHRB4KznhFSAUYWibZQY7aHWd4vLl+
	C+hIIaodVtz2i2Ud7oZYPJvRhZBtbbsYVTEA6rjX+aM2A+b4VSlBwu16hLz4IplObLw6v/URPPA
	RqPlweMqPcK0lZnorjTKzDjDnaczhfnXlOAYWwWK7cqpOwmSBlvhk6TXL2LviEmph4o=
X-Google-Smtp-Source: AGHT+IHZjPXaI88COjRf9GvEuRLmgl0PYHsx0Y3cRovus8q7NXsRoP+QxNNiP63HqJv0kKzhQjMITA==
X-Received: by 2002:ac8:5a0f:0:b0:476:ff0d:ed6c with SMTP id d75a77b69052e-4a73c5a5ae7mr268614401cf.40.1750253407228;
        Wed, 18 Jun 2025 06:30:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a313c1csm71675451cf.33.2025.06.18.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:30:06 -0700 (PDT)
Message-ID: <6852bf5e.050a0220.15f572.e553@mx.google.com>
Date: Wed, 18 Jun 2025 06:30:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6966413418202303504=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add support for device 0x4d76
In-Reply-To: <20250618130251.774085-1-kiran.k@intel.com>
References: <20250618130251.774085-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6966413418202303504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973439

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.65 seconds
CheckAllWarning               PASS      27.25 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.51 seconds
TestRunnerSetup               PASS      460.14 seconds
TestRunner_l2cap-tester       PASS      25.29 seconds
TestRunner_iso-tester         PASS      38.48 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        FAIL      130.49 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      15.10 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        PASS      7.76 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   1.43 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.223 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6966413418202303504==--
