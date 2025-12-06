Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690722127A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764992361; cv=none; b=r/jvkOijQvtx2J8LwFAaYpyZJM06w5QJtFhEVRjR78/t/urnwbcWv/Erm7EKLbPsrofJl13cCadpGWqhNMFxA5l1LV+5xodxgPtgzolG4fjsnVbqyBQq2lARndUfvQNq685nyzBjbGywOOjf7dFSSRH7LMYOsM8hPXPvnOy8T2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764992361; c=relaxed/simple;
	bh=9iBfutDgo2tlvQBngaDZT5+sJzt4AVkGKjDZUyAfFlc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g6H6hKm7WSSEUxllBXroGyl0s7ZlgX/awaQjOXesdq838MSi1WfKRpJAyHhx7H/9yFVlNKBfcDDOAX0ZxiH8I4MxHVZhmp+Okh/nLUYW0R88jloj6j3c9gaPlHZDWbYVyPmkwtjMn5HR2lb+secb6bUAoG3Lx3NQ+dXLXF3d+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVZre2Qo; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVZre2Qo"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f02dd964feso7751371cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 19:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764992358; x=1765597158; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oT5YrQ533tmfytEy5Qf7LnHDupB01ZVdi+Mu9cfJ02E=;
        b=YVZre2QoLfmfP7I+4Fnh/yKqfCPkyA2wqKedNjI9AgI4U3DlwYWi3SElFItZAe9sVV
         2HsVXd2pJ0gEg8NjYgK9f3exsE/O4i9YyDrCvgp+fxBdHzqg0w1faOw008/iziDw5Ltj
         2NgmaBWNQhTDFh+YQOanZzTnEFe2s2O891hY2SATjfV3IFOobcdb6CzvAe/SvRfI5TkG
         2qfy1xK3A1496VGUr4RuTCul45WOab2zaQW+FGzYPaMVcUtj+HUiJ0ZrjI+/YHAA9Irp
         kTdU5OZ04qybfZKDUGOaaXnnJ/sm5BiGkhZIf8wY0IbhH3sPjq5eECM9/yDx+QjYV/3g
         Rtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764992358; x=1765597158;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT5YrQ533tmfytEy5Qf7LnHDupB01ZVdi+Mu9cfJ02E=;
        b=MlkTkoTndrFCz/A0oNNoTVKag3xgtczfP0YLfEMSaucU4XRT4HQMz1FSYR8MZTfYqz
         SDByVuo/zkmCBxXnO5ilT2kk2R+7PhnLAR0RZwl4XVK2kk6KsYQMJf2omcRqq4eaD5zE
         yCJWHwaDQpcRwzJRaewIiaXZtZTdAZ/ge8J5XOOuXbU7UAw+sGYojIyeWBwsHA5do9iL
         BbCwZA4PsJR8MELMTBBaV+FDOsn9vaDdPWmG7S1RE2mHnH5gRZEvsZv3KMslZU0dRn0l
         vhKd6XdLlgmbCPbRsB+rKDwsl9PpHORfd+t8O4A5vpESE4VD5rIGc8OplIZOEO3taBSb
         IDDA==
X-Gm-Message-State: AOJu0Yyy3YqDK+sf23Zxm7xq/y5FPolZ9c+9ISjrALG8dDG73ycuUMH3
	q8VXCOPNEMeeqOQpMBIqvpaQIz/nunMvpNkWJ08ByMh84a35hDnn6ywtzca+cQ==
X-Gm-Gg: ASbGncsE38OnFsJktJqR5jP3z/ysKrhZMgr1JLfbT3huDmqDy4zXZYXQGESNFjv6CgH
	dZjPXCoERKAl7GpbJ4kI5GUv4Q3WdPTp0VP0/A0n8FVAVvGFBcHQma3v4RoWyJYyIJsZqRWHPaw
	6+/aym9Jz2EIPREH6pTcrqnj1erzPbzVGc5DTjAO8T4WpaUn9WSdCGRPo+ZrAjxlxo+OsUHRxO8
	kL75MhLJW9wP9Ahr1cmJRon0AhiRVQTqoK3TT3uG3o/NX9z0lVPEi5drZK1lgeMljOya/9uxpfb
	43HEIVRNczokX683uO0LxK7IpOkm6IIyCd6ZTaZUpz0xeDcjrfdetvkSBz69ij9+2tPsA2m26Hf
	eC4U/EWzEe9sjxk/hF36YvgJrpadfXx4SyOW9hvNRZYFQPn3GNpWpI1TxJi+Uf/CZmTQBM32Ew4
	T6BKaR209gW06r9nV4
X-Google-Smtp-Source: AGHT+IFosulRub0YEyZiaGOcR0/whscnejMiLBXWqWxTrs2y6j4vwNDVJFAFMwQX3km28uaco7rjyg==
X-Received: by 2002:ac8:5fd6:0:b0:4ee:bff:7fcb with SMTP id d75a77b69052e-4f03fd5259emr19895881cf.1.1764992357807;
        Fri, 05 Dec 2025 19:39:17 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8883b5e9dfcsm12827706d6.40.2025.12.05.19.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 19:39:17 -0800 (PST)
Message-ID: <6933a565.0c0a0220.28a8e4.485f@mx.google.com>
Date: Fri, 05 Dec 2025 19:39:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2927386397450772713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrew.smirnov@gmail.com
Subject: RE: [BlueZ] input/device: Fix off by one report descriptor size error
In-Reply-To: <20251206015257.651144-1-andrew.smirnov@gmail.com>
References: <20251206015257.651144-1-andrew.smirnov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2927386397450772713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031026

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      651.12 seconds
MakeCheck                     PASS      21.74 seconds
MakeDistcheck                 PASS      245.97 seconds
CheckValgrind                 PASS      305.54 seconds
CheckSmatch                   PASS      355.98 seconds
bluezmakeextell               PASS      185.95 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1055.11 seconds

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


--===============2927386397450772713==--
