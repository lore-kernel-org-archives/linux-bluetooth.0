Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6A1531C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560546; cv=none; b=q2KvbxU7uJvgCHQeyhjmbg53/Ads271ZI7WUureiRbWBgKG6h77ljej/oVcQsahYJ033SdYhG7qWwV6gaWSoEJPr432JthqNN4L7Kv6XdUALspRLZYgMwoCJc/VkxI0JERUgUkeUreQpaUIwLTSSwICf9IkFhU2c+xMCjr4dsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560546; c=relaxed/simple;
	bh=6nCF3kDwxVjDycX1WjeBaFsGR4vf7p0PaSGrHU+pSPI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eyzKaYQkQFPQfqZOj/AwCuYUoSMRgGYo8Qmxm06wIpkJZ3L+8YWoVF+OrhezAXwZ7o+4/bjMb3MPdHWryQc73K6EnFq4qEOe35m+GmFVDoFZZyYlWDkIjlbHAovM11/wbw/HbRQ0xHZiUwpfrFJHWlW/4mh3LmUmeQeO/XircBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL4ae+LJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL4ae+LJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20551eeba95so36661285ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726560543; x=1727165343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VwxTWh/dwDOTanVKObye7b4utDnLoHHd49QCyd1oRUo=;
        b=EL4ae+LJjgLXyvTSmS221fjD1VXIxfiDguV7j24+dQrwh7WQJ1TCE5POGBJli/HARl
         7FOpYxMurwS8sKINDIsTBYhBqa4DkA1WmWRLnE6Ml4KaWVIIk8nr6MLPaFjWpCDRZL8T
         +dkH41Tke+rdjKsK4g+J1bTOKtlceMlOvF8qs68Pa2q+hBGOY5yXK9NFEgLKgFtkZpuS
         vBQwayR3DiQ28IhIzvTW3vpItyC1XYGtkLwksQHUbxge80pXLRBLrgrrcdqdI4weSD9b
         umbo9RtTVBFpBIrxrI9xhEC7VjIJBBILipQtylNL7lDxxz0V/b/gEkRzr8re8N4fTfgc
         P3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726560543; x=1727165343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwxTWh/dwDOTanVKObye7b4utDnLoHHd49QCyd1oRUo=;
        b=mBORiY7M9GwfrHL/J9QwsLgfI2N8e/V3jbWbcbOdyOyeVPUBiMMkKwlwbK+zPm+BCt
         nwdRcusfZvDjjiKzJUSlmETk4LZPnErZFhxcLmtI0MVZcFeOYtlcvoCK8QO2nS1EyAE1
         jXE4UvhCFQ59tBU2Q74HTS2uvGFMd/44Mg8PQ+ZyE30zVehCIPuOKAjTnDCB0bEDQ3Cy
         VkO5uKuXWAwe0gTlJ48pRu1mdtIFL6lon0NwOMWh+qYsxFW5fvhu25GTOyoZG0J1koIQ
         Zh7xFgLg7RLABm+LOSBKNoXtsMZYGQda2p1I9xLhCAXgWRVMgjWjL7l3ueImQqUV+j56
         OpDQ==
X-Gm-Message-State: AOJu0YwxIrTpHT4JO8TCVlXZc93+zd5/384oG+hNWFf15WlidxfskBZU
	6IWxSMIzzhd8Y9iNNoCSlyRIp0fLhLY9AERo0kIKMMPJ9JEBWllwc+GkOg==
X-Google-Smtp-Source: AGHT+IGauiBXOCZQEibf1L710GYYavpBJyuVTofy9qdiA8c40cElO75vwSOm7AuSoeAArIyr+skSSQ==
X-Received: by 2002:a17:902:f541:b0:202:348d:4e85 with SMTP id d9443c01a7336-2078296a9a8mr197553225ad.39.1726560543383;
        Tue, 17 Sep 2024 01:09:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.141.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947356e2sm46242565ad.250.2024.09.17.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:09:02 -0700 (PDT)
Message-ID: <66e9391e.170a0220.355c7e.eb61@mx.google.com>
Date: Tue, 17 Sep 2024 01:09:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7402111237841986210=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, coelacanthushex@gmail.com
Subject: RE: [bluez,v3] monitor: fix buffer overflow when terminal width > 255
In-Reply-To: <20240917-fix-log-buffer-overflow-v3-1-26fd441bb7df@gmail.com>
References: <20240917-fix-log-buffer-overflow-v3-1-26fd441bb7df@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7402111237841986210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890823

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       FAIL      0.45 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      1727.17 seconds
MakeCheck                     PASS      13.74 seconds
MakeDistcheck                 PASS      181.34 seconds
CheckValgrind                 PASS      259.09 seconds
CheckSmatch                   WARNING   363.88 seconds
bluezmakeextell               PASS      120.05 seconds
IncrementalBuild              PASS      1423.05 seconds
ScanBuild                     PASS      992.04 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez,v3] monitor: fix buffer overflow when terminal width > 255

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (100>80): "- Link to v2: https://lore.kernel.org/r/20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com"
24: B1 Line exceeds max length (99>80): "- Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7402111237841986210==--
