Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A71C1F20
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572659; cv=none; b=p/bOFh3hNIbTE/CeE25/hhmh+e5J77uOQnKSnrVIA3OOCoNsVRNNtQwXhfFFf4ad51FtRb5/l6Uv6qAgy5CzxfGXY/E7cp8dohEIOpVWvYas4Q42PtvZIh37fnBi70yCgg7HF895PknkC4pxH62JSwb8Ul5P9934FlcLq02lvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572659; c=relaxed/simple;
	bh=8YqjZVpgwhf66GWOTlVo583dQdxYrgwJ4ZwR1QbRtXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YhLWGMFFHAeDo715D/LIeFC23NAYvVZ/RNL6T8Up7tBfIK2OKSTttrFzVP0fzAk2G5kOoQ1Y360WUrMlHpT2PmehX35idA8llzhT2qkeCMUKQUj4jgVz3mA0zs9H5JN3YDP4dEy4ZQdruhhLyFragip3QdmdFiwWBMtRE8/CXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm/3tPP6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm/3tPP6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-211fd6a0a9cso36289465ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572657; x=1733177457; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wUePQBy4rCBrDdPhKvhknjo5PSX5kz9XJf2t+wVOa8Y=;
        b=nm/3tPP6ucyCXVnY6FzCeAEKes7NMv2t0+VG0SDYm/qngC9DWkLc0im3GXKMp5acXy
         FHcq5sTrEs2n7sG502OB3EfS59pqjfKhkEAKda5CFhekf7dWIC4je+IWXMbZ1h+PYfKV
         JFDceIg+lYb1oRONdKH3a5GnhhDANaLNXbVBT5RUAZ9dzVURatDKsQ/9v9wtJzmt/Htt
         NEyrmW8z0hjOF9P5ayaN8DlpzSvGBuxigTtCJauypW3t4ppxkhMKQKiftaXc5tLFatnL
         xr8s5xHqU3+k3wsEuQGn6J7XqftsUkEyFBuVBdT+KgwXDnLNA0dgU2DdpBkn8BMIQwy9
         2MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572657; x=1733177457;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUePQBy4rCBrDdPhKvhknjo5PSX5kz9XJf2t+wVOa8Y=;
        b=DLqQ5KaMORwmYWEpiKlkGO5DL5Jyf8D9Vu/JgkYvFSjji6rCwMB/IssxWNAyOSI/KD
         F0K6Q/W5jTxqs8cv65memfgN6/uZQC6aapIAZc2m8Q8YgS2qsdGj9D9SQR50S6CYn3KA
         dW4e5xpIyDJ/jU0+jHfcKuW6zGWvGTeI1rTQPsatYJ4FtJ4GnnKACvor+AjUwf9vxfQg
         UMT+OUISvGjok6vnCUvIrS1K3EhH8K2NzOb9kjseKcaMrHGHxEr/vgYnqLfKe0IP5mCa
         b7ToptWRmymh6VCAWmufQDOId5fie9/t/2qNOjVxjLicsAHXksJ2ZRq5kHCsSTUSAA+m
         pT2g==
X-Gm-Message-State: AOJu0Yw61DEGapdkblqKoni2gg3zTKmWKELyobpmnhooHaXoujfX3cB0
	P/+j9g2lA1ih1jMIli+lsSFHI+1VbR8PDFXH8Ke3Y0JhN+sKhvkbsuYOEA==
X-Gm-Gg: ASbGncsa7TzttosH6G9FSRsNtCvxkpwjzhe0QRmSVc5MFnY8koQ/Q9LyPNPoTwHXWq7
	lzyPm8yRNByRrUyhddGP4wrZCtku3ZW7TxngF4aJgQatxJGV+i28pguY4BRNgf16o3v15nqrMDw
	6XzQQex1xTQDpxyVuJCuVpX4finn2zod32QeAOaWmw39DCjZXMZ00B5ZZkHWhihGqoK4dYUwlRu
	Fz93u3XffRqZwBRudWYZuC7igv9SEN1YPGceP9oUwp/NoBzSRnS9Hs=
X-Google-Smtp-Source: AGHT+IH29XTqIYNZBGupOwbnuh14gdfH/Iv0uWGe9dSViO7wBVh9VGUidXlQnd1iBr0FyHxvLJm/Tw==
X-Received: by 2002:a17:902:cecd:b0:212:5b57:80eb with SMTP id d9443c01a7336-2129f21a124mr230180865ad.1.1732572656960;
        Mon, 25 Nov 2024 14:10:56 -0800 (PST)
Received: from [172.17.0.2] ([20.171.46.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2a763sm69874155ad.273.2024.11.25.14.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:10:56 -0800 (PST)
Message-ID: <6744f5f0.170a0220.3523c.034b@mx.google.com>
Date: Mon, 25 Nov 2024 14:10:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4324858190294741806=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] main.conf: Add LE.CentralAddressResolution option
In-Reply-To: <20241125204711.719853-1-luiz.dentz@gmail.com>
References: <20241125204711.719853-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4324858190294741806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912341

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.68 seconds
BluezMake                     PASS      1584.43 seconds
MakeCheck                     PASS      13.15 seconds
MakeDistcheck                 PASS      162.16 seconds
CheckValgrind                 PASS      217.24 seconds
CheckSmatch                   WARNING   275.69 seconds
bluezmakeextell               PASS      100.06 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      868.90 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4324858190294741806==--
