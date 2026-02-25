Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE633B8D7A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025186; cv=none; b=AgidIXVhdP57FQ06VqiDagC74dzh9tsGI2x+vYo+E17rkxCW7NETinKMJ6aQOaYRhTncL6ERT8i4VNQm3x6v+eQfXMwMLieyZ26WXXQI54QTfUpD7S3k2FBtw4w4kjFb6znKoxfKeVl2TuRjKFVA852vwelo3Tj3dTcPyn6UhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025186; c=relaxed/simple;
	bh=XH0BxoGuU26bwdltIy1aH6zOtt6rQZI1/5Q0ZPwO6I8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZKhxUazTL+4HyPzj2qaoL4pYP8fZthbrsS8uXpyd5KS0dLulbP8FrumA/UZ3u4p/g0iENRT9q5vwb4nQsLwmSUTWEi5jD9vp/lvPdWko32earNHWcqJVuvfa78SdUX+h1wSEVmeJZypRtIL41LN/hxZQWqpj4vkSGYkz1VBwZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWfNEabV; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWfNEabV"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb40030be5so682412985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772025183; x=1772629983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rct55A1gkgbZKfeLCIJmGKi3Ntre+pNp+P4nER6D7Ng=;
        b=LWfNEabVch3fB8M2WiAh9drSUir+pGfZ1WS0IKI+cTiwlnGyGM5dAZzkw19cMntTV6
         x829i+hAleZU919tWRGyQv954LpxbdtzNQGlDi+FAnpMGwtfHcbpgI2J5XxaIz9a8Pw+
         qpXWRXf7r5VxNwBjfIVwaRiqvW4KMUraPx39YuXTu8qTQtaqQRX70KKBbtbZQY070hec
         RVAFJ4qrSbGBzFAkYpTMcqcKp3Lvm7aRwcHvG6WTQRQCxVDL7UaQO/+xZT9+smwdSNG6
         E+RXC8iLSlNFo73zJxC2+COYUyfUwhQ9REnH/lYJFnfFNPMwF+NCXT9/fGNifwPQRrT+
         w/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025183; x=1772629983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rct55A1gkgbZKfeLCIJmGKi3Ntre+pNp+P4nER6D7Ng=;
        b=VQL0XY7ugX5DAvAsdozxxrwIbxHwe/bugd1Ky1IsvDJz5WzNl6yZl8OntFUWK6RzEG
         PpwyaNAAaahoOn59DF31tjc7vhL5CqX8j/+sMbGezCfjVPcyoOC8kOuMry/Hc/m+R4I1
         QGT+yEBLm9A7NmdbLECaL2Sd9JApneR/yBYF0pucsPKnylQd3XrwQ73PPIXHb/GHaJ8C
         eG023t913ta2xE+DcZ0vjHncfChpB+SooGBuCN7Wy3MLBMggFjKxqnjCapYLMz4I0bV0
         dNSoYMTKVkHow/IsUJ8sdvvLm+cktHd77pGVqN+T2s+AWRMAiOiRSHjTOpKaZWjecfKK
         yeEQ==
X-Gm-Message-State: AOJu0YzXxDGc1L64E//z8CRSIGAfdTPe4dn9MoR03H1PJqx088Tkg8ZI
	3/pDZr+DsWScEQAB5nJkqmti7s/sAnBDHKOqnehmL51cupHa0geAtfbd7caIGoQt
X-Gm-Gg: ATEYQzwfEa/WHrv3zzM3DAPX3nDnoM0szGaytrsgN9cTdT39V/86IdioyzCm/pUYBKq
	0XjCSu4+uPysT/Qxqw5DsXH4SGmBegNvql73WLA9CB4peZSsX9FSse4qkzkYgOKpEZyp+liLJu6
	yPPnY1KyDWo95LsEozBq1KwewUw6PvgPJmI3l0Stdnm1KeD+V32qt4w75HBIciAFor2cT/Ot6Md
	zZROz7Elm8VQTcK87z/WBZMF94QO40XkiYFjy9V5MLWQ/wpNUGDWGWdp1b9hZFS/ydG5gJoPA/d
	E45EZNRTqJ3Vf0vKcuVr+t1zSc2HiRG6ryhnAZ0n11UNCWwu819k5t1z+BQL5j5cJuH9YZi5C7a
	EVKIXBbKnRAaV6iJ2uqBCVagDlViZwPc8NcUNsiWbrDMikMsCEDk8ykDn3cZDZqTHtr3Hc7VMey
	yo0gWBHnRFFsBhFCHc0b/eb4/ghmxB
X-Received: by 2002:a05:620a:2844:b0:8c9:e8e9:9bf5 with SMTP id af79cd13be357-8cb8ca6e6efmr2037008885a.53.1772025183337;
        Wed, 25 Feb 2026 05:13:03 -0800 (PST)
Received: from [172.17.0.2] ([52.162.137.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d103084sm1540197285a.33.2026.02.25.05.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:13:02 -0800 (PST)
Message-ID: <699ef55e.050a0220.3a12b7.9478@mx.google.com>
Date: Wed, 25 Feb 2026 05:13:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0476629635945330785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, konradybcio@kernel.org
Subject: RE: Fix up WCN6855 RFA power supply name
In-Reply-To: <20260225-topic-wcn6855_pmu_dtbdings-v3-1-576ec5c4e631@oss.qualcomm.com>
References: <20260225-topic-wcn6855_pmu_dtbdings-v3-1-576ec5c4e631@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0476629635945330785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057767

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      1.18 seconds
BuildKernel                   PASS      26.17 seconds
CheckAllWarning               PASS      28.53 seconds
CheckSparse                   PASS      32.83 seconds
BuildKernel32                 PASS      25.67 seconds
TestRunnerSetup               PASS      564.38 seconds
TestRunner_l2cap-tester       PASS      28.64 seconds
TestRunner_iso-tester         PASS      84.97 seconds
TestRunner_bnep-tester        PASS      6.60 seconds
TestRunner_mgmt-tester        FAIL      115.33 seconds
TestRunner_rfcomm-tester      PASS      9.69 seconds
TestRunner_sco-tester         FAIL      14.88 seconds
TestRunner_ioctl-tester       PASS      10.50 seconds
TestRunner_mesh-tester        FAIL      12.56 seconds
TestRunner_smp-tester         PASS      8.93 seconds
TestRunner_userchan-tester    PASS      7.06 seconds
IncrementalBuild              PENDING   1.09 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.603 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0476629635945330785==--
