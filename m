Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094E1B4228
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457798; cv=none; b=X3rARlkO9mZciwJP2tZCNALLjCLre1NiI+KtpadP7laJqSyPnilcm/+CuKgekVfWZkNY/arFEUzh8qAAcxgQTs5VqoZLhZciUmEi2le9qOkqIyVNHz/OGe1yc/wWx6wvLPsqFqVOrSSE3RL6MeT+Sw+xrjT+ymziMhfthvoWb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457798; c=relaxed/simple;
	bh=69NdsNU172cLVMAb1/cWnOdZI25VJKtG3VdORNXwTtg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HhcQJXJADs11PtHJ/oxKIVT0MFoE2DqILfRqXvRWGmVE5l81hFHe+SbQUPbygH5/e6ZByXJVIdpUyPKwTNPzhUHFSrvvl3YpZyJqeEC5hizpI2eSZLqgD+cmKXNCRLT71IUvDyY3hVNCdzfoUk5qxrtB/wHRsMfPDN20SPoWbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXVcPYMo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXVcPYMo"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd049b5428so47537246d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 03:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457795; x=1738062595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jIjpsDbp+V5opE9meqkKRO2K8J/epqy79PrF8U7Ivvc=;
        b=aXVcPYModyDUhQsTDTR0ArFjO8YbDMluagtG5uqjqoab0E2e9dsnMOtrdBe0IY1cb7
         jTbaXidLqXPTAwHD9JPmrHnDrxZXU3Xg1P9cWrLyae5Zh7usNRltD9FU1l0wZRm+tDC0
         BiToPd8touirtmnjyBsdULEUicSvZmTReH9r3Hr3D2JvwZLxp+0rDiBO1h8ydzRVJvD1
         7P5HWRslTNng51Vyp4AkeO2P+IZ0zdnlmPP89fLWiIycJm3QIjz+Uehw+AMnSxxA9gb5
         wXrEC/TjZ7sPeK05++8ARlIyP85gppgLFaNk9Kgk/ms+VOzPciqo5EJkNtpw6SikOPe/
         dmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457795; x=1738062595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIjpsDbp+V5opE9meqkKRO2K8J/epqy79PrF8U7Ivvc=;
        b=WEULaZwXSeZ02Bs7S7vuLu6CeAWXJfn2JE7uak+Ge2Era9MmVQ0sXGpitL9TSOuaen
         vzfoSAvwVPWpK1Jwdjd08WFPeP7miYWLV/Ax0+/oLh+yt+nYDAhJxCWxHxsgIWljn6z8
         f7UBbDOmZhcF6oCf3TUi7KTvk0jISE9ydxrbHoXFE40v7pUYYEMr3uyATu5IahdyEE5C
         u5C9Ht7J6WBbJSnoDjNG7WO/suigtw9NZIVH8NVVR1m83pFvdoH1dWt5HA02PD0pHGRJ
         I5QQY9Nh9zySmtS+BDKrvdOWl/WxjkxASvhtGRuXNbZ93tAYZIbbm0ONmxxGvQa+/v75
         uF+w==
X-Gm-Message-State: AOJu0YwERWhXzkxOydK2A8t9Vi1h0VEQhp6YwUdgsNzW5ULLzsF36IzA
	L7LNi2rhEfkQ55Hc97ipYgqDdvgf70acuVyqtcXibpWI8fd0iq+AlZViWXiX
X-Gm-Gg: ASbGncvW6UEaLiSDgMrAkp9DZ8nV2S+VDFzOwqqRwFhXg9MCcKtqf+3xpYA6OEiAZlO
	NsYGolKAQmAYyOKUT5zttBN75gt0yD1Nt3exltQGONnohhlvs7vaoXpvr2t8Q0ZddKqGyIOmhCT
	VvURizqxgIhhh0WRIYXCcT2N47ZtxLsVQ21V15KW0RMkStlQzUQ3n2Xf8IKlKiEi/LMKk49uoFx
	/bj62jo3RH7W7uw3c/+iTppY+TFBI1iDX2tyuGG4nHUp5oAoksHEIekNDp9kw9ECluGZzUThVbF
	Iw==
X-Google-Smtp-Source: AGHT+IE9OXo5nmu7IxhOXiBIskHga6rANPXJEBEkUgxoBThQQbAO5RMUixOE9rN0cvVui3oI2W0utA==
X-Received: by 2002:ad4:5ec6:0:b0:6df:9740:68a3 with SMTP id 6a1803df08f44-6e1b224c029mr291434046d6.38.1737457795135;
        Tue, 21 Jan 2025 03:09:55 -0800 (PST)
Received: from [172.17.0.2] ([172.183.183.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc22eadsm49983176d6.53.2025.01.21.03.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:09:54 -0800 (PST)
Message-ID: <678f8082.0c0a0220.22960b.2faa@mx.google.com>
Date: Tue, 21 Jan 2025 03:09:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8589686877999840242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: [BlueZ,bluez] gatt: expand the max GATT Channels
In-Reply-To: <20250121-upstream-v1-1-7b6e450747f7@amlogic.com>
References: <20250121-upstream-v1-1-7b6e450747f7@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8589686877999840242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927176

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      1504.57 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      157.83 seconds
CheckValgrind                 PASS      213.59 seconds
CheckSmatch                   PASS      270.52 seconds
bluezmakeextell               PASS      97.87 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      855.73 seconds

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


--===============8589686877999840242==--
