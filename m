Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31509262A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596479; cv=none; b=d0g46qZucF8WhA7oiDd8w+qhHZ+EYTjD5Oi9OdKArsrP6nl01ShMzPjcC+xijSg7Y4uG7gIXdD9uKEDxnH0PAjk8n/xBgzfaRFMkIjXNckkwHcFBKhUR+RK63QcasKgtKbvayoSLRaHMo8i5Uun1AqsyJaD39vMEZ5sywd4uvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596479; c=relaxed/simple;
	bh=YrGAnM5FWpje4t+lXAnl4kWVIYxMcwdGV2CIasfroNo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JyHoX64N1xFr5G84Bp3bWj/9hrOAUoZUcexNPb+BILMHEPqrTlFhAfC+KhWf2Z7kpefxb0+IOwOsgW8QmSCfX20FMYSihe+ge0Sq6cXh4dYDUQk0r7D4BNQFzKinXXmH5T8h77raJdCO6Uo/NImpGiq1G6PVFQF0ldV5YPM9r44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7+y9t+S; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7+y9t+S"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46098928354so4395081cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731596477; x=1732201277; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff8zh3Z1xg0rwl6kU5FZe+S96apHEoGDf4yI5QwLqmY=;
        b=d7+y9t+SuHQrxqAZ9uKgBcpW4IbdMrv6fwtlJsAdQ1rx7SrWEsAdg9aZepULT6Zuvt
         PetQNH0P2t8EmfaNETBpyA5irj8cbT4zSCNlRqtDJwJPgKSCblo9FctA6+QREVtvJ/fQ
         tOSo1Bfrhbq+MJQQUZ7b5VOYVGBB1xbB/sBdhDKNruRMF0blEvp2csc9rpwcf+9BPDs4
         GSn78tqbnRFjIuBnYby1ENHKTLY9czuVCSj4PN5ev90ZKdAzrSQXmAF72sesphPvbqSt
         GMIiDOg4oSRIu/UUCtvqieNt4+yUNraMgwUPfnn/LIWFlJusIyKXkGw0LuqSKZwtjRar
         gB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596477; x=1732201277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ff8zh3Z1xg0rwl6kU5FZe+S96apHEoGDf4yI5QwLqmY=;
        b=XoNUlxOoQ6rt8O1ceYo1jB0Ml81fsewVvyzhdHVKtbIT+7HXec2wqO0fVMByZAQ1c0
         2tS2Rtl6kOLZ6wK6FUY4WpaZAXNWYZn+ptlL0+AY9FW+AxJuFWmlMWkuqdhlmKXB67/D
         4IBhIbvORN51uaXjuDW5d4An2qoqYqWgQmnlP9M9UxPXWxMZPsldXVEg1w2eym/L6ZUm
         lAnZES5klaWZa7h877554cqD75bP9dsvxGkWiV8FqHBJsRamff1q3koBtiBZ0XRFmMVe
         4mV7rfmt79lhB4rsximGCDBwDlRBGWppwIqWwKDvOS6heqNxm588wrSBjTcINBer45Iy
         Dj9w==
X-Gm-Message-State: AOJu0YyP3A8oq8AvjlO6gmXysfBTdW6htJHn1nFvJY3TFa5yeEV0o2m6
	V4mCRRm87EW9qYp9EDB9CvBxeVkabk7F0Q+YZYmh/op2trZokTs6qhXGhA==
X-Google-Smtp-Source: AGHT+IF/LwI6NN9pGXjXHRXddTS7bIsjsLmCeFP+Snfshfj34KVh0gVHSFuB19e/a7uP8v4KvjVC/A==
X-Received: by 2002:ac8:5845:0:b0:460:ae0f:470c with SMTP id d75a77b69052e-46358ff273dmr24728641cf.47.1731596476751;
        Thu, 14 Nov 2024 07:01:16 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24f73sm6355271cf.61.2024.11.14.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:01:16 -0800 (PST)
Message-ID: <673610bc.c80a0220.31d1ad.2c30@mx.google.com>
Date: Thu, 14 Nov 2024 07:01:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0615246121835236279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: fix use-after-free in device_for_each_child()
In-Reply-To: <20241113160949.1325502-1-luiz.dentz@gmail.com>
References: <20241113160949.1325502-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0615246121835236279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909346

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.59 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      34.08 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      449.74 seconds
TestRunner_l2cap-tester       PASS      25.07 seconds
TestRunner_iso-tester         FAIL      32.59 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      127.95 seconds
TestRunner_rfcomm-tester      PASS      8.19 seconds
TestRunner_sco-tester         PASS      12.69 seconds
TestRunner_ioctl-tester       PASS      8.48 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.92 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 119 (96.0%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.238 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0615246121835236279==--
