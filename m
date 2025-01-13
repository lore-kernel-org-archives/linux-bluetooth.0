Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246701FBBC0
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782384; cv=none; b=jYP9jewZrbOji4f028Aago+f7b/+Mz6Nhyvj9m2EtMlRaeaLkdRJ+v2GD8Ofb5COBzXtU/PqkdZwV31Ich5JmBOdMU567j92ukKCxn2Bw69upPRpzTO/J33bgCnx9JN+G+n8fXxdZ1qdnuVLDl/7e8Z4jaztlsqZrzFbRBXlFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782384; c=relaxed/simple;
	bh=jHHqfQwV0DpzksvNvGiuKWEb2zZ9W/8Uk64W4kQkWz8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jHzNNvvZviVmDlNTXd0I96KE5iC7Sv8w1KJNINFpni5lTwGGIEQeUXRWrR0EOI+Lbc5uZDFFO5GbihV4ehmcpY3M0QgPLfLWgzoWRP98ykC6Wu2smCj0BAqemufkhC8w+Wchs+eM302K1fk1g+f9jViE8nWbhESfDHRwGWjiMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTv8aizY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTv8aizY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f7d7e128so484332585a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736782382; x=1737387182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VzDlQ89/zKnA1ZWtdEl3OBI9l+RbhHch2OFZMkPI0v0=;
        b=VTv8aizYFBsNYs4IVeWouIvHSFbVLWn5XpNpTaeyT/Lzc7fm5kmIwGcE6IXD+/E3G4
         RZsfN+LAYLohOAZlq+r18a65QjxjuLa3TwY/xW3QmnEkfzYTwLQioYkg2XUocy6j6LKo
         9cAHByoI2oTEirxy2cKdHuVjpTEUEjfxgU1Ra/9EpVsVD9USiM3VybF3yVvOSA7lgeJq
         JqB1UBDx1jKKMKBIfZsIky8LsX3ak1vxtrP4QgqgdxoS2U0yVKzXzKdAfKylQ27CspKa
         6SHMcIa2uiQ6o7bkrgFvWXuFaTDLQPUyaAKpDjaR8jDZ64PUY7hB+NduMnBpjMsgS2ZZ
         GUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782382; x=1737387182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzDlQ89/zKnA1ZWtdEl3OBI9l+RbhHch2OFZMkPI0v0=;
        b=hrJFu7hIXDIH7S1mTZ+YSSYTtxMAmow1HXorQLCZn/c0AVoWvxYU3le1p77Nc17I/2
         ow+5+PBhzWy/oXZJ4mga5l5+Xqmvt5GxRujQqV8q62E6rwSe9slKg27qpqGzjtS6uenP
         l2elZ7i8AnviIY7kw6wTFvH20PagoWncJohj94ENrTzMvB49C4M2JivNlfkBGxVba0b9
         P27ilu1lHawoIQepUuduIuSt8YQWHwRu1GS69FZVfF/uE1lDIdzJAPt/gEX3XwzMWsNF
         YwN1tdLk3XewVV3xd+62X2UVkU5xsroPN4C2PC1LmluqPYn+dNzRGitKPA/z1el+8pLM
         cVJQ==
X-Gm-Message-State: AOJu0Yyt6komvz+Gn7Dwa0539Q8amhYJTo7E6LzJT/hM7UtjAVnc0saB
	IKkNGA9QoYa2kZA3IbdBa7pqQQygjz1v+3n9mkJWyaX2puirBUolKkw0jA==
X-Gm-Gg: ASbGncvvyH4KhPgvZtJCgWpb8lJuqkxwR6DuWR918qwuazEkGRDwAaUPnQydf8GLKOV
	NWOaLZ0FstBr4pzX35F8GVq1Wcm+aRoxxYUfKQWq9rshE3Gv65C23YXidwfMfZ2zbVUrLUq84NP
	/+E60q1ZVNXP19gVHcuLqsHTIgLCsVnfdYbKdloRmmPhy4Ef/UIAdlCQ9e0ls51VgIzVz9ULOve
	tIHeVMVPyzlGo+TuylvVuCodDwNnWw0GBC9Ad4yakRmkVMOWOoXx7XqbhdZacI=
X-Google-Smtp-Source: AGHT+IGt65FGWSGHTsE56zOUMGkjy12MnJLPmiknkevGEUw33Osx+D1+oOsHsWqK4vIL+Ujux9g9uA==
X-Received: by 2002:a05:620a:1b94:b0:7b6:d312:c5c6 with SMTP id af79cd13be357-7bcf3655ea7mr1711208285a.9.1736782381790;
        Mon, 13 Jan 2025 07:33:01 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35160bbsm497708285a.112.2025.01.13.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:33:01 -0800 (PST)
Message-ID: <6785322d.050a0220.81c7f.30da@mx.google.com>
Date: Mon, 13 Jan 2025 07:33:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0599350886249445350=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun_hu@icloud.com
Subject: RE: [v3] Bluetooth: qca: Fix poor RF performance for WCN6855
In-Reply-To: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0599350886249445350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924924

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      23.92 seconds
CheckAllWarning               PASS      26.06 seconds
CheckSparse                   PASS      29.51 seconds
BuildKernel32                 PASS      23.70 seconds
TestRunnerSetup               PASS      428.03 seconds
TestRunner_l2cap-tester       PASS      21.28 seconds
TestRunner_iso-tester         PASS      36.48 seconds
TestRunner_bnep-tester        PASS      4.98 seconds
TestRunner_mgmt-tester        FAIL      124.64 seconds
TestRunner_rfcomm-tester      PASS      7.80 seconds
TestRunner_sco-tester         PASS      9.61 seconds
TestRunner_ioctl-tester       PASS      8.44 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.184 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0599350886249445350==--
