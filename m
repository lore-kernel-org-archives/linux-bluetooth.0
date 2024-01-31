Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F86774E
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694082; cv=none; b=NHCp7z9xkBNeAfN8vjF2znvEaqwQDhY6uyFWcU0g7pLA8qqBepDM1K8kXlUmg9K/1zzgsffNWNYuYybHFBuDUs3UCt140Ua2CTsUedolj0QJSTCkcoovOY68j4NJ0D4NbbkqGaua0aGlj2DuQHZEZl6XUZOb4Z1tJggpKax679Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694082; c=relaxed/simple;
	bh=P2EppyB3fXdHcBrMngRRyfbG9R5EhDi2K2/u0kF84xM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ICmQjdzUIixzELTIUc9fKLF/9zxQ2BMZVMXve4bKrH/rfnNinfMb+daH1pSEGKEb+btP9T6dhMNKceNd4Q3X/0zK/TtaSaMIFRBAtq11qCGlarFNiUJ7PTwApEv6SA39BBAjVjOALdcs96ugT8lL/Efe2lrlnOl35h75U379QHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuqUxLLh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuqUxLLh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2556879a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 01:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706694080; x=1707298880; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1y6OAdj1fJdJZm+GqDeutfyotfg2ED3IGPRLj5a6L8=;
        b=MuqUxLLhqESpw45Hw0F/zX73mFjhwCh3mFkpsxzjEPVTc4VhE3Zn9lm2ZA5ffBHcRa
         pIe7e6p19WOEfGZ5DW5sZ6Z9P/ietN3iwxGRLUY9HsDa5jW/wB78ZqPESTiAGRF21rtr
         OYM91OLcR9Ms9FTth2CtvZGPNkQ5LYoQRUrdMqRjFokxROUU31e/O3mzpQw3fHovthzb
         GdNQ3fhXxaBDL0n6DhuTdxeKm96/BgP8XlcNuP6E5IMjpLe7/kROhM7lasf76ZhDYBAR
         GoYu00tqts2CJpyNxjPCI09h2VhVazIG+DzZGqPtqVynEZEh7K6hvsc5sWaTrDQmZEb6
         Yv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694080; x=1707298880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1y6OAdj1fJdJZm+GqDeutfyotfg2ED3IGPRLj5a6L8=;
        b=eI9+kpp1abAnHOUMFC6BSR0JHGhrvL2Zed0qeOPcDHlvvgtaeS4KJXTvIVPyN2dZrV
         bIswBLweOXEtVrvhBZlolJBkuoEUMNxUfYzKJdLagpb2y1neYw0vb+djyCc3WkOdemD0
         tlN9Hqe5L6x2QiKSe+1QPgM7HSwLrOg4Wg4SiMHsRoR8Zc0iuDVgQuSkG1Oor1zlTR7Y
         3gkEvcxT7/1My4WYvmOj5dtrjux/j+jPSnaicMqp1AEo2jgoHUDbjb+wEDyYLEgYRoBw
         KVIKAWhrWncloqRRhh8IPubLNNTKnJvjSS6PhSa+Ju2XgHUbxEfqbpx2d6zPYR2m8uWk
         XAnA==
X-Gm-Message-State: AOJu0Yzm09SzUiYXqz5T4hebjhnh2ZqTvnXBqnJN3DHW5UxYSCjacy8C
	ptS+V8MCaSauY7mOn/Efi06JWcxIP93D2P0EyQq/RuvmXnaDnKa2LdAutBCv
X-Google-Smtp-Source: AGHT+IGxWIqTtOHvynNHCF8GRyVCqX/KK96rr422rYUAD7uzQFuJm5CcPTfiBRBb0xhLWtB2ErNR7A==
X-Received: by 2002:a05:6a20:519f:b0:19d:afe1:20fe with SMTP id j31-20020a056a20519f00b0019dafe120femr841043pzf.6.1706694080317;
        Wed, 31 Jan 2024 01:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcyUXOgUJWVpP68J68E0ueTjHxXhiotFzJ9wQ413fLa7/6CDaKg2UR9qQ553mGVyxXUhC0A1jPheRVqcHNBNNCISgCNiS0Fk2aYTRC
Received: from [172.17.0.2] ([20.172.0.36])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090323d200b001d8cb103327sm6090225plh.215.2024.01.31.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:41:19 -0800 (PST)
Message-ID: <65ba15bf.170a0220.3fc3a.26ad@mx.google.com>
Date: Wed, 31 Jan 2024 01:41:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8978179797947254954=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/2] gatt-server: Add support for signed write command
In-Reply-To: <20240131081856.308071-1-frederic.danis@collabora.com>
References: <20240131081856.308071-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8978179797947254954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821585

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.46 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      721.20 seconds
MakeCheck                     PASS      12.11 seconds
MakeDistcheck                 PASS      161.18 seconds
CheckValgrind                 PASS      226.24 seconds
CheckSmatch                   WARNING   329.55 seconds
bluezmakeextell               PASS      106.90 seconds
IncrementalBuild              PASS      1324.62 seconds
ScanBuild                     PASS      931.03 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8978179797947254954==--
