Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FC136327
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616407; cv=none; b=sfHmL2byOJ/nUJT7V2/LbY66urJCN/QL8LzZoNSGw9SmF/hlHZZuLNiZ1y79YwspGjDuamNViSpa5z6BKOVwROd6OhuGTSrY9Bktg2M8o2MV4hW2avPzHPRwLSTn1sfgeB4UGIyqUc7oxhWpvSX0/gP6XD8Pr+NVI3KseTpLhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616407; c=relaxed/simple;
	bh=PU1YCsTUfNqRHoRwM6+c8JhIdQmZfAjVE6CEgytO+Ss=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ts058Me+2Bs8t7LgJuJT8UtNtBfsTbSEV8W5zUHQyNxbgzaIf0AiL/7oRfpobSfvA59vhR9Dt84ig7ifvfTYrsCWsoACL252//xFlZPOzfZB6P1CJW+y2We+Sard5IFwwlBkoLzBM0pXzZoOKFs/vxkwQijkuHkkizbVoVOCOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci1eN/8f; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci1eN/8f"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so10893395ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731616405; x=1732221205; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EeEGln19QRILJXkQds1ifN9sNlwXAkSbtp/ZaeHrYkY=;
        b=Ci1eN/8fKbYo2eg78GliqHUczXVtUZt/ABivWRZmS/j2z0LxsCQpCcBOOQZuBeWYlL
         jmzrYncD2vU/Eh5+u5EI0/aS6wU4STpma6kUSdvpiNGsUfyDnf05V6gjUrEoWZ1Ceuoj
         SfoSSI2UQjAImigTfQX15WCKEVk7DjQ5Ab645bb1OuUl0nGdcMBlKuGQSJ36uETfj30N
         72Ye4qeviykiKKE/SgsiaKJOjEaqm8c0GPUH9HEdba4b7lSBr2tM/ui6Ycae+L7Qw5FC
         3Fzz1HGy2+tGGZB27HF9pLnXx5NLTCEb/cLZpDUx8Bp6ciFzzffA1iniBWGA9MBbSfDS
         zlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731616405; x=1732221205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeEGln19QRILJXkQds1ifN9sNlwXAkSbtp/ZaeHrYkY=;
        b=okn83clHwnFHabbvxb0/RX4fjcCDa5K9QJUbPZjXkakxzcjArqCcEyqv7JYsLq0VoU
         0YZjeRsElnidm3QAgGPKaP3eYXzyetrpYzwrQwF4u+wBJvi6pMC08PN/9rPz/YZ7BcMf
         dXghcHX40p01RMIEwR8RkvXWkDdXj1vY5dmtsm7HTg+NOpvgwaTbYzXoSOrwF6Y6afyL
         n596gBXbplJvED5UrXwqbOE9ZJheV39QtxQiyVhwPrKNfB6dGkHSOzXLzhIK4dmN3KZx
         m1ORVvpIHjrxAfqWcpkUsbSoSVP1PVL+Qegid1udhH2pzunnPEiWEP4pp8MsJm8WJocn
         XEww==
X-Gm-Message-State: AOJu0YwgfVD9DguvS1eeTiCsgk4rVFGnyqcPRQRs5odORLx89XR1UbFD
	WlTHHrsEnukqT1ONUi74p+mbyCxj6YNEURQm9ZnkeDjIs7oqCto1QUfpNA==
X-Google-Smtp-Source: AGHT+IEX6V6+2Qhr9ZYBpjmd37mGAH+JT2n+awzVS7GtMFWpWejvcCZphr/ha1RXFGyCd/WxRlgLgw==
X-Received: by 2002:a17:903:2450:b0:211:ebd:e35f with SMTP id d9443c01a7336-211d0ecb12fmr1849335ad.39.1731616404541;
        Thu, 14 Nov 2024 12:33:24 -0800 (PST)
Received: from [172.17.0.2] ([52.190.140.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f61670sm331705ad.281.2024.11.14.12.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:33:24 -0800 (PST)
Message-ID: <67365e94.170a0220.2383bc.0180@mx.google.com>
Date: Thu, 14 Nov 2024 12:33:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3623233644918388712=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] mgmt-api: Add Send HCI command and wait for event Command
In-Reply-To: <20241114192524.1856334-1-luiz.dentz@gmail.com>
References: <20241114192524.1856334-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3623233644918388712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909740

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.85 seconds
BluezMake                     PASS      1669.08 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      158.31 seconds
CheckValgrind                 PASS      216.43 seconds
CheckSmatch                   WARNING   275.04 seconds
bluezmakeextell               PASS      99.28 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      857.74 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3623233644918388712==--
