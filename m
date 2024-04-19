Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7142AB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544774; cv=none; b=AiU+ShKuWCtp+mnF53un8QIxoLeyl+3O3ECOW3TiQqbiVdPxAjmHtAgj7kY64vXYYPtTlQ9YG6+BotONUvHNWUARETBq+9J3WHbIpBwRSbePQy3/L8TTwrgLIuzqFgpGzPN3m6OnRvV+4dwFojUdC1Hmg5T2A9z71mjkDO6spME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544774; c=relaxed/simple;
	bh=zcI7aXU0mmVePUfyrkq9/axWyHjzEZFfTsWK/YDdnqM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pFXWGFF27pgJusK5TwXH6xPiXjVgXV37ZaIy+f3so7WywpKqhRdq8dwZk6zUQBbqmhd/QmdvYaDYv74m4ULsha/ki/Kl2pADqdjPcLuspquBhpYgwrlNAQZsmNAOmviOyf05kyjr2ph6uCZXZNMQ8qHA8sjF4ObzsKBszEPQTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d204pWjV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d204pWjV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6962a97752eso18136126d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713544771; x=1714149571; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xmFLDOqOf1wPb5HWDk9lJaJ++K51U7Uuh9RBPJUBbm0=;
        b=d204pWjVICTMUD+3C3G8FD2WALUjDUGACAF0fz6OzOFXea4OeQByA7VEvef9456mVM
         0+cFekoptHmg064/tB5qerscmI7flS8+ZgTQ1G0nSrrqb4/adX3eOd+H6tFKdUEG9uAd
         LeW36JgpxIOhOZEoBwUpjgpmYfOX9C/15iMefzk3RfHBA/vI9MoDJulOMAZAKGOkBtDT
         PfY2gp6vASuf8fYPVjmKjWpfKiEaYmRUU49g9y3baqG03TBodEg5lbToY+KaGvfy/Mse
         Te99zuWz8hNB3XJ7nRDwPAeYWk3X2L4troe+Qh3jyVmyseyjK3WZSrIMnyIWXLHCnzRZ
         9hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544771; x=1714149571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmFLDOqOf1wPb5HWDk9lJaJ++K51U7Uuh9RBPJUBbm0=;
        b=trGrtkVhr4Ump1ya4zrVHlTY/LXorNSIVMIH78mmBCK6grdJToltiyUsTdXicZS78Z
         y3GTWCLM6C37dx8UsEs0Z2gW/ikmgw/WYdAwp7S2dniDFrXUJDPnSS7AIgmlvrnsAtiS
         SJruBGuKARkNWKh1ZcZzCyGCXJrhKWSexcV+3J8guODwTkqHgaTBMlamRdetX8uz4PIb
         wFpNEaX2e120i6PjVT+1wLMB9PkwwZyLDsAboma4P9GbthoKxQt1HL15IhgQBChIDnDS
         4FFPyucpNRnoKyhwt+pkuphb8r/NsUU4zypHGgklqwZcuWnzCRnZlcciOr7JF7wmtjII
         cfDA==
X-Gm-Message-State: AOJu0YyuRpV3cW+yroT2rx+7VPtcBsbFi36/CL0cLMpgmhyYT5O8cBsM
	FJwSYV/anrmI5jsrcosP3Zcsgki/ksbTuwi0hhMz0HqrDbM/UmDkR+GQxg==
X-Google-Smtp-Source: AGHT+IFB5xRK3KHpPXpnhW4pm7xw2ahysnAjtnXR1MpHF67PmoO4pMpnKlBGXx2yfcUakz8MnIZqFQ==
X-Received: by 2002:a0c:9782:0:b0:6a0:582c:119a with SMTP id l2-20020a0c9782000000b006a0582c119amr3024714qvd.1.1713544770797;
        Fri, 19 Apr 2024 09:39:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.66])
        by smtp.gmail.com with ESMTPSA id g12-20020a0cf08c000000b006913aa64629sm1680068qvk.22.2024.04.19.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:39:30 -0700 (PDT)
Message-ID: <66229e42.0c0a0220.c43d5.828c@mx.google.com>
Date: Fri, 19 Apr 2024 09:39:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7356990987869359552=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/advertising: Add flag to mark if data is valid
In-Reply-To: <20240419144117.1554291-1-luiz.dentz@gmail.com>
References: <20240419144117.1554291-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7356990987869359552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846157

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      1686.86 seconds
MakeCheck                     PASS      12.95 seconds
MakeDistcheck                 PASS      176.22 seconds
CheckValgrind                 PASS      244.11 seconds
CheckSmatch                   PASS      347.02 seconds
bluezmakeextell               PASS      117.86 seconds
IncrementalBuild              PASS      1476.99 seconds
ScanBuild                     PASS      993.47 seconds



---
Regards,
Linux Bluetooth


--===============7356990987869359552==--
