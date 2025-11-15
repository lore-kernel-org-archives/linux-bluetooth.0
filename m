Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200F2D739D
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763214509; cv=none; b=XnkdGgjt0zKaO/rrQAEvQiMD6TnzknS/qdo1zCZJtQPUF/XDdngSxHkZiFrAJsdPy+r1tlmeR1s0v7HH3tXqqZ/N9Qbb6CmSpwsnV4D0MiIQA8bvWFOGaQrc97ntQjUmsMBdL6E2gi+lbmNL6bpwq9hVNDKVG+S9s9bq41OLQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763214509; c=relaxed/simple;
	bh=aVLth3eP3A1uBoPSqPEB102yotJ+PRG6785vS8DMt5A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KjA3L6JNIYGtKlpDqG0G4Y7PSBmgK3VEVlbQ9yxBgp2vOaM04mNZ3uKLsy10nOtCLtwsasDdHE4NjUnxBksmolMLHFelAgojwYMiEoKsgLMy15C6bQlFdK1qtp7bvMLjpbGQ4osd4wAkpnuImNSZAuC/9NFp4BrOtCSOrV1DrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ROlIdH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ROlIdH"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2aa1ae006so383666785a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763214506; x=1763819306; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qrzN6prH3BxO0vQgzx017YIfeShc3jIbzVc42m8uWBA=;
        b=S4ROlIdHA6ax6EaFEFjShobC8o41GnAVkfRtKnn/eJam1V0Mhuoak/hH7dQx/ADmKs
         VwOWt4EMtSroVRjekS9qwbOHV21ywt4Jr+Yi7fHtAAsLLcACwPbaEFmP8ZAFfjhbyIVv
         2egdvoMDJDyxc8tW++JJYmmJncjTp69R7jzCCPdZKU7CN4V5IGtEYYQiCaGJLLgdicZ0
         VWcGmb7yQiF/ufAM2/QJ5c5PqSFFZ+uKAfZr9WgmsH74lAklLrD1fla2iu2w9Uu6y29M
         TP0JELXW5R2+BoW++obiK9LSfFg8OpEKuOkWb5isNa8Oe/qOg9T2vAhfPu4pROpeyqdo
         +Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763214506; x=1763819306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrzN6prH3BxO0vQgzx017YIfeShc3jIbzVc42m8uWBA=;
        b=wyI2nDNvFj6ZxyZyoDYIkPnAoM9KuceGhOFZMzNkJfdBfOKmMqGh+JLuHdT7CqlAt/
         aMoXQ3HP7ysPDBRZZueETcmn81Vrw2CizIwa0QyFF6pG3apZegDmcYdotVYxu5bMDZJm
         9EvLEC7HSreSOczXZvZaNQ5u0ZrRsP8Fq6dLsHpDevasF6PYSxD4Pg+VUicp7pBSyKg7
         xF3uLcwGxeO0WoUrsB5gmaH5khjnVTKGoYztBRQDZqlkiM8GaJyPaIN5PPAjuwj5HmdD
         wjv0hBx+0JOqZJ6aIFfa0zlX/jU4fi7xYtTiMdXiTHVJ2H8VvTaKp/vAEy19JWhvIN/b
         DAWQ==
X-Gm-Message-State: AOJu0YwodMcel5zjuSOeqSKkoGuzZyxgUMYQ7goL8AMjR1ASQ6AUz/+i
	EjSj51hjv6kkUsCgKLE0i1HgAwVuk2HWEkalusVXQaplrTP/DMYwiyxxrKkTLQ==
X-Gm-Gg: ASbGncukzGtlimBNFLxJfzRs+o5QfKz/HrYvdNsKfzJ1SZJqf1kQ8Q+OILfAsrPcWeh
	l7v3bN1ykFA0fBFC1VkfIrtQPDGdMe2cN/fN8uzQ9Ccl8gUYzs46l4crRPH+N/B249JjUpOoLPj
	FxPpe7etMM1bfv5jQHoQW0bdfbRSiFuDFtfsB4+6Gi4qYg9o+Sd1MoDMLIzmmMY8jkGIfHXZawH
	rQEe6rHnLnKBrTH7JlKk/Nmubbc+w/NZu0g/FRjgsDDXUaI0SMmICDRGEz5XlkYogBTFAVyJjkz
	Hbz7I7hxcbWnoL+FOWPeNpXF9ART2/rEb/5xvJfEgpE7y39GFc1FUJ9/niDr2LrYNPuRRif7JpV
	wQsMlYebj85pqtBc04ZpAiZzNPCTO0RE2ku2Nw/8sUfAQeUh1pNRpiOE9PPr99A/irxqs6sI8pL
	0qqHztBZzJq+nDQV5WWvFlcxvrWfdsakLpHWlMdQ==
X-Google-Smtp-Source: AGHT+IHuyry9uBqQ/d08vMLatL5CkvxyyUkdaRO7VIv6qUJSDkRkBJpVLZoxt2KqeTpKdLOnxBNMkA==
X-Received: by 2002:ac8:5d05:0:b0:4ec:f4be:6b12 with SMTP id d75a77b69052e-4edf21330aemr95377781cf.72.1763214506029;
        Sat, 15 Nov 2025 05:48:26 -0800 (PST)
Received: from [172.17.0.2] ([172.174.165.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee02763778sm16103731cf.32.2025.11.15.05.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:48:25 -0800 (PST)
Message-ID: <691884a9.c80a0220.8c14e.31c5@mx.google.com>
Date: Sat, 15 Nov 2025 05:48:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1479792994866875224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_core: fix accessing consumed skb
In-Reply-To: <8d6e3b719f6dc3922d653795869ed7bcbcf086f7.1763212292.git.pav@iki.fi>
References: <8d6e3b719f6dc3922d653795869ed7bcbcf086f7.1763212292.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1479792994866875224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023840

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   WARNING   30.92 seconds
BuildKernel32                 PASS      24.95 seconds
TestRunnerSetup               PASS      494.46 seconds
TestRunner_l2cap-tester       PASS      23.82 seconds
TestRunner_iso-tester         PASS      81.03 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      118.50 seconds
TestRunner_rfcomm-tester      PASS      9.15 seconds
TestRunner_sco-tester         PASS      14.21 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.010 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1479792994866875224==--
