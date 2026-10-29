Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259392;
	b=e8KBie+qFSsBvIyrMwt385/oCUsV1Gxb4znFxh9z8D8t/COAR7dpkajZuLEM7WoDzpX2
	 oIHXV8y92ZqDMcm+o3rCXPEqjAYJKDhrgE2gXIhKNlPdBmXLkBhK2IaSUanUvcdbsSQLi
	 ClwI5lVy6xXIVo+vj52yWvfhkIpmCIfKvmcM5xmmKDRCqkb9Kt4OQ2OYLEFV/zD7TVZHL
	 ZTTYq0CG21fd73FisWjMAzfHgwfxVrUqWRj6aKPdYh3KhGcCmYFMyYGQjNbjCIJvmNElE
	 l9DM/Hm+/uJyfAY/YVctwRhwSTgVZPO4wGQZQ64y/luqQvZCsUGS1UwEIDmilAe2Ujg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rYJQnEe7iWuK5kOVkKmkWh5UKa/EgPlIp4O7r2fJDiA=;
	b=MMOZytnrdKP4/A9qUdL41Nu/FaBf9xCTFl0fup2sG5k/6lU73DAeUCg8D1kR39h6kj48
	 PxdLXUBOdIpgH1elursdhff5ABGubva35Jq3YF+SLzYqPVA5slJ7H4HLPLLhmku5zQyYS
	 ryHMpcxY43Qe3AWO9YgqLfY23ng8j6L37svZlDtU+zmJQOArzCEWpg+rBkDxlSPmdcHIf
	 K+x24AYx9/Yem3DTvCdr1NZGeXm6ep9hoSS+HjR+9BAy/u0PrrHDsSPgiOG0ELAhgmzON
	 HU4zUSH6JfnxiruyPuas2lcXQQkRMAvRk3HoYVd+VJlW5NrB0vHpP4UXJ2ostbLtSaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SYuC+oQk;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9B606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 07:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SYuC+oQk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-702fd86d674so1271297eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259391; x=1793864191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rYJQnEe7iWuK5kOVkKmkWh5UKa/EgPlIp4O7r2fJDiA=;
        b=SYuC+oQkxA8EBqHpVPRhnKHjj6osRN69wm6CMh5rcl3QFaFyoEBNo9uqocDSwkNABH
         VB2V1MRhZT4ulMnhv+OsgSw/gN7xtizdjyzdoTA6Ff3EeH3ePlyLHRxBiFQ4Pah8WRKM
         m4hKU2lKxLIFmnJYeocFCZgGRrJ+JXlKGRdYks5niMs7MyOfrAfHvKEwlHAFeeyqA8SC
         bCITFPknFyFtyZOb48agFzwJ8XNHquHcdnfkMfV7pXOEgx1USGyFsstt8RejC1AJx8oa
         0UQXtC/ccka7Oa8zC/UFkJ2OmRd5VvoxIzmDPEPz2By5tMTj1/BRUulqWEODTWkb+sCe
         HxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259391; x=1793864191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rYJQnEe7iWuK5kOVkKmkWh5UKa/EgPlIp4O7r2fJDiA=;
        b=e7cY1ULvE1/rDU3kv/18AWrZtvLwGUG/CG9PmaV6mJHk4s/CPO93jp9ojwERi1OXmc
         qbQsNC/sa76I9C7CIQJS4pvSRJBEJOpJFW6p2N7HREfOxsuVOgJvHW7u1qCYWtbl3vFH
         PsOirIXsXOzSIBwlfjqWoRDOo5NqQqbvage61pjWrXKMgUb119UhEvStkogh2ewVVx3t
         Mc7kKSdQq8WmOvESpX5eehabBZYTiKICwdk9L79YatmJN9etKbLXRQYg5t0L4bxlaplh
         9xyxNKzLhrF/lNpnCQ8OLKyYLe2I2HaViFkeC2gweIYup5wFtDLZQRuqtWf/YnhHH/aS
         Yr7A==
X-Gm-Message-State: AFq9FYKXTUA/h8o25nnq71GCzMNpcsKQCsJdczO6XrUKb3QDMHj47bmT
	0tRPpmJ50jdYulDcJttamY7B+5qB4G0xsWiL25TeXxGA6jUhtMtCq8TBTjDbAA==
X-Gm-Gg: AYBFou0KFDj0ybiMBLx1pdGzmial0bqu7ecT6jB2SNO/3cZidZ6IlDRQhiczKGNAaKt
	kGauUKA2Zn0cyc9GHjGYr3S2vOpg/u7RpmXY6yO6GnWoF16Ahbc/U3FV+HvOp7AY6u21EQPb+SF
	k2043xm3eR3C/fkkBl4VHT3E256ORvtXpQtSkNCR1GgSMJL4t6inIDT4SImtVpPZpKtcWcwwPld
	OYGFtrdLyFgYU7SnXmAcqD3R+8+sykfLy0MqKJmr+6PNfPg1/pD3tWdcazZOt+LnyuGV8NM9aKe
	BHA+KHE62xid/fD8YnyU8lk3tgWyBLdcq9w2rqdSdZTbkV8sIb18sTB7a4mdcqZYPKmZNYqYBNe
	koWp+izXASpDhyCZiRYynIn+SG+9Vg9Y2grYCCyC4bbL0QGkmHpJ3BJfPd2FLsn9S4xw4q6iFOm
	IBgDBssc8AZaHZiFPr3CDpHVyWixX7BmihR9rNeWhPyr6CkQhNR4MEIZbn6AV385peOBjObrASy
	seTxWiBd/sRYwflYf+tu43sDIrZow6iSQXeTfzxsJ+VmXx8yZfJxpRxgSwc30w=
X-Received: by 2002:a05:6820:f035:b0:713:de08:b031 with SMTP id 006d021491bc7-713efb16071mr2884769eaf.53.1793259390915;
        Thu, 29 Oct 2026 00:36:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.15.230.129])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b788a09csm4461481fac.10.2026.10.29.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:36:30 -0700 (PDT)
Message-ID: <6ae2f77e.5986774d.1839b.e3cb@mx.google.com>
Date: Thu, 29 Oct 2026 00:36:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1653818677859993435=="
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
Subject: RE: Bluetooth: btusb: UB500 reported maximum data length
In-Reply-To: <20261029023235.1280321-2-cochcoder@proton.me>
References: <20261029023235.1280321-2-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1653818677859993435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195840/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.00 seconds
CheckAllWarning               PASS      30.34 seconds
CheckSparse                   PASS      25.31 seconds
BuildKernel32                 PASS      21.14 seconds
CheckKernelLLVM               PASS      23.84 seconds
TestRunnerSetup               PASS      490.03 seconds
IncrementalBuild              PASS      22.09 seconds



https://github.com/bluez/bluetooth-next/pull/1020

---
Regards,
Linux Bluetooth


--===============1653818677859993435==--
