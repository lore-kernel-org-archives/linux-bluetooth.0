Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C11248F73
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186319; cv=none; b=UxIukAqXavCTVRgLVytNZpmJd+NXWFAvx0LWM5gc3YSLw805IU9LL2nib68ws3RtwOmfRuVYsXkevtX6NS7TbPq3ZypOt+w0jwE5bwCcz4mmq8CgF1zhy3pES7nlhIm0ADHSaGyFCvkqIIMnZJEnMS/fbao+0HrW6iB/9DDuMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186319; c=relaxed/simple;
	bh=DLAv6ADQuMn8qjeDNN8Es6W2prg3h0ktdxZPVhgYngk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JV8rf5201pJ0xKEns2yCFrugFL14998jMAsKnE3W5SzX4MCklR/rJ+/uJAM+/ex7hqcRiNC9a5Pi4Fbljbyc0/f9kbikYwPIn83S2a276muUug/tSjxPCxfL+aFgdG0+Tiz9PeCvyvNduUfZeBEvGDQJ9aX4YfYjMgCAJ9d2X9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf+zB21G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf+zB21G"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50934b8ab60so4389871cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773186316; x=1773791116; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yMcqNXfbRKfZijEjA8KI7SjgWdNOgXPWuSv6ZuQYcqM=;
        b=Bf+zB21GcHsDdim0ii4RHVylP5ipfEQn+5lIm/KLLCXwQu4NHUzosWWenSi2hvVrMY
         O/XSML+/HNaYLLjSgu2rZcNkgbuymDz3mO0ffNPhP1Y7zJOkM/NGF40zgVuFYWCep8Fx
         0Dj8lzvCOERHuVbnE7ea0FB5tPYfOun5cTdNdXWcUXmeUDs8WXvDcSTtOl8uZMyXC6ik
         MygSyjjnOn8M2gRWP9EaGdR7mUM4UfzIfHvlN6eENuAVKl+XbHQne1zJ/ishKnQErmTA
         ESQ1kKZlSWpGVKLa+kWiCbPvQeDYC/lEIGwjDa7Ac9hv2227GnhVcNQTxJutjIjcum14
         sxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186316; x=1773791116;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMcqNXfbRKfZijEjA8KI7SjgWdNOgXPWuSv6ZuQYcqM=;
        b=G6gASvi5/v2kZMih8W9ijsgkCSD2InDUvrGnMDyeNS92cHoSIQBfeZzLhhgi/81tTV
         +hKufIXHBwi+VPXZoMOzSBbJP9B1wRn/8pPLdKBJYLB6gXk8SNhstvk7tIjNq8UZlrw5
         pT7eM160VyxaJGHNhOyOMdt4BODnbaf6BCbv/H05k5Dbrg5jg0thbbENfbTNIvh7gLIC
         REFKvt25SxvqElguZ9+M20fC8DYY4Om6rzj5kzzM4WfLBmSAwWEb/JlAJIwwpB/tLRsY
         tonb4rmR5YeEhPl/6kN6bvuxrBUh+T8abCaOXI0m4rb70vMOxsmc8jN9IuletEkw+IwD
         J0hA==
X-Gm-Message-State: AOJu0Yx9d8tkw3ADF2iS3NhBYe66wzgWPZYUfPY5TghxhrIuu3sGor6L
	mTEtAYTDa2R9AFSb/E0iqa+5aFpKfBXpDN0GxkRMuY4YArd9oPAfqIjKUcOyEg==
X-Gm-Gg: ATEYQzy0dbeRcfcRJcDZN3QQHHDo63YFzbTpire4OEBSIcLWHBq6gs697ZRuehV/+am
	agsRN+6XvOjiMkkfPAGqpr/8fDYrcw3u5e3M3DsbHu4KIZjSNR9Iv9ACFCNJl8jiD1FDtznpFex
	abl9qfdv2oVlWKVa6VzhOvI8xXTB/KjZDX6gQ1J35BJzrgp1pqD8N5F99OkhEyA+ByqFmh6i/Oe
	J1GtYxk7tDY7NA0Us/+tpxCV4BQjxBR9SN5XKxra5NKMigXjnXJt465LUYA6h5oR1jFuV6VN7XM
	OJrJJ0KaUPuhJUg6q8DOEhWie5gogBdLRTBXjVjKKi3aPTr4N3AyVHxHMfRZmxgcKdS32Jt86mE
	FQxLjwE1QJvtgjK6M/ecPTwfyGPEO/zjVWTJdTUEtWtfo4EPYrYQLbcU8/OBhknAPKE+EJgclHF
	5K2NJCHwjZa2Dt64N4iEXyu4ggEd0=
X-Received: by 2002:a05:622a:253:b0:509:1f53:f557 with SMTP id d75a77b69052e-5093a119618mr7027531cf.21.1773186316445;
        Tue, 10 Mar 2026 16:45:16 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.158.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec6697sm2780491cf.9.2026.03.10.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:45:16 -0700 (PDT)
Message-ID: <69b0ad0c.c80a0220.3a09a5.cf42@mx.google.com>
Date: Tue, 10 Mar 2026 16:45:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8163616557255740128=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: Bluetooth: extend WCN driver to support WCN399x device
In-Reply-To: <20260311-wcn3990-pwrctl-v4-1-70e571a18e40@oss.qualcomm.com>
References: <20260311-wcn3990-pwrctl-v4-1-70e571a18e40@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8163616557255740128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064679

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      26.30 seconds
CheckAllWarning               PASS      28.60 seconds
CheckSparse                   WARNING   32.74 seconds
BuildKernel32                 PASS      25.45 seconds
TestRunnerSetup               PASS      561.20 seconds
TestRunner_l2cap-tester       PASS      29.11 seconds
TestRunner_iso-tester         PASS      64.34 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      125.41 seconds
TestRunner_rfcomm-tester      PASS      9.75 seconds
TestRunner_sco-tester         FAIL      14.66 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.99 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PENDING   0.53 seconds

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
drivers/bluetooth/btqca.c:1045:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1046:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1047:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1047:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.569 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8163616557255740128==--
