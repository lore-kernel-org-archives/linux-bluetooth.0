Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962D3590CD
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579578; cv=none; b=rtRxWDUn+lRy4eFd4N45rknpROf7YLdduqQHtc88Kb6tl3Yq+eD1Z6JrDLIrhuJM8waiAtrlWMcG7CBZp9ZeFa2upYUJIn0gG7iTjoxAsTcpbqq9TpTSm648fL6lM0nE8a5KiYjKxv8V01oK5t541wTM9SqmSgwZw+IFnik9oe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579578; c=relaxed/simple;
	bh=1hxjwvZzCSV0xM1hsqlZmxpx4oPNQzX/Y++ONxFYVpM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jb1fz0rsIlzjdH6txshTlVLYK9hz7ZRry15HABgbXXgLnWFeV5nRSOX7Bsn8ZdS8tQX/lc+Q/q3NexRUuk7kZ1q4VudPfThN+f2v/34Dk/uyHp/orheWFq5BQiQuy6jnD99b0hfPgRuPowi7ZXnjDuDv5xd7AjHbNauZvNlaWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCMIppsg; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCMIppsg"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1274204434bso2907982c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773579576; x=1774184376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv0hhFRsnnBKn5NZi5k3zHs7XPwt7Bq0zesk9mWS7fM=;
        b=DCMIppsgGG5Rvy5YRWddlmzcxluABXGihIhzBB2k64R5QwF1ngVMCYm8Yrb/LdcjKK
         HCJwzTJGdBWC/NkEvwYxZrvt6B53LVCwbPgUMu4/CVNVZe/ddaZ5dedzZHuYqr27oxQX
         WS2vPbJ+8fk7eBN2kyfTjgB+Sp0vnE22jvS66u2WyLlsc2wLQ7gZqWQjateZ6xe3ypIV
         2zs9s9ObpGkJatkd4enRV3PpGzZJKU7TYWaQDywqIwYXA5kr5eXt3kQff+k9GNvejgWL
         vnyVIQzqFCej/JERofnPVSZZ4JHn91AFTOhf9uy+L4aIFA+K2Trndw2Z266+N0YYKDrT
         yQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773579576; x=1774184376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv0hhFRsnnBKn5NZi5k3zHs7XPwt7Bq0zesk9mWS7fM=;
        b=rrzZcc3K8NsRwAPkYSgmZL6Mev4L/U5bX0kZbAGvFv5TlENn+ii3rvPUuqUfhWWFFQ
         KpUxRdOHnYlWggW8X+vXQFt1jB9Uu0mfwQmh2QD9vaocSpCT6nfXH6j+Fr+sy2WgrWY2
         7+t/raoVABySpzvRhaohxsWmlDbXnTyFEaYd/XHs7EJNp+Bx351dCjVwWGbb6K6zgTBV
         GZUO5nauFONZnxNGTHeTeOCdzjPCa01BdatOwZynWxmvzveY+11l5+l0pJVZZ2i2Ot3o
         q/2ZXWthvAKG0Dg7b80TgkLahHAzVAgQ30gxwzXwDUj2LOBikFWxP72/3C+lqXJ7BQGZ
         D6qQ==
X-Gm-Message-State: AOJu0Yw6L5HOXQssE2eMVQtOdXzUye0hGK4Gk8iLaGLE0cH3Epvj/Hxx
	bgfFxJ9IPn6qbwWWLp6ZlN3VOLdASJ1S27SqOvrrjBKBLa9WhdH0bXsX9gEC8g==
X-Gm-Gg: ATEYQzxMC6NaRLn+HFE+eEaOqfwLJ45DbmzocIBwcbf+qvTnZ/ZO8lm22mdKcb55Fbo
	MdDVGLjqaAwZ0So/lYaTHTSL9b/lkMuuFJP9x3FSch8t93Z4rTvDJDhyKwBJEy+KO2afagX5o2q
	/b9HazdTiwVby+PQ8tulWbpcmgghOIdOAfIDrriEIrhMoqEOKEeEi9gEZvY5c5m99TrDktCsOfb
	ozBKomYNtlHP+4EthBsO0dORmStqubdTibNseUKoFCpjx8DoosnCtQ+6dp/1KgIqp4mAx9ocXFS
	3oBlp7Xs/tZeuPV6A5Ov77ULDbNscXbBkTViguHtF3b4Rc8pXLNwOoC/9LmOxEFFSwUwjpwqYp6
	SaPQL3FcfRiIWGrhvCkER1MZd5P2Mko515ceeOEzfiKhvZeKbrLIg40Wv3DfYWYkdAqSVMjnE6N
	cl/Hvew9XR2MhTbOJK3+rWfCuu8UM6
X-Received: by 2002:a05:7022:b8c:b0:11c:883d:1ef0 with SMTP id a92af1059eb24-128ecc046bfmr5469169c88.15.1773579575941;
        Sun, 15 Mar 2026 05:59:35 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62991c7sm8672848c88.5.2026.03.15.05.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:59:34 -0700 (PDT)
Message-ID: <69b6ad36.050a0220.c9dc1.2775@mx.google.com>
Date: Sun, 15 Mar 2026 05:59:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1506307777258692752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: annotate data-races around hdev->req_status
In-Reply-To: <20260315120726.2772382-1-zzzccc427@gmail.com>
References: <20260315120726.2772382-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1506307777258692752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066895

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 PASS      3.89 seconds
BuildKernel                   PASS      24.64 seconds
CheckAllWarning               PASS      26.45 seconds
CheckSparse                   WARNING   30.04 seconds
BuildKernel32                 PASS      23.95 seconds
TestRunnerSetup               PASS      521.80 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      84.07 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      114.52 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.55 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   1.07 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.867 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1506307777258692752==--
