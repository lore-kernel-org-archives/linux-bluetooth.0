Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD1EACD
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231727; cv=none; b=a4Uv/X0TKIBnBzUY07XlGuFKNT5uw1GNwuEw8b+ZnX6zp26ToNY1nnQD8jQwaMvxxrWepwyvpgHFY7sW/ZvMqDrNHATQypaTX3lnje3WyO0dcUijyZ7PEo0ah4V7LYg5rqymNcMfpuHZfOor6gLvE/ylaxu+2K/RB5VYtL5Bfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231727; c=relaxed/simple;
	bh=AN3ColVWzD9PcLfju0a1rJ0cxJ6QB+Dtoje+7eY/+T4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tCtkCbaYZiH8hh/iKOwzCVAUG6uPnFA/xfCNFGEMDTFulIfx5C/iQLwPk3V2uvj6RxlXtuv8F81HP0uG2k4KNO6QPALU4eEEDNzpmIoagiSjKFwdXoHnmgxCYkB76K756uLORWGcD/w19JEXVbtokJIMrZ/mLTMlf88rOtrsm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMN/GCvn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMN/GCvn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225e3002dffso45802635ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742231724; x=1742836524; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Td2AE1U6O0WZpPmWeOvTHeod0SEQFHFJ1xfG0tG2hM=;
        b=cMN/GCvnelWFEBZAswXyvAEMJsLI9DE8SBer2OKhXbphCSRKhLdwPgzgQ8PT6BZOFv
         14O+y3pBgEaZlq80qF8JHqOHiJJvpirQmLZ3IlZoWFFMbTZfgQyqcEmPlEEfqQjYoVw/
         2BuSCIRHhVjdo9QDjXy65QwRziRuEIgqHutRp9TjlG5PA7X7JCB7vly4kn86APKZlwyS
         YFf8nYCFlvAd1gnjctsyubMyTrG/FAhCPus2Xg4mQbm1OM/w7aeQ+ee09vk88knSohoS
         jP1onw7ueBAz0N/fP9zRma6cTJlPGr6199ex6uzchT5Mis4ZYTj0yCgZtaRIXoSnOLf0
         ej2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231724; x=1742836524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Td2AE1U6O0WZpPmWeOvTHeod0SEQFHFJ1xfG0tG2hM=;
        b=nasgTBgXp03mL/v+nOR5yu1a/uYD9nhOJpYHsAfj1OeXSbDYGqu2LG94h/B0eA5pa8
         zoN+ZoCXH++dGx/olAiV4+lh00TanaArL9Y/HwpJzVRzx/Q7PtrG7vHgXHCpGQ8Kxx0s
         FYuLwLIW9Zp3ifdpgehCuEIl9R1QS7w8nBUkEhqF7byGyRGRkhv+8+JuKpsakhnkv3Uf
         QLYkw8oRFO7tD/P2nwAcB0ZFQM2WiyPypbM0was+fIZTBddbmO8v/L02xPEb2hIS0n28
         u+r4Pc1YeCfo6btuxT2Krod3nQYo+U38MT1EqLoE1i/x/8r3BtzIIl2TtBbFYmWr++yz
         NLOg==
X-Gm-Message-State: AOJu0YyNm42fajrMSeEr7I4Ld2jmEWvgZnNoswqYHewgWKjVAkg4QBdb
	i53TxLutllDhDYlP0d5aF+wiR8QtSPhbwdmzvEofhlMJfoY6lYL1K3mNLQ==
X-Gm-Gg: ASbGncu7rViacsjQ7Rz3WYK/a7EMHPI1Wfyj2Oit5RZqv6+vTad+ln2iTP10yDNlpuH
	Yk3v7BzD1hpfeGgS7ibwxRlOR0JEk/CQaAuUTWlAmTTr43SkCEnOaOkUeJRSiavjZLaICyujNCE
	m63UHcR7q+iOu7VHmK5knUdbIYEs0eBHSs9Yamtv2PcR7NclcZD30wkP2XgskgVbqdmQZkjFM8b
	QbDDE9S7mzQEorteZeRJgrHdIW7yvDoaf16sefBPtDacLR/uSGyfxDyzryO9B/L8I9vVpz8Tnr3
	sa1lKVfYvxR48lx7OsqRkKnh2sDdNB3R8Xukwgw7rob+YiEZBguv
X-Google-Smtp-Source: AGHT+IEBu8WFz74EqjkRW2rEq5ARQiPaghL2TKMb5CJDdCBFJ/Q+72UyB1VF+h0+n1qZtGJgxHEgug==
X-Received: by 2002:a05:6a20:8416:b0:1f5:8a1d:38f3 with SMTP id adf61e73a8af0-1fa43aceddcmr683837637.2.1742231724429;
        Mon, 17 Mar 2025 10:15:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.103.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695ad4sm8096106b3a.132.2025.03.17.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:15:23 -0700 (PDT)
Message-ID: <67d858ab.050a0220.292175.06f2@mx.google.com>
Date: Mon, 17 Mar 2025 10:15:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6805731528692584781=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/hci: Make use of util_iov* to parse packets
In-Reply-To: <20250317140440.470397-1-luiz.dentz@gmail.com>
References: <20250317140440.470397-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6805731528692584781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944727

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      1454.62 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      159.41 seconds
CheckValgrind                 PASS      216.72 seconds
CheckSmatch                   PASS      285.22 seconds
bluezmakeextell               PASS      98.16 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      895.05 seconds

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


--===============6805731528692584781==--
