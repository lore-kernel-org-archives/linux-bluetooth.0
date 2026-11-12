Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490239;
	b=1zu6GL1pUcDZakMBjkBzHG89ejFMlEIcTYLwJZZM2bVVTEJUNbdbBZaXJkTmZBP57FWw
	 WdVavbPjNJVgGeg02sL775RRe/RlwDtIeY/gBSEx8++2wbBJg4xFmWUlPtvQAy5KpwP76
	 EVBvHjFe5ViTXNzCfC3b9984ZlOdPh/4I1dtGCrCjTAwIfw1bi5N0AadUi/0waWqIZCVS
	 k4NiWWaL0VovKFr1pK9RRXC4Pd61smbkKG30pHAVq/HADXA7RPGeRcoAgQT+ja2DLkcrx
	 GP5p7RQoPwQrkDUdEXZ0mGFFdVPF8m5Ejnvyu1/C47JolJM0B6LSq52jOcyZ2j6FPEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=QTeOi366sTDytBNJJMmMcVJOT1m+8ljxignN4vUO+Ng=;
	b=XHiOcN1pROu6s5iyswMe9EATgNa5WhBq/PY+LU6x5bl/Vv8UUpYiktej+5qAQ2OYGZaW
	 gSN7kpXlDBxcB1BLGo0CnQj+Kcct34nvemKG7Tk8OLCBplrFd/akEdKnOvfbsks3Medom
	 mredwgQ7nlX64FkvHZU6hWmlmHeN3x1RUI8l8ajWwvZkRKGXDLUTckDqGwo6WjrW6u/4h
	 yyiUL41D/RzoSsm6ehvDYj/1xATWH2UdsKqvYDgzRhHV0y3488I4QQp8y36cP+/0uFSYc
	 PEJBiXhKxN8vD82MkpT0Xpuntbi4sqarDkmenvpQWVF3Hfxnb1SJgk95WX9cbNO8w/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIJ9QsMV;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DA606A335
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 13:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7DA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIJ9QsMV
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b2382bf051so2468708b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 05:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490238; x=1795095038; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QTeOi366sTDytBNJJMmMcVJOT1m+8ljxignN4vUO+Ng=;
        b=mIJ9QsMV4PGLOUT1gg1A9Vjbq3VuwCCcsFVh+XCa4RvGROsL/P2llLyOxicsj5VAj+
         e3+vOgi0WIEuRE5YNYoy42ggiwwwzOl5RuIWGVvD+sD1V1Ae9qvyblRcdBk6JYuCl4MA
         tXHHY95zPEMFjYJTK86kqwbJ0+JS5POidFI+Ip1heJfo9KKmu2fYPAZsA8ZEu7fw3geu
         gR6VjIddnh4vOWs9eH4Zk1XVHqbWUuIDkOz2EiuQp0GtXYhMdg8nk1opavOSvsONLlfj
         hrwe5IGn2gGGYNLAK1BRpVEMV9+YWjE7RXk93yU39NYgg+fW6NvMY4pJabnkxrSBFk/Q
         hgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490238; x=1795095038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QTeOi366sTDytBNJJMmMcVJOT1m+8ljxignN4vUO+Ng=;
        b=AXifOUCkA+I7frLcJzpPLQ79bkeUqdw0VD9j1LNiepDASbz3Bg6R56UT4XSe79m/IX
         mauy8AhwzUkaD6E1je2OUnVXpkiYuSHyAUMJijFfpWt30j3lx/Qla0hWAHEhKmjAONlK
         y5oP28G2G5Lan+UxbGHYbuvEBbmjY22qcsu6DkTJE4c0RegP7MsJwX4Kt1/OC+sp1Sg9
         RIdRMHSFl39TiZtwilTmAXft4Nrdggm45o8SoiASs8R9Qw1J5WjH2FIc8JF2k8/Kkje2
         tDF0CiAP+6giYuhGkpIz5sY4RwvbOe0sOhePv7V4kd5jqT9m6GmhjvZ7b3bMFGSqYP+t
         wpSw==
X-Gm-Message-State: APuU4Z+Dr/N6TtL2TS4Q4F4jAVL6zYO5EylkJuI1v2yh2kv5pIFzepfq
	vzEl/3Ekvd+JiLXUVLWGyTmNMGGabyPKxwdMcCEu/Lk0vhgr3K92ReGpeQKKNw==
X-Gm-Gg: AYBFou1J92JO6SE3wF6C9PvkzLIH4NBUcv1Dt86MEdwloax0Y0Ock969fJ5LxoaAj/a
	A/uR13VVKJS0pSLdnJ8AYGuOQ7Wy3zm1D8VYTkipr6Or+SQTLFOuiAhhW7Kj/g0nHaEXIlAi07n
	AEqrCblQagAS18B041GC1G8CsrI+gz95FjuPJV1XTl3bZ/GW2CBjoM0/AIW/zQU8l/+o+9BI4pP
	qx4ZEXP3WBa/tC7s862UN4cBjQ4gXRtl0zOaeKb01AEY/69C/i6CCUf93+Bx53dBWIYjR4+nIUr
	6MmI59WPc/h6EJLGJ5xDCuw6SmnrfJpdeMO8J6HayuEtqOwuQslORc4FHh0wLO/4CTeQ00jKdQ4
	18y759PyTDAnRyeoTcF52vp/DOHSrxQBceeYHbvL8c4+br9tVniBX1uUu922lHeUrxuD1l7nA62
	IBMLntov3i/xPjdug87QIVRUt08lirma0j4fClp+Y1gszG7GLRdaFDQK6AlJxUAQ5oClswan5hx
	Qafh43c4s99VR4tIaCOlrry2KxWtx6sMX+Z6Po6SsJRSXKKXu51i6vymoik7g==
X-Received: by 2002:a05:6a00:1817:b0:87d:e8a0:2389 with SMTP id d2e1a72fcca58-8bc1ca75a43mr4926990b3a.21.1794490238128;
        Thu, 12 Nov 2026 05:30:38 -0800 (PST)
Received: from [172.17.0.2] ([20.9.244.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3583057b3a.5.2026.11.12.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:30:37 -0800 (PST)
Message-ID: <6af5bf7d.0a72d11d.124ff9.43ed@mx.google.com>
Date: Thu, 12 Nov 2026 05:30:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0721193615045238961=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bence.csokas@arm.com
Subject: RE: Add struct_offsetofend() for pointer arithmetic
In-Reply-To: <20261112-offsetof-v2-1-276ede839967@arm.com>
References: <20261112-offsetof-v2-1-276ede839967@arm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0721193615045238961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209363/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.25 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      24.17 seconds
CheckAllWarning               PASS      27.55 seconds
CheckSparse                   PASS      29.68 seconds
BuildKernel32                 PASS      23.76 seconds
CheckKernelLLVM               PASS      24.25 seconds
TestRunnerSetup               PASS      551.50 seconds
TestRunner_l2cap-tester       PASS      13.10 seconds
TestRunner_iso-tester         PASS      11.49 seconds
TestRunner_bnep-tester        PASS      2.87 seconds
TestRunner_mgmt-tester        PASS      83.78 seconds
TestRunner_rfcomm-tester      PASS      4.07 seconds
TestRunner_sco-tester         PASS      5.11 seconds
TestRunner_ioctl-tester       PASS      4.27 seconds
TestRunner_mesh-tester        PASS      5.22 seconds
TestRunner_smp-tester         PASS      4.01 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.09 seconds
IncrementalBuild              PASS      23.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/2] treewide: Use struct_offset()
WARNING: line length of 111 exceeds 100 columns
#430: FILE: drivers/gpu/drm/drm_edid.c:3254:
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);

total: 0 errors, 1 warnings, 437 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14975821.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1121

---
Regards,
Linux Bluetooth


--===============0721193615045238961==--
