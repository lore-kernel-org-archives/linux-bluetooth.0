Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8313635F
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727597902; cv=none; b=JJT079JtUMjFMk7kRUvhYTrVUJTCHpmh7uQZrMmv3yKM4tOFhLOvasiNO9o+7YfoQHmP6+Y2dVKwP8bOwKEB9hYwPzweWev4F7fBoWbBDiv8F5IT+1WgoLbwuJyep0WejeX+85A9uHeGkP5Ba6d6Xb7mMDDkEeaznWzohPSYDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727597902; c=relaxed/simple;
	bh=4rcjFUwx5dMdLOWpLx1nr4cAyy/6IUvhnhbSPCGp7UE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eH9EmPPa/CIIK27l8WD+zIpsPm6ROMriIRoWkpNUJOf/4aNjcJiXOBsdKTWXCgdrUWG4MenUXMbBTN91lMdCBsJ0nLbtX626p9OQ/p1ihoOfNnpcPJz1nZWz/FUBPzKGYN9pMj3AjxkMzPr30O5p3ucRJkffT5Wa4UvoGUysjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWM5dzzx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWM5dzzx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so2620900a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727597900; x=1728202700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4rcjFUwx5dMdLOWpLx1nr4cAyy/6IUvhnhbSPCGp7UE=;
        b=TWM5dzzxNcZNtexolUOCxTJi4rS59RZ3LQgCnOc/Qunx8MCOOagh6iUGok+RcY5Ktv
         G1CGx4hDPoqqNFtJe/hgPR2CJbxBzWptrVM8nUXtQrmyFpQWrxcd127iV04aIU1W5g8E
         xnYeI55DJrW+yyUmkRtFTzP+84v7oBK7YK7+jkjN6tt7T2iO7VRf/IyczLlh6dhwB7L0
         YNN4a2ps9/Irv+l6PS3I3jO6G3PDnat6lJVC/dnkfYrcn5FIZbYOL4ogePit1vDMmHGJ
         nBx/PomcX0SPMs5tjGrk8EIzQbEENa6XAzQoWwLjVyLJq5mC9eEVpVx/ZmQBq83fKXDg
         Rg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727597900; x=1728202700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rcjFUwx5dMdLOWpLx1nr4cAyy/6IUvhnhbSPCGp7UE=;
        b=wZ9zOwDyN7F6CBiMwrzS7hjUe3QqQN3C05AnwgQ6753A7XXK7hQobWN/CfYV1dNSE/
         kliHuxm+NL3c88LIkOEmENkBLNKYerpVqzoPZUaijBNeFJcbyFvy2GRhJ3WuBi/RyYh6
         woUxa2cKnY27m6ZufmG+XLzWQQfwGyWVDhvO35AUvL4yaB6y42LlSmJ4C3LScFCRZm2S
         fJjVV1/eoOSqlFHLY3WVZUuqDmFDpW1vPg9WV0GxbxaxCog0ob9Rs1vBL2tDE4iiZ/S0
         35OkCsBgLeuCHpXrQTyFlC+XGgcqK6ygtCsdbzLa2CyN578RbKx40KMI6hx1InyErA3+
         gq0g==
X-Gm-Message-State: AOJu0YyAmiBN2WJY7SBfQCT/SjCD9M/Xxk95KvvQVfYzPzsxZhAxEkkz
	Giwsz/y/rtCerX4ardGIqyapFNcYCs/ibv/riNZhSHW47hWAvIoqbXIahg==
X-Google-Smtp-Source: AGHT+IEulIxE0TGV6eO1LRZxhFhkluIlP427dJ8tzsPiSphvs5vP3Zlk8jKxljd6u+k0PdboahgTyA==
X-Received: by 2002:a17:90a:8c08:b0:2d8:8d34:5b8 with SMTP id 98e67ed59e1d1-2e0b89d4ce3mr10638918a91.10.1727597900227;
        Sun, 29 Sep 2024 01:18:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e11d702bb0sm327630a91.17.2024.09.29.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 01:18:19 -0700 (PDT)
Message-ID: <66f90d4b.170a0220.288304.076c@mx.google.com>
Date: Sun, 29 Sep 2024 01:18:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0950323057665668608=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
In-Reply-To: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
References: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0950323057665668608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:512
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0950323057665668608==--
