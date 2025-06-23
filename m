Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B12A1C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673044; cv=none; b=ZTvgLZuTpw6XGID2Y11Ov252elK/Q5SbA6/PeV6SQo/yIsY7EgcyCHDB4mgcqbvcDPA/u2Bk07ZkV2Gw5ve88U51MizIcJC5HAh6TlV8VUJoacg2Ctiy5CtnGSjC68SHKibir1kKXOWslAP7Afe4h2eeRyZzbZk4c0qxe8UqzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673044; c=relaxed/simple;
	bh=J41kgQvvRId7ioENaqBP+2QZ/pG/Svbf40MLsUTlP/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XOn+ABOVSa7bnr94iaaocO5vX3/312BzmwY677EaplE4KRuwKGmku34n1QMQC87v6R67oiDw/Scr4XY6qyA2a9u7Je4fplukGYW5b9V2eM9apOX8gYzrJh6L4h0jlRdSoKxuDOvCqC629CfXm4iHnTwE4DjeVYGUlcI64Vdvr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNI+1xuh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNI+1xuh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso4098552a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750673042; x=1751277842; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJB5f77m5nvtstXDQcNU+crMjwiTTHldUh4mzPWTpH0=;
        b=cNI+1xuhDPujp7SlwFvKE3D/1xO9xBa4NQn/5YR+oyVEkXWyU1xoaefi/mHkklRynV
         u2I5Mcf1WVxksT3xbDS61HZmB8zjNv0INNoO+R8P3jtIZGhgtQ72lx6E41OIBvmXiK0N
         daKjqSvafklJYQdvoAzHFihoaVuHyqSGbOSuP/C09E9oG2palYEAgKSALnes9Af07gOr
         /QQ+sl8CccuwY0G+uEUxpY/0nIdcWrQ3LtM+M6YcsK7BALiOyInZKGd7eGk9OCBXK0Pe
         00c24PasfpzPzfj1arM7mo13PMJvAalDcgpsyKiKTN0IFwONsqhbvKrlXwIL7V9qN1vz
         Ck3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750673042; x=1751277842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJB5f77m5nvtstXDQcNU+crMjwiTTHldUh4mzPWTpH0=;
        b=ZxPipUJOm/nb4ij9aGeeG5BF+GCcqc5wD3FtNybf724F8QPL9sTbwj7RdaboM3h4RY
         CDI/tJs0FET6uR6FQ3VimaUGa73dhoeIutnR9TP0iRDIdfifwzQzk1DgkOa+pxeeWKpk
         PMJH8rUJvzWu3F4x3wayjVqF11qWEoV+Tx1sfA9TjqtvzUMnHFXSrCdce4vBxRVBJLwL
         nQfjZZnkSEwR26VjCAg5fiVlGmcppWz2pP3JcaxddVZyb41qB5fWNTbPM9zd+/q9zDsk
         rYWL79JLMIKUbGOmtgSuKPsxcYstkC0wtEJ90tCLi/MSoZv6U2OvdxTP6irgQynwK2Mi
         QzhQ==
X-Gm-Message-State: AOJu0YxwfS2cfxNp9uLFmy8g6w+ogaK8Sp8iolbIETVLIItaMQ/4mwIJ
	AFzJLG9g5iCLlsTjPKEZonXEfqrjhr2HUx7gs7AgWiWufk7O9K32zLPQox4cxg==
X-Gm-Gg: ASbGncvBI3CPCxdnhTu365VRItDNdsuBW8KYSlerfcs+r6BRcGw2i4U5kbuml+NDalo
	EHP0gJ1gxhQsRuHqG36/B8mEBdR2ZwEwzptRYD5xvtzO32LHNRqcCyyrImfQ+IwsTQ+pn1PWcnZ
	ulrs0OIoTuJLoRenH2HJXKtFyyafGKun/TZgy+fey8rd3ew+x4fY+E7aixd6iDZ6Qm4ZR8jt9bj
	hoG7FHmHD7/PFk4S8Se0ND9Vmd1dHQzz904KJ9h6ieM5RYWBV8rtjNJPTA5co1YwKMnsQPXGIRg
	ZQCNdCcHRs58j4R01Dr6Kw0fSeAP5gcQRhSqI2x3xjUSU3DtxIz7Odsgp9LfCpBQVC4=
X-Google-Smtp-Source: AGHT+IFsBJiAoup/HF3goAODyYd0Vhoq+HFmgL45Ce97v0MyoD1SVJY7c1orbIG0gkGzVLSUblRtlA==
X-Received: by 2002:a17:90b:2889:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-3159d8f7f8emr23414261a91.33.1750673042292;
        Mon, 23 Jun 2025 03:04:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.0.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3157a60781asm6683956a91.0.2025.06.23.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:04:01 -0700 (PDT)
Message-ID: <68592691.170a0220.37d78a.06e8@mx.google.com>
Date: Mon, 23 Jun 2025 03:04:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2285269558159292240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v6,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
References: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2285269558159292240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974754

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 FAIL      0.50 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      31.28 seconds
BuildKernel32                 PASS      24.61 seconds
TestRunnerSetup               PASS      478.34 seconds
TestRunner_l2cap-tester       PASS      25.08 seconds
TestRunner_iso-tester         PASS      36.12 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        PASS      129.46 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        PASS      7.41 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2285269558159292240==--
