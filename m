Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57901846F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321896; cv=none; b=L4xY7DR/VC+XjySmfjPLyoleKktDB1ef40vIR5G+i9L7uf0IgKh0SQRI/M4lvMO5Kg3r2Wby11wXqJdSvDJFuK64RL4B+08vdiBeIbonU5n1OOGDliIKyqQRjJQ+dSiRNyZlE+nqJrzfpX+vXMq3M/5H6GmlE16RXhxVXLLgZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321896; c=relaxed/simple;
	bh=EIo4t75ZpDK9kGUxMfgIIOIR3XlwBGB/jxIHHFOCch0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=srUnGt8OM4JasVorO1tg+n39Olx4Ovq8jIMwoFHKkRH2aMFPFbKTZzqMJ07bPMbbZyF7DJXkjiFq/VnC21TvxQt37Bpc/WUX5yswraD2cvQiysFuiWsZ5hiKb5nWlNenDA81O+I9PQ4uCEOfhgHWNEV1UyzhsC/QD/8XRXQ3/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tfx9G1Ro; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfx9G1Ro"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4af027d966eso32171611cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Aug 2025 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754321894; x=1754926694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oiUCdv9rpXjX5cQ/FjzDmQdSkuWkUTBAYBNEDgyJxos=;
        b=Tfx9G1RoAf7OZkhDg8eFkTpm8GLkKAqXHQXTRykX66CXdEo5DCDOU2syAffNgG220c
         8TYryZoxfS1mufJtSSdINcjtC4Lo/77PVRNfvaseyYixDSDpEK4zjEb0YVsrYi0i9FZH
         KM5b5ND6H9Ai04/qHxPaP5ndXcmKdXs8dv+y2X4ymZ7QSsNdHNAHsDgQfuZss7Fhk9MD
         rFa6P/71nZ+Q6TWIJC1z8bMknmsx08pZ4u3q1el9iZEAVR3yPETswkQ3P4GPjRfhCCPZ
         vuiDzvGJ9xzEKI21JGgKwtr0rezWMwFEWVEplg0dX9pOnyQ9GJs0e6UU2DHy9Z6Cp3+L
         zMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321894; x=1754926694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiUCdv9rpXjX5cQ/FjzDmQdSkuWkUTBAYBNEDgyJxos=;
        b=E7ajZEU5iDwjJ7qEsni2KGJZ5nHFEsRuTtqZBxtnNKNHFX2tvpF3HD8368LdshiPDg
         q/+3sN51Z3uPu71nrQ7sPGRgGBy6EtrJhQGxWwnaUKH8UbNuOL5CxlVmsNEX7ivhfRpC
         4zEhmGL2ux67pyn9jCDf2cdtqPrUuRV8fcYNpY571ejjb4a0LUfKBAv67Qddv9L85E1p
         kK/AruoexOqZ1VyTWCmEKHSWU+I6ve3oc+E77uPrnYWe5LfxoWnGB9aQNt9W+HANTpeC
         at2S6iHWRh0JL6PBt1j1houcM6ggujUaByHFk4wbfvN9ANour99Aa3jCrtgVvGirKYSa
         2WkA==
X-Gm-Message-State: AOJu0YyAsWVayg3fQY12f3o04eaE96ixrn8XQn6N3mXleHM02iGOoDSO
	Pyr4/PxFMbqaExOlp2uRB6e5KpZ1IzViO+nj/BkzrdQLoOCbzKLnj2HpZrEhLA==
X-Gm-Gg: ASbGnctXFMAv8HI0kDUipJv3JsO61hoeMXlf3NUOaU00H2NZnAdMTS0nGkoJs2yn3IZ
	Nj4iA0Pqv5imFyKQ0pldl2Sg9OVQz3hY6iL1ZtXn/FfpF5jPqFCWctFk7BagbnbhOwyMAyH44EM
	2RlCfoDNJLwl8d34Uiyf/tQWD0ZHyyyLCAFBo4SoljnKdr7Nip9LLTUYjNF1Kce3ERyYSzRJZG3
	x3DUbXQkEhGwy2Ok5r5QyFqJbdILvNZixEsp0TJ1UwTAY4/EIQslN5bvtlMaWJ2sQJhSeno2q7V
	0XuaXuU6uwNdDhw/t+CP0198rApwt9h2iVeEmDuLscpc76/OMR7RNxCV+EhzxGJS5GR6irjjkFA
	dLa0kevEP4jkgfGIIcJkPPSCWTkmg
X-Google-Smtp-Source: AGHT+IEWe9YoHtGhdsK/ej529LXAl9PB03QyXRUkDKmdb2kZIiLoaQkg5M5TLZfpw/40OHoc9KeFZA==
X-Received: by 2002:ac8:5745:0:b0:4a7:2f49:7626 with SMTP id d75a77b69052e-4af10935b66mr148477931cf.7.1754321894047;
        Mon, 04 Aug 2025 08:38:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeebddf52sm52667261cf.5.2025.08.04.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:38:13 -0700 (PDT)
Message-ID: <6890d3e5.c80a0220.19049c.5840@mx.google.com>
Date: Mon, 04 Aug 2025 08:38:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0350289966590886131=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix {cis,bis}_capable not checking if LE is enabled
In-Reply-To: <20250804151210.1295329-1-luiz.dentz@gmail.com>
References: <20250804151210.1295329-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0350289966590886131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988188

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.05 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      24.11 seconds
TestRunnerSetup               PASS      476.35 seconds
TestRunner_l2cap-tester       PASS      24.78 seconds
TestRunner_iso-tester         PASS      35.49 seconds
TestRunner_bnep-tester        PASS      7.49 seconds
TestRunner_mgmt-tester        PASS      125.01 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.71 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.156 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0350289966590886131==--
