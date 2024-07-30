Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DC18DF9D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378795; cv=none; b=eEQjKHdE6HcKqOjXtGRBHYHp75vHP8s6/wCLhpqQF8oPvVqaBqOLVe2hKbwYsa46km5dkWXDXL2Jo6oHaU3DvMy1mId+NjKotrCeXvp4D2Dmw1wbDWuuGzGeIzooPWlYCH5uHmmve1O0JG6SxVkNtI+yS4VU2ZLcnupkZTNFMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378795; c=relaxed/simple;
	bh=ZDyACK++eXFke6J2oCN+H4Y7nJYSSjcaPlrIaujZtQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QxqZcwl0nrI+xWNHAkYFpUloUfBgVUcvUTbwzlCUndDR3IV+DL2ZpSpyevp5BNX0qF06Ho3GYToV8UBaPcK6tBNuy7l6uU2Ujmii9g1sNEaXUwK/TDMQo5OwK2v1ibBx1LjSsSL5GX1UdNT+BLvmtSnLjcJkK49t0nJLl/OzHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKHltsVy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKHltsVy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e4c75488so275331285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378793; x=1722983593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lDIzO2ajnDDYmf6fycisBfmb7wZy9nc01er5FYA46c=;
        b=iKHltsVyd1qtGdza2KYBQQqctJo8Rl/njjYxtE21wrQmeaql4imhW2Gcw2u6jb63fg
         jcHUJbV/ref3wEdE9sYrLyu5lhiyHAvdgqolAWuno8nKFQ2tkjt/5S7A/4M+iGR2y1oP
         wY31xmd6XOEe4/vqw4XPSIvl1mawP1mvTXSAE7CqzvszsfPFFppTyaX2UcZNJCUuDdfk
         Xi7qwJ8XV3Bw21zJP/8gvL5XUd5WbJVSIzxT+rwVRQ9XJN6LVjFTRRtutiS3njrG+9q/
         rpM02qlxGX2u8gunQ2CEfJyjeARHHJyt5Fh8h7mB1/jvI/9K7Ai95EGpr6GsDdVSgu+K
         x1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378793; x=1722983593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lDIzO2ajnDDYmf6fycisBfmb7wZy9nc01er5FYA46c=;
        b=PSa82BgFW6SRMaHF1W9HGVZ+g6n+YIQyQelUMuTreh74uHA7o2PQTN0CRL/X2JxfGO
         h8vi9sAt/2jC/x4Yv01uvaY056Txdh7A2ZUFPfs6AVvv+NLeCVj6IEeBUpJEl0dC/pap
         lgGd5BMuL9wfs5ZiMrs2GAlHzdo9YrKhA1J1VrJfchfHnLNPGa0JUk8HY93ZEYH7TNNK
         4ma96HuuZQZ8tQ1CMFNNVf/HkktITupZpglyRrh76lbFT+mwLCH5PmyY8LxFN0GQYM1U
         gxFL6pMTObEJ1QrYFscAXLe2+oYLtQVcXaC9EkyzoGL0BWDqnjxzAiUztnOc2qZrD/44
         qXhQ==
X-Gm-Message-State: AOJu0Yysgt3pq6GOOXjPXZOQWfOCtc4WHKLC/+bi0iaWHS8IxGOy6H07
	kA2jKcTSip3ADoyr6rhLj86hfE+ZHIPxOBI1vBUTPO05u6d0/fbdeqe5Cg==
X-Google-Smtp-Source: AGHT+IFU1rjAj5wpnQQ1k/uCR8V0OjgoaBfUwZpJmziOx+LVMG2weDa+N/GzwbQgQzdCJNl8yBWfBw==
X-Received: by 2002:a05:620a:28d4:b0:7a1:c40b:b1e4 with SMTP id af79cd13be357-7a1e52cdcf3mr1615197785a.55.1722378792668;
        Tue, 30 Jul 2024 15:33:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.35.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7395b60sm683286185a.21.2024.07.30.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:33:12 -0700 (PDT)
Message-ID: <66a96a28.050a0220.81785.560d@mx.google.com>
Date: Tue, 30 Jul 2024 15:33:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6322033761923190656=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bearodark@gmail.com
Subject: RE: [v5] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
In-Reply-To: <20240730220824.224298-3-bearodark@gmail.com>
References: <20240730220824.224298-3-bearodark@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6322033761923190656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875239

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.26 seconds
CheckAllWarning               PASS      32.87 seconds
CheckSparse                   PASS      38.26 seconds
CheckSmatch                   PASS      103.58 seconds
BuildKernel32                 PASS      29.18 seconds
TestRunnerSetup               PASS      532.97 seconds
TestRunner_l2cap-tester       PASS      24.24 seconds
TestRunner_iso-tester         PASS      37.44 seconds
TestRunner_bnep-tester        PASS      5.00 seconds
TestRunner_mgmt-tester        FAIL      110.67 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      15.18 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      6.16 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      5.19 seconds
IncrementalBuild              PASS      28.22 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.175 seconds


---
Regards,
Linux Bluetooth


--===============6322033761923190656==--
