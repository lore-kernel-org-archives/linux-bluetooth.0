Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309572;
	b=MhFVDpRXt+va4oc66DvpiWK08t5ooBF7HCMjzzUUKhna1pJsefNmtXUY2DtdXlbD0A+l
	 A/DztCUI4tdnBg8KDkOSYoxNHvX0fg8nvr1dEBxFyVHyoTvgHFUxpak5o+is6cxF+BA1l
	 QFw6nsovDejzaiVxCDP2tl6sxpqqCBhgtDAfY6W1/oQgL7mNAXJEO35A20Im6rmibAmHp
	 P1bsWiPfQC4M/J6DvcEs4o8RdlmrVvTIlXvvUgdgxj96rBwuZiyJCHLOEC9JsuFFLo5AK
	 L+lDF1PVb8Rqow/1YEe9l9DkSUGkXYxeteFaZ7F/xFlgZNARnvbn89fzcRHcvCoHNsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8Tm5X1c2u9Tr0zimIvItQQMo85v3X3fHimTkllJ1fOA=;
	b=yo3xe4ASIGpVcHbyIwLrhjmwOx2W2LQzv3ju7wZ/7ZV6x9apGV8YCRHZaPqhOymdgRDz
	 yXgPoWRFMGiiwDgLK4oWH0pMTCrxfek7QEZHvSH/FdRRp5wc4cT7L244r2hsCkbGUCb6u
	 tnsW9NmUPCeO34bGHDaQTAXcNgdEEf8GLZr0JvH0D74dlyVmm1FybLUWOGpHTh5csQjUW
	 6XYvIJyru+8Hmp+XTd5tvpKtP9aIs+m2kOsz1dKtCQA1tv48CuChYUCBuchyRRGGH/6l3
	 5BNWT6YKQROA7vYKmfHeIjP5LU+E01exoHmOumY9sfugldoKg6Hl6MlHOos4Xga4PBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUQ6G6Vv;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900D606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1900D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUQ6G6Vv
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9440304604aso199388685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309571; x=1794914371; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Tm5X1c2u9Tr0zimIvItQQMo85v3X3fHimTkllJ1fOA=;
        b=lUQ6G6Vv2cEOwV80MsZ+Jok4SmKTCo7AwQ6ElykDRx8JFc4x0gyV4Uo8dT2En1RDpi
         vq/vd6BoWizobI7/8QFkh1rgTP3pIdVngTpFaCFOPdQMdCFUdzZ//SBFZJEpXBswz8Lq
         VfN2bBmPmJCdXodm1rhW9upkqz1t5gCLf4pK4hlFXwQu0tUm2H4p2baa6DwXUDlv8Lrs
         36zdjlttzSbUrXII4g5r28Ai+6+Zi9gtGVhju6/qT1VEgaHLINxx2WnAlcd+WNp4lrFM
         fUl6GfphAC654NoDOw5Yj1xLBOsm5clSGThd+kxd8/dyWnEEklgrq+5ub1u6OwUu2LbC
         Zr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309571; x=1794914371;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Tm5X1c2u9Tr0zimIvItQQMo85v3X3fHimTkllJ1fOA=;
        b=Pqi3JTLkGCAFZXNV/p/NLPp2lesL8n9IbIEyx3BsJFwtNHXPmpZUeeI3rhcETKxZN2
         KBz0TdJL/uJIyLTxnvVJQPTByHUbczR8JdciaubosTIr9d5nCvPPPtdq5aU3tSFIQqMd
         PfTJ1Ycn+AKq9jmAZwm57rGbObt2imisKjxGNsemz5a1JMuupCSqhpjo9DB6GsaEQ47p
         Y2HSogOoiH/1fAP45Qf4ppVArMjQfRh6I91ZqRoqq8q71OfL7Z4TeTDmRWA2Ybgpuud1
         no86Ur71by5my8kKoCdxkU/YyPXlzp8PzOxFzskjFCarndbYqPqgnpY451zEdza4z28r
         TPIw==
X-Gm-Message-State: APuU4Z/KME1gHhkEMtV1NREKQBocQGiwtp2KcJ3OPgY+lmQsWuDTaScx
	PN2N9NcqgG9AF+jMqsZbV0QjF3S4FKHYPgygqiCtkBtuDRQkokJ0E94VptX9zA==
X-Gm-Gg: AYBFou38qb8Tgv191oGS5AyPZuid+Xmy4xiM2QK8y8+1FXWvbH1UVKHYc2K6Lu9XMKY
	f8v4lCPLzcWS/8cAr565fML/LSNmZa5l4Oycum6bSJZzAn7KRRdQqcUMlaZyd7k9zpQnHbaorMD
	3wWX1n5YC4C5U0RGuALlSEAg/B1JmJGzHtUZoA4+YqhaDdzE/c0v32dh6lkfxAoXYaxPqRsIxNK
	K0wPAovOCH0RdR+8BM0xK1ugHzqOQlRdunp26nvWcKYjq4uI9xiWt6XDQrv1vVcnNRPvjF1pgt+
	w2K1cH45mJuezzUP1D+IMGsmLTzmKo0QvSpk7hNS7Q2BVrbF1+7Y31aevq77iykBbWWWgnbLhev
	D1xjfm+T51J5da+T6zItmSvihd7P29ybuxiZtzqfST4azsgRKf3AVi00OI+OAck+P0SPckKLjz3
	YAzGBXIoelvB2fgqDzpHkSTv5i9j1dikQG/VN7KKUIvVdITZewBxajCcWklIROWIk3mB+0LJcnY
	buN2/q/g+iuppHFAbV+H0b3vUHnxuY7UEicG018eRocKlCz37ug1H5cDV8s7jo=
X-Received: by 2002:a05:620a:640d:b0:93e:95ce:5394 with SMTP id af79cd13be357-9479f315948mr310115785a.2.1794309570937;
        Tue, 10 Nov 2026 03:19:30 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7a7ae0sm199927185a.25.2026.11.10.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:19:30 -0800 (PST)
Message-ID: <6af2fdc2.967958c3.f0848.0240@mx.google.com>
Date: Tue, 10 Nov 2026 03:19:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3709495294897054473=="
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
To: linux-bluetooth@vger.kernel.org, joasantonio108@gmail.com
Subject: RE: [bluetooth-next,v2] Bluetooth: L2CAP: validate MPS and MTU in ECRED connection response
In-Reply-To: <20261110-bt-ecred-mps-fix-v2-1-48c5ee28fd8a@gmail.com>
References: <20261110-bt-ecred-mps-fix-v2-1-48c5ee28fd8a@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3709495294897054473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206665/

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.32 seconds
CheckAllWarning               PASS      35.44 seconds
CheckSparse                   PASS      38.16 seconds
BuildKernel32                 PASS      31.60 seconds
CheckKernelLLVM               PASS      34.54 seconds
TestRunnerSetup               PASS      753.62 seconds
TestRunner_l2cap-tester       PASS      12.73 seconds
IncrementalBuild              PASS      29.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluetooth-next,v2] Bluetooth: L2CAP: validate MPS and MTU in ECRED connection response

1: T1 Title exceeds max length (87>80): "[bluetooth-next,v2] Bluetooth: L2CAP: validate MPS and MTU in ECRED connection response"
14: B3 Line contains hard tab characters (\t): "	pdu_len = chan->remote_mps - L2CAP_SDULEN_SIZE;"


https://github.com/bluez/bluetooth-next/pull/1097

---
Regards,
Linux Bluetooth


--===============3709495294897054473==--
