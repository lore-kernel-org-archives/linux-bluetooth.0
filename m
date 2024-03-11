Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2041766
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168466; cv=none; b=CuudD7FFFrUchwHoIuCPziczaaX95geMUaHGHfI/OuOCB/96ufX6Q+vrNw51C1ePB9X0UJ/52lJbi0ywdXPEwtEONDvhmgy6SUZgVITDLIpcwA2Fu26T+th3+SlFrghTzRYYOR5D+YV6M6X8kXW3YQtmNDnJGt0qvmnGJZVis6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168466; c=relaxed/simple;
	bh=ouBnF2QYpRmVkgw4hiCLuPoj3RE3ooCLYTC0sePO/u0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jPDPae+eYrD1jQITUchpJm1M12KzrDqOCdFIwEIyJCE0kQFxaiwWZMxbgYz23T1Wi6xeIDrK1Sdu1AhTjnWZ9GuxCuRCzDuyFeLnTndSBNuOnH7lUi+3r9OXT8K3bxaGnYfynsBTsXcmHLAAMV9E7Wq4S3fP3xLz6see2T6WcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCeb9jGo; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCeb9jGo"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso1780454241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710168464; x=1710773264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ouBnF2QYpRmVkgw4hiCLuPoj3RE3ooCLYTC0sePO/u0=;
        b=bCeb9jGoBKLR88twl5Da60aAVJZTbqQ1on+LZXnLLpIWXGA699HChjALD5FlEGL3B1
         kIRSQ5bzP56vDVvWIUxAQeTwGTIP/Yjj3Mhc4902aSSo+3XbizKF1FBxX7XERhAEcTIb
         qg2aQRuz0JdFyCkQnWFYLp06bbeSaYf9KBLmeYG1OS/zxYu70z402lGcMox5yJOrJBAv
         SV0lfLwgRrTQa6FWMjn9tZNUCPWn8nSweV2bQAqmma4yvAowxEDoIAoLJHXQvzp1X9S6
         Uo1Q7MVOPKnHyOoUzA6Td4UjhkNXuHQw2tcAyBeum9A6M86tbD1upo6KHltJ39ErtPVj
         zOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168464; x=1710773264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouBnF2QYpRmVkgw4hiCLuPoj3RE3ooCLYTC0sePO/u0=;
        b=FN+utR+v8+NdFMn7SBBPGe3cEy/EvfueDBzev68H7IqEv/KeMp+2FVQpjdwjLqA435
         ooLorU4m9DAAd8pwoYlC368EirgV2hsmi//KXuDQN9LZyPMM5WLSEuYXrmN8Wz51RJvo
         ioQ6bR0HVfgM9/6BnmM8vPLE6A6ULLfKm/cPY/C8J+uiRPa+4fnaM1XW8D04Qd5xCkgS
         2GkDxn6f/g2Yk9OK12vxcKIfPeiU1sGYfSndVZgYOvm8Lf3YM7bsnrPFxhI6k2yUkkbV
         OpRNHzFUZzCtfxwVf3A4yJN+TAzCpaccfuM1jLZt8izIQxa7u5EXSVNuPcRj5MuJLOW6
         fECA==
X-Gm-Message-State: AOJu0Yzg/fAlCIY/GpC8ClJSFcjC641m4JE2J0mNdva+CP5MRprB52Gs
	u063FbsEdqT8pC7G/nAu+5Cd+L0LGKQvxgkXJgPgDWbPJcEVEJpzWM/73ef7
X-Google-Smtp-Source: AGHT+IHDnU9pct0CtiM5YarpYzKZrp94riWrxuVo2kWaCFIuyAo1lczATNgQU5zKzEiNWZMimWmPKA==
X-Received: by 2002:a67:bd10:0:b0:473:78d:b273 with SMTP id y16-20020a67bd10000000b00473078db273mr3755088vsq.32.1710168463835;
        Mon, 11 Mar 2024 07:47:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.152])
        by smtp.gmail.com with ESMTPSA id p8-20020a05621415c800b0068f0ff36defsm2705815qvz.47.2024.03.11.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:47:43 -0700 (PDT)
Message-ID: <65ef198f.050a0220.d3d89.8285@mx.google.com>
Date: Mon, 11 Mar 2024 07:47:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8426023593361371825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btintel: Use proper prefixes
In-Reply-To: <20240311143703.751323-1-luiz.dentz@gmail.com>
References: <20240311143703.751323-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8426023593361371825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel.c:2217
error: drivers/bluetooth/btintel.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8426023593361371825==--
