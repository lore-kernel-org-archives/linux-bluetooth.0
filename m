Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18C1CEEBC
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330334; cv=none; b=iyrx73qEMV/Q2dYfZxa+kuN7J6QuFJdsc1aL+nmOkxDmxXJmtvx5g2Td6An+oS51853eCsdKh4qTOeXw45YGcW7uf09PvSaqFKrthLkvmlMXOjV2THS39Z9Wwelowi+x5DhgupGyMWj7VtbgzuKrJZxTKjxwAlLy7rorUyyq1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330334; c=relaxed/simple;
	bh=V89o1QCGoPIrn4pkqWOVZOb6Y+U526MmIvoypHCf/7M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=exo/IEzgsW/C86aPH4mehK8nCi3RmIlsbnqwtijotGVhiEqDu/fLQJUY60toLeXNlKNUlvnabG1TDV2Ds3SeLyt6tDAOK1fajHLsYtEWIqJgciQ/KlnJURXOjAcMBOg4jGVvg3ctq/ZSrt65aGyg99E4adTv61awwioCCjaFE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejr2bOe/; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejr2bOe/"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-718816be6cbso2419277b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726330331; x=1726935131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAYd54xwbeB4ivrhcCIdqlVDBdFRwk6DGssNxk0lvmM=;
        b=Ejr2bOe/tazVLz80pAkuhT/UuuoGE8pwxrVBmAks8FNBFqNG37+EWd51MZnSpiZqbs
         5GO08lyvcKNdwoGfpJe/g3LxTKcKgF7xExo9oTARVUJsm2er4Zwj5tLrV+m8ReaE/48d
         a+AoPBnDrwCw+tV0PYhjls4NhHCn/pQDkeie4ZRif3UHsds/YpYlZ5u7yULencCFqOrF
         C41LnQBAij73CetyCEtxcWpGMfnJxkOGMrde2vyUN0IhiP8wJ1etQLKRfRUzEcHOptD/
         0zOSkWDR663/ILvuXyOWGDMa911boVIoDpZM5Cs2Q40CcpRrhPZ0jN3o5Qj7cbyJ5g9X
         iATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330331; x=1726935131;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAYd54xwbeB4ivrhcCIdqlVDBdFRwk6DGssNxk0lvmM=;
        b=uFGHr1dAs07Z+rG3khdFidwKx5Gx7X0ADxnAL9Lg4+cKqPXBrqJ3CtWtNpKTuAlXvY
         H9TPd//0ZftKHwNDmWqcRxlwTxq3EKA3+l4riQCYF8386BT+C7b5TMbD0N/RGTMEJvz8
         tVGTHtEITo7vRUXCDo29K9V1lPwJ2jnfmN4/YafWHiSe3tVnM6oysrJ9fNPg0pPeMMtv
         9dohOxC8aAKc2tPpql1figS9f6ACvLXjd1+elMLmEBu1Nz/4Bo3ymY3UVF0996ieiqh+
         n4Uv2To7OTOJ9E/imAdN4/EGriSQh6iC8sG+SSqErD/btmMWnneGKppI6ikbneVcio4N
         fHlQ==
X-Gm-Message-State: AOJu0YwYdoiiecAwLZpMxsMPpy+b645xe9B8zzAUL8MeQyVmH/aA6R2c
	t9+P4Mm6novWY7sCYaOXUscMFWMXJSEQnrISTXnk+GMPUXddRlmTXWdfcR9SPFs=
X-Google-Smtp-Source: AGHT+IGRMdt2G/OgZ4ue5DFz5rzboRLxyKHM77SI3Jk1cVPf7xnW1C+oeyYriOtNWeJy6AATbba2ww==
X-Received: by 2002:a05:6a00:1783:b0:718:a3c1:60f6 with SMTP id d2e1a72fcca58-719261ecd95mr14126818b3a.18.1726330331370;
        Sat, 14 Sep 2024 09:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719449b370fsm1150474b3a.0.2024.09.14.09.12.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 09:12:10 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <ec0ee6ff-f70c-43df-a4ac-a21b1f109b8f@gmail.com>
Date: Sun, 15 Sep 2024 00:12:08 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: monitor: fix buffer overflow when terminal width > 255
Content-Language: en-GB-large
To: linux-bluetooth@vger.kernel.org
References: <20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com>
 <66e5b39d.050a0220.34073d.206c@mx.google.com>
In-Reply-To: <66e5b39d.050a0220.34073d.206c@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-09-15 00:02, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890395
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      0.49 seconds
> GitLint                       PASS      0.35 seconds
> BuildEll                      PASS      24.73 seconds
> BluezMake                     PASS      1696.44 seconds
> MakeCheck                     PASS      13.31 seconds
> MakeDistcheck                 PASS      179.41 seconds
> CheckValgrind                 PASS      256.32 seconds
> CheckSmatch                   WARNING   358.63 seconds
> bluezmakeextell               PASS      120.73 seconds
> IncrementalBuild              PASS      1407.21 seconds
> ScanBuild                     WARNING   1016.29 seconds
> 
> Details
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures

It's the code already there before I touch.

> ##############################
> Test: ScanBuild - WARNING
> Desc: Run Scan Build
> Output:
> monitor/packet.c:529:1: warning: Potential leak of memory pointed to by 'line'

v2 has been sent. Add forgot free() and send prefix "bluez".

> }
> ^
> 1 warning generated.
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

