Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109721772A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670483; cv=none; b=poWLS+nPmFOj7zbUPjcHKjT1QIlJfM2PlfCzYf6yCEATHiYkCNmCsa+R3U6LaVAiU8UHgmRGecaOQAjLRRrhUSnLQ6WF3VkBr5/A4Aic5OT8sJstYWMCex+ZuKbupFQGLHThyQHzgCk0AZlG99Un10adTj2u6OX9nEr0i7VY+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670483; c=relaxed/simple;
	bh=S2mGqeELHPz2+YyiyuPEyvzW1THfbU1vcxRn8KDCIQ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=INOCJkJe1UWrCAk5Q8rffbCPrpKXM8TJv2DO1GnfmrsGjbBPaQPO49LiYoq5SX72dYZR6ZAMcU4LMv11d8DWFl2z2OWTwC8x/s/Tu8FwBlL3DGTw6d9QJITh4VJen74ATGHJKSt8cFqUodIdWA0l0FwZe8XITnvrce+97tTC200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYWf+hEa; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYWf+hEa"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d67f1877so7594265ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767670481; x=1768275281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B03FcDqvTlRb6bCN3FZRbINITjsmZ+lyK5u3i4ODppc=;
        b=jYWf+hEaD9R9WPCs34tSPOvBnsMX5t1wO2QbqcuA6ooya5KeYYWg+0gh6Z66VwQHnQ
         fKUBO7nFp2MpXIgBlj1xQxOgpIpoeGdYaTr2wQpWe5rxzskOGvBw69FFur6RCmzvn5LM
         rxKQZzU/7HlN9g15Kf5mzq+nGYR2r9/81aLnJOd4zjRz9oHCsMBdrv746SX6tjcsJ5iy
         NyQUPV1Oob40Eh6zQub4O11rmoe7Ab/Vo0b4JTjn9miN/nYzSElNBL2Ft48Ya4reLYzt
         iB8k4PCyzKjs9BykLuSMpOUlWxoisNnFXDL+r84BZ7TbZnO3VAWjl6cBDEdleTHM0qCd
         qcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670481; x=1768275281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B03FcDqvTlRb6bCN3FZRbINITjsmZ+lyK5u3i4ODppc=;
        b=Dr/js6Q0h6LiojpPJ/N1Q5fGTCaR/lPP20k0Wcpul4hb4mjtdPLw4zeAiIm7g4FB3J
         Chhpv4fqRPb7ILAo1YaHsx62kHZ/FMuIv/usEtSevw1sI5CoJlD8nLz53Sxj5Vw1NuYx
         +kHRixb9HMiH1vCrwQ92f0GjX+P6gMm/hkn72ylTKh1uvB+myilBostYezqmVCOm+GpA
         X44x4RDsNdwfYTj6hTc1JaclAfXixgwOBAUjl6kyody6w/5MBVAT9UdAjYwK2gzcL7Ej
         to2tObyitytx93HCbrzBgFTjLqIVAD5He4PudzArlOgxSNBf9oIeyDmE0aq5jM4TTzh6
         sAAQ==
X-Gm-Message-State: AOJu0YxBYkdNgoX7VEdrQH0wGTfWdJ6eyKrES7FMMaulR5502FcgJVDK
	UrzxlAfUCxh539FSXta0mPw5TO9iybFIMse1mSTbj0Je6E1UUqDtH0vgtGlgCLH7
X-Gm-Gg: AY/fxX5BLD4Izoho1RP1ACWg4FsQBYw1omrxE9OHieDWUEwrWUjZBk1eiPC3QmfxsfA
	BBBJQ8HlXHZ8QdfHNUEQ2n2pTnQD1BZypBONJ1cyqL6Uq9vXhsg+v2xofm2dObWT526Mjfk+vdP
	8vyEV7ljAE7kKbusE+Pa4j6X3x+sIKQsgsN/ZepoVgpPa2DMzWoEh6oi8FeXHj+8JMwub6AOQyU
	Zrax6Qs4Fk4xUCiHL2myNXSL5VeNW2s07eFEk36vzbmKTUdjAIgGO0+VApm3FCl1PQOsQZHafLf
	ugM9mnwKKhzpS4XmpyUNhGLyU//l9+ujNMcL4jPatrQiao4curlQ+wOeWB6uJrJKzD7bZfjjxDC
	ttzUzpbJsmgRjQxtucX70pVdwhU+z0dr87QaqVWiEF3nX+0MOwE22Fob9MMUKqj8SYQv19K854W
	IjNicDQo6e/qllIe4PPA==
X-Google-Smtp-Source: AGHT+IHLlF0AULo3MCz5BOzxIcouURoftPl21AspQUP2v3WEjttAj3wXkdKomdp/95C85oeDm2b5Gw==
X-Received: by 2002:a05:7022:996:b0:119:e569:f268 with SMTP id a92af1059eb24-121f18a338fmr1535334c88.17.1767670480582;
        Mon, 05 Jan 2026 19:34:40 -0800 (PST)
Received: from [172.17.0.2] ([52.190.182.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078d818sm1421679eec.21.2026.01.05.19.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:34:40 -0800 (PST)
Message-ID: <695c82d0.050a0220.ae987.ce88@mx.google.com>
Date: Mon, 05 Jan 2026 19:34:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8762778387649255794=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: move WCN7850 WA
In-Reply-To: <20260106020738.466321-2-shuai.zhang@oss.qualcomm.com>
References: <20260106020738.466321-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8762778387649255794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038759

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.57 seconds
CheckAllWarning               PASS      27.41 seconds
CheckSparse                   PASS      30.73 seconds
BuildKernel32                 PASS      24.61 seconds
TestRunnerSetup               PASS      547.51 seconds
TestRunner_l2cap-tester       PASS      28.42 seconds
TestRunner_iso-tester         PASS      75.35 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      113.08 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.56 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.153 seconds
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
Mesh - Send cancel - 1                               Timed out    1.915 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8762778387649255794==--
