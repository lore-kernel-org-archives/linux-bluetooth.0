Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBED1EB5D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333499; cv=none; b=gtzN5eO9NTNvkuA4wUbxDooFZ8Tt0RPy2y+NtVie0/4OPHe+joW0e57Aaq8exjIWXIPyTt4fznFPiK3Y33zQNqkFVwYJCFpQ5ybLmvWt1lLT7bfvlMEp+87ZJFsY7s1uYrXQu8L5h+rhwYX+Fyc31V0ZCKtUVzQk/ZCQtLd153w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333499; c=relaxed/simple;
	bh=PVk1YkocVJ4fS/foSyRW2V/f+a2/aIhx2v8BDRszkwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e5aitahBDSOC8/1Xg6flW/ztB5Qht4IptLb+BXO1S4xb8Z2wkpIyf5kxBtxKsTGiiiXbNpZckVzKyfaUZ8cEFxfGSuNdfZRLDe8k0MWBH1wCuyP3XthjbjDN2tk8qOGo4zPLRM+akWSNoxhwjasnpQQZMv0BkNTNMXnQU/gadXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahJwQwxY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahJwQwxY"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso6992776d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742333496; x=1742938296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dogou2TjTJvikEo1ztI/pmwUDz/hvDIxt51iPK8esno=;
        b=ahJwQwxYVssRl8V+iSy3Sfyh+Fhfigthud2O3cBScTSNGB1Zsfnn5mdQvZGfYQ0803
         jf6l6/J5it4EnygNYC6ceeLEnsvfck/f5NJnFfomalLyVMMYVJr6dNZzHvVr9iVfT503
         9pH+JOgGdmk4kon7U5E/FEXP0AeFiiWjwzDdaAnNFmrZPCPbx6qF1cpAYNGDEZ2re0BA
         Xzcf1cbGiIu0e8vyWnSCMKCLeo5F8ByaJOc3Ezf4L+IZSKK123dqyGG/3HzSxNVIIgVf
         knjZ+8/RfZ8fAORlCiZygaZwZ+6Ci/UCaASIFXFb6Y97HzrAI7HUCyOl1ujcVQbIsnQZ
         g1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333496; x=1742938296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dogou2TjTJvikEo1ztI/pmwUDz/hvDIxt51iPK8esno=;
        b=eB/Jvj3hWS8wRfvauXNQD8EZopdKxxKRZ0/BQcvGxIi3PsuxX4KgRoGUsIZ/UpPO8I
         DpN5nt85+hecz+oJxlLgjkGNjwhTLQy4EZ87SOAooICxPuAYp26Gv+OHxXj69cKuK2nJ
         /TgzNyS77xvsmwJ/1XKsJ5oU5bPzonIgbJfnxdJVuUcHwfElkBe5/4RWfdT1Pga9/ZbJ
         TlmWahXCg2XatpOXO0/jAbJ2uY29oW2T3brB8Gnvm9fcBsuKPWhqb67EJ/ympMyiGxCX
         w4QnVq00KaqWdzuAPjeuzm163BV/UW8cvk3n55Y0bmjDRi5GhaXV0p+zAS2FiyUJtiTW
         kRkA==
X-Gm-Message-State: AOJu0YyK282y1sRqQvEdH50FyHdHy3dni5V0BAgy7fahCEJUPGE2dth+
	Q3LLhtxoGp4k3tO7O0xx+qlpZrcZ0rtHYnNQhURKPx2ggx+dnaTS/zSbFg==
X-Gm-Gg: ASbGncsx37PX99bQWZatv6J1VuRGQTrqUX40Wbpqis0hyGTWFyy3aTD4dsNnqQwP5M1
	7bxTPf84c86eORXDMcGGgSLJmqAmEdry8fToGI88sHklYzE5jOe03OjJBozKHbp2ruj+i9cVxB9
	VKj4hlKOdBvCc/qQ2m4k+SuVZQO/wAV90yqoTs141rndHRynn3Tc8C/7rAljWSe6oHaEnFQXD1M
	kTSele93B59e78qAcmdUwbOSRc5zidsGR65Sm/3hsKA6dPhJTGS4yoP7p1Fs9W9iY/roV9ENytS
	utCmBbsD4ixPTtIM8GXKqWpHQzYUJ9LNDOkviqu/K+zz54ZBCRPp
X-Google-Smtp-Source: AGHT+IHSUZ4uI2io3y00JBYIfrHYbglj205bbV+Wd050phj1jLISURWqLpfSTesyzJPRmDwjwPr0dQ==
X-Received: by 2002:a05:6214:d62:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eb293b5b6emr7529536d6.27.1742333496477;
        Tue, 18 Mar 2025 14:31:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.76.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c778sm72068806d6.110.2025.03.18.14.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:31:36 -0700 (PDT)
Message-ID: <67d9e638.d40a0220.d3216.adee@mx.google.com>
Date: Tue, 18 Mar 2025 14:31:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0690013425156926237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
In-Reply-To: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
References: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0690013425156926237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945296

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.75 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      27.22 seconds
CheckSparse                   WARNING   31.06 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      432.00 seconds
TestRunner_l2cap-tester       FAIL      21.34 seconds
TestRunner_iso-tester         PASS      28.24 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      121.31 seconds
TestRunner_rfcomm-tester      PASS      7.82 seconds
TestRunner_sco-tester         PASS      12.14 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 61, Passed: 58 (95.1%), Failed: 1, Not Run: 2

Failed Test Cases
L2CAP LE Client - Write 32k Success                  Failed       0.402 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0690013425156926237==--
