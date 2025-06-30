Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13E149C41
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267568; cv=none; b=tt8oTYawyzOagWbQTw5f6o40ReIk9WwwwoFu5z6U1BFEccxKGTM+/gTG1hzQkNcFxobPh9Um3F7sD5qxSu/qEF+M+tPbi3t55DF3NRAq3GT6pCPLguV3WEMvOg3jzrE0msaTzDuyrAryuc6+mmvhsepvnuiMBOxwJFteeNomFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267568; c=relaxed/simple;
	bh=JFrRgJh/xrr/d0DnuywdS4OuChD6frnF0eyjSNilzls=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L1nmKC82ioO6WX8BOXWuJXWjCKDmz+R6hu7oIMerzwiIplGPmBiGZoRGTlbNdVOPFFNlL8jBKEtWwckgpiSiU+waWwLFilBkLNjGjgU1Q43IhG3sM7g3cPgzfcrQ95mZESkbZzWJWD6loozpIIFTdbbAwtnUnhytV2AFAHDHF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsblEKJ0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsblEKJ0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b9b2af8so9005471cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751267565; x=1751872365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x4xqzEnDgl5Dq3EC4EyBUbBsU9MZcZ71/pt88ZPvyGE=;
        b=gsblEKJ0THAXt3Una+DzYf84NREDEgZDIPHiyNNvxFbKnVUe0ckpPaW9DnIyPooMSa
         9jN/SPqmz6Q6PTY5xON3UyldaNUClH7BD9I63aiUSKW6emQMjVrQwWjyHtxfvi0MBm6t
         VMR/PlVn8dcTl+FwxUkWBw0GO+lKB4c0jAcQNY7ZJFMspGmH+R1iWEmgzNEN2LyJyzr3
         4f9ldpWFe2rINWdMfJWZA/TrVXe9lVNibTQeDAm3PkvG0ZbykLC2QGI0DPtWlPmMlttc
         GwX7JzE295AogiF4QDblzRbXduU4LubOqxKxT14GcoZIbKu7+Gg/HsXQhVcKgkIIAWDd
         8yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267565; x=1751872365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4xqzEnDgl5Dq3EC4EyBUbBsU9MZcZ71/pt88ZPvyGE=;
        b=qjLidxfiesHC3TQmnljc1kwTwYJT00CZoVDf3o+nFyZ5VAHmbmroJxCVQMyT2HbAtd
         vH7cLQkxnxbpK/0YM1JYPT+m8fo85addFQUwnUmK6PXP8X685ZbEl3YFhC/OEU8dbEZQ
         2t/193PJZ5iyAzGk5CD+pc2cmKGQZreO93lgqk5W5XPyd0/iVObvz+D15IKZ7FCXZu7R
         7qOUGrnP1NqaQA1UAOBdWPEjnr8cCXiNvHoxMhPtILisB13ft4FdEqWieTxUcC22+9U7
         lSJZGFAByG/2ZmmKDsaEOtJ5NzlE6gH1p0gVPnuCGWqEs3RBiNR8m3YEREOfQg/dWLJU
         jFGA==
X-Gm-Message-State: AOJu0YyZm5UWPEz3bZYAGHtX3Zi48uFm++FC6FgmNvZwoidxiOR0YIE4
	IBjH8pY8bcYeaIjCXryd3yBTKFVqkUGMpcj2D7TVFFLr4tKq6h7N3W3zfc2n6w==
X-Gm-Gg: ASbGncv3zfGzJj+pVW/syHqCRNkaAT2101T95PGjdaIqSVyTN1sPunNGweKDIeN/GPn
	3vyFxrUUbMTA0gYiNQVtzUJ2C1yCAImRKRQ9LEfdklOqQjYuwgKQ0Rk+EapeL6+350OL0NukXmQ
	iEbU8zX0m1jmUMDDJtNYN3J3XrKP3z5RuYnG1TY3PPtlBWrlpqDYAEzRNOySBtCOlvCmCgzh0EC
	0ovPf8ytePZyxzWh/oDC9kiYmFnuvHOIECDFXn0Isc73oFFnDlwifHte8+W/+QAkmeN/4cWqTs1
	9O5Pd9C1roxnxQTjAIEEuNkFZD3u+dgFryTGLeCIgDMVb+wyzNrI6+s756/A0mLJNyvk
X-Google-Smtp-Source: AGHT+IGwQYyScPpDsn7KFu1JiUarAj/mbbY0aWC8baOGbFufFJX9BbAFc8GlWz1zXAHlGE7F2YAFpg==
X-Received: by 2002:a05:622a:2305:b0:4a6:ef9c:eaf6 with SMTP id d75a77b69052e-4a7fcbdc53amr199953551cf.41.1751267565067;
        Mon, 30 Jun 2025 00:12:45 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.207.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44321a706sm549367285a.81.2025.06.30.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:12:44 -0700 (PDT)
Message-ID: <686238ec.050a0220.56957.dc98@mx.google.com>
Date: Mon, 30 Jun 2025 00:12:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5020172552729551584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v3] Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
In-Reply-To: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
References: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5020172552729551584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977170

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.60 seconds
CheckAllWarning               PASS      26.88 seconds
CheckSparse                   WARNING   30.41 seconds
BuildKernel32                 PASS      24.43 seconds
TestRunnerSetup               PASS      475.46 seconds
TestRunner_l2cap-tester       PASS      25.30 seconds
TestRunner_iso-tester         FAIL      42.36 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        PASS      132.72 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      14.75 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         FAIL      10.80 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   1.11 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.094 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 52 at net/bluetooth/hci_conn.c:568 hci_conn_timeout+0x14e/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5020172552729551584==--
