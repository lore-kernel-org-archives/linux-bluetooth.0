Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546138;
	b=R3M8KG9JIhn5FPIczyLlNWTHOB3fA8SM5WpSkI0ggD2Ivl1WE2sgSiVl3AlFY3WSQzNM
	 rPmqt154kx+2q//W2Qf/uLY/pg+6PY+EnTfuknTnhrNOxw7jDftI7iiO4dv3SNcWDDLjN
	 +02fShp1jxSkOce1K5cDj3uj9YNX/oeEP2mt/asmlTUF7s7ylioyE71EKObUSzFFvK4Ul
	 wXbDA7yQJkqh7cL28D5wxg1cA82G4fB+ouuulC9yl10xss7FbgiVGKvN3jN3qayDV4MgU
	 0x6AfvHSJhuE65oJ5wjiDzT+X+mcZjKgG7ZUe+GXUWoBWIf1/kjIY/H62qIIAHhk+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=fQxswYPMkjvJSqixYD212kBmwflWpTGhKoA9ObvszWw=;
	b=Nu40A4XlFk17YhHmQlpzo0hxj2dLy6l8xS0HkNajMtcqpY9GNreWzPoEB5trc4chNjz1
	 6YvUwrhH2tCf4Z+DLX07O66ZwiSXGJ3O0k+MJs+/ZEk9zhPNOt6AVZTYdk+5SX7Uspcyq
	 RBOxWOzz1Lf6TWJ7EidFtk7b1jHTaPFUMr2HxWHZ/nU9oyaA0UBqWGARnHTzXPGxVEBBr
	 /DzBIuX5UD3DzaD6giP97rKn5voAD2F/mIM+MdtXMG1ul2NUSTC7lN0Ce0CPkZXuqnaOZ
	 FIMBs4SwR5bl0MNLX3Rqg9HObPE7ndWVdYh2kQiVcefKD0STyMB+W4nvFyGelVu83QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TznNrX7u;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E2606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TznNrX7u
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b5786e099cso2864860c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546137; x=1796150937; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fQxswYPMkjvJSqixYD212kBmwflWpTGhKoA9ObvszWw=;
        b=TznNrX7ujSpQZQPy7tR+c/R7Tyx52cReniNhUA3+4IeGZnRsK7okkm9voZCOMycIb0
         v/IYmVoUWO162cieKwVKm+LBcLvRMgnWWfTHCcRBEI0PIp8l2EDFurBUUy3Ch4CNeFDV
         PSJMpzeMlSFERzZzisB82Ude52PLmrXU3RlJ5sucWRRudJ86I4pJgkY4tzzavPTY/JJl
         HcSVZ6Rvy/veGYPFx8MTwiexk497sh7kCNFvBxGIQyL7r288VFI1Rg55zgf4gapqV3/b
         jC37kZBfaDfvQwivRMcsKWI/ckRh/dFChBHrB2nxerUh1hYivoSpQFCq+F2i6szSui5+
         GybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546137; x=1796150937;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fQxswYPMkjvJSqixYD212kBmwflWpTGhKoA9ObvszWw=;
        b=BEHe30qbpS3uMKYAR++eWApQhB4Scc3vI0P3Mr2j1+UdCEvOSCLril9tAgd99UNmzc
         FdmRgZ66XlpiVu1JOr5nkoz7bp1y415JSW5eOLXr8rrQJd4ZSQ01PIk7xpPsgT6++aWA
         v2en26Dov6/WkD9wOxe0stXFd9Ry0BFLjEPxOU9lQhGf+16CWZEVYdaSnAkKtmynQFNs
         XzbWz6qxwOW9p2CdJ4n4qluEbm+g9VdQEVRpiByody2V+gOsfKa9GNBc5MGIWoG/8GSi
         Nsqdz81buz4taxJCFVmHP+LsRYZJetU/Qu8zJgCWPZOeWbZxTcECMdPe+kQ3EnLBil4f
         j6GQ==
X-Gm-Message-State: APuU4Z9HedQFcihuDwhyRwwShkDx8tOnr/7LaYXCXxvvbZzJ0GZaMA6p
	3/en0pj44gOcP+CqVEP0u4vXQvXJFEHP1VjNgRnr7jva+yWvIszpHFwH++uLmA==
X-Gm-Gg: AZFdTZcuPNagWlpKtJ5+q/ZZ47Np79K048/BttOD4RFnzI9OIFFqEd5zh/3QZ6v5WGE
	06YVYH94i5CMftaDVgFlAnzOWD+9YODV8ck/UG3PaMZRIpftR5viwvEFzzT8Mu9Z15jWCDPIymg
	AxO/yHG6ymy8WqOjLSbRGcfwOz0cd2o3/E0mT9RnD1/Odk34tcenKxWbNJ8ha1nqj2DDwSFzouQ
	AP5QCvf8jMvjm4wx3r76/7MjR2aeKFuS8XR1PaARll8P+1r4bf8WqfId+vFkCcTPomEnUI5ZoD5
	kCCt8Q3fqxAkfEUUblMX4Yi1VBxX5pzdcxhWtV44r4b3wyT3i70F/71V7TQ5AOxTyVimLoWf28R
	nM+P1oSiVsmy4FinFyV/MrL1dNoGwRL1DWB9tsPHf4wXGBjBcAfrj/UmWmau4zExeAlu2aFRFta
	FgWGaCKSvnAKvZHpVMVqpNUN8EFBOXRIV0tyW5TWvQF665FF1X4HxByD9Jv6GtNAlks0UpprFz0
	W2L6h2Azzt1/F9ILg4Hn/FQPDUQborF+myho1PBZ3r0HrGQ5LTzLVpx41Ps
X-Received: by 2002:a05:7301:b18:b0:386:c857:76c8 with SMTP id 5a478bee46e88-386c8579c4dmr1451996eec.22.1795546137166;
        Tue, 24 Nov 2026 10:48:57 -0800 (PST)
Received: from [172.17.0.2] ([20.171.2.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm57132458eec.11.2026.11.24.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:48:56 -0800 (PST)
Message-ID: <6b05dc18.4e434f19.685a.b8da@mx.google.com>
Date: Tue, 24 Nov 2026 10:48:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0669872258121858521=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v5] Bluetooth: l2cap: prefer compatible local LE intervals
In-Reply-To: <20261124140405.3096828-1-cochcoder@proton.me>
References: <20261124140405.3096828-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0669872258121858521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220933/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.74 seconds
CheckAllWarning               PASS      26.94 seconds
CheckSparse                   PASS      29.31 seconds
BuildKernel32                 PASS      24.40 seconds
CheckKernelLLVM               PASS      26.15 seconds
TestRunnerSetup               PASS      560.20 seconds
TestRunner_l2cap-tester       PASS      15.26 seconds
IncrementalBuild              PASS      22.17 seconds



https://github.com/bluez/bluetooth-next/pull/1219

---
Regards,
Linux Bluetooth


--===============0669872258121858521==--
