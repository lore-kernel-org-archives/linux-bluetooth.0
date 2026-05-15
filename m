Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8925393B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834605; cv=none; b=kXJBBkz/IfsF39trGHCvCA0GFLJGtBoXrUSsLna4JO6ZaBveVSVtLI+R4D7Zvf7TLOCU8JJSf753UocGCUGVn7uftqV1GrNW1ctu2WPMDYg/h5iTPopkQicWoSelyX/ziRp4okZRSSFXipM2JyVfkwtho2nRyXacHM4dJwhy8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834605; c=relaxed/simple;
	bh=wvgDyGS3I9Ktk2S6wrlbLeMQZReq2iC4poFHZs+e7YI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qhHmNI/d7gHQpj+tvQNRQZbliLaTk244XrFHX8PB6Bh8cn2N5iZ1g0avz0Grn3ypX/QBCcBd4wCZxjIUDhltXKa3QHS4EMammdx9Au9V3Klx5yZ7N7C32cuc/Rv7LkwUa7Ey4hHRwedZSgtFcd6Ll8/ynwEu8+aoijWGxsiUtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpG1+0EL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpG1+0EL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e614fdb42so69856741cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834603; x=1779439403; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lwhiDu7slQZaqfMEWUd0MM2lHoTY02WpwL2JMlFlu4s=;
        b=XpG1+0ELOtnNloRMb3hGNTu43Wupsu6b4eCsM2Q7dnMwnBLtIxlc6fvAKYZ3nGxSWV
         WQ2aktFkYuOW9QkfvxwCcmRuelckC7gks3Z8yPeeQSP8f+dKf+qpmZe4ggRRqxWgzI6o
         RsRHUezlQ1MXwhYiLzOG1EZJaVXLx6UDM4dbjdlmkWGrx9CjEOPxtF+dSnSFZS3aHEFh
         d3aQhCQuHe6aWPF8aFcKUrS58sG7qAlUbxVn2Cum46uGy0SAmoi1mUPJbDq5rJeM80uq
         cl4wwucTkvZiQcwCp6dibc8UMwl5WSCDyk2oN+OIrA6AfovVy2GUd+c1ekVkWuu/1QLb
         k3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834603; x=1779439403;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwhiDu7slQZaqfMEWUd0MM2lHoTY02WpwL2JMlFlu4s=;
        b=YxSGqjsGiK+SKKUvJ+/hJxtHq7TLjb5DwDuXKbWEWZyRNoifenjAl/9dKFRz0Xw03l
         Hs/RQCOLW1Pk822VbIpG5zhaWSPibhltZqSXdOwwIxsttY1oFEDP0/DsxKEekFGD7yxH
         CSbLiM0GlBIwexFu6BobzFkhtxHPMGM3UD9Ik+5fMQ6nGT1DNpmv4ThyivlLMTzQy6xq
         JY8daIfZ5JPj4W5TyR298kYrPJ+nt9qu4LoxoX7yC8qksTkO2Z9HvBWJMuUawt6+tnmy
         /NZMNcnyIKxNVKTKPK6NsRMcCBxoB2YOcgZpMm0e6LtiZI/irF5S2XSWGWZQiHbxXNmo
         Yl7g==
X-Gm-Message-State: AOJu0YxT6w6PsnPUPtqdNb25ASvSnFyuLxPEZNutEO1AWOkuC8Ul433Q
	mI9GZDmfStPkO2CyBUOo6vVMwTs8w2UURgkqTR5TZT9cOVaUO55Zvg8kaYutHQ==
X-Gm-Gg: Acq92OFuqjKPkDKPkJchiNqFYsN+8yRR1ByOnw1JjOsuMSj6Pjnk5FxWsve4Qh7AlMn
	IpLRAvCv94BA2Y32HIgUJ0L3oFf4JmWvG+eckDTtP80lJVcHCY1qtGtXzUnfiXOkBtUHG9BENo1
	2+xUGv4IHCzxBz+LSb/eR6fqZmWwoPRZhgMLOb+ng7c5cgX/H54C3YsmbtggZuR/cCYeuHGCxFA
	LSUxVP2Z9IOTQUMuVt2LxayGz7ZfcAIK1LCB8/G8t/IkqwkVq0GJbPxAAPKTKKkA2nVJDNn4mbR
	7Vbk83gQ4pVs1Rq2ndLNLcqoqml6K7ro75/FvZosUJaD19xDeob4lVmMFMPnRJw/cLUbRcpHzcJ
	hiI/NVmbVw/0EkGPeB8XNPk3KP68C3x3yLwUQkPi/rQpboIyNOwABAotEDTDDJan2WOL217+K56
	Jhp2PAQfYkzlkDWuk4ajjUQg5HTgFq+TSa0DwdinW8cg==
X-Received: by 2002:a05:622a:1b90:b0:50f:ba44:ce5f with SMTP id d75a77b69052e-5165a059af7mr39370031cf.22.1778834603080;
        Fri, 15 May 2026 01:43:23 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.125.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm39488281cf.13.2026.05.15.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:43:22 -0700 (PDT)
Message-ID: <6a06dcaa.d1a89f1f.231649.1b68@mx.google.com>
Date: Fri, 15 May 2026 01:43:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6544501165450099973=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v3] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
In-Reply-To: <20260515065009.383265-1-w15303746062@163.com>
References: <20260515065009.383265-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6544501165450099973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095160

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.93 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      26.42 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      527.73 seconds
IncrementalBuild              PASS      24.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#86: 
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940

total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14574096.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (124>80): "  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940"
17: B1 Line exceeds max length (86>80): "  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0"


https://github.com/bluez/bluetooth-next/pull/195

---
Regards,
Linux Bluetooth


--===============6544501165450099973==--
