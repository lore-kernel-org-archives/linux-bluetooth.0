Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07430D418
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958330; cv=none; b=o2XU7rMNxZRlWl6GdKBBTpq3i0LcJVqlg/6HmhyV/DLNQaszKiit6oguzqW3FXZg1SPcVMoASuN3Jj0S1Nbxf+yUbcVZ8eHFlv6s22c6RC+KBzq+4cUPhNnGtap4YrDO57nF6cQXlmHCDLqVtF1iDmqj9lszqlJBC7XSibM50v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958330; c=relaxed/simple;
	bh=5PfEoLJyNGgpLuXqrjtmd817FtLTbrZ1/4kix6B06Cc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NdSrawpOt0SPYg9F8Tol0Bq5seiAySmPE4C+ctqlI3/zGIPDscGWquglb8fIYN3Mg36PbP8O65va3EiOcks9661GzD+R1Vpyhg2uc7rpm8osgmrj9e76XQ6tTT2QfvDYZD2im3Z1cLjiWyMOZYHBDR/aBpnr9VdfFEOZn6o0fIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwnmqVuu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwnmqVuu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfbe05683so24411321cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783958327; x=1784563127; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LyZL3B5auLMvOS5lpk8q4leO2rAm6SzY6aTbuBpeUNI=;
        b=UwnmqVuukx9p0Tni9A/Z6clKL7Yl5K7T16Pfu3CyHFiyTC0IK62Bo9SOuLPiZph/XN
         Hvn7UWnhQ+lz9SB8f2UU+A/n4PJbLbM505RJ7s6C2N0pzE11SW6T1d9Cw0r5Y5i8JrDZ
         mEtZqRd5dAZY7VeEOuJG+q1ShqDrDJPGcnPVKTxWws3kdA9WuIPFgjM2Ea3NL2g0X6tu
         ExawhJBx/kjVJ+i45VXOpV1zfMMwxaftlsjtOHqYseW8d56lOLTVG9hm+CWWgNCoGxmA
         Hcj83Sex7fxp8ZKVMvxuffWyDnoBiikuXuk1GrNSP8POg6xlD9DPwCTGYP84uHYvNfge
         eF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958327; x=1784563127;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LyZL3B5auLMvOS5lpk8q4leO2rAm6SzY6aTbuBpeUNI=;
        b=jw7Xk306P91DbKKnuiyYmFzw+43Tf9s4oYKj9qFx8vaAIKeQOP9W4soWjX3YzrCDG8
         7DeH5QA2Yvv+by78P37cWT7qKW1qr6MswAIvD8c4IrEsa434t2xAD1rk+LTJQlixFyD2
         eMLUzHYbZU+QP3IZRrMwB2VuFSyrFDnN6u+9IvIWx0N/kxI6VKQMIF8hn+auOQtM6vw0
         sT5h3BMJAfH70jJx7FR6fg6wZq2j4zjxrBX/sQPDojOiH5SRya+mwjGVhSFfMoCdQoj1
         u/nDF+rC+eszbs8jjFyr449fzrfgNd4mrZoPe6wlqn2oSo2OtLVRLHq1jVA5paeRCsRQ
         wQyg==
X-Gm-Message-State: AOJu0Yw3VFL0cC94hlTcaHHUQ5eakHc6DuuW5d59jz4BBfAmkdnsz9B0
	ggehQdjC6LJ7LkjN0AZmdEXdrIqv5PSGCVSQmXLzRdRarysKkNn6uxykjByhKw==
X-Gm-Gg: AfdE7ckV8I1v8R+RNz90M1IVLGi+sRAyWti8LkMyv0cpNTWeAyYmSLNZHtDZ0Am7fes
	3nWKw5Mz4SW9Wf1z1B+7YC61izUr/s6+CWIx3X2sCu1H7TAhELV9W1ciZzysqBGqFOWDJNiQime
	dx50rVqhpxn0IqNgK4Q5y8bLXijxJjdRGiiRBQ4rgpnsPVB3yL0h8DexVd0W9KpxyGkIz7glLB3
	5GbOG3n7RXssp8YMJk54PjSHVr3mkH9qsar9Z3/UqKIzOzIpJtk5T2OUpGUhFb/bvihp6rAWtB+
	3ii5fTTYMfDSmLvk3PyC3+kcDFqcxusVYmKzPgcxKOJ6Idkhp0NxBxFeGa4YbT8N+twUWjTWnb1
	/Ur3TsRalcmL5NH+yaEMj69SwnFA5bFLPVBW53k040pMFPr/bLQmNrtiK8xqv9ei2XPbphGUdeA
	caHiOVYRhlvCy1zYEs3RFp
X-Received: by 2002:ac8:5a03:0:b0:51c:1590:8e28 with SMTP id d75a77b69052e-51e3c1ce16amr858611cf.25.1783958327343;
        Mon, 13 Jul 2026 08:58:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.94.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9036e27f765sm95115506d6.11.2026.07.13.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:58:46 -0700 (PDT)
Message-ID: <6a550b36.a8f5276e.dc189.77f9@mx.google.com>
Date: Mon, 13 Jul 2026 08:58:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5886157019739289359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btbcm: bound local name logging
In-Reply-To: <20260713125008.75358-1-acharyalaxman8848@gmail.com>
References: <20260713125008.75358-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5886157019739289359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126651

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.35 seconds
CheckAllWarning               PASS      27.88 seconds
CheckSparse                   PASS      26.61 seconds
BuildKernel32                 PASS      24.95 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.04 seconds
IncrementalBuild              PASS      23.34 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/431

---
Regards,
Linux Bluetooth


--===============5886157019739289359==--
