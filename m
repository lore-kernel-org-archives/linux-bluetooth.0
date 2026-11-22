Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388186;
	b=QSsO+8rO+uzs1U1ZIHnyLnuBbudf6LLGBy5/0r6FCTlKffReyyp3XUv2kuCjdo1Nf1Xw
	 Pd378BFu2pKrJXtCJT40wDzUME483RPcChdvo7uab2GkTRswNeZp9A6n7V0d7Le77kviv
	 WO8un53Tnf+x9DaEUWQGNiOWp/QSwouo2HZjNrFWYR52uzSXW79YNCafPzTtrDhEONw5l
	 1wCST3hgTnmVcLMtoCQjIgjFQS5brporacehg8DsZ09XmSLZWq90TVCz888TLLhR3V5jE
	 oMaDQlHFK/sdatf5rAldmx+/I5AYVuH1sUE7+xq2GCPxS1iAQgLpRK9Nu7JLo0QQU6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3k27L3E62JSJK8UCHTNL+4zOl+rL4A/L7fNkysdN2h0=;
	b=D0VilIvIE6aCfUARI9GpKjn8sw7ggt1HjRXyl+gUaVHS6gmpVjp/M3bLFDEpP0vXgj6x
	 Tpw5t1CFBE273r+1Pdgn/yyIpZejkWXgPo2agDOgshCKMApW5J3EWQ1hosn3oUGqV67pN
	 BjRHk0Lu5yzHM2nuAm0yjbKP9yZGMPKg61pmNTK7LgFkDwd40SdECBJSVLWPAf9so8sA0
	 Lx3lGSRO3h5OWxjvb5a1Oluapvi4px1YEtZ9m2AiUZ6V0aFSBhTVTn34CGS8klMVDZOuN
	 hazK8sGL5vYAqKPneWyOp25Ayt3oXl6htgsKgNp0nmnpgYrsfj7+9kBpOqC/M1/hY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GP00HAF6;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E614606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E614606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GP00HAF6
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so4487234c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388185; x=1795992985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3k27L3E62JSJK8UCHTNL+4zOl+rL4A/L7fNkysdN2h0=;
        b=GP00HAF6worAIP8s8hggtJbSyv0xEz2Q7U32jOq4M8+Jsc33Jtzmylw7uJRShewedf
         ntBPFOjlZKEussuWFiGvRnLeOwK4GYVfRitfK7lwJxVybZx2Um/NSHQzH+VlUCu/ASEP
         jTqG31++sczC5QJYjSquDN42CxIiqGyLejrbol4Gx1JcULIo1ro2wdvGQPHyheTojEB9
         yvKkCbE2R6WXRlqUrH1YSH8gmCacMwM1mPHP4mAAbypWgo7r2CowBdWEggtlRR8XhV/4
         gw1ekfJBkQxZtjOTYZ+H3usb2mXMYFeY7t9k/QXhFf0B/JEA/VucR5l1X/c+PLRP/e6i
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388185; x=1795992985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3k27L3E62JSJK8UCHTNL+4zOl+rL4A/L7fNkysdN2h0=;
        b=uOpHQ+yOSjp6D866bTyA5eBzqu9pYMyAQCM2kUwiYxvb83BIdEEMg6OD1hFk5N1bzE
         EBeVQgn3WgUsRDCGVOa1NGg+6AozmiZYbRN/PuKheg7Yr8gXqauT+nRl6hrM5wKkiKYw
         Wntz8m6yPAvkynCpbX456p8ahAUZHvCkoGmlgaEIYpkhoJ3nS0I+XNLc2u9IPMtGAtQQ
         fHhZB8Vm0Jh8FIn/+l+AtTNMUB0zemQ71m89jTwkvzs47EGxdH0EMjn+NP1VnCiq42rp
         WaTaNI0AF5hy4fL87Cjd3ZHyNialtl2FptweakbIRhFKV12sFR2VDzlr7FRZoFZJdZ+q
         adQQ==
X-Gm-Message-State: APuU4Z9xAnl+xFl2i80WLuc/MsE8FtN0hNDhPHjXvbhPy2aZV40pNoME
	8iJaJGcBNm3wz805wcca7SF72cSIHICb+HU9w9yQizRmp/ZxTDxZL1uZhozjaRIh
X-Gm-Gg: AZFdTZfBTaOKtp0Y6+sg476KShfh2Pf6JXhYc/Y0ls2yeIh0MNYT3f6gbKuE/k1EhSv
	c8+yCSMSq8shD/jOGwuHMcZVpjNcYKTovxd9TZf9y6ZerHTkckuxkjvcxdjg39x1/cttgp9fZpb
	FUGYFcOzA0XJ76uXIuG5CBG6uSiJb3CXdoML/SZOnwjtxpzSL89iF96zi8zDS6ULzOQl3aESzzd
	QiJzOZ/bL4nXfjljlAOj1GBsxumgrhaCYT7IYXG2GV32tk1QAmQQ5mhsncfIy3MFdpIukqWrdrL
	LqXK4LvAjxAFLeG6ahSgzuFvABziFykhKOrin5jU4Mhruvlj6mFYr1jl9oEkvqeAaMLWEPI61fP
	wKotM6S2vVYd53zBegl/bTbsoiY+TnYMXx7E4U5TSdBLfDeoId/kymR4a7dD0sepnzr2YQHxvOl
	DWfYAOpvGbspXBwKS7O/kpU7lJyMkoh1GHlbLbquqAXcDZHlffv7whWIENMZHQoktot5geEhP9G
	hOTytOY8z4WF+PYe14AuWgKCF6Ndcwu9Ov7Mb1W41f4Xp6c9k8rCt3kxTA/Ig==
X-Received: by 2002:a05:7301:929:b0:376:37a2:87f3 with SMTP id 5a478bee46e88-38570f25262mr9399911eec.31.1795388185407;
        Sun, 22 Nov 2026 14:56:25 -0800 (PST)
Received: from [172.17.0.2] ([20.189.186.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm24923495eec.25.2026.11.22.14.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:56:25 -0800 (PST)
Message-ID: <6b037319.4b6e150d.279180.d828@mx.google.com>
Date: Sun, 22 Nov 2026 14:56:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1863271213802131121=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_event: Don't report a cancelled PA sync as failed
In-Reply-To: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
References: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1863271213802131121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218955/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.62 seconds
CheckAllWarning               PASS      34.50 seconds
CheckSparse                   WARNING   36.75 seconds
BuildKernel32                 PASS      30.73 seconds
CheckKernelLLVM               PASS      34.09 seconds
TestRunnerSetup               PASS      739.39 seconds
TestRunner_l2cap-tester       PASS      14.80 seconds
TestRunner_iso-tester         PASS      17.13 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      88.86 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.59 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      4.45 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.37 seconds
IncrementalBuild              PASS      28.26 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1200

---
Regards,
Linux Bluetooth


--===============1863271213802131121==--
