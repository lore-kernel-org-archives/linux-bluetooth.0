Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792865642;
	b=tb3CBJVIjnrCYIwV55p1R2lLj6zgWCHasdxX+6WSj8g1cJtqfieWYidpqHKxifdI2+qC
	 gsvp32LQ9CywtPS0dWeI95FDLhIKDpW7tAcBFua3LTpEiaud18yl+haFuXChSXn2tS+n2
	 ja9lPATzHbrAEQsVQLRRSxZ8UgqpjC1EHhzTmE/U2t2/yba5CAQBnDSCo4NMP/gYLBT1o
	 DkZjY5yc0eA4nerpO2S0g/zGmtbQ1ihEzQaAYNouXFnbYbcJVxwG9pF8zbcQKg7bX+nN+
	 /4KBmZrHtCWxWzEQ5CWhCATJx2eriBmCIJ5QkP5+H98qoLqa9apIjyNmtDiQoMSozdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792865642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=A8qm04ZEnsslWrxmP2BXYBkI/b++A42dT0ccYktbE+4=;
	b=xS56LVReNgluvHL963+o5vpLRtGK0+Dad1c9SCG4uNfWKe+y5kdSmuK9k3LyF1lgs0nD
	 iKc9yK0v6+Qa1FpKV0HYvuSgYRvXl2RPYqSdOoCzP2gtsY81Pbc2ai4TprSCtmAWx+R4x
	 Akgc8FihgSdcmI2G/HXYz7ZDZHKWDgVBw1MiDqGfODmZhtaE6dz/DHTHeHW/vQd1BeTL0
	 uB5B+EJR7PeTIQ/64HZQBJUUmeMMK/fgDLPHlXWZA9XAgoHVKodjnBTZys6lCIIY6GRBJ
	 7OOtmo/2aR6aG1EHq7Ihyx+2ukRm17JKBWYpfjTodWs5gls3/Z07Pj/JDA9PEPBBVbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwDPzwoW;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D21606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 18:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D21606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwDPzwoW
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso3231316eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792865641; x=1793470441; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A8qm04ZEnsslWrxmP2BXYBkI/b++A42dT0ccYktbE+4=;
        b=QwDPzwoW7WpgM7odlCZ2tQtMXcNXzhQokeK5B2OVUoDS9uED1u1k82sytYpFYvLGXS
         xwR0gqi1EQqz+naYlzFg4f1tFCiJjul8+MY8qNz73doJFCp3oVaWT7cd9Sb5BP6kz796
         v2Yet1nXz8asfyrMsLfGaD6mjn2UeECH1slSTOO4PiJ61KZZ3abKDrgi71AQAtXRa/0s
         PWyqlVD8gA7iXpWCTcihoCCENbJ/RWUW3wkxqUiUazJ4UygTrFRWhvvySt/m/rK/gWFE
         H6kQfRdCOKAdyKxxEED7ozflr7BGhjI+lzBzd0OnfU6VMXMwwQdCO4zjnnNRnk3nOkeg
         LMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792865641; x=1793470441;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A8qm04ZEnsslWrxmP2BXYBkI/b++A42dT0ccYktbE+4=;
        b=kHqIpqa60aTmq3SSQHns1Pst5+exsqjp1kFgGBGPTWTFlH9MgdO2aoYddFv3kgc0Q/
         2/69VKgmthCirC1ll0FwHEYtHEUmAHTz7GHtswP5C4yCaJ9WusrW/BBxDDLgJo2Nta8n
         sLA9RokVagS5u+OxeULr4awfarL3T6gqLZdT1WCP2mr4pHYSihI01cZe0mOj28qChMsn
         3gIlQhjk37HzNDFl2jUbnzFxZMxkimMQxkt0yRLlJFH12ZuGxfRSfb0lbhM4IZo14uhB
         CSIObvUWw/XabEyyiX0JA/h21BF2c2OhQ8FsaP8eEzNMzWrirCzWDZ62TZOFF13cyz8v
         Ymfw==
X-Gm-Message-State: AFq9FYKeDrzrn4QGGrv+6Z5Bg64LHIpwbMvatADryZEggRrxapoDPzTW
	SI9mqdjn0dKDKL/YEMDVTB7h4jXCjffFLsAxa6ZVVTyRq1R2F7Rv6xM8KGvw/Q==
X-Gm-Gg: AYBFou2pRtGPXO3t2mV1Q4aFwAZaFlWB55kr9BgyQdd3I9lhCxlQ0y2YE+nYYsQ6Zun
	aBzNMJuivzo1xCzVK+ifMKlgL+OXaAUPVrOzKB13+lVKpP31TH1INNYfPkshtsBLoOmRRBq/d4G
	te+aT9njvTBh0tBd7hpSVg3jZ7ahUCq5mzvi3R53YvTLoMaj8oBQBFblS+aPZgTWHZw1v3LtaHd
	2ZVkvuuELQuAwqcYdI4NjTbFJmlbF8BINS87wDeCgycwRvsF/TUFt5dhfOO5vHq161YsipC3N3f
	sdcgDWGq/hR+A4ASNZTRjn+qK9ErXQwiIKH/5PE42NrQcPE7gxqHOVK/R/6ZeEbTRxmyoAnc6hM
	hWZaJFcGvTkdNOQYeqWCmsghnMjcQYOSW6esDbcSeIj6ekhhxlg49u/hSRB1GGib4Npt2S6OF2t
	rX3SLRQ2k+0vW9DbkgJVXKkUEAx2IXUfFbvT5ovIsL/IZDGYhGB1LzJ3EPyy/LbQAdkriBQf5WB
	BXFA+8isrt9O9NpMHqoKawaPy8s/xuqZeSPXCipWVW0gSThSAitu5ubyi8jrg==
X-Received: by 2002:a05:693c:60d2:b0:35b:244b:ca8c with SMTP id 5a478bee46e88-369e850b09dmr4211528eec.33.1792865641150;
        Sat, 24 Oct 2026 11:14:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.31.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm16073140eec.25.2026.10.24.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:13:59 -0700 (PDT)
Message-ID: <6adcf567.4b6e150d.3aa805.48c9@mx.google.com>
Date: Sat, 24 Oct 2026 11:13:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1500497614830485488=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Protect the receive reject-list lookup
In-Reply-To: <pm-bluetooth-objects-candidate-0157-v8-a3b1b1bb30aa6b263b32@gmail.com>
References: <pm-bluetooth-objects-candidate-0157-v8-a3b1b1bb30aa6b263b32@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1500497614830485488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192733/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      17.29 seconds
CheckAllWarning               PASS      19.96 seconds
CheckSparse                   PASS      22.12 seconds
BuildKernel32                 PASS      17.98 seconds
CheckKernelLLVM               PASS      18.97 seconds
TestRunnerSetup               PASS      394.68 seconds
TestRunner_l2cap-tester       PASS      13.05 seconds
IncrementalBuild              PASS      20.77 seconds



https://github.com/bluez/bluetooth-next/pull/1000

---
Regards,
Linux Bluetooth


--===============1500497614830485488==--
