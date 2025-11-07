Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A967299944
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475622; cv=none; b=lJYy1CfMuJVTo5m+JfdyTK+B58N6nCBNHEmG01JgYfLENxmjhijydes8VgATerdtZCVk8503CuwgEpOkHr2XZsEb5l6J5sJcPM/QrXB/slcOK8nYn0SE/lhi49QhxcaMiLaJ9wUVewWr0w0GCvh4yFTCY2ExNYSthVqtW8LqhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475622; c=relaxed/simple;
	bh=juzhH7SEnoareSs/Y+PRm2Wiz7Dz3gpeRfelSgwlEUQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a5ydZN8+yT/GVheAdyWXi43vn1kTMgWBk3JelO3bNz3CORcUB819FwWwbB/3RPtnE2MiKLcHFMEbSpbLH7CTVLfHzYt+pMvQ9bI6UcEDiIuXakAyLR/1THftcCNTiRE6rynjCHM/DVJyyo4CpTGtKlbG+AwW3vyLzzJ+2Tz+lAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyGN5TFZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyGN5TFZ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2148ca40eso33111985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 16:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762475619; x=1763080419; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw3XqDQWExN7ZW3UznLr0NOBi9ddCundfaf+lXUTab4=;
        b=iyGN5TFZVK12ggXnC8bB+9YwEaA8MyAaWtHMTTQmTMAXmWuOFFvmVPsCLRgGVFaMQc
         LfnRaW9io7QRTHfAkkpDEL7NT3/4chxErylZr9DTIyBQuSF2A1FnSZJ4A5BjYc+ZWSAK
         QkxLW6r7Yoppquhhm/vLydz+FztXqByRGg1yv5CzbXyaLD36pLWpodvd/Br2/wJA2ReT
         w7GSA81oCzf6bDkbW3xoofVE7Qn51rAvBrPafibmNdprhkG/OWpeETIqcxqifYtPG5Po
         gPOAdZOKu6q3NdEJ763LZHNCmV4X3LIX1+2haqgPevrHtZdGhRwe9jPBkHZ6KSmQa4fC
         chig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475619; x=1763080419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw3XqDQWExN7ZW3UznLr0NOBi9ddCundfaf+lXUTab4=;
        b=kXYILOczv7UXcvUKDI/aR4FDPMsI7twhZaY4INAmLTGLCvNUMMRkx4kpB2htEEUafV
         Hmylti3xGo6JTzieRT7fBVb+Ofs4isY+xnzeRtcjPTqWBvJecrIJy4KCD9RIDQDwGzxJ
         FZNaezyci+ThUURBdmaJdB7NDXlyJB36HoY24j9NQ1jZDKT2bnQAUe+upkMmC1VrDqxh
         eIxdHBQRyRKuNs5OUOlp3pPHNAkpuJQzncnWhyGU5sT5TQ4motPiuF0aWpX86h9/g777
         37NrIpyuXFY5YJnjd9jNHvHyt648RXgVE7nqf5ujKY/CPDkRS8Ed2VYR6kgpm/60cOdq
         er1g==
X-Gm-Message-State: AOJu0YyJJAXS1HKfYuIUlzRn5DM2Ks7328GT7uAXgLjhfErzC7Vv3J++
	QaeKlqXaeoKWncEczzEbRZOyb9XRqcC0AEtHD63EiAEdQ31ZMz+upUjr5t+uhg==
X-Gm-Gg: ASbGncukR6j9ZEaip3MBLCo+7LnlpzN1OB2ix8EnNzHR+SZMz2tRJ/32Fp6MXieA4b+
	GyN3TvGzp832PzuwCCYfvvvDZ+ku70PtAeCBN0mPBJsH5u27UAPUqSCOTdvbv7rCr6DMYUP7ngZ
	fiIdqnoDlFn38IrFkkbd1LOx5PXl/zmU4bsbJFw9wTbcxuN+/ddR5SmMh0VM0wztH98ha5Cv3e+
	8W13ZD63SIK3dVeipHhlt+B/43wKigpkII4dzRjWeEYh3dDJxAbvA5DXDClbkDZgcLME9GL+k9n
	uShR6W8h8ecPDyv8bVxhAxcbZFoCnirPqaAiOPLavTNf3ipw5Ud84LkPikDzKTsK9+0rudj+wWW
	o1OrVNua1/zK3afBvQlxC5N5Da8fUZ8on900JKmlVIp1EtFbqfcoajYenhNkykCMRhIpcvB1vj+
	Cf/SrdWhAf
X-Google-Smtp-Source: AGHT+IE/4VHDh3UBg5MdqcfLsxxy0J40CfsDkf/QSJIxZcvHifcJJJcpUKgOTIqj+XqkCTHCUb+/MQ==
X-Received: by 2002:a05:620a:17a3:b0:85b:5fdf:69ef with SMTP id af79cd13be357-8b24528c4f7mr222657085a.30.1762475619200;
        Thu, 06 Nov 2025 16:33:39 -0800 (PST)
Received: from [172.17.0.2] ([145.132.102.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580b649sm296571485a.48.2025.11.06.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:33:38 -0800 (PST)
Message-ID: <690d3e62.050a0220.3ccc23.809b@mx.google.com>
Date: Thu, 06 Nov 2025 16:33:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2262144895780902154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] github/stale: Fix not removing stale tag when an issue is updated
In-Reply-To: <20251106162615.745878-1-luiz.dentz@gmail.com>
References: <20251106162615.745878-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2262144895780902154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020539

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      2700.80 seconds
MakeCheck                     PASS      20.40 seconds
MakeDistcheck                 PASS      188.89 seconds
CheckValgrind                 PASS      239.04 seconds
CheckSmatch                   PASS      312.90 seconds
bluezmakeextell               PASS      128.60 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      915.53 seconds

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


--===============2262144895780902154==--
