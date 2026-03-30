Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5412EAD1C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887918; cv=none; b=Mif8BjsBEROfYhaf1FwHHgI++rz5PPo5/zVDxm/KYMcJIPmnN1ozlEdZXbTk0wXp19iEeMcElGXvq+Vj4GpLSMcF4h10gqXBl+t0L6HrTyxoDm/ImoCWNTaWgrj1ON8AOBkS67uZEl8+1rBw16akSA/rRF9hnWcah2eGBIb3AUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887918; c=relaxed/simple;
	bh=cG8dxmX05Dwy3P3vJB+TfxEmq4M4wsIZ35/iuLcxT8Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JHQahBOqCnWefOOYxWB3HiQHx01Vyjqs+ejGcFQ6xC8cTGVl7dr4LIRq2iA1ruqvwnYNAgIALIZR69Q5SqgZQR2QXIXZT9+cJ5jhnPOQ1kUzm29jj39y34R75Cjv0enjAnkpanjA3qlUgCkkk3g6jUMukZC93FOe6rlksPy66As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhFYTKla; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhFYTKla"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4459765eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774887916; x=1775492716; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VKCM6g/k2QEC3B1ihs55LUUNDfqr5hS948+sU7XGrvA=;
        b=FhFYTKlaK+F4rqY1b8A9nYnuIOuB8Agaz4LS8hdXLYOZa3SMx6pcHyOMY0dXu3k83z
         rBRv2kqomOZk9m3an83SeXXUkOhjlicuexbia+1MJrAJQ4MR0uoIKYyX8VnWskm/ZDcX
         D57QtK5chziMWOxkqV63ilvIyEmsyDRCET/Br7H1mPguhLNtSMuQKRWpvulQ8IXwNeVN
         WOgHz0dqBzNkhRrer4VulGiD8f47j1MBb1za3YPcQLCpx6wDyUOPnv5uZYqpZajQkZKQ
         jnDwUeoEdvreJ+ovXFXHA3HDPglFapD8BdgMJCHrCYW+E9OG1FR9sdg5Z9XAcvHtdp0y
         AyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774887916; x=1775492716;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKCM6g/k2QEC3B1ihs55LUUNDfqr5hS948+sU7XGrvA=;
        b=UCUbfPIG8M2FOQY6RTFGPP69ubEHm0O+qebCwyjfHvixdzx/q6SXUWXWHFWwNtwokn
         5QsGRovU/uLCfKHpWccqyKD9F+ZtwPd8A8SKwKpa74M8JbunZPhRdfBPniABo3XArM61
         UrqclpOr1druxCr/sfO8z+fbYlfPL8QLjZ31jvNBh58HUomm63PaLvN7zqqXER52GI9J
         a01WrlgEvY2FKdCEj8kgXVEWCGNwy/HWLwuZ7Ism+V0gN3gydJLPah43WBZBcjfV2YHi
         JTAyb5/ZvyHucDEvdpoznPhFCfvEAM8NqRx0TeL4jzcveAreanZ7B9lveBNiDse0vbDN
         Hm9A==
X-Gm-Message-State: AOJu0YzXIAY4jf3WaMpJo0yJf2safF1KyOb1tI8LOMpEgCa4RVE1RpEq
	1OxjkFWc0y5x3q2PPkdRpdeiNPVPbdQ9is4IcEFnzISUsAcTqXIzaTfkE4QlY/HA
X-Gm-Gg: ATEYQzy0hljHF8ruo6hFPsSnN3kH7Iip1clu9vyRedUdp5gOqE8l+v23qnThYJh/8K5
	jo5hOOXi38X76iE1Jp8+q16oeZ7arMGr59hINctV72zXtrfh8RolHz9bqvVZarEeXIlblRPP/19
	ftP8bIsdE1/hsaJl2vx68jLPJAuX+kKm8XLCw/PQOJ/xx5l564WqzfBB/UgumkQ6PvlfEgUHU58
	gwb5ihmXKrrSmwFOzkquK9k+nWBcSIOibuS+mIuOS3JWOvMHPuBAg4L76qQAE55pRu1x0TB+g2/
	NjA+xMPgKuhk8Ifj1RYaIbAgvG5vlfSYv9QQqOf8qu+0HIt7YF1+KxA43lnnDwSbvpC5ie6GyEJ
	kkw83kW7pq4g3v1fXK/AH+SV7RnJmuPbqxh/thoRzcv5XJ2lthvzR9ZPkI9gNAF1MvGPcd1MY7X
	6XIa+ME18vwaLU2KYtOICeaj7aIfw9zhma
X-Received: by 2002:a05:7300:ec16:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2c185ec1216mr6855299eec.21.1774887915814;
        Mon, 30 Mar 2026 09:25:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.194.219])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9ca80sm8290841eec.22.2026.03.30.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:25:15 -0700 (PDT)
Message-ID: <69caa3eb.050a0220.17a49.fd54@mx.google.com>
Date: Mon, 30 Mar 2026 09:25:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8345605120025565309=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: Bluetooth: SMP: honor local MITM requirements for legacy pairing
In-Reply-To: <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
References: <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8345605120025565309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074695

---Test result---

Test Summary:
CheckPatch                    PENDING   0.72 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.81 seconds
CheckAllWarning               PASS      29.79 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      25.94 seconds
TestRunnerSetup               PASS      567.37 seconds
TestRunner_l2cap-tester       PASS      29.34 seconds
TestRunner_iso-tester         PASS      39.60 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      112.23 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.27 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      10.45 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.125 seconds
Adv. non-connectable & connected (central) - Success Failed       0.122 seconds
Ext Adv. connectable & connected (central)           Failed       0.182 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.185 seconds
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.837 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8345605120025565309==--
