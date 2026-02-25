Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C818872A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771993521; cv=none; b=KKZ9SsG5cMV6TE7168j+FhOro/1cwHz2GhvS3refRZrwxXQmt17YwH8jqlvbCkDiUOER1rXmSiOjo9EuiU6+0vSpaMFgl7kJ65qqoFXxB5sHKLAnlTK9k7PvU9rNIOQpMR9Y84gMJFjQOReZKCAEn1TMQzbNCeFAfLfvqS+40eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771993521; c=relaxed/simple;
	bh=XnQ9AbqMYGWzi5l+6r8hJeE/54ENXthxBZw7qi5ZqrQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mDtywUuepoeWG9QMBEwfp+VI+YXnNkXp4+4pxjvcpTJlkgipA/sJc9oPrHN9I0jqQ2h50I4a6xNcjywgpUwW5n+mx26mn01FfgmrXUjvdWztoffMQuTXKu6enTDCexQTtrlAlJRWHJpzvpvdtTjijC5lzbChy3CPJdQ5B5uhdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whu0g3ur; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whu0g3ur"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4c65d772cso5861432a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771993519; x=1772598319; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=03n0EOPUdJHoEPWm38rjBz0TkREw+dY6NnWT+9j2lIQ=;
        b=Whu0g3urok9pd9C8nNdwLKccCEkSgOPRDH4yCSbFVHVM/2xJh0MpOFCSCPSmhq5j+c
         NRfsr+JOchXK3XfyCy/BVdf0BYX9mXJNPnD37vvl6jCWa4+BCu92XsrY9pK7fk+fvvrw
         BK8HYAJAIAlwvashkPZ9JxtWdtdN2gWlckj+spdNnuw/xHeRMhVSJZUyEJPHSYeapKKR
         3Yd4KyFbcMSS9WXTaZ27+z8xSPloos59pdr8iupvTt3fHRxhWpCYC34xUIcBUo2Z5wyt
         TZZ08ZfMUoRXlGYCxjCJgDJixN+uZFPdZuEbPJCnk85TXZ/m6QTpDKxrxRa88E+mvu4s
         xQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771993519; x=1772598319;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03n0EOPUdJHoEPWm38rjBz0TkREw+dY6NnWT+9j2lIQ=;
        b=h8ViXGPOBJs+gi+VfkMLbXLKqeFD7WxWj9DXBITDR5zInUyIt+ZSHMkQKjEwGPsMr6
         PdasXWaweN1Fuk8lpw8vD9uDbv7KeYocEa1gJneBIt8AammpEYojxUmq6A8a4b0ut9vx
         aSSl9hyGDkPm1sD+1uezEGDDrDEQugtjQ1BdhC3vz0YfGd2rK1mhyvqDacV8vJzYW+Nd
         9dV8A7AsT/P/RB20+2U46Fm2o9VKhrFYOMcsWsDxFy5/bb4AAAKkxemQfQFjq/Lo+v52
         /TMaIHmD0OGNdwvn5dGTl1tvSyVI34vDlmGwB30Dxchr3YV//nU+0g0zNS/S9j20zCex
         b9gA==
X-Gm-Message-State: AOJu0YzY5ZYRq2wTJMLAZQ0H1jcZ05wL82s9RbJK3Yvbi5xwZoD3WBSS
	N9Vq1uadqGfAijLK4yZufXCcaL80JC6Vf4nbGhC97pXBu5iwP4KSz35uvNjqXJaV
X-Gm-Gg: ATEYQzx/l0dBW6TEUGv3rk9EPqm2WNj32eZsSElk7RfobWJxY0cSn7SCL0jScG4qyuA
	G6ygXdH2/xd2CEuVZwZ1yHqEo6iSbUzWvCDiAOsH8fAbNunvBlXA9vnTpXg6AZjN0vQtCbxxKLs
	PeJ08bzJR88zY2wIW9AFH/3LpMYzOwaoOjTe8KiMC0t9l0rvXahVcGNvhXxfT93pr9oZP+Lpuyv
	aZkJhS3rouMPOPNB50xwZHWYRgmK2LjJsvi5a0UFV15XSN2Wx/lA9J+epC3BfssFbF8HVigvpI1
	64VbgTCJynGgbsx9TheOeZqJ7YE5X8pohaMBB6IBf4CVRVpDmLrVCxKC7/3FzdaLEcAF9+WiTO3
	pdTp+O/hWSNNZBd+KaFtDeGiwdihPKY/U5NtQOexm858TQitoQ2K+CyiIPBCRWhyjSSGFjgQF1y
	7fU/qiWfOyCPuaZpSUuZNsmpMUlvs=
X-Received: by 2002:a05:6830:730c:b0:7c7:2c63:f2d6 with SMTP id 46e09a7af769-7d52bee4aa5mr11073218a34.11.1771993519069;
        Tue, 24 Feb 2026 20:25:19 -0800 (PST)
Received: from [172.17.0.2] ([52.154.21.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf78e52sm11659958a34.2.2026.02.24.20.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 20:25:18 -0800 (PST)
Message-ID: <699e79ae.050a0220.b4a52.3afa@mx.google.com>
Date: Tue, 24 Feb 2026 20:25:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0917503093269324080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ericterminal@gmail.com
Subject: RE: Bluetooth: HIDP: reject oversized report descriptor
In-Reply-To: <20260225013527.17605-1-ericterminal@gmail.com>
References: <20260225013527.17605-1-ericterminal@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0917503093269324080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057473

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.05 seconds
CheckAllWarning               PASS      28.17 seconds
CheckSparse                   WARNING   31.76 seconds
BuildKernel32                 PASS      24.81 seconds
TestRunnerSetup               PASS      558.37 seconds
TestRunner_l2cap-tester       PASS      28.25 seconds
TestRunner_iso-tester         PASS      81.34 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      117.13 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         FAIL      14.81 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.73 seconds
IncrementalBuild              PENDING   0.89 seconds

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
net/bluetooth/hidp/core.c:1477:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1478:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1479:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1480:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1481:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1481:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1482:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    1.887 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0917503093269324080==--
