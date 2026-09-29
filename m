Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4845FFDF
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708882; cv=none; b=U5SI/FFoUyxoHeJlGKLWgcX+PjVVRYwLjAPIPgfcCIdxX5VIAfS8dC3dQIi+Ai9rBrjKuQ1dpdoEgsV+AEvxV8O6+7zJRp8FHuALgcFOIOVyjzlLNCGyM7hLGILgsmV6utvIST6NRLdls5eonNYzSjqr7JAMzyr07mRTl18ioDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708882; c=relaxed/simple;
	bh=O8Jy79R8Dq8aSwI4UyoaWwLJK83knrzYOD3y5r1We7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AwonAy4GivRgjoIXEtuKTijpufZZjaOH4A0EIq0BMhmyoYmjOFMof22dPTE0N1NTrj0x8wFibY/qTthAVhwtwNziSBaWfIrDDPSxKDKpNvWx0sFpXNNYf+Oaa6c5YTDmj4lY+vEFsQWcPBM7xTl4y7AxuHcNFzkb+VMTpwi5OfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShuDXug8; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShuDXug8"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80a18990c76so2911959a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790708877; x=1791313677; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6yNdfbZcjTIIN4vNDlh3MH7EB9VTt9wi7owC7nv+ve4=;
        b=ShuDXug8v2PfPSw7V6FPLltyNJBnpTok/utkgY9j+lMl8GU4K4BXeRuwbWkDCINwoa
         7zIUqmLGE+7OTIFpaQe9NWsVAp/Bm8x4d0gR1KDKOagbBhKul0Y8b22hHo4O+aImT6Ih
         h1GB0LHY6bY+cD8sUVtQWuXlw+u1xlzOcTxLdKjFMO1dRYXGMQQ+iRgaCwtTKmXygg0f
         HVV7zYiSwOPV1Tu0JRBjhFK5NBBV+heAgnMVDnR7yKVD3CmwRMihcTiek8mDSq1YUt/o
         lk3oNwulVEno4TweQ7ZgQuPo2fsMUWvCVkzwIdsbhVDMUQcRFsiRXI79I8g3j8Eiq4qi
         jkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790708877; x=1791313677;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6yNdfbZcjTIIN4vNDlh3MH7EB9VTt9wi7owC7nv+ve4=;
        b=IRz+rv7Qv3+6mTYC8D8TL4Q1dHKuA84PjVpgLyVvvT7gffCIZi5KHpSLtcR/9KU4j4
         jvEILGPyPd6Vxl+Av14afcoBqw8Fv31jQGVmo+yE17D16flBDBT7IJsJlcBFjPlySZQA
         pyVJsg7jVQNnGWpNkNJhCHGZzRMIwzDHfDMQWpLL5b0Q2UsZyOn0UpxZNkkAFo3HgTE3
         9BCE7kwR1CSsLypNavKtJIvNs344OBynkZRO7iD7PdFBTMLm/tZSPrDf+kBeWHjU+TxI
         5QPXnO9S/dpIfsYPfnnoPXKBkTgqdNNXXl97eFfo9fmJKyxvn3dXArnrBhbt4OTPjwHa
         eyPg==
X-Gm-Message-State: AFuF++nU+6RaSv6+3/540fphTKd6VwHvM7MwoIWmyVEvKVulXrr9+umv
	iogtij3yeaIjuLkYRbH2V7/3J+mP46Li33rEmP/7erDpIoN7OQodOA95byUB3g==
X-Gm-Gg: AYBFou1c30qORPhoc2foVDIE+TRVpUHHi50XXOuhrcxJGMiQP4hoNSS+Kl+DheABYvu
	IG+xs4I/tBnce6uF7cS8N/B3zL/rloNy0gQfZdCxd2ga95elIdF32e28SRR0KPy1Krb+8HMaAPW
	b9u0l/uNnPIKDPzAK7A8fmH5wuzgJyoqmALZMi9yoiVVM9mqrJh+jmAr9UJPoCPgkKUZJvuohEH
	Q3EWE2jCRhVcBrObrQwNC/IdrjxLHup6h6g7DjbXDSx0UJedaMT6H5knq543XkPPR5/yT11rmxD
	sTeRKe5UUgg6RgPIu/qWe4Aim4NW99eYlaGL7Cp8EPSsPqaPEU49sxlEEcJtBUMlmyNmBdkbyTI
	27uCDyrL+9EEYUOnQbuicCPIw3KiV6nvF2iF2Gdf+gvreYgaNkKkCD2EJzP0/IDVX+GPssYqZy+
	amREr8jnWI64veGW1PXtv0OrvTF9+2Svm+ZtvjuwXlEBhOJj1R9PMXb+xjxRAiRB6HtODFufzBj
	Q8kjco=
X-Received: by 2002:a05:6830:81f3:b0:81c:e293:7d66 with SMTP id 46e09a7af769-81fd8773219mr307899a34.21.1790708877506;
        Tue, 29 Sep 2026 12:07:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.230.144])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81fb01d3a75sm771250a34.27.2026.09.29.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 12:07:57 -0700 (PDT)
Message-ID: <6abc0c8d.0e70cbc3.28241.b92c@mx.google.com>
Date: Tue, 29 Sep 2026 12:07:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3659188866598845425=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2] Bluetooth: L2CAP: Reject signalling responses in invalid states
In-Reply-To: <20260929154219.2366060-1-oss@fourdim.xyz>
References: <20260929154219.2366060-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3659188866598845425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176242/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      21.64 seconds
CheckAllWarning               PASS      25.20 seconds
CheckSparse                   PASS      26.48 seconds
BuildKernel32                 PASS      23.03 seconds
CheckKernelLLVM               PASS      21.04 seconds
TestRunnerSetup               PASS      507.87 seconds
TestRunner_l2cap-tester       PASS      23.22 seconds
IncrementalBuild              PASS      19.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: Reject signalling responses in invalid states

25: B3 Line contains hard tab characters (\t): "	- resolve the patch conflict"


https://github.com/bluez/bluetooth-next/pull/842

---
Regards,
Linux Bluetooth


--===============3659188866598845425==--
