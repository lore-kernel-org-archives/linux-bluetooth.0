Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D333987
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251537; cv=none; b=TB2eSWijL8JAEFPOURuZ80umBf2PR9FwlYgNSVcSqAagLxS6DEbB1+wKW3sSOXVgRAYgA2flJsH2ni/5Yhqgtjl7GfNOaUJ3Eez+LsIEx3I62ExVk/7ShnYLD17vvBburW5p9LWCHOasmtPm8JFOURjGGBIDdSk0GS3TewKmZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251537; c=relaxed/simple;
	bh=7TBumYQz10zUQcAAat+fL6zOSU0jgQQHBAvrKDfs/fQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Iqh1nQu+qoH4mlM7CCd+SdC7lYsziY/Cs+S7+COL9DFGcw5MDDopoAyBMPMeMhDvW7ruqZgqMtM4K4237j6QxkGRZJ4T11VwZa296sHOzGzye1KaPyqhY9lClNAqhGsCe6HnrhSOKJpYvpQutQeKvBWoxzGSW1pxrgNf9I8PdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNZy+jZI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNZy+jZI"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899fbf92bdbso1936016d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251534; x=1773856334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr5Llnqv8XSNYb8d3JgfzUdFzYFQ3aVGljtxKnGqdzQ=;
        b=PNZy+jZInVZIfAJz39nEJCQcTDy7VVNHuZINmUFQ5QndHHuhvL/ANt/uCaQgGwVeGJ
         tl+hIugJOgS2bOIJzjbyybLeDDVr+necqFRPeqayosmugzaEkT+GyAE5Ti6k6U+bUxPF
         YbLg4dfkujs0IBc3ZFERUFRwS+e45pBlD5TPVH2Y6Le6MuBuJ13eXvptTIGFjscxuUN9
         rqE6d9JmBS6OkdeAJ5YzEyecNwNaj4x3cX/WmXwHm5wKN4jkO8hmEvw0aaE07nobxIEh
         21PZBAxFG053LctS4+OSypswIKZoVLu8sZXwDGWB2IGVnWlkoBRv7lo1rOsMEKX7mE9J
         0mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251534; x=1773856334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5Llnqv8XSNYb8d3JgfzUdFzYFQ3aVGljtxKnGqdzQ=;
        b=uxdphDWSws70N6PaJIiQhqyMHWWoqAQcWPA1PcBQR7unTaQIWYp7iXW5s70X2GIs7+
         92ZTpihwplBTTKLmqUUO0beIW+7KoqTJk7Z9CakOBJYTPbv8BoBD7Uqc/w3L4SzEF0Tx
         9+wy5ZXca/W4ntEpeo/FFYEHyjoh8DpYl+1rtOJBvtdVZ4Pzj1qnTuwC1qe8EEtcbqe1
         CnEWbo28yI2M0/jU34YkWsy9HFcDhNhai/U3yuUpJA28hdjnkxnxQBpHzAMbRcBm6vw8
         RAoUCF1TJT3kC8GB0wX4cMNHe3YFBVwtW2QbAL825z0nlqz/RnfCNU6P+HTADyYyJgNR
         ksCA==
X-Gm-Message-State: AOJu0YxekzeOkd0bWVbJ08fhldIwjeZkdT6QZoKK6agGFKdiS4P9C5Vc
	KpuWqmpqnPCGywr93a1tKVRwsvZomN035uQCuDHpyBsPYeevnWSADX1VcaUpvA==
X-Gm-Gg: ATEYQzyVxwSN+xia/wbmRG83JnIsBKB7aERgcEoE+wnwbJ4srUe9HVx9YDZFsq7PvDl
	SZtxpPy+tem6f1oe9XVvs6kOr33NipN1MmG2HtcTX27DnyaPxU1fH74/OD6dZi5/FFKtfU6koZo
	hDQPLU14m6wjVY5ZLOiA5Iw7fy+vHuNaQtzDIOJJ88zLWLykdLUFInlWQBxY6UB8+jYev6Hcp0v
	bbVwQP/RB41ezcjvRx3vUMk0JhDJNXkAte477OnMlU99eA1fXYG2eRsRAbB3ZmaUsaWhIsXhWLC
	CeRIciMqNG1vxpC8DHuwxBc6oO1/E0ewocBZHaCDdHYvB6oBglFFVuTljFaFDZtgjfj48FYQPcK
	E+BB0wsNsKdqxKawsV8GgWFxxMQrjua8qBSM1lKRi4VF2HhM4I9++NXIyjnii97eAUQdB9SrMwe
	Jdxc5HQ358tnevpc+XpD89QSRT6ZAJ
X-Received: by 2002:a05:6214:528b:b0:89a:1ec:5304 with SMTP id 6a1803df08f44-89a66a18b5emr42809916d6.29.1773251534307;
        Wed, 11 Mar 2026 10:52:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.45.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4b3sm18754616d6.14.2026.03.11.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:52:13 -0700 (PDT)
Message-ID: <69b1abcd.050a0220.95dae.0e51@mx.google.com>
Date: Wed, 11 Mar 2026 10:52:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0431800169430870315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: support setting send Time_Stamp and LE Read ISO TX Sync
In-Reply-To: <08692f3273776c975e6bf5974c77673a28dd0236.1773245666.git.pav@iki.fi>
References: <08692f3273776c975e6bf5974c77673a28dd0236.1773245666.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0431800169430870315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1065140

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      26.20 seconds
CheckAllWarning               PASS      28.57 seconds
CheckSparse                   WARNING   32.83 seconds
BuildKernel32                 PASS      26.03 seconds
TestRunnerSetup               PASS      574.85 seconds
TestRunner_l2cap-tester       PASS      29.62 seconds
TestRunner_iso-tester         FAIL      59.66 seconds
TestRunner_bnep-tester        PASS      6.62 seconds
TestRunner_mgmt-tester        FAIL      127.39 seconds
TestRunner_rfcomm-tester      PASS      9.87 seconds
TestRunner_sco-tester         FAIL      14.85 seconds
TestRunner_ioctl-tester       PASS      10.71 seconds
TestRunner_mesh-tester        FAIL      12.96 seconds
TestRunner_smp-tester         PASS      8.92 seconds
TestRunner_userchan-tester    PASS      6.89 seconds
IncrementalBuild              PENDING   0.63 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 140 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Ethtool Get Ts Info - Success                    Failed       0.071 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.478 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0431800169430870315==--
