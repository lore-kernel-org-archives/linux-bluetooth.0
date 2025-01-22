Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8D170A0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737520434; cv=none; b=MRsP+t+0rJqms3SCET3VquuluCaZbZ+Ko6iXVzdq84YZbVM450ZfuNfJOZqlVC8rwZqdUpzbcghLMfTqwxCZGg7SNlf14gK8Wmp+zUe5aQ/dlJHqOuz3FjZ6zbKUWw6tQjajkYHfHwnPFioxoRCRHTIooPuwFYZNFafels74t8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737520434; c=relaxed/simple;
	bh=rO17zDrh1QENnYDvlr7+Z/8p+G7QidKB4C19f8EqmBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gapi7XP/o2V5d0M1SmjLuW41AeAIBRKczxCd2t96N43Z2fU2UB7ay1xL742qYgn4feDb2isDwRAyF94SYNpdb5JgpcoXtKEPEtqLe3z8pUsJVynyRvYAu6BtM2fXwvQtxYRPUULIuFiuy9D0hkU2y4T27wSDoclYH9wniaptM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjeGdTY0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjeGdTY0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a6ecaa54so58179841cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737520431; x=1738125231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ryAfxJg2jpEsnOV6LHJ70yeJOOKT7xx1PPSpUEXD7jw=;
        b=MjeGdTY0ZATYaLq7H1sYqRsac59UciNPSJDK3G53CyBzf7QfnJXlxZYqS6ItFJ0gJZ
         aDLNS5J74Ah64QWYgDjYsyKX0oxPP0y8IEvUHYcaiWNLEgubkhpgvGcnRFkFLD8CAkzs
         MVnVuBu3bqyG1l+uo31bLIYdblJASAcbQAd23Is+/eMs/VPQhrYbROlGxZU3bewYl5bz
         4J46gQsCTeCAspwz/fyA5h9bjpMJ1wI0FWxpZm08L983bd1wzKNIm4drmb0THqRKb/f/
         +8uQsI1hfjsMoqvzJgfbhF1s+C7khqzk2WWgIGxwt7BkO+FO6cGQb6BFNtK81CjGWgut
         k74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737520431; x=1738125231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryAfxJg2jpEsnOV6LHJ70yeJOOKT7xx1PPSpUEXD7jw=;
        b=L/5TAR0etW0FYzD2XgMoqLMJRzJ0YJtEYSMA0apccUeclijUoqZPEfbgikYvEKN5pd
         Bp56twkQLkTfGB8/NxK4T7rkn3OdUqYQdF02pOsnFHbB9/4zWydr/3/ADXYanuRuel71
         7Ad5u7r5PCqM9LsiY8LPLqJSmjw9KIKiEQdpJV7HnY3CPiu/tSq9U8ZfkOqyk/p3T6OV
         4go5fEz6OYy+vbsZ1El2f6YUz+0NCFfW6M5ohGQ5p96u6341vMMy4RbvQGaaVEOkKBlc
         +Go0xBR6DTzEaJmuAPmfMeBneR8XPIeHB2ArMtw6DXroKNK2yjnJE9dz/aPxB8VNMHOr
         HIEQ==
X-Gm-Message-State: AOJu0YxhBM3kp5qd0vtfzLyHdLspmPPpvMpxN7ZGjY9SMzEcbK7ByOgd
	1mPqWfNPohby3Ck0f0HMVn652B+al6+l6+YIKOuYtDi/0ye8r/cgq+B3NjI+
X-Gm-Gg: ASbGncsgSxcRoRqJkLu3bPAc9sJMRpzQTLUEHLyAuljm29zV2Vwj667wv5tpj/rXqgh
	lTbAC0w1Sy0avC5YNjYauQgoeEF9gMaliHq9fDgJYTD6mYYaSkzpFhUQLE5453LY+kwmvj3HNOk
	Z7vgA4NY7Q/hxvt9z1aDIA/L6cB/z56oLq2bxrQUdyhIMFa/lnucd6C/Zasb5KwhDM8lXbT6gB8
	91Dx9J2KRQ8EMJjexUUGkqC9JhPN5G66PDF6pQ+3+yYx/pf10dqsUSRCKMZREHfkyPbCQ8HE5g=
X-Google-Smtp-Source: AGHT+IGNq2C7G2lzfm5jnvsu8TWhu9gaiRfiiCsHwdp6wPrjWJcK7xp61VpYOGizZqERVCExDgiesw==
X-Received: by 2002:a05:6214:1c4e:b0:6d8:b189:5412 with SMTP id 6a1803df08f44-6e1b21bca37mr337734416d6.31.1737520431651;
        Tue, 21 Jan 2025 20:33:51 -0800 (PST)
Received: from [172.17.0.2] ([20.57.47.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc22eadsm57711146d6.53.2025.01.21.20.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 20:33:51 -0800 (PST)
Message-ID: <6790752f.0c0a0220.22960b.752e@mx.google.com>
Date: Tue, 21 Jan 2025 20:33:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1289506809517166353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
In-Reply-To: <20250121-qc_wos_btusb-v2-1-377b3dc2a706@quicinc.com>
References: <20250121-qc_wos_btusb-v2-1-377b3dc2a706@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1289506809517166353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927389

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   PASS      30.08 seconds
BuildKernel32                 PASS      24.44 seconds
TestRunnerSetup               PASS      427.25 seconds
TestRunner_l2cap-tester       PASS      20.32 seconds
TestRunner_iso-tester         PASS      29.63 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      121.34 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      9.41 seconds
TestRunner_ioctl-tester       PASS      8.09 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.94 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1289506809517166353==--
