Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E1221F26
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956964; cv=none; b=cnUa2u1XL3V8XbvBlDqT9cQlah31vecbi4qv+yXLLC3Cy6UPfVP+pk+Dkz5hX39BFWIZViXdi9xsFwIjCvKcjTDUHhlCeL90wG4YU/GH9s0v/D6HST+Ixwhulga0e7Qh9Jh6H3w+QM7kA5X2a7nLGzMuXHqjSfgIgITsNDwRcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956964; c=relaxed/simple;
	bh=zJwIkuAqWj5pz7wv8WbPc10kUyjvTkUXkwHzloUDsg4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WGhqQGP2Htf6e3mokaaO1pPEXcOeKX6rHrEW7Hjq7r1fwd+VCBh46YlC2mj7ZDCc4b8/ZcGf8Yfe2C5zTlXvd6Zq47Vxcu3jBLODF0iWnHhtU9FPuQixqg+euhZzxM185aY+efJ3g9tHFlsfF8FW/FOreII+1HdFS1pShw+iIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2D1qEbJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2D1qEbJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7da363af61cso33963785a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956961; x=1752561761; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/YPUjwBsSHF+yOxnWrPudYI6TVDii6jOd5/TRvyEcRI=;
        b=m2D1qEbJ9iyS2F+Fzjieaq7yndly3U5YdtqOwlunPjzK8+ZlYumZpXfGjr2yyWXJUa
         UaxbPmvUQgO+mFof1W+gSRlYrjh1SyI1Q0Vcoe1eUHEYatjHLYt6KlFXBur7UPoALzgz
         mHNW8LB9UeAS1jsFgn4GTuT0atMYGskFuhqJyTkdOilTUGqrp8tlW4dh8gwFlRx7J2Re
         rHZub20vWrmrdrkd8SWTp0d1XmGqEvEjxE0TxWCoSYzEy4y49aZw6xzeDaROcg4YyhNQ
         LWogvP8TpzxzFWOHLue7YQVcWBVUaaNt3AIjA2F/rQ2NvF8lW9nmxpBMAW+GfWoG5pWM
         X70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956961; x=1752561761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YPUjwBsSHF+yOxnWrPudYI6TVDii6jOd5/TRvyEcRI=;
        b=n1lWEOkftnQIYmEwRDXmcGCsInWEBST36ivKQLMFHCKd10R6O1l5j98lQE+sfpcTJC
         uKuXN+lHtZ1QzuYNkiEtc76drvtk+a2tY5iBTPnCkN/DST8laAcgDfvZ37IgwA7xadAE
         yq3NfjmcFabdgm2P1OewGSNSP0yrYp1wYIjm2ieRE9/n873nIr1CNb/4QHCYMz0UK/NB
         K1mF0ODr1omjtXB/pCMZfYW/HvEM+qwdK5QSG1CS88YfhDeN3+VHAY4VWv1BilSgci+P
         jyz2TMuv6drtvAH9VE/UKOsBg9SJeoIMrcaSMOAlgWiJ22FGR4VQenuDdCjweP9Zx1Oi
         e8bQ==
X-Gm-Message-State: AOJu0YwcP7dJpT9+3/6LhkGJPSvB4zN4YVTNNytXjmkem7tryfQcXTto
	MyC/wW8pCw8FxGJOmhzCuzGP3UQluuxMMYo6lcz+UArHFRwM30bAAOBMObUWzQ==
X-Gm-Gg: ASbGncuR9/c8md7Hb+oHCsY2JH5s1z5h9b++qzFkBxTf9gj2XTRaxkL9ikguM3FqXyE
	A+KXGZjkSPfl20oeGSPuUrdTJbwtwr+H9SDJZJGZK6qJGpeFX5KIIRQZ9+Xv8K6nG3f1qwehXCq
	mtNPXPuqKzWBDgeZx4sYkNIc9pNkwTyafxbD0YO6xatxHLFZ7HTY9j0WpIh2KtRzevV3sYo7HmZ
	cq5DctTaMrL2FFBguJvqUmjis/hdnX/qe+5zK+/cW/v2Ydas2W6Qiw055G/xCQdDPvvCI9yXbHe
	ABlO9hydPPNQNNtlZhGi7JWAo1PWszI22PjsQKSdnI9+SUfTGvDCHLTyH26hYGZ9WGOd
X-Google-Smtp-Source: AGHT+IESScisVsIRkfrbPaEgTGcaqeva+taEN529VTNb/X86QkTG0IDR1JzmW9545F32Z5SEhz3v1Q==
X-Received: by 2002:a05:620a:440b:b0:7d3:a602:6767 with SMTP id af79cd13be357-7da03e5061bmr276722785a.40.1751956961242;
        Mon, 07 Jul 2025 23:42:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.32.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7c2fasm732671285a.76.2025.07.07.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:42:40 -0700 (PDT)
Message-ID: <686cbde0.050a0220.130e2.a718@mx.google.com>
Date: Mon, 07 Jul 2025 23:42:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8512482137986712995=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: [v6] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
In-Reply-To: <20250708060150.27375-3-ot_zhangchao.zhang@mediatek.com>
References: <20250708060150.27375-3-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8512482137986712995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979888

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.73 seconds
CheckSparse                   PASS      31.43 seconds
BuildKernel32                 PASS      24.05 seconds
TestRunnerSetup               PASS      466.15 seconds
TestRunner_l2cap-tester       PASS      25.11 seconds
TestRunner_iso-tester         PASS      39.86 seconds
TestRunner_bnep-tester        PASS      5.87 seconds
TestRunner_mgmt-tester        FAIL      132.45 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.151 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.166 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.186 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8512482137986712995==--
