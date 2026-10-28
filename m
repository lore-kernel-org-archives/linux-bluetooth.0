Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186929;
	b=hzwsEcqQwhBAMWTTL4sZVfHkR0IDzNOh/uqZ5D2t21msGfgC1G72PWH0qxAZGpgtg6/T
	 4gbH/Mrxf039iJsSY69Tuow6a0Xtqfw5hjkhexoftNpqPTj0t60hgWHm3qGfc6JChi8VG
	 xx7KJk/iFd+CnKmOWsIlmplV+PNUreDiHT+K92jn/5g1O2vLxIxUzdAlCZxscN/LAuFC9
	 4knfljv/bsCpWIYe6INJt5sypNhcqEnjN+YRwdJYR7+1aVeToM3Z4mYYKIIg9kv6CsPNj
	 lNY9f6rgj236QbBt0KouJ9HY5qIkgfJPfewoUipCB/ck+BMRncmzs89kUqOOx5mS4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b3gzD2up4gjAb1Jtk3fDFzJ8TtAACn9wfM6L1iLt0fI=;
	b=e8tu/b8uPYsMfmQKOzPGSxi/YG/X683zmjXrSrjj0TOT4sBwvBQXaA+On5dTWmI6Auow
	 4pjufb/8d56arzJlUvICutcGeAEtqMyFOaP5r4skvQvWLY66E/nPFcV8lG8V8j5UIJ4Og
	 ft9crzMIOSPyS6p3I8KCVyMXN0CWMgEcOLGwY8KfyEvXdcJXKA4UqkXRRUrRZsxpuL7rw
	 5jv69kNS8NSRV4SqSXcazD6gUZztOEoX3xF9zbS3Q/385soiDB24iWkAzr6SRxZxMmwgC
	 HH+HKXxpJtK3O1GA0r4N/MVdTCrYhYF2NIbpHVVePKVJaPTFbPZDdZ32p4PPmU0tduw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yRRb/+f/";
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1B606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 11:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD1B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRRb/+f/
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso410735eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186928; x=1793791728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b3gzD2up4gjAb1Jtk3fDFzJ8TtAACn9wfM6L1iLt0fI=;
        b=yRRb/+f/GHbjucmUWUbgorMKVdHBwxun+pFR44ibwePbqKCNf90nGtwD2AuJqyB3cn
         4eYh3bmpMG1yG0FFkx4lbiwMdAVxbbkS6Ni/JprVqM0YNdLbrJl30rSvnjwSu9MRPBhF
         NdJmVBXB5HFqDOFnQLFELrv3pTh7aeM54TcSmMKqcnhHnQud78UaLnp3NVAuQMZWXX9+
         +vdpBTHouLxHrSvNCDGnW1nRMSZ7HBds0nmTCNi84ZXnmELPnWBJedZQMe5l+gk0ytUs
         RzX3a5fbwza6kTqO1GNB/NZhdu8TYHxh1gHBy6tAWMkKZow9OOWQs80hJ64d0JpdbuZ2
         MK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186928; x=1793791728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b3gzD2up4gjAb1Jtk3fDFzJ8TtAACn9wfM6L1iLt0fI=;
        b=p/BsoIkRmYnNNV9M13/mEQcFfgajrXYfU+j+kcB9LK6pjVt5JwMwAAKUNCSqSF9VP1
         DqHd9D0uTzkRUnUjyS+WYsRgQaxshp56qqpKOPybUhGDHdjd6Z255CtqaCrrp/UVY7Wo
         X8S9MMvjrV0AgqP6K3HSZJ0E/d2mQnMQFwfiAqSWoNYNEPNnoro8NkQ7dHsUJFs+IcIP
         LvJM8oSzE3dyJ3DRg5Lb+gLCT/TYQs+VGQSyNfS66qBFIhD9r2LrwyVF4hT4Hj0VfOnC
         u7kAVoW7IudTJf8NV37tf9tDHj54qSGN9/YyDSldKiCf6GjH2NrUVjiTKlxRDR+5QodZ
         6kjA==
X-Gm-Message-State: AFq9FYKU/74B53W0XJjMJD4LnD+zoN38xaSOS5VuJ3rfzQg2lAwHPOTz
	Cat3k7xZ7j53Bg8gvI9DhUIJt7KwKLKRH2RHTc4m7ACyMMbst75KLnbfZOVtbA==
X-Gm-Gg: AYBFou0DRIkOSetUtoFFPLWTbYh8ez+ziqakP1Mtkg0ilH8K0Nkqx0wtlyn6Xw2EK2J
	2iTU5RU1t3WfSXRNdfu4S+lK/VtGpieUicq15OuSTSBuH+Z/ZMKoZZFcR6tWqdF6NXg6mOUROLr
	rY+Fuai/dFbAWSia4SdBFFgdtmFFirIptPUwEQh6OWfB44A9Qa3dKnAcbV5ABsYLvTDDR66c+OQ
	9onWCsk/izdmw8iQOLTBxi4HqzRag5z0dNcPr8Lnqg/65HkwN0gCr3beHKU89ebegZQgRUu+XH8
	BzECgz9hoALlVBSrr8CQ6csqaaBmbV8rj47atyxpCIdrRDSpiFoqu1pUGOFwqV4lzoNoO2sMOPd
	yAtfoPnhwR8tSHs0jNqalUsfy0hSVsXCsfzn/c+1/txQlhVtj/WMdCuu7U7tNg7JxIdFWaVScg8
	XoGV2fAB2wL5ZlQGMF5rrvZTlyGgxFdZYh6L5M1y5Yo05i94tig7ss54JPLgF1X2t+CrKPpu17I
	1av8aU0yRYKhP7A9zDDVv0zwgpOBhKVEoT3V7IY+w85mlNasKK9OmvrGQn9EQhy
X-Received: by 2002:a05:6820:c3c5:20b0:70b:afa3:fb1f with SMTP id 006d021491bc7-713ec708c42mr760109eaf.5.1793186928329;
        Wed, 28 Oct 2026 04:28:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.230.178.193])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1d363390sm1333881a34.1.2026.10.28.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:28:47 -0700 (PDT)
Message-ID: <6ae1dc6f.e9977bba.188795.1f87@mx.google.com>
Date: Wed, 28 Oct 2026 04:28:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7551861577095992443=="
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
To: linux-bluetooth@vger.kernel.org, yangguikun19@qq.com
Subject: RE: Bluetooth: hci_core: Check HCI_CMD_DRAIN_WORKQUEUE in hci_cmd_timeout()
In-Reply-To: <tencent_884B14762AC6B7F8489E13AEA94994BD4F06@qq.com>
References: <tencent_884B14762AC6B7F8489E13AEA94994BD4F06@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7551861577095992443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195247/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      8.42 seconds
GitLint                       PASS      3.10 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      22.62 seconds
CheckAllWarning               PASS      25.92 seconds
CheckSparse                   PASS      27.36 seconds
BuildKernel32                 PASS      22.66 seconds
CheckKernelLLVM               PASS      25.13 seconds
TestRunnerSetup               PASS      523.86 seconds
TestRunner_l2cap-tester       PASS      13.58 seconds
TestRunner_iso-tester         PASS      9.61 seconds
TestRunner_bnep-tester        PASS      2.78 seconds
TestRunner_mgmt-tester        PASS      83.76 seconds
TestRunner_rfcomm-tester      PASS      4.04 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.18 seconds
TestRunner_mesh-tester        PASS      5.05 seconds
TestRunner_smp-tester         PASS      3.98 seconds
TestRunner_userchan-tester    PASS      2.84 seconds
TestRunner_6lowpan-tester     PASS      3.96 seconds
IncrementalBuild              PASS      21.38 seconds



https://github.com/bluez/bluetooth-next/pull/1015

---
Regards,
Linux Bluetooth


--===============7551861577095992443==--
