Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A5255259
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103971; cv=none; b=DGJQue0fVDHIWQEmo0WH3QEI//cAWyvZBY4Ugz9C8BsD6ndNVkdJ6+qokVA4F+30j/Y8Sq9mwydsmNAlo8bMaF8vcH5pBPVeYJbtE6tjeXIX+bA5T+EJsqn6q4T8Rc3wUx9EoSHgvWTH+r5sIp4+KZbZZZf4t1P0eOguPixGUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103971; c=relaxed/simple;
	bh=VhrKBIxDD3QlsN3LCCCsmw1h9u6CE4JqEhLojD3Pe48=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p5c0H3r/TeK9g0kSjX46DsxhlACfjcGkgPsu6XorjJ9y/KW5jcexz9Lv4+1vA3P4L7cNeOYNSUiVYED+xizCxUphrE4+eZi+R28izOF5B4GJGbWhflm0kRhowE2A4COEdm8ay4oKsXpoREmMADllaJFQ6MciBcveCM+zL8ewxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSDPpqr9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSDPpqr9"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e41e17645dso57020646d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741103968; x=1741708768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dlXHTDa3+HHaQ7Of0b7Z3Ltho4f2TJwC7AhVNUq3/vQ=;
        b=TSDPpqr9IWMi7en5TN1R52imsC9EC45hmYGdU/HEcWuX+lXNl9zx2g/Kw4rhV9x/pO
         yOSBEwCorOo3YFM1z4fSYNSXCDTmCCV8OS8Db11+esveAGtoDQ3qhlc8qUYd4WQWBH2u
         UPgjX/lL9CKR64kbl4E+nOb98n0VcsPZR7XeJ5Kw2+IU+5LRyBjwtAuV6vyNXEBCGher
         mUehrZUPt6B5u7LQtHVQkIQHkHaSrCzXLffETm+3qLUdLgSwoqcLG2oEW8YJ5q8WM54G
         ivEq2LL/aH9k5fMsZDdbVAgBS/KGuKfBB6FWS2mc95iDQ/mq0M+k+9LBkJH51JJw3TMz
         iZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103968; x=1741708768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlXHTDa3+HHaQ7Of0b7Z3Ltho4f2TJwC7AhVNUq3/vQ=;
        b=UrLlHNn5Cg9aSk8CLAgS/rZPNmOyu+clSsSYQDSMpn8OAMib3kLu4tc9wx9Zmjbi/W
         LtzzSS/9JSx3B0goh/kiC+pgJqyhKCshzx63Krovtl63bkFdI2ybFGMxjn6XxxoEedv8
         jgBZqAGsm1k6Z0YwRP9jt8DS8bOH6UlVVRvIVaD26yXRXLp+qwcP7nBBOEgJWngFVwBV
         iU+TabYvfAzwzpaaPI4+5KvvZsxfRFijIWdfvgkMMGXpeWyR+NJz7NXR7Rl4339LJkSq
         LHp4B8BFuKXE/3n+DHPYDBjl+dMssqdK79V+s9esgFtGk06UuLyc6SA6WAK1x1+dF/XY
         kQRQ==
X-Gm-Message-State: AOJu0YwKtZOBmzvye9SmfiUvdKRTOq29EdPW++7offY6VFjsm0uhQ/Fl
	W9SMPFVx8OxbODDNBzJCdA4Yr/YAIS7BQSGXQSLHqVEKXXlwm3BJ4JK26g==
X-Gm-Gg: ASbGncuOBX0/wQdjh/i37k80bCHeFC8/YOYz56L1z/GLQJ1Zyj/yMuXbsYgVZ/T6toT
	W5ZLGfUcje3T8k0xhbXkt0oQrXMLQpRkirTnz2ZhVaq4rh128SzAuBJxVP2qIk3tltZ1HVNcVWK
	jZR0Z/8+y6X34Sx4rmG2lxW4FFIADBlXWAzNCAE6Z/XTEqSSCHpE6A9S6B8aT7rpwWRY1dmC9De
	7AIFs6c76XJluWFHoaxIwR5Nyk4bidSIJyCM+qMA/Z9CjEaFxou8fzMIUon55Dri1Irsya6ZDRs
	lwr4lGwpBHNhaAPMUhTJUPcnz8A+uFaF0hCxa2nBv+ARo6edDYw=
X-Google-Smtp-Source: AGHT+IGH9g6jM4Oa6UcKT3vNWiMcW8sURjXkOFbuJn83fWNNbx5fu5/8HLX84iLSWYM+JgJN9rYbmQ==
X-Received: by 2002:a05:6214:226b:b0:6e6:668a:a27f with SMTP id 6a1803df08f44-6e8a0cfff83mr271062856d6.17.1741103967949;
        Tue, 04 Mar 2025 07:59:27 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c4615f20sm217830185a.27.2025.03.04.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:59:27 -0800 (PST)
Message-ID: <67c7235f.050a0220.21b8da.7315@mx.google.com>
Date: Tue, 04 Mar 2025 07:59:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6129496170608121181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"
In-Reply-To: <20250304153934.112156-1-luiz.dentz@gmail.com>
References: <20250304153934.112156-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6129496170608121181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940135

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.52 seconds
BuildKernel                   PASS      24.50 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   WARNING   30.45 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      438.61 seconds
TestRunner_l2cap-tester       PASS      21.65 seconds
TestRunner_iso-tester         PASS      35.72 seconds
TestRunner_bnep-tester        PASS      4.99 seconds
TestRunner_mgmt-tester        PASS      123.93 seconds
TestRunner_rfcomm-tester      PASS      8.18 seconds
TestRunner_sco-tester         PASS      13.84 seconds
TestRunner_ioctl-tester       PASS      8.76 seconds
TestRunner_mesh-tester        PASS      6.16 seconds
TestRunner_smp-tester         PASS      7.53 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PENDING   0.61 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6129496170608121181==--
