Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C749C4C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300280; cv=none; b=hbZDFj8xON6qiEDkW8NWrrIk0vQpRqApK/Kagf9wCDFF5UcyZZvuw6Mlu+vBkL66joGEsKpPYcEKOhvKO6ou99MucwHBRjr/AsI93KDrnbiZg/LawumF4ywyQh/bkGbg3uo7AtzZxLSG/9wYkqL3v0FHF/hAihscMei8t2HtQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300280; c=relaxed/simple;
	bh=BsZLHAhdpUYI9RwOCpVUWhS680zsyLb8Ltuxz+R4vc4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O3MNlrPdSoKvnj3x+AoLLxaBOrwomIospJob/jyU//HFqMoNj+ETGu0O1rhSa9rMzoJXGPAwmRFdzrfFXLMSL8vldJTBmAwzAfBq9FqwpTI+8ZtJGjYprkPuByp3YMdgMpK6u7C1GRNKtZKNFMDf8OlTiFffuujUD+adOVrNSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8YhpPuw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8YhpPuw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccca948203aso514119a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300278; x=1791905078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MT25F/NQUKdKOwfEYaquyw6zvV8VZN78HE5XPxy5IS4=;
        b=e8YhpPuwYN4/JdeG+xhsxVmP57f7aDigd98Xwy6S7nq1i4ZsGYaMcZVWNoIW4yAcgH
         ExwYl9MfcV2QXoyKjLvJNcFasZda0EApMwWwzw/EB0THC+Aey5A2m9j5mVvpiHyDM6ce
         1ECBkfC0iUQMcSTgg4Yz80yVJrXmur99Cj7yx7d4WJN35bSDsVTNN/en/lV/pLOPcvRI
         gw5L4HlL9B4lp5gpuEUVRglGDBrw8JVl9yViNU83QwSw+xjtGmGLa0P1DAC8/MkS2wR4
         7fqwh4c6udZ3d1aCoMD/aZJ08JuW9OTVed90uXtDzyjMVDGqLzOTAajT1F6fsQuhsYFc
         3oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300278; x=1791905078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MT25F/NQUKdKOwfEYaquyw6zvV8VZN78HE5XPxy5IS4=;
        b=rBnR/xQxMHnvly0zZ85wmCVCvWE35UWW1ezbCKziUWd9XblfSix6pBo/4GDEOFVH9d
         LDAtgQDJT6yvpC9seBkUdzHaLsFQp2cd1MSEHIStLwzeX1FBy5E/c0o4DxiyFQFIgIiV
         9eCvGOuSSSw/didXA9PU7TYWjcKbjZAmUxOYRazwaX8gAuE7d7H5VEGpUWI/vH6h8zoo
         FS0az/QZdcOeSGgr8fIPserG6wKVwykJU5r3b4A5k+6Z4xKvKWAO6YAFknD5k3fa4gDK
         WwzIFMR6HD3Irgjn+bXrgjomBfoVnfnSV+Ldtz5V2brPs+3IDNO1RdyjcMnny04Z/c7/
         6tVw==
X-Gm-Message-State: AFuF++mTgfapI8E0y784SFSNtPtag93TPWZ6DuE9hzmyHsBFP0s15hNC
	hp35COoN5n/CvOa+8N2KL2l9Bj+KqbwF0rQZQds/NXvAApSyLkPHlIyjIx9d+w1XIhc=
X-Gm-Gg: AYBFou3pxePUDTXIQ9Sj8nAeukVzymg/uPsjNuoOJjamwFdbKlLa0vrISE0QTQ1/P8K
	W1Lc8UinFCEqtPzR0LWGeQt5k5JDVEy1xAGE1+oNtVvfJbkTU7rafckjGzExxsY1dn/TOLSmFho
	u1cbH6Rj+bVCIe9xvZIqGQ2OLHmig5KhNdTwNhcM8dqdFr40KTW+L0AYNbXpv6eBWgTkPmAv44E
	o0dEZYKSUJNfSZ+T8/IdImOikkr5Xdc9jrXYl3cQRXrUE831HBWuEzMDYllt0ZhwWjSkTrpVSfB
	OMU1yf42gb8p8psRnaXBE/ncPgt6PVb1yXr4GtZXd9pJI5x5HIBa2CQC/RsSiDO0FgIth9L5WZz
	YEjjyHpz3WtX9Ao9j+a5+2gcr5JnEgU077s7ooWlS7GyIOcXtuNhxuD1Rw+E4rlvgOLBlJmjT7Z
	SU/Sky8tBGyK+ZO0f1JhNgZRQVtZHqFe4ZX6DQB4dxYNfdri/E55g05xeckRfZKBncYTBBV599n
	H9M
X-Received: by 2002:a05:6a21:a395:b0:3e1:16f8:4a11 with SMTP id adf61e73a8af0-3e12479aa68mr1448066637.56.1791300278242;
        Tue, 06 Oct 2026 08:24:38 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.166.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6ded11ebsm3001607a12.24.2026.10.06.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:24:37 -0700 (PDT)
Message-ID: <6ac512b5.24712c84.eb118.72bd@mx.google.com>
Date: Tue, 06 Oct 2026 08:24:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2487967953358965300=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
In-Reply-To: <20261006141502.3789138-1-luiz.dentz@gmail.com>
References: <20261006141502.3789138-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2487967953358965300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180355/

---Test result---

Test Summary:
CheckPatch                    PASS      2.15 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.74 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      17.46 seconds
CheckAllWarning               PASS      20.06 seconds
CheckSparse                   WARNING   23.37 seconds
BuildKernel32                 PASS      18.65 seconds
CheckKernelLLVM               PASS      20.07 seconds
TestRunnerSetup               PASS      448.04 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
TestRunner_iso-tester         FAIL      17.75 seconds
TestRunner_bnep-tester        PASS      2.73 seconds
TestRunner_mgmt-tester        FAIL      57.11 seconds
TestRunner_rfcomm-tester      PASS      3.94 seconds
TestRunner_sco-tester         PASS      4.90 seconds
TestRunner_ioctl-tester       PASS      4.03 seconds
TestRunner_mesh-tester        PASS      5.05 seconds
TestRunner_smp-tester         PASS      3.88 seconds
TestRunner_userchan-tester    PASS      2.78 seconds
TestRunner_6lowpan-tester     PASS      3.91 seconds
IncrementalBuild              PASS      26.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic

1: T1 Title exceeds max length (82>80): "[v5,3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic"
[v5,4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters

1: T1 Title exceeds max length (85>80): "[v5,4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 136 (96.5%), Failed: 5, Not Run: 0

Failed Test Cases
ISO Broadcaster PAST Info - Success                  Timed out    1.842 seconds
ISO Broadcaster PAST Info RPA - Success              Timed out    2.000 seconds
ISO Broadcaster PAST Sender - Success                Timed out    2.000 seconds
ISO Broadcaster PAST Receiver - Success              Timed out    1.898 seconds
ISO Broadcaster PAST Receiver Sync Lost - Success    Timed out    1.817 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 503, Passed: 502 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Add Ext Advertising - Success 5 (Set Adv off override) Timed out    2.611 seconds


https://github.com/bluez/bluetooth-next/pull/869

---
Regards,
Linux Bluetooth


--===============2487967953358965300==--
