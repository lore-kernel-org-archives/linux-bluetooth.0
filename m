Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA12F9D85
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104905; cv=none; b=X4YtVhVulrktWBknJekuR7mNfGvdNcfHP6FmsHWl7U53m7rKzK2ncNGv13z4ArZmtbBGSwLD2RVzfz5E2Up0XhRUvq1ApSNdxd+wrPYIPPUNxZdX1ndYcmbTyManh3UdIssssgCeRZMAGn2RK2ezpJLQTjkCg6iDqSWWQJi8iUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104905; c=relaxed/simple;
	bh=1smj+EGr9xAf5KRZRDvEIIo9/DZK4/J8fIbtnE/Qrs0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m+5/08WuvYRbaKBWDGS7z81I5Yh++h7BVjjWOPJuHjXorQKvECfUOuqJ7LOGjV9qGcjk6E88IWRdzILEMSyBhcDlCzwhbh49liloqXgHwDvnC1akHFmevcNL23BEGGV8GC5bRJrC7RH8xuiLnyy1WvvdZvOrtKuqtOraqZeL3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjwsva0Q; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjwsva0Q"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6d76b9145so571572685a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 23:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770104903; x=1770709703; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HXgZMayi8ir9z7BY5gwU9GZayROrulRsk2hPsWp8+bk=;
        b=Xjwsva0QpUmd2t5b6wyuTuHDgxEAUt6j4YlsbPQL4wGQT3RogHMDnXarNAQgWk5Gmf
         ri1PjtJvmaIdhKOjM6Tke7y3zGYbFixTjCeBdr1fXYWTzWS9i/VNWj7WRGwyyIasTx3t
         volxsL10x6aDakwcxlPDHUM0jB+szVhf4C8yAwn++YjrLP//j//SrfNDcg63Cqq9yI85
         fWy604vW4xr6QmKpY49LHHc1Ybnuqt5kFruq9oJ9JJDtd6kyQK6Lq7Vl7nNGDsR6cBT+
         DzS9tS5TYlqy2gjgTPR4o4azx406p+hpy70DxkMrBtb5weby+SpjeQIjbqTmkRd6j0U3
         Gl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770104903; x=1770709703;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXgZMayi8ir9z7BY5gwU9GZayROrulRsk2hPsWp8+bk=;
        b=BpIoPGNYk7/2os44yLLckkVx7Hx/uZvhHEhkdtt4N1fIUBCxHPvjqoe3dTX4DIsPHj
         sh0BpaKOCBJEI2ocqK0L3uD8SlNTUafyCJEBsR+a6zJD9fDEvgVg0DHHmCiSBKry0oa1
         DiacT+cgWF0UtzEefzxHgum8C05b/A66cRapCJesHAQGAn5XOEYe5Jm3sx8oohwcEk6t
         fNRzGpUy90l8KCL5WrzwZtKPuffG3i9AK4Zx5bq/WPqFlsqub9h/v+GqtdXvHS5Iuhv+
         D5IH8eJc1ueFSUMci1mNRzb5PcJQ4IYBSV3L43DUqd5+7YPLjzDkTYAF3G4Cmy+d113Y
         IrKw==
X-Gm-Message-State: AOJu0YzunOwvjqx6W8UeBuL86TKjWeZge6VAITfuN6k8g3Kwbp2bgirj
	Vh9hOGWYNyfQ1P0YROBLlPBUS65eAy7pDvb/21d26/48F/lKzUm0QDgs9G80pVIn
X-Gm-Gg: AZuq6aJM4+IXyB75/xNqSejBfQiH2gbempHScfgNDcSdOBiC2LbnQ+NYt1W6td8j6ZH
	0ioAUlDZJa0MkJ6oKwpetiS2h72CGrGn/80SWDPxEE1K21rRveUrZi8j5i54wNYjgLDLDVJQrbc
	mIDnBassvae14RakMCDBHP3K0w3Rjvep3y83XUhRb1GQQqGt/nU8xolrlfmWjWhK8Nlewa1btes
	jzeH/NYnFAynr98Y5jcnNuIO/R38ugcnoQz/5+D0lpuDs5XUrMnjb4Lne0eeY2MqpmIzi/rxMhs
	Y/KI+uv/JDa7kr7LFuGHfl5TekJLtoxU9GH5DKJW4DSWXqt0QLDkgN5vuOYOWnDeN5cdUbifKkV
	WzuDK8mBYexeB5FQLwOJN8TSGU5PCtsHcexYaEqDDT3mjWPcPKoINt1o+omP2WaaIu16KpPJPsB
	XefuQFEa2ZD2ST9sLWWrlFhNh1
X-Received: by 2002:a05:620a:6c0d:b0:8c3:598a:2956 with SMTP id af79cd13be357-8c9eb28ff2cmr1634822285a.33.1770104903008;
        Mon, 02 Feb 2026 23:48:23 -0800 (PST)
Received: from [172.17.0.2] ([20.49.61.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b29f796sm1310409885a.22.2026.02.02.23.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 23:48:22 -0800 (PST)
Message-ID: <6981a846.050a0220.67bcc.f4b3@mx.google.com>
Date: Mon, 02 Feb 2026 23:48:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7038635774458379781=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jindongyang@kylinos.cn
Subject: RE: Bluetooth: btbcm: remove done label in btbcm_patchram
In-Reply-To: <20260203071048.1624461-1-jindongyang@kylinos.cn>
References: <20260203071048.1624461-1-jindongyang@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7038635774458379781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1050120

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.18 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   WARNING   31.90 seconds
BuildKernel32                 PASS      25.75 seconds
TestRunnerSetup               PASS      565.49 seconds
TestRunner_l2cap-tester       PASS      28.76 seconds
TestRunner_iso-tester         PASS      82.46 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      115.56 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.58 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      12.41 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.49 seconds

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
drivers/bluetooth/btbcm.c:778:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:779:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:780:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:781:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:781:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
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
Mesh - Send cancel - 1                               Timed out    2.653 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7038635774458379781==--
