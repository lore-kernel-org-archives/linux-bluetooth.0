Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CB26ED46
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297310; cv=none; b=arfhlWxPlWOygTEssBJ+vuV+FViXEq/urDloTYX9/Sh6fgtXIJXTI6WLU2UpuIsqMaGeopJblqFrMhGGWh+xXxo6nCeM5vhv9YLtbr4i19625khPBNGTcL/dGoM3AaG0ICJeufOQ3fW2f6ZJ2q/XJLNgBMV809qYmVCeVxBuJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297310; c=relaxed/simple;
	bh=U6N9jH2IHlVxjY4LpyHdCXq3ybaLxMS3lK0rqyZ+kbw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GhdLGUEPn2SvlS6FbqzI5SEmEsRfXd9TOsuAbu0k9PdbAsY5HQSTqmb6mJHlJg4aJxpTMG4mIl3zLXJCYgL8iyM4cP/wFu0w12r0/lC/+HdpIkpLULH8nDkO/B5fqQMNkOXRizd5KlaXrEm6Q9yY9c7KYVmgleIGswlLJGCHv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6duAUeh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6duAUeh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295548467c7so36920755ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 15:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762297306; x=1762902106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t8w9bFqRWQSFHhfka1VQBbJviLag6YO/Bk3M9cg23AM=;
        b=I6duAUehrp99wvyUr5QfTua9a16sLLF5zz+DuctRC01pbCUPSYhSgXW2mu/hOs1v1W
         nNncrsoTa7k125O2x7iTlxGDQyqRrh13HazpPqrf7D6XYfsdtVxTtS0t83AADBSsWx6n
         UHyv1kuhmLYyzuR2Vr2UlKIg9lT3w2NX3N/dGz9kgQF7RuRcv2DfUXDcEi1gtMFe6TJB
         wn15PpBs9OWxS9/ZT3k3aLaVxWkgVNjBHMd5fojmOJLGyD1CS0wDNGcGcv4Y/36J6cHA
         rV62L3GjqWKqoqiYYN1f5LE6dtUhqlpt4Qs7ItqOHj3dEHzFBCfrMnDXuVVZSJgn9nNn
         IEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297306; x=1762902106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8w9bFqRWQSFHhfka1VQBbJviLag6YO/Bk3M9cg23AM=;
        b=XV02r1TrRAC/+l++DLlpGExsl7NwbnH3Jo98yUNLzUUjvIDQxiCRxAup9ZNxKBcUu2
         hXpPyx7fg9GZJ6oBTJRKFPwi7GsNsryfV9OkW6vr/90HVcDwxL8mc3CGKHsT7yxrNzd5
         Yufcq7MXBwY4icrpMWqpuxJbMaeM4QMA4Oi5JFxpxOXGj+TmOy6NgCpMf3LN4Fb413I4
         eshQjAbkoKsMcEyyCGpdNhf4a3wH4/1Lzn9I3EAewvOXcjVBlRK3/tGrqzEIf2xpKX4E
         UY3gXW3QKY94zBH9LV/oYmXOg5mZF6o0NF3CxHTUdUc84V5YpVgWk315qSkQIrK3dHmd
         yxmw==
X-Gm-Message-State: AOJu0Yzl0AqFP4cgbB9pn86AHHdWSNYl8V+lRRhXly4A4u9hr8BoRjcu
	0wdxLuxCaCaA17bxaZpC8Y2MVB+C8frogGWg/H8m6HU3tnC20oPLOFisXKIdzQ==
X-Gm-Gg: ASbGnctFMsr0AvM0oOPAVU0l25NFOhjzYdalVealQoqRDA4BtNrHHXz5HiXEv4svSPM
	CU5fG61s7Y6gKlF5zFJHuSbsjVJtB8dkJOugzcYRUlxNj7DIUlOEYq91cef5IOQ+0TncemT96jG
	b7DwglSai3BqZ0OTZYmL0ofoIv5dMWYED5Ri7dAfWehc976tcu9OcG4R5993bcDDwGyIQ1cXdbj
	IUYfkm+JCj6pSGx4eg22tvuTIi2ycBOKsfx2oJeNDjTrgkhO+1kAwxXUzu7dAQ2hR2eN/YJCQzI
	13qc5Uk7KUpJ+bn+U7GA4DnpsnwvgPmK4lseMVhzPs9sk6ej1dQf5TzUNSXFp8WJ+4fEIhjxOoQ
	a7cKZ5+OiHO0BQ2XQExG6BMK5PyV3fpdKRN/haDprFPiSzY3FZOX3zzAxDcaugyOZeOIk+ny2S1
	eCCFnkN1g=
X-Google-Smtp-Source: AGHT+IGP5cRE7Mbe33BVSKAHAXvzmMSiF/PXUfO0rX3uhCuEbA5ze5yC+0UR1dw8gHrWqeUtlvbDMA==
X-Received: by 2002:a17:902:e784:b0:27e:dc53:d239 with SMTP id d9443c01a7336-2962ad9670cmr15646845ad.35.1762297306408;
        Tue, 04 Nov 2025 15:01:46 -0800 (PST)
Received: from [172.17.0.2] ([57.154.172.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a8bcsm38335805ad.63.2025.11.04.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:01:45 -0800 (PST)
Message-ID: <690a85d9.170a0220.1803ed.241c@mx.google.com>
Date: Tue, 04 Nov 2025 15:01:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3901400022107218265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
In-Reply-To: <20251104222749.198958-1-luiz.dentz@gmail.com>
References: <20251104222749.198958-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3901400022107218265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019638

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.34 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   WARNING   30.34 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      490.02 seconds
TestRunner_l2cap-tester       PASS      23.64 seconds
TestRunner_iso-tester         PASS      69.87 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      111.15 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      14.26 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        FAIL      11.64 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
IncrementalBuild              PENDING   0.65 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.095 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.174 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3901400022107218265==--
