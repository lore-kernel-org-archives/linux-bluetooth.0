Received: from mail-oi2-f30.google.com (mail-oi2-f30.google.com [74.125.231.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EB32FA1B
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789831987; cv=none; b=rSlLM5J4lnyz0H4KoHeW2fjG1508hHVHfRGQuZ0Z+jsJhDuAfK+7u2u9s+1XfWUP6J0Hq6XNNU8vRLdWaCB7dYA2cVmYKRgb78K9wTTDfi+jGwQFyd1/JldgmitfxloJFvCWc3k01Qdt5CvruPf8oIt7mh39v+YVUMnNLfU4URo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789831987; c=relaxed/simple;
	bh=2TMrRGedDHH8LOjKlR+6AkqcEOJmmamEHwoqzLntcLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZTErgEwN+IqbqMmCx5tkeLDAYXwmKxZHZSDXC0PPF1QEDs7tKQWE7weRgtBAbKfjiVclZ9ohsH8Crft+Vbia7om8UombPYkaJMpuCi4hUXrSSJVbperjoQJRtVGW6CWXDYlCHbbJfWaTVx5C9C35J/WZ980ePA2Omp4aaMuDWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSFfJecn; arc=none smtp.client-ip=74.125.231.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSFfJecn"
Received: by mail-oi2-f30.google.com with SMTP id 46e09a7af769-7f65ebea805so1022362a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789831984; x=1790436784; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E9+9zH0SL1nmZGNlDpXntbW2fNwK448sxtJbqc1L8Z4=;
        b=ZSFfJecnZhaqHWA+3ja9kHS6UB3fyfgHNhmp/URJzBgjleChzB0ljkVfjpKR5DTPvK
         tKhR73u9tKjzNc19eroLhCs+iTDpCKUeCI+P4/m2y/z1ynMt5oUPDF5hRbly3h0oqnUm
         FI4l5rGAc+QDH77bFpWsszy0XopY+lwbFQMniqU7KI5D0DCY3Hbv9a0uQ5ndTSc+TuPT
         koR+Rzvqi3T9Az2LOooIWbdAr7mrLVINB5r2gYrPjugrBSAgbZu6OPDztPPM0wFVwedv
         kIPyPzNWBEZuXC4g6nLfKyNv0YGSgXggmz4NKaMnDdoO3aEtIWxKSxA+zjmJwr1Dkk+L
         Q7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789831984; x=1790436784;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E9+9zH0SL1nmZGNlDpXntbW2fNwK448sxtJbqc1L8Z4=;
        b=otrNaKHE6aNrJcGrJL5knK2I3/l3AUynPl6ZsNnaDaE9il8MDmNr5tij5urFB2kynp
         Uu0mfMAFhg1l2QZ0yw7XzRmnDAgnnxpSb5g6t6gy2peHLhr1XiSt0LHJLB8w1Yuc2H7N
         zjH5CxKKbnpaasza3UMBu79cgEG+F75v/vX9wt2wqN+C9DiF56/ggWBs/p9gy6492P8v
         o6mLd4yNNzya0LisMk65d4/715FJ2j3zz+Q+kcRjCUVwGeJJrOQwRgae3y8rR8rqHrLX
         nsScdFNvianyFoHFFDCXlXNg/4GySBZo8cjutEuOYw9xy6kbeVTujlUc9R6A/iY0v0UT
         RSvw==
X-Gm-Message-State: AFuF++mY26p66Zhfylepqmwfixg0qlxsi96XaYpOKapx6s42Fqxwdie9
	+TYl2EoRbi9dHAiZbXYw53IoZvDijyolQFQ/P+klyehotNhBTcd9hM+rqWqt4iyc
X-Gm-Gg: AYBFou1oOi5ZKJzfmtbBru9ln5YZ8wjeRWX9ADkcJi3kg0nh9D1topd+Wj8MhxOvYbQ
	lTzYKv86vy+8UoIvjre0g249er/60OGgqPl8WtAzsygy2SKg9sXoXQ3TpYrdwBR0auknENb14dL
	9F+iJ7PmDhrJBjTBVGDAE+BuaNW0+SGECefrJ+Pwkx+3cbAmfnazylW5dL+hL65JJQO0oMUKi84
	2Z2tbQvrtwJqbKnGk2YUQmNAfDxxLv6+xMyuf/uUkjMSl9gUWWHBXYJt/Vsi6exMc5FaBDmfr7D
	/daxWniJ2+31nMN9+uQihtTArR0EYW2DIpdwaTFIGk6HE94v5EPLftwv6KtsLR8rUUCnwsO1V1T
	2cpozQUL4XlQsXI6iEwwg86fU3etGi3TtTT1PnIPA4gNDBDXHBlHqeUEgd6+U1siGQ02+u8xG5h
	DiWSa5FCtk8nOr/QLG4Vw41WPqSrKGcCRsvfccbAbFzaevjer5GHmgJEBD1cCcOKYgCVQ9VRbU+
	us7IA==
X-Received: by 2002:a05:6820:4c0e:b0:6c1:e01b:3b32 with SMTP id 006d021491bc7-6ca9c252385mr5212530eaf.33.1789831984490;
        Sat, 19 Sep 2026 08:33:04 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.38.48])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48821db6ea2sm2196370fac.18.2026.09.19.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 08:33:03 -0700 (PDT)
Message-ID: <6aaeab2f.1290c124.f9130.9e7b@mx.google.com>
Date: Sat, 19 Sep 2026 08:33:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1589290745037060611=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: MGMT: fix mesh_tx leak on hci_cmd_sync_queue() failure
In-Reply-To: <20260919115436.3998954-1-benquike@gmail.com>
References: <20260919115436.3998954-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1589290745037060611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169247/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      28.95 seconds
CheckAllWarning               PASS      32.94 seconds
CheckSparse                   PASS      35.66 seconds
BuildKernel32                 PASS      29.20 seconds
CheckKernelLLVM               PASS      33.21 seconds
TestRunnerSetup               PASS      782.58 seconds
TestRunner_mgmt-tester        FAIL      61.32 seconds
TestRunner_mesh-tester        FAIL      7.82 seconds
IncrementalBuild              PASS      29.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: fix mesh_tx leak on hci_cmd_sync_queue() failure

6: B3 Line contains hard tab characters (\t): "	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);"
7: B3 Line contains hard tab characters (\t): "	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);"
9: B3 Line contains hard tab characters (\t): "	if (!mesh_tx)"
10: B3 Line contains hard tab characters (\t): "		err = -ENOMEM;"
11: B3 Line contains hard tab characters (\t): "	else if (!sending)"
12: B3 Line contains hard tab characters (\t): "		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,"
13: B3 Line contains hard tab characters (\t): "					 mesh_send_start_complete);"
19: B3 Line contains hard tab characters (\t): "	if (mesh_tx) {"
20: B3 Line contains hard tab characters (\t): "		if (sending)"
21: B3 Line contains hard tab characters (\t): "			mgmt_mesh_remove(mesh_tx);"
22: B3 Line contains hard tab characters (\t): "	}"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.022 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.403 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/798

---
Regards,
Linux Bluetooth


--===============1589290745037060611==--
