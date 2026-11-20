Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133060;
	b=xR7tFqtjxgdaQwfdQNRb4TPsu2aRgfVKEzZg+Ty5ZyQwVqrU+PeFWXmRvhEaBiyuLjl3
	 GT4H3CoTjRTR8zUvZQzRJZZFwvDdo+skMqjOTQCOl9wDKp6h7vuDBD2iTMsQasfRe5Amq
	 q+Uu54VqeXSyxa1dPM5OK8zxrTj5/+nlBE0Wykf12jpcQbAAeIPnBcr2Zs7ujs1lZSZ2t
	 v0bz4+FpAZLc0fM8ANpM6UWT+4OdwAR2Lh/CQuBox+dQmyQ6dWXBFoVExG9P1I17e4Dx/
	 sOAo1tVJzLQozN3p2kWTxgdcM+j76JDCqHGoN4d44zL0hgQvA0w5wTQB5OqW2SisxGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YgoGiCUR93trSpfQIGWbRQviegNp32D/0L+IUARiKmo=;
	b=DQ9874k7myOjA9HiEB42+0K2JxXjT2Y1XUXVbAsPKxe9gKkwKORFtS6HV/5hhRA/7c0A
	 XQ9cGo/9P4uv5m40FqHwYW1H8lvmPe0cBXU0OYky7dxlynMw/ZIh1leFdAR3dT9OaUilc
	 xQgXcBUNtiMlsvWshH5h3DPseK3d67yswyDnAw4rq4WE8zOx5UXo8QeM5Uydrf14Z+fJS
	 BLVSN9Z0TjDqM+a0siORBQqHCOMTyLR0/6UNsILGExxDAWh8YXVPqHbdyn5IG+AVfx+t8
	 2xwSe54LKi7d+EAefJsYSJruKGpP0+0f4EpndtCmpVZ2xb3ogetQn0Ga/5SDO8NBy8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUwmWP1h;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C060A2601
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 00:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069C060A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUwmWP1h
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2efdbab4e03so1081315ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133055; x=1795737855; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YgoGiCUR93trSpfQIGWbRQviegNp32D/0L+IUARiKmo=;
        b=nUwmWP1hmEV3l1XaTKgHgwGiA0wnr/EgnhJ0dPBMpKVuiH8zie2gXMaQxN66ZNo8DH
         AKZLtClHSTopJRuIz25jrV2H5i1dpyuDSUIb9N1agh3TtsjMNAWVRvGKpfeXASUnBF4l
         E2WySwfllk94PUkdCR4wbt/kCltt1Erwe0xNZsT2eVZRE1ejKTc1KaWpMC83OidcQ4nF
         a9w9+ddkDwAHD72+MBrXGHKrSNJ+Jvdp8LVSfwgGz7sNPCRUYr+bo8SvpxZW2ynTExgS
         NJn97mTh+QYD2TOKbS8KEH0X1PDKKo60RlQEFt1/iHviMgCj9kICfqhE64FuUbiGwY9t
         1GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133055; x=1795737855;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YgoGiCUR93trSpfQIGWbRQviegNp32D/0L+IUARiKmo=;
        b=oDAWRFQCz10oL8viMS/7pAzy2MA/WdocvK0V/2c62lHwOWeVZYPX4gXEsQ+vrjzg5y
         UFIbQPEGj2fc9rVA316gJ7h8ZkjJq+xvmBjUabwwflNGNfCvc3tvbUlrBk1kKf+Fi1Np
         0n4tu6QpE1GvFIMz7qOfq9icoM2OWyQSXtBlX6sIrat6yU4h5qePGTNTy6pe6ipLSFh0
         qMbNcPijjgSllkM1JLu2J7vRy8MKqBlTLQ34OYfdJcsj9gRUGcRRtzQuqD1J0CGkiooS
         XwPH5EkGSjhvU1lAQUUwAvKr/tqniUAcWyPg7VQjHjzGMjty/KVTheZla1sVgu6i+b/G
         NpiQ==
X-Gm-Message-State: APuU4Z8384YPezEzM8Ba2A173rErwwz9QwWu0qsLwebTset2GesVL1Vt
	rywIEmKWpXj5BuKY4RFNFZy29hHHuVDnjML3FZsZ6LB7r+fzDQ8sjZRLiDeVCg==
X-Gm-Gg: AZFdTZfM1jYF5Oh727ONUdgKcgzdS94NgaXOhUCCnqaUzfHJ4jJQmYZBmaH0cVny/oK
	svsRX/n/Rdt07GveDMAWH5XA35x55ymsQ3eeaWAzN3NKULWCVzGOoxyenoGzF9TH0WzJ4Mj8R9O
	NfFxxSoOWNdxmfwF6uwKco4168ypYE2yTUx7F6muV3nkr3bFyQHNNotYCKvbHjHPVv4Y1Gwxic0
	BbeUY4LzIsYRwt02cPPy+vke87JNE6Wn0KipVVl4OT/x64sSaw5+GhVrfJwDKTffJnOEZGGq1Nj
	3CkR92dIC8n7c24IuObnhc0NJlQoD6EEkxVStZUSetth9oMR2qBwiyr3DiuRMuPEyU7G03DpjKD
	KwCi9u0RX552PYBu87NwWuKZSc9DDlvJfaqsVYNyGIrza8m2oIA0jXByprfNIgtclQLu3dL/Eoz
	kWcaZkIbaT9UGSdmCTs09BERJY3I5nT8ikObIJWFDZqEZ2CHn5M4WsTjpowCoQvAHx4O60wjLWR
	oQD9e7ueQDDLnr6x1/SRS8NN8XiDZs9gZYLSSCt+6zSUdC7JQ97rqH1vO+a
X-Received: by 2002:a17:902:e847:b0:2ed:3db6:2eb0 with SMTP id d9443c01a7336-2f03f1d63c6mr14216285ad.48.1795133055171;
        Thu, 19 Nov 2026 16:04:15 -0800 (PST)
Received: from [172.17.0.2] ([4.242.53.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm5998565ad.28.2026.11.19.16.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:04:14 -0800 (PST)
Message-ID: <6aff8e7e.c7d98db3.3092ef.5a75@mx.google.com>
Date: Thu, 19 Nov 2026 16:04:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6419987772636661773=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: L2CAP: check security before completing a BR/EDR connection
In-Reply-To: <20261119221607.1311815-1-luiz.dentz@gmail.com>
References: <20261119221607.1311815-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6419987772636661773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216713/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.15 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.40 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      29.21 seconds
BuildKernel32                 PASS      23.70 seconds
CheckKernelLLVM               PASS      25.68 seconds
TestRunnerSetup               PASS      552.07 seconds
TestRunner_l2cap-tester       PASS      15.43 seconds
TestRunner_iso-tester         PASS      13.43 seconds
TestRunner_bnep-tester        PASS      2.82 seconds
TestRunner_mgmt-tester        PASS      84.92 seconds
TestRunner_rfcomm-tester      PASS      4.08 seconds
TestRunner_sco-tester         PASS      5.14 seconds
TestRunner_ioctl-tester       PASS      4.24 seconds
TestRunner_mesh-tester        PASS      4.15 seconds
TestRunner_smp-tester         PASS      3.99 seconds
TestRunner_userchan-tester    PASS      2.93 seconds
TestRunner_6lowpan-tester     PASS      4.06 seconds
IncrementalBuild              PASS      24.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
WARNING: Non-standard signature: Assisted-by:
#145: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#145: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15003387.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1162

---
Regards,
Linux Bluetooth


--===============6419987772636661773==--
