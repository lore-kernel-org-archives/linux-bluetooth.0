Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892518EA1
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304290; cv=none; b=VwJUY9aTMbhjXZs02oBTI6SjF5NbAL5kW7t46sCkUjll3zzXhkkhOz53iSVeYTknKxhKe/FYNMhqn9JTlgS8qV8fjSWTRcvySjsEDWzTxYsif/FW826Psm0KGDXiuN4a60OZzR1PUjTOuri9OhfI2IX7k0Xnf2ou4YnKfuLfp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304290; c=relaxed/simple;
	bh=f25CuCZh83SPuwaXmQmzHFXelnLSlu0Kp0CQww7DjYk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oc0d43HsHnPoGQEDCSQU0RDLvjdUt5FyFO+0iYZV9oUcIpupdWUmFCdPwP6GrEjmQlJVqX1DTIr+IQIYbylSs7xuGOr4OSR0h6I8nqozpQZnGrtUIlQXLL6VOyVamf36m4KGCktzb1+guM5Y85HivVZtHC0xU3Axd5Nhxo47/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGHvz+Av; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGHvz+Av"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74045c463so4799505ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304288; x=1707909088; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f25CuCZh83SPuwaXmQmzHFXelnLSlu0Kp0CQww7DjYk=;
        b=iGHvz+Av2qMCcQ7dfowui28s7OPPNUhu6V3dBSA8hNpERdhuzIeiFzWkzIXxduBZQI
         uvwcOcKImhhDdTQNJSnDwfbEkcHIl2VhOZ+Iz9uqJwBmCQoLY5NBh07c6GhR5iKUAHxw
         E3QxAthY2URvqfCa1gglaPWLLXy3g9WV21Gxs9VsNRdy5UhB6492cZwXWTm3aHrbi4Co
         ozxFuCW/jO+Gz4cAFka3wqSRbNMBuwNPOUb6vvPaJgILoQ0BCMTRPLxFbly88Z0fb897
         Yw1ep1FCHjwMuK7AaDy/mu4G6uWyeX9zeNE5QIL+fUXMrNztxUcup1yGN8c/7EbFjYzq
         fwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304288; x=1707909088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f25CuCZh83SPuwaXmQmzHFXelnLSlu0Kp0CQww7DjYk=;
        b=UwC9CF3U6NqXWSNULUtcbSEuK+x4ril+0FxiFoLg9HRFEMxLyTfO8QpzhidujyQCJI
         AOKF596yXmqEX7GXa2Ly3I+qLJOezkYyrCoQQ4L739iVtq5ACtFwBqlq3w5y7xhqHavM
         8oNTbddooP0r6tog0ebQ3BD29jC1IR8SJjwQ4vWpSgl15bP2awDKA/lSwmTdYLwS0r40
         h/9eE9rGEAzOj0JMASwIk2/mLGXLYE0U3w28MucvWAVAwxXhBD288FuoEz1T6uDiLoUZ
         qOJezNwAUX9Z2XEVekyXq9iN8FcrmzKDKRBSeVSsNiDl32inDhMb7dpKIXMDgEgXi3dX
         SjdQ==
X-Gm-Message-State: AOJu0YxmbnfaENsYnhu3msfwjeYKIIim+FNnxOhR8tHSO8EkME0oWfSD
	8pxCfodMuvpzdP9gTcEqJBklR+XNf7aierdiemmjSXIrDicc/rzv8lk6rfOs
X-Google-Smtp-Source: AGHT+IFxeuNgF+djzIXVAZeinuqL5dZDqWXuWs6IoQdvb+kqfonxHqo6PPwxvCGUR0/CH/vZYE3BKA==
X-Received: by 2002:a17:902:e546:b0:1d9:d:5730 with SMTP id n6-20020a170902e54600b001d9000d5730mr5039336plf.3.1707304287666;
        Wed, 07 Feb 2024 03:11:27 -0800 (PST)
Received: from [172.17.0.2] ([52.157.14.164])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001d54b763995sm1162524plz.129.2024.02.07.03.11.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:11:27 -0800 (PST)
Message-ID: <65c3655f.170a0220.e7119.2a26@mx.google.com>
Date: Wed, 07 Feb 2024 03:11:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4169208853434353554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi.com
Subject: RE: [BlueZ] monitor/att: Enable the notification logging support for the CCP
In-Reply-To: <20240207040110.398884-1-user@LBTOE>
References: <20240207040110.398884-1-user@LBTOE>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4169208853434353554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/att.c:3481
error: monitor/att.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4169208853434353554==--
