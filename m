Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76E271260
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903812; cv=none; b=ZLCeVrowB6lB0Q+yrbLhNccVRZLrCTpINLE3x5zsiGRPIchg9JYdbkHiTO4dmTsgrkQ3XUkvkioLvF3uwUoE/Bp5eY1v5ZaOHqeOWO/9InurPbfBRXWflI1E6RXqSqqQPQhEWO59fNumhD2VvW0w/ByIdcz2jxOVLf/NiC4WMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903812; c=relaxed/simple;
	bh=HxOijWZA/5ybVav6lUGtJ5SaNz1vlcU2wjDP85vMP1k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QyQSHDTPQ/S+Cc0Z4MsW23r/AvJbwmCnNBdC7n7O5HDJUXOglRsQQ2SMALYndFHASm+ght+GpMDfGR+tH2QaSP+Qo8k/gIAeuga+d8/+R2LgpnFRhGPKaeJbk5yoiWeSsGwEbdfTkU/73jbUGSazbeqRSTESkcEXJ4sqJAW3b/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY+L/l/o; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY+L/l/o"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e67ce516efso19733006d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739903809; x=1740508609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bxsk+aP1yuHzYXVl3sXI7H0ov0ocRTVL7YpllS9OAsM=;
        b=kY+L/l/oRfhMewQao/On3MSnaJlk9IzNvnpbe9QDNbLpf7lBwlRnIyKUxf9KumfD3C
         l4w9bQ2I0uAxKALHWvd6WbsnQj5eCEVrSH2GshHqYl2CplQmT7ZVkmTVF7pDeunGr2M9
         7qJqqd9hJj7D64wluWMQYfX7Xb1XuqnAnZqvpDdBZxZYolWgl49a/3icOt/jcQb3o4+t
         ADuaTTTLvxPMMFxcsbRmMB2cMGT+7Idt2h2tPuiDxWzjiTHI1HGuzU7rssRvyKuFjiYz
         OddRFU6aMJWrqKijrp5btguuld99mIMY7PH5kvuhmioSWZKLbQfaQurNfumZHeW1wkib
         1HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903809; x=1740508609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxsk+aP1yuHzYXVl3sXI7H0ov0ocRTVL7YpllS9OAsM=;
        b=GLg5bHnXLjIDdtnWzg4MBZD8dnXu4nn40xE/X1WT+DuUq4YmfZy+mCgJu4iKn7ubYc
         sf9WCa0igvpPWndkDjyxzgAvsQzoKZvYbZn0blj3atZFtA4js3aK53DKLODSlFvwIfXQ
         1wgIl+A04Zy4VasBQLGc8aX/l7sUy8A8PrWhmul342wXr2IlZKETdPgC+AkHb89fAxYI
         9afw3ViguOTXtSaj7bu1En+yse/2cmEBzjXase5qSlSCcAKOn5oUuiGFatCBB7vXwLFr
         egIqb7qKQAl6eoL2C16Ugc1/SXv75ie7OOY1T0ctjeXuvkYqOFsQUu47hPeH0nWAxNBG
         1Seg==
X-Gm-Message-State: AOJu0YxPZgf/c9oloe7DRNGK/of9JiQB4BKtBtwOiFkZhF88fzyhT4Eu
	IYcl/boMP6L/pk785d4JN3QfKt2++onUYGIg3Vr56p/l4MbSj26uREy5jg==
X-Gm-Gg: ASbGncu0Uxnz0NXqjSgs9eBtCFe2e4grdQYycTw5+EhOfuZ5pR/tkMFyORufctRzIlF
	or0YntLGXkxniUK7wX0We2N4BrV2ICHbK5T1S2KKM8V3w06OjUxgxrYyBYbaXkmBbOZaUAiTX+H
	y82oaHP39TfNldnh/67UzlySNqBRyCZCWqsn+NRSi8Y0O+x2A4TEWNRzfd77Gmb1lN/C9+VJiUE
	IGbXBItLvuHVD2EuK6TPj980mYaYBWnm1oHfekbvYi597l+9JuZxnUw2l08MrgiLmusm796IltR
	06gI2NYDxLR6uwERSeqx
X-Google-Smtp-Source: AGHT+IEX306uqHBXkUJchf/wYByqBbgY4TDAnwZOSrdGLOMW3SrV6zDJRddJG1WWvOzykvhJii3AIQ==
X-Received: by 2002:a05:6214:240d:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6e6975a4497mr10018746d6.45.1739903809021;
        Tue, 18 Feb 2025 10:36:49 -0800 (PST)
Received: from [172.17.0.2] ([20.57.71.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b16072b7sm62915785a.98.2025.02.18.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:36:48 -0800 (PST)
Message-ID: <67b4d340.050a0220.2e3cf1.4603@mx.google.com>
Date: Tue, 18 Feb 2025 10:36:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8221226562866415993=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
In-Reply-To: <20250218175123.1479657-1-luiz.dentz@gmail.com>
References: <20250218175123.1479657-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8221226562866415993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.30 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      30.54 seconds
BuildKernel32                 PASS      24.03 seconds
TestRunnerSetup               PASS      429.73 seconds
TestRunner_l2cap-tester       FAIL      21.09 seconds
TestRunner_iso-tester         PASS      33.18 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      120.41 seconds
TestRunner_rfcomm-tester      PASS      7.92 seconds
TestRunner_sco-tester         PASS      9.64 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        FAIL      6.22 seconds
TestRunner_smp-tester         PASS      7.21 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 61, Passed: 58 (95.1%), Failed: 1, Not Run: 2

Failed Test Cases
L2CAP LE EATT Server - Success                       Failed       0.137 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.108 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8221226562866415993==--
