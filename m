Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA841746
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513695; cv=none; b=ZGTxSPmI78zq0UeM2gpajcPUMMFXyNcUoxeUk3u5Rr7Mw7KPsQCXGbMBudPSO/1L3NmiELMCfQ/gJ0mw4rUPzASG+gfq6Ak8UK7CyhBSCQWqcOsD7QtUe2J3C4Q3moFDdwTF9T4S8MVM89RIm23DWxPW2b6yPzOEDmgD7nxVOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513695; c=relaxed/simple;
	bh=VIrGK/tpKVIooaur72/6uVxDcmfMIFZ6qMGHxTksNJE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GkZ9yVIklPTKwfGyCFuAc33VHuCVZRZ9Sc/ZIEF8du8+k8A9f6hZNlPxi2MmnHYdNhsP1JcxupbBgWwxrnE47k2H6FQRCljR1zhGMxFCGQLfxrjF4r97Ks3xSIqHo/6hT8I4gjXvrz2ZxogyEbFTAiFHL5qfynHmLMeo2PSM9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cug1fVk9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cug1fVk9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b148919e82so468573585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513692; x=1732118492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E52No5OiNgqJbabtRmwYHfKmH9qhDy2DP2RJShcCQZY=;
        b=Cug1fVk94U1d2RZZxuxBBDLh10pfPrcXxJqafxEC1pBSuAm5zF4eppIo61XfJotH5W
         h4oo+JUVlDsaZmWRLyuq3odnXwgJAq/5K6CkRxN2A9QvOQUX5nPwAwWOv9qyFWpZdNMl
         JVLuRV1exPYHUTvGL4S0QFBbgAr7renBKcIO3oXTO9rltsmdt7ay6Dmt2rfsQLmxbeqw
         4KCxr6fWLY7SZCmBNqsD+agKoL+mfEJSPDkH5O0kBkHT+vFCA20evbub/MpcH/Z8wKD7
         aryXIiXreeUotZPj1lfM2Gb6LueiIpFM5uvP9QXXC5DMTYjMhBiQVpckCq/kBm9urtJ1
         tRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513692; x=1732118492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E52No5OiNgqJbabtRmwYHfKmH9qhDy2DP2RJShcCQZY=;
        b=Dbd+CgjGCcUxdwJb3L3jEh7zt1mtO82rJBe3xBkmvoDZzWYwC+te+TSbpmI78OwHwa
         we2GIu7WmQZE4qyjL5x//zsmOIlCflIeX1hEdcmX43F8eblPEX//kr3NDlbYMwc/591o
         Yw03QVFsrgLqFb67xmtmrggtvRjAZNkHVQebUyVAVPn5UacDgy/42U2jJiRI3/9eDI/g
         nx55ajB1pAARc7cs0jna9MVMVKahbsOJaqggUVNDzQCXqScU+36NsLeoGDbINKQQWxMc
         9r9CJIbWkEmLeI6Y84fam+zasQRNiw9vLVpS9EyYWnMNLafernXDJQHkIw9Winpk14vp
         zFVg==
X-Gm-Message-State: AOJu0Yw1DlApzMVuqYWa8GBlJcStjdj4iIFOQBbBqQIyj2Dnd2bMzMdl
	9OoyAb9iXNZByIyyCClbM/92jtT5QFm7z1wV9JhpaeKdFMzmmKxvU0S3Rg==
X-Google-Smtp-Source: AGHT+IG3LtPdwtq+3gMrs/UVOmaYfl/gL0vXEWuBXURJGylFxUUmX2Y//vO457R6puIiWDOsZGxkOg==
X-Received: by 2002:a05:620a:440d:b0:7b1:1269:44b4 with SMTP id af79cd13be357-7b35296216dmr407775085a.36.1731513692347;
        Wed, 13 Nov 2024 08:01:32 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32accba18sm703872085a.96.2024.11.13.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:01:31 -0800 (PST)
Message-ID: <6734cd5b.050a0220.35469f.5a09@mx.google.com>
Date: Wed, 13 Nov 2024 08:01:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2086034436548373232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marcus.prebble@axis.com
Subject: RE: [BlueZ] rfkill: Do not log errors for missing device path
In-Reply-To: <20241113141256.602066-1-marcus.prebble@axis.com>
References: <20241113141256.602066-1-marcus.prebble@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2086034436548373232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909312

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.66 seconds
BluezMake                     PASS      1660.50 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      163.50 seconds
CheckValgrind                 PASS      216.58 seconds
CheckSmatch                   PASS      276.84 seconds
bluezmakeextell               PASS      100.66 seconds
IncrementalBuild              PASS      1473.04 seconds
ScanBuild                     PASS      871.26 seconds



---
Regards,
Linux Bluetooth


--===============2086034436548373232==--
