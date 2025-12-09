Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B931691A
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315272; cv=none; b=t5oZ5aq/Jgp2ZseVz05YbVf8Rsv0/qZ+GnEa8TNnujStj73xsyjJRxOGrCXT0mM9RznD5dSramVsopE1KwdWXOcWpTo/59/OIO1es+adIA8AXmK7SMedScIS6lMnF4HMgY/qSJ0yPbUrVwSoFAyokY0wPXzc7r8Ly2Uik5y6XYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315272; c=relaxed/simple;
	bh=3nMnSn+ApHzwxdNY2zNnaiZXNslMPvNbFJxmMjj0GWg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D2aQLO/DkRck2k55vgPTTlnIEhnikJxY/Y02co8azvfVBKMhgZDmcMjcznnxa5NcRUk/wgpLnfsNusqftGEyolDBHOzIh9UbtT5R967DjW/81qaI7sCBRB7w2pKL4Q/YdsBdfiQg3QByPQZxZ8J57r8C/u5CZAbAe7iDmgZnVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdqJPu23; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdqJPu23"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2ed01b95dso529761485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 13:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765315268; x=1765920068; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnrev+jYDN9XQT2aPSCXbIcAmPytXDixND09kS6hbEM=;
        b=hdqJPu23pNQLBKBCqiBLUJkjqDrBIJK5CesLZdprgAqs6PnIJ1EyxoSmTbkMwvPuJQ
         llSQmbBtzYQfua/hcGJlD/QI7WMqXfXbEalmf9x3Lwv5f2O9vE/WVqN4HNdB0ZXfEQEI
         ODyG9wZ/+1jWmXxCL1Js/hIVBgC2SDNlp+/KMYOwCDDcWw30P4OmCldI6t4qTmPBZHg5
         E3dph4EoiIrtT8kdsbGyQt9iNn4+DyxXCFhDl325LYvsu0TiBjlK+UAI0jtYRm3aXXrW
         UFT8G3AHnR3rXxG6dQ9WVRavRhdOYU1vZLDhM9Drr4q1l/8IrPJDUTZVNQATdChgPYfx
         AX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765315268; x=1765920068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnrev+jYDN9XQT2aPSCXbIcAmPytXDixND09kS6hbEM=;
        b=I/Evw2fa1zIuOVTb82uYBDogTiuRQrGYfvInaANpfO/HT9u/bjCHZZ3p7Ht814cTHP
         bBNFd7v7qPQQYmXIg8n/tMt5s1Mu1kRQVbVDMYbYGRfFqHVG6Zpi/FCqRToXF77laLkL
         w5SOv4Dap67b10w8CB3gKapwQIwmclLU52owDfLNBbg22a5GrlIgi47v+KIaTBALQhxv
         Taj8iCddF2x2yZ6iYmdUmjw94tkULZqmurNG0bp555zLD/Y14t0peslhF03dY5nXW/53
         Gdh4hwE1rJ80+WI4RsPdfgVU7oCTrt5BkNq8q78c6jnB/HrnM+ASK6/R4UFeGmILqLp6
         +0XQ==
X-Gm-Message-State: AOJu0Ywn5XqwoMm2izDPPCH3dFTEiOl3ebDjglMvjHbur0Hj2hHDAffl
	cI2Lyz07aw/IBHEtyBFnnkGyL3MFOSHQIsjwLzmpA+vtHmLTQ41bDd+dK8Bjxg==
X-Gm-Gg: ASbGncs+7vqZ8kgrUxra+b06/UxTzYDB5Wphrn9l4NeuyNKN7uzmcwQnnxgbuBIWVWg
	CRwr/gz4M5pL6RGKHc0kuXJViu2+O2PYGuSiHXQ8EqycCh6DD8zpg2/s+dknwTCtm2M2CU0EVgU
	QE77Hj2UNXUEJCjFWhfNJyBouDfBoSeuU4q78nxnFYFtmpNXSvaFLxAhPHDwPUKH+KBCMHwXlOv
	B5UFZpcoCKalKxbNkkATD8EB22vESPbzGKTC2i/O/vuQJAFHaMPE+wLfSCcPPTMpgjg9tUB+vCL
	BhYK7exn/y2/V0D9uBCB+BiabKiNbUAUJUKs6H8qNaQ9kecBDWSmJJcXIgMEojtkLdlsgeo5U7q
	EP9OPr0dtyUQEpDWuEStBujmKV9trQa8DoVEycs1NnOKvTkhb8U0u8978YHP5zxEJ7nJuM6+p3z
	EDKzSGBi6w8TxRp48=
X-Google-Smtp-Source: AGHT+IG51Ego+2zfKq3sZIGUJUVojzJtQJwVN/d5ktShVUQM59kEArc0G7UGPS+sfbxS02w7vYJC9g==
X-Received: by 2002:a05:620a:2548:b0:8b2:d6eb:8203 with SMTP id af79cd13be357-8ba3a666ddcmr71555585a.69.1765315267867;
        Tue, 09 Dec 2025 13:21:07 -0800 (PST)
Received: from [172.17.0.2] ([20.161.60.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252b4328sm1363019185a.14.2025.12.09.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:21:07 -0800 (PST)
Message-ID: <693892c3.050a0220.49578.7f0c@mx.google.com>
Date: Tue, 09 Dec 2025 13:21:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0232008835996001074=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] unit: reduce macro expansion volume
In-Reply-To: <8da87c1000bbbb062d302b74518351a8ba65075f.1765310255.git.pav@iki.fi>
References: <8da87c1000bbbb062d302b74518351a8ba65075f.1765310255.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0232008835996001074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031813

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      19.94 seconds
BluezMake                     PASS      635.97 seconds
MakeCheck                     PASS      22.07 seconds
MakeDistcheck                 PASS      237.44 seconds
CheckValgrind                 PASS      297.68 seconds
CheckSmatch                   PASS      345.96 seconds
bluezmakeextell               PASS      181.79 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      1021.97 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0232008835996001074==--
