Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1701215F43
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708711; cv=none; b=fk69s6IF2xdjhYkjlVj+/Hi2Ydz8QJnGx7lRvvet6cnd8caeqT4c75zm/XSdBx04ZuShPdEUtzhHz0F/Jcs5LgqQYPfT5z8eUMYLpu5wxWlm9FNhGffE7krA4IwpOtk8X0M3gHX/XMoLKgOmy+hyDQQprXqy+v9aCJ6ZPpvNIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708711; c=relaxed/simple;
	bh=UVYJrOVWpSjSzu0tzddO3fdssqSyBThbZEqieEud3Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FWIbjFHnuw6QqtOu9izeT8vSIOHOb+NLfHe33LoTW0kYTlNNOYa1QB7orHgCpSXUPqYVQglM/pQC4radhHERdyqToebe8v2vIhCPQkVHrEXm7+sAplBjgU8xeChpnO03K1lY6PB/gltYSNxgwN+cgpdCb4eT4RVoPKFpvyDMMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDO0czJp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDO0czJp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21683192bf9so21815265ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734708709; x=1735313509; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsXUwQN+UR9yQaEWUDhZPm/SXcD9Zhz6nmH0UZQ0C4=;
        b=LDO0czJpGLC9lnfWokR/gnMJPE/8vI0rbOErCwhYJ49NOdbCrsUejtrMMMZSA4S880
         oLaS3UIsHzWxrF0zJHvIa2wn+QY+HWQG2J1KmK1fPvAGTRykGEJ/D0n2egh6ho5PCt4x
         NnATQI5F+mr5TjVry/wkNTN0XpHkt4xWE+qVuPfCxea58MvsQoSE6FZR8jwNZETqxCw9
         NZHBsVcegHCfjKkxQAHCbEoPTymHWSInEwp2uhA2AxDz93o4t2evtFxXo9sIP3eWvmRc
         YWee1cDWzOMpHf0/42jjoJoqY7uxnth99pyjfMpuRwJxw/oeMPATeu8I+1YGCIa20Cts
         GUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708709; x=1735313509;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzsXUwQN+UR9yQaEWUDhZPm/SXcD9Zhz6nmH0UZQ0C4=;
        b=gKX9oQlToYyQ4+VlEMHztaeIsAtDnx5rH2HddroLIuoKWTetTp+13ETYQVFV2ci98A
         tRmbjZgwjMT81L1CpfQMZhZqiQb0oaibSGAg+lIFPUfhByAkfTOE2gHnoTsaq6dzb9+F
         aFhwbZoETVaE7xtepaTPCr0iiCSJtgwr++lATteZOoFlkXdGqYOyU3q0BynjH0h4HlKS
         MSVa5uCw4WPmTTW128ZqxJoNebvNbAkaeLLlMKfo/3M3AIdTDwV56TtZDG+yDXC6aAEM
         ZuEO7duTK6ScfN57lBIjopDq6B9T7iqXR+ivZbJnrKVaNkj/OohPTF8e0rRbJoqN/aqP
         zEpA==
X-Gm-Message-State: AOJu0YxxiD6tf/1/1d2XVt8sgWy7MeF1w9CaRaTIwEtRuEQu+O41TGbC
	JO310ikKGybNjZa8QUDnzPWGDlqIvnE8MyUHfs+6te3v7G1Oo4TUJXy4rQ==
X-Gm-Gg: ASbGncuHfExW/9x68wZR0f++qyxiBtOlATlS3V4wYWdf1Im1Oj7oycCtG7wcIY5YKo8
	HaJ/bpBw0KWyC99gLDD+eHNjUevpxcpdD7HsmI/pvb0yo2Hdy//d5jNeQtDcR+btYVEe7uGMEPA
	g3p4huYcw0J1EDdBnlK305An1XS7ZfFvdcmKX3fq/d2Ug1V1AZYztF9d1VgENCCvMlaX+F7uCAf
	JwbUrEQYdX+MPnSM6apYLq7pUlE4RrXuipjoP+8J5Cy7xdtNxGLQnKk+Irf7wpB
X-Google-Smtp-Source: AGHT+IHD55PQf/085eOx41FEweZrvZnfVtkaaamULmzE5/yrdhBLTk4yzY4cyLDY8t6UXBZM8izkOQ==
X-Received: by 2002:a17:903:1209:b0:215:af12:b61a with SMTP id d9443c01a7336-219e70dc4b5mr41051925ad.50.1734708708470;
        Fri, 20 Dec 2024 07:31:48 -0800 (PST)
Received: from [172.17.0.2] ([20.171.122.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b3fsm30321355ad.244.2024.12.20.07.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:31:48 -0800 (PST)
Message-ID: <67658de4.170a0220.28ba0.5115@mx.google.com>
Date: Fri, 20 Dec 2024 07:31:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6817344218014073759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rorgate@gmail.com
Subject: RE: Bluetooth: btusb: Add hwid for WCN785x
In-Reply-To: <20241220150744.51842-1-rorgate@gmail.com>
References: <20241220150744.51842-1-rorgate@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6817344218014073759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919927

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   PASS      30.99 seconds
BuildKernel32                 PASS      24.82 seconds
TestRunnerSetup               PASS      440.89 seconds
TestRunner_l2cap-tester       PASS      20.98 seconds
TestRunner_iso-tester         PASS      32.05 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      119.72 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      9.46 seconds
TestRunner_ioctl-tester       PASS      8.10 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   0.72 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.177 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6817344218014073759==--
