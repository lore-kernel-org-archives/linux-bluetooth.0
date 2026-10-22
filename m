Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674380;
	b=vccpap1iDMPoMfVMi2rFCnvPO7OarbTtJ9mUyVOo+BpRdJTxYaSIrVv7CV5JUKx17AHh
	 y6oJlfhj0SIP7lfj2x9LHB+Ehc3pPp/ICvf536ltSIEhQV619djwx8vFGE7pulxPnpQID
	 3MjHHF06zPJGoVoZkisIVf5RTH+eU1Q2T4ouu1tH1HZ3TaW/ssWh4S+0dRNvKMMFRgonm
	 K+TNP5hV9lktXCIL2/cDYYfdUDPgSaIcH11aMuzRg06QabVFLXJQHn1iFpcQ3rvQ50Sdh
	 YEAPicswmHcM5xxjd6hXTKBUyW7L2eiQReDF2bNqmZ5DQzrlc/pzwv4ZGQKHiBaLQ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yeKlMPTlk8JYmXYtOZUWZKAS4ccef+jzrfUiuRO+biE=;
	b=sTme4Xy2PgT020yyOi+5whRuutpAjOFPi4R3FBuu7u7oW/Y7CfvL4yziEJwLjYOk/xkC
	 7FeVh/fkhFVFQZXOIaBQgsLZ5bb1P0rq48PN/oCJHR9HpdRS+qPRvvC9357rqbVWTwDEt
	 g/jXMQx5dlFhYGxWgVn9SVo5D3PVB7suO0HY3TJBhipC+RCP4quwUI5vakWK+OCyoHdB9
	 zlwwZqPDqsQINVsC/SvahWfG4M853OSis4U8LfhzZch8VwZnStHfq+b7omh3EAxslZ+kJ
	 9IUVkcrWsPQBIZXxnvohYLkA8pt7zQJmg/g8yGoY3IdLuGNh5JTvSLm48HLvMd1RENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b01PJ4wN;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B3606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b01PJ4wN
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9ae391a05so6526315ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674379; x=1793279179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yeKlMPTlk8JYmXYtOZUWZKAS4ccef+jzrfUiuRO+biE=;
        b=b01PJ4wNF/7nxlASmqWRvSnPo17hlhC8+hixttdLChiSzR4Xt/TIO+GuvvCiA1xBA/
         s4BDQW8RA83jhtxDB/BT/dyJGdPmMc/3eY37eNiJqBFYEQYGgekvIdiIoKbhroBk1dnF
         39fCP4u1j7kFEkNFhguT+fL1Z/HH6YNLyMJzcFaFQ0VhqXUsj/ff+X3OA/JUTHbicblW
         G2+MgUN4mYCZprfmaKVCYvh+QnIzW/JXdCfs3DiSAY/ASc8Jb5TIoAifkpGtzOosnh8L
         JKAmHGgrSuVkSgnQS92Mqdqido0/30jx/g0pPoI7gFR3V9fs7dEyksspOwSopTKJ7L1n
         mJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674379; x=1793279179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yeKlMPTlk8JYmXYtOZUWZKAS4ccef+jzrfUiuRO+biE=;
        b=o+pDKLkb2ZIbfLjv9HRnnWkBNqlxrNCJ2tD+aTMqUnT5bC84nEUkzXLsws2vbZ9tpu
         +eF4Epiq8F6+OwpAviX8b+ry9NRVxYMLq3CtI+P8H5AUGB016dGhWi26CuyES5RN9HNV
         QYr094xiOskNr014V15DVKtGoY71/K+2+oDr6hFoY2ZEYM1Szw45se45o3aH3z/XAjZH
         gOkRD5ROsIkkUA+iSyPgFCAV1+QRQQVSgoLk9W2P0FbtXUPKD6A4IsTwC01vW/N4ih8Y
         pOavs7W2zCzO69s5F/QJ1d1JLkRHJKyxP0cooBHiI8ZaU2j7YfYf/bmjxouKA9Hx1byB
         dr+A==
X-Gm-Message-State: AFq9FYIizJmgdsJ55SoibdI1h9syBYlbaQoogXHdztaGk5bTE8wRrjtq
	bA+L8hlsabT9/FgId4f88RKa2kttzvvJsbLQVU+XZQO4zNjt9Y69FwVO/nRmcQ==
X-Gm-Gg: AYBFou0KgdpZjHG6Ebc0IsrE6x0MRosdazlRft0bzGhHVGfJzjDcCU/LrX4+GXnTFz9
	yjXJg7XdNNWYgnDdPh4vrBs7IyyhmgYOr6Z13hifs5PBYYiLV7tj7030XZJvLPnTimKSnC8eU4h
	osZ6oIPAR7k1Gs/B+gsezNjORIkKcJO7i87zHSbyJgCEIOV6ZeC3dyfS2uFxuEOkE80zx6JFslw
	dSk+fBjH797bfmodvmSpMyQJ9ACDqH+SmKgeamDKOT95mc6Nk2zmeCGq+p/SaNFabyVbUMagqPX
	csB4H1O7ITCsjbNspBhUsti6slG0Hr9SHqmYk6zW78sLOaQ9o+g61vo/apWvULtVtxcXIX+HO5i
	jvAqvShhUDhziu89+vfzaUNnqgG6vddmJvUcodIZmYB9e3E/uuVmWMcJp1Y3ir7WeEkOlJGO+i3
	5w6SW2HUlOpFvieN4FajFVtqSV+vxoE9B3k4AkBOPkac1dSg1VU+uFncbC3GimO+qC8J1LB1Eh2
	Luj/tsxEAvaZEo0QPMEIaYZk2EYI+ESEv2dMpCr2Z0Ha3FckTkb2MBjXEGb9SV2
X-Received: by 2002:a17:903:234e:b0:2e9:5598:d182 with SMTP id d9443c01a7336-2ea628100f7mr16749585ad.15.1792674378868;
        Thu, 22 Oct 2026 06:06:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.162.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b434e67sm23585935ad.27.2026.10.22.06.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:06:18 -0700 (PDT)
Message-ID: <6ada0a4a.783ac244.363c2b.60b6@mx.google.com>
Date: Thu, 22 Oct 2026 06:06:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3243944478153366168=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Protect resolving-list lookups
In-Reply-To: <pm-bluetooth-objects-candidate-0159-v11-9bd4b4c3c1e56d9ba355@gmail.com>
References: <pm-bluetooth-objects-candidate-0159-v11-9bd4b4c3c1e56d9ba355@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3243944478153366168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191269/

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      19.57 seconds
CheckAllWarning               PASS      22.69 seconds
CheckSparse                   PASS      24.74 seconds
BuildKernel32                 PASS      20.13 seconds
CheckKernelLLVM               PASS      21.58 seconds
TestRunnerSetup               PASS      453.91 seconds
TestRunner_l2cap-tester       PASS      12.92 seconds
TestRunner_iso-tester         PASS      10.68 seconds
TestRunner_bnep-tester        PASS      2.76 seconds
TestRunner_mgmt-tester        PASS      80.29 seconds
TestRunner_rfcomm-tester      PASS      4.04 seconds
TestRunner_sco-tester         PASS      4.97 seconds
TestRunner_ioctl-tester       PASS      5.68 seconds
TestRunner_mesh-tester        PASS      5.02 seconds
TestRunner_smp-tester         PASS      4.02 seconds
TestRunner_userchan-tester    PASS      2.87 seconds
TestRunner_6lowpan-tester     PASS      4.02 seconds
IncrementalBuild              PASS      21.34 seconds



https://github.com/bluez/bluetooth-next/pull/978

---
Regards,
Linux Bluetooth


--===============3243944478153366168==--
