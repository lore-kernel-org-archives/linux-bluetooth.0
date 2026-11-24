Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546456;
	b=q/+cQdNehoLNYHcp0dcG0esJHX+W7lSFWyV2jYnWDrrmd6y6+G6AtxzDcgwH4IC+NRkd
	 ZpGGTeTTfMOJnxKyorPlnMlaP/GULPea/p2D2k9FtYxMBdPCB2d/a/1PlO7wmmJmq+szU
	 b8wGGrGwV1FXp7B34ZiTGfyRS+qUFvjsXa7lxE/7kmn7vbI9Xz0Z51Infzw1m6nI+KqGQ
	 CjkaA2snDmw943Sj9uQ05ErDhBB+HHxCx7908o6PWdM3diKrQJtedHlZgRgDgN1lZkrx/
	 SodTmYHv5T8MPuiW4LtpHjWZPZF5mCCG1D+VpQGu672KBcQZWTO4RvJ0cKQEcMuY9Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=81eoaVm9U+/iXAcFash88jZKvISETBveIRClbj7sDDE=;
	b=CbcrIpBWSiSIIh7Wu25d4QYKT64IVW7chrsrM2rUxJesBsFhxMVvzyZwXWq+pTbqJAJy
	 4r1LNKx370wffpXAhrZ2BniE1sUhHuNxj7gPDkDbD/n6vJWpyk+8GPfEnjDI5IgJ6KPEj
	 siS3gQCDXnrJWD3NHnQzW7Z1mS4KtmA7C6gYu9N+UKJNLuNcBAOUeI8GZdRTOTWpP+Pp3
	 SgnTr+/iTuxNnw7NGvmFdTEEJfSdPP0IO1aRaXyPrV0EF9eRBs3jv7PeOEZQsJkV0kaQf
	 dJrTpj7qP6GwoBkKTDhrs4pXuZ7PcjUKBIVbf9oDAYls83JMGray+0rbk/k6Lcuw0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEHeKvVH;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7645606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7645606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEHeKvVH
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9214032a2fdso39711786d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546455; x=1796151255; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=81eoaVm9U+/iXAcFash88jZKvISETBveIRClbj7sDDE=;
        b=zEHeKvVHzXoGd+yB3Gyh9P4UAV/JG25hYpljtea3ztsoxHJ5PmxZZWsapgIKWzxKId
         9468i9RKM+S09nMJJ3fE1go1zLmQlUYrdVUx9lKhpjpD+4swswm6xAW+bSKgLI/tgo47
         RiGZ+0hzF8MfQpAE0uqOWVVtDktULyzMh9IxaPZMcsVSQ7jaa3ZJX9vwtfMpk6ktAJ8D
         0DnNsWq/XcSORBi+x+bZVEA1EwXPZUE0ZGFafVigHAXBC8SvBdf4bX/r5sbRHFKTfMhp
         +00muTKoq+suozvFktFeI3HPTXU3v4j8tXdUDi2cFUeSyxEPK6dqycaHUZYKC5Cz3jDL
         xWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546455; x=1796151255;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=81eoaVm9U+/iXAcFash88jZKvISETBveIRClbj7sDDE=;
        b=UgNqNeWGQLxCQcgSPMdUeYYqomc1W5fX+UXRFFpdoolZQBX1Dd+6/UzcJ6zcteDKCa
         tVnBoOu5AFW2g5S0ajaThxbXdsm7N21+CbMWiD33GVax1ZmTNOgqkUEaEp1TDnFHt2wW
         OiXh8/h/cm+vWBwIi+S08LSOIV7B2vNRTtbw8LQyxQF+r24JuVCyOVBKowpFuCdJa0dV
         DmNUdGAsqMW+xoaJzm6QufCphAEb6vm0mR78sFYA+fl5XSctZDLd5ZCmVIerI8IJapCN
         LTCBpfc1nncjsjaksJajRsWh5C8/gvLZlMzQhCyfqDt3eRlBKG/iZ3XyAAlsS9mml63E
         prBA==
X-Gm-Message-State: APuU4Z8Belpy2olBuAKr+6SKIzRK9pnaedA/a+cB/9S7XZQujdpzRjAj
	/CT/bSOVpX4v6L/oF2mFrRyHJEz1m9zDS23xHGoVxUjRg8iqfCDG8FfQ6QbENg==
X-Gm-Gg: AZFdTZfKOzHw92WYKvNpwYb5r8iOiXxKPXs/anTXAJQmzi6aU1Bx3WAv2kaii6YD80H
	I3GLIrIqHtrM7iCnoXKJ0eXT2Lrb5GsEuJhjMdHnCWCgSg66VKw7BnuUD+h9cmo1gx1KAe+1/Zp
	RZdSPgZk2I+mREmDpYpCG/wfo3V9T6ewhPqJA8HOEM72+h85ZIWQUFjAhnRtoetGUaRb3lGzPX3
	NgpBgWQWNbezqgyOQqulMfah5m9TBQudEF84Ktde8fZksYgBbLg58FwPydrLBGNMveMUggKCPyQ
	QmkHSU/3Sui8ZIprx+DzR5A3YPskRIFaNXarqlWo+izQBPTd6c6YbYIo9fXNlZCy6odTLnds3iB
	ThndEseL2xNN2FMsImZXHezRShYi8CgIemwbxHWdIHnVRdX2cP1EBk7V1UBkfXEIpniGS4Ebep2
	PbhDIePcGAHLSJbwNCueNhZG90cuVrNVFZlMTUJlSbBCBOfEvBOXSByCM3xFF1vu3Y2uyMLZOD1
	KRVh1fpWRzO6W4B3vAjRy8Nd6K+jmlG8WQlTSCZN2yUxuB1CfB3bO1n026LT4aUwQ==
X-Received: by 2002:a05:620a:3710:b0:949:a6ac:cc1c with SMTP id af79cd13be357-949ba9d4cfemr2516255085a.50.1795546454755;
        Tue, 24 Nov 2026 10:54:14 -0800 (PST)
Received: from [172.17.0.2] ([172.190.110.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f5c31sm1116426485a.30.2026.11.24.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:54:14 -0800 (PST)
Message-ID: <6b05dd56.e20a777d.35bfd2.e167@mx.google.com>
Date: Tue, 24 Nov 2026 10:54:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7233547384726654067=="
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
Subject: RE: [v2] Bluetooth: ISO: Don't drop the hold of a closed BIS socket twice
In-Reply-To: <20261124114035.1698961-1-simon.mikuda@streamunlimited.com>
References: <20261124114035.1698961-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7233547384726654067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220749/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.64 seconds
CheckAllWarning               PASS      35.29 seconds
CheckSparse                   PASS      38.38 seconds
BuildKernel32                 PASS      31.19 seconds
CheckKernelLLVM               PASS      34.59 seconds
TestRunnerSetup               PASS      754.72 seconds
TestRunner_iso-tester         PASS      14.21 seconds
IncrementalBuild              PASS      29.99 seconds



https://github.com/bluez/bluetooth-next/pull/1216

---
Regards,
Linux Bluetooth


--===============7233547384726654067==--
