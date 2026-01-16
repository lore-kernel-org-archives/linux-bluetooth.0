Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510923090C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553089; cv=none; b=Oq08f56PcolePwlU1s9QjGxTchZ1QwkhxJM9C4X//fdzEuDhB9xThRNdja/AWapdIPCdL5I02qp9Mh2gDYxUOhic4yyTeWzuXMA9Vbo8xQlAsxY6BowQaco8szT3K17j1eBY8N+KZtfobQtAK7MOkn+X7PsvOrH49UxK4BHwbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553089; c=relaxed/simple;
	bh=32tAHRFlR8ZBVDIIjnABwKaV+NmmmIpyQy4HCzb7Kjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rOOfZXqv+LlSv77AAkiphM0TtO0xki+rczIAucymGLpf7gNdK292jCx+2eZ6+3npYGZJLrzOPnh5ZXtxv3PQy8yWfrffCTyuwd/ILsCNDBM82u925KYewFs1P8rxPLobzRTg51Fd3rFBlQXdJCGjzm3wxbOUlXJdz8xtspq9bWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejiEbJD+; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejiEbJD+"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c52f15c5b3so209313485a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768553085; x=1769157885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gM3/oyJ8sQB3yDHWVBbKnf6xdbi1JVt/94GguJcsEM8=;
        b=ejiEbJD+VUu5llmhWryfWgYkNBUK3UlEZccDfD5xzaC2upmVhbx6blGP7ihSRpQBTD
         pMGIQWx0wMwTnfC1XLz9OUtG0r5mwwIo41XXmYhlJYMePXW7ZN0JtAIAUzMjr6oeVQkV
         YBCoBbEdAnext1QqJub3aUMnqhq0ZnRENQQyw+w/rRMhnoeWbl3OmO7GZdGfU6UN63eu
         lpC/ZrLyooSHOnCeXWpCShWSktaPbnnFG5HUxH/Mux9AWsQKqvrxqNqGbke1w/KFL6zE
         i7mrOBi0EZv7vxjfs1y1BWGhHiiAp/ROsDmZs0SHq1v/g71XicprxupMgNNjH+M+dLmz
         xMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768553085; x=1769157885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM3/oyJ8sQB3yDHWVBbKnf6xdbi1JVt/94GguJcsEM8=;
        b=tSTO89oilsEQaEWANELYm7QtzBQgMz1HFOQ67IALihiZ8jODUPYc/fTRSRgQzKFr3o
         HNAU3RuFxg5uS9ga03sH6bvye0a0jnv/eQv8iKMV8Motlhm1FnxWudfvmKyL9wdIw77V
         Jvex/ycakXnfPEUi5//HmsWKyXr6y2nTJ9xTPWMWNkjZsfUIIesG9reUI0MAtVrbjIlj
         QJAsINnGJDTrAhbwQ6Vb/dQWfMuISTTKXIaAMzaH9UXEXDH78JOsnENUydkWcAtQBepj
         zhbeQwYwjNQyPLY14IYv5MoU8DW1XAbWZ199HbeOb9Fu59eNQ2oBkwi/7Ho69RsTTTo+
         BdSQ==
X-Gm-Message-State: AOJu0YzPSeMde2676CUB1HE80d8V8U5Moaxie7qyEdO0ZGVBY7DJnaRa
	CB+o1N6Ql7LwzOV5FftihQB/ON3p0H1WbrCueB2EOKFRTTotGslclPhM25FRBbQs
X-Gm-Gg: AY/fxX6Di1QEVT+YIL6/uuai/OVSnJ6sbDc4DbI80aKQ6CxtAN4ymN1USyIKhaHkGkN
	lLfrHPv8sAQ4pUs342cAL74jIpOgGc6rBR3c1pBOt0HQLhkKGf5NS13Gnl3xpQ3QvQ3P6C4z04w
	0MWANVlOERGfKk6jFG6CcMYuxulGrFcjUvt+KGhg7S8mxXbKjcAqPz2FB7lvqRO50O6LQjKSSxw
	Re0hmYuuHZ+Ij3wsUlOTRusX+qPKxKDXZg1bqzN2OVp3PCgT5Z/xnXEwjpVaKWoD5DG/Tlv8BDx
	64Tbjhx8G0vfqgy303splRwp4KRwgJFfbPzmseW/isUClFE24YpLxU3bmQqBHkcxAXShy2TrRan
	lAoJm3v66L2O76n/8JaaH3NeR0JF/ymTSCfZaaSLPZ/+cInUHlP0Z9dT23OD4XN5OyBmTPx2GN1
	taqDG81i0cpUjsYBF2
X-Received: by 2002:a05:620a:3f8a:b0:8b2:f269:f8a1 with SMTP id af79cd13be357-8c6a67a1226mr232283285a.71.1768553085339;
        Fri, 16 Jan 2026 00:44:45 -0800 (PST)
Received: from [172.17.0.2] ([172.214.47.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c06e5sm176263885a.16.2026.01.16.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 00:44:44 -0800 (PST)
Message-ID: <6969fa7c.050a0220.174505.e277@mx.google.com>
Date: Fri, 16 Jan 2026 00:44:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7348889427394182913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nichen@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: Remove unnecessary check before kfree_skb()
In-Reply-To: <20260116080703.379903-1-nichen@iscas.ac.cn>
References: <20260116080703.379903-1-nichen@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7348889427394182913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1043182

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.25 seconds
CheckAllWarning               PASS      28.52 seconds
CheckSparse                   PASS      31.89 seconds
BuildKernel32                 PASS      25.37 seconds
TestRunnerSetup               PASS      559.50 seconds
TestRunner_l2cap-tester       PASS      28.45 seconds
TestRunner_iso-tester         PASS      64.52 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      126.56 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         FAIL      14.49 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.819 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7348889427394182913==--
