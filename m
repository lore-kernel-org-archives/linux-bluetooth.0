Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629825783C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711755; cv=none; b=LqUksUVPXAkA+VozJGhIrFGNlmQa/hbiYkkxBdp+shFKsi7Bfe1uCm5JVWl97D8Mgrn8h2+Y6XS4HJPEzmnrHQWMqWOJbI/kPpwhRk0Yhlc47DEI7Dk2OfIhHS+1zADLpswoQ7tWQy0TCq0NhswmnNoUNplVR6rot5i6jig0XBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711755; c=relaxed/simple;
	bh=zcT+swDnJpb3D39psUf0Qe9afSEhYqd4OSOoxiTPv0E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bnzdQFS/owmYR2WBXTYecWCWdCuHf09e/8yfz0W7Yw/iqzN9reJRBUtzRmP/IjHHyx+GcEG+5ChbQ8Vqya3ZgOXEOgcqo/zdWU1HFHuNm1sO53J57d+cS002ME968XjHXIOEAktP6YYzweWnrsN/ttqdna47dcnXLZb5X0SMrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3JjzLyv; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3JjzLyv"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d37f94so192854a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789711752; x=1790316552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=il6DPxbYBRmLPiIwxy2Gxn2XsLBvB1XLdS/SdecVGPY=;
        b=b3JjzLyv9otXG0YG2TDZIRrpR4EL3q0iJcTpFAIG40ehpM/37lWQdL+MDqn2P5ozAo
         pyjSJiGqV1WQyAMptQZuqepzuwYdzoXWHpTV6KJeXd4UPb3V6ptF/3U8iy+DYCuC5EBy
         qVog11xD5vJCBz+EIpabYzJZ23jEdkSjtQTdfGRCEmGSo6HVvNJzB/USURq5kV1t5H7i
         y26q7PtPkOF61pJDCN1dPcojnHKtLojpOlCEkav/QHoBbdxoHNqtYhj/dW8ePqR+gxUR
         Zu6e+FcmHMJdzrGRtAp02cV1uTxe0q+UKtA9M/G7rnZgsYOSfPixdfNtP/ewrbYJw5Uf
         mjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789711752; x=1790316552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=il6DPxbYBRmLPiIwxy2Gxn2XsLBvB1XLdS/SdecVGPY=;
        b=Htjp/eU2lI95e8LIO9wG9bs8GZu1aAD66s6eNqnCefTCZO5327bALn2K1XKwl/7YXt
         F+CRDV8zUer+VcLje2nHAqsg9SocgX03KwVXE0aKmKJI7QnXoew2xyoQAUHQEggA0Jmx
         xgK9g0RYao2vEAlK/wQQn0C1fk7srqbqXioK3L+55rMLkFUXJvfg/k2veMtx9KTfpAeA
         7gHpq0XzyktyJn63M5lPRzKYzDQHFvB9zmZjeHISJX+FfLaU63pMRjW3tJihuhtBd2Qd
         2SruASRDytqi8oOpWGLCyiB2M+yQRxDSM5Tibx7Y3fBPIhI5qy69DabWWrgIq3EKFJ0s
         e1TA==
X-Gm-Message-State: AFuF++lLC00AFVt3ngfZOQ3yONKS5u7LNkUzYqq4doOse9xcUZBgbpEv
	CSN4Ui8fpjwDcCw+0BKgTUVSXLqaLY0qjix4eviUb0b9GayZhdapebt5cx2bnkku
X-Gm-Gg: AYBFou2+K0bLgv+JsbahxcCU3vQOjFwb2oDgpi2554ZhqVw1/dOXVOhhIv5ZJ2Nrdqz
	MVEkoIPZJmyxceVBEd0xIi3rX5RhjmpgpKsA3zpU3lPaNquygw9p70IXXrmla2TdPS7w0ioeMSz
	qUZ+B6faxEl4KQCZK2+hXK/ZFVRGu2GLvlxXgdmFGt4mQmKCvdj2G5QRdl6PE4SWqUU/dVJPP1/
	DO2dhRL1pxGEsKEcuzp73zZ9WWTQEY4e/yGNj+eCzwXiRgpx4M6o06d2xttKlJX9HtGN6N/ZzMY
	Kb1fPdVaD1GoGuZylWiJS19I3z7EreJ3N1VF70rfXup2vKhbn2+k4LP98XJuH2jsJrNYKuYuxN2
	SdX2x+/TQNWvXBijxcwEErHQ0REtim4stY1YIoS9GbH7xDbsQNrcL/4IeCwlE2h9OkX8XSjSOFD
	jX0vgRf0ZoPn0Xu1MVAN/HuQ3LmXIMkVLKJ31Qra2fPcyQ0U/avRr5L1xhZNLmhguGzaQteUlFP
	W+ohJk=
X-Received: by 2002:a05:6830:25d0:b0:7fa:5c49:5258 with SMTP id 46e09a7af769-80de3ef3732mr1799362a34.31.1789711752619;
        Thu, 17 Sep 2026 23:09:12 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e51d5ff0esm592800a34.16.2026.09.17.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 23:09:11 -0700 (PDT)
Message-ID: <6aacd587.142a58de.228d93.786d@mx.google.com>
Date: Thu, 17 Sep 2026 23:09:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4970233939097895636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xujiakai24@mails.ucas.ac.cn
Subject: RE: Bluetooth: hci_core: Fix leak of request command on tx timeout
In-Reply-To: <20260918013501.1851186-1-xujiakai24@mails.ucas.ac.cn>
References: <20260918013501.1851186-1-xujiakai24@mails.ucas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4970233939097895636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168176/

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      28.35 seconds
CheckAllWarning               PASS      32.12 seconds
CheckSparse                   PASS      34.74 seconds
BuildKernel32                 PASS      28.23 seconds
CheckKernelLLVM               PASS      32.98 seconds
TestRunnerSetup               PASS      726.33 seconds
TestRunner_l2cap-tester       PASS      16.27 seconds
TestRunner_iso-tester         PASS      26.55 seconds
TestRunner_bnep-tester        PASS      3.21 seconds
TestRunner_mgmt-tester        FAIL      59.84 seconds
TestRunner_rfcomm-tester      PASS      4.94 seconds
TestRunner_sco-tester         PASS      7.53 seconds
TestRunner_ioctl-tester       PASS      4.62 seconds
TestRunner_mesh-tester        FAIL      8.18 seconds
TestRunner_smp-tester         PASS      4.28 seconds
TestRunner_userchan-tester    PASS      3.58 seconds
TestRunner_6lowpan-tester     PASS      4.35 seconds
IncrementalBuild              PASS      25.94 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.031 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.451 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/786

---
Regards,
Linux Bluetooth


--===============4970233939097895636==--
