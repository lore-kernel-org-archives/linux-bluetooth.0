Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942917BDA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622906; cv=none; b=ZT6EAE4OQ1St1rMo78ked5XJD0LuF1tfo9mPxPVFj9jvcHT4SpQBnn+7wja4RmzG2nWWTcqY9WxMWyi97Epry46ns5WHM79HIwAnrcmzJyZDWcuQ7LymCvG+2bkBXwH/6Di7NA5TExN86tHyvrdlrNlYB8FGzUYN3ECod5+xJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622906; c=relaxed/simple;
	bh=7ze/lbu1heRTRvzuvLhahjAkIhGrSrNGm+hLMseAJXw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lH8t1I01VXSlOvFh2mNcBPEOtLdo0MVeouaWECncufBQQeBoiyAZdZoXpgda4mGwXpAdZ1/o0gJ0Kk6RaWNH4r6D/O8kicbT5AK/6OL/XzfOeZPH1ro5sV2zjt3ei23EVGGzNjdJ28Ah/AqJmsxoKlgkx7aP1rpHvQLnTbMNHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAHIYkTt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAHIYkTt"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6962e6fbf60so40571566d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622904; x=1713227704; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VV/mCmxlohJveqf9kMhulaT/FXcfpYCRiRNRFaMSO2I=;
        b=cAHIYkTtgUcBwjLDMWFk3FFaAWTPOKrNQqXvWuIhatoD1HlQ0ihLFjKJWSZqv8AsOw
         qc4sfJ7Z5OOtZoWthGfE0pH6ozYkR82c/e2f1yiy1M/jezpSNSX0uIyHNIqUvMrya4+J
         3jaJtw3lvz5GuP6gBO2LmH4Js4vDx9JN3isoJa/bmROllEgmu80re23H+FDtl4pq4xZH
         3xnr3Lbyg0vow/ZFF2XUG25kaDyWP1BQOC5Eb+ctwABywsbbDYSV2/OypRN4HcWAnLFm
         1SWB19c6RodRCzp6pky1B7hZ1Cpfv7SeEA1j/QXVScsnTt+PBz2KzFhRTAQqWAlMJKcD
         aJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622904; x=1713227704;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV/mCmxlohJveqf9kMhulaT/FXcfpYCRiRNRFaMSO2I=;
        b=EVD/y+DlnFxulcf8i5vbi6BzalTcPD0mjOEe4nD72dyDMYgZbmnxA2o7fzHfXvZF35
         brFxggBJ7BzHEfcv/AJTUYRJyMpfmPa4pWZ22Ap+vzmDsR2zvVP0h6Ezs6YjlHRHGw/0
         OefVeyUnyU8EyB0OUoqlGSvUfKdzgvvJvsvav/NR5ORi/J1URADUlfAADQC8Us/Q/nvG
         b8ocRKTqGLHtO1YIYSJVMXkaQXhONL1bs9eNVs5lhWZlGQdws+1Sso+iUtSo9CED6nFl
         N2dfV8F+8XI/rBT08fVc+goEwXp+nYRsRz1+qFnARrE2sgJFYANwUHgp5dx73rfuyAW3
         3IEQ==
X-Gm-Message-State: AOJu0YwMWpZT2WiQQs8fC4WXEjMBWAD5SYVglht8VqIRYDleNDDIZxvm
	VIwTFosFseHKjN6h9qUmWM1PTtR5L20OFljq68M7ZJFWqvMvKca93vLx4FxZ
X-Google-Smtp-Source: AGHT+IFuW9kzMb/1vKusyHt/fns7YliCMcB6SD3VgDjyI1b5t5Vp2ANAuszgjRqMB96whWDa5AROjQ==
X-Received: by 2002:a05:6214:62d:b0:69b:2aa8:dc56 with SMTP id a13-20020a056214062d00b0069b2aa8dc56mr207111qvx.36.1712622904039;
        Mon, 08 Apr 2024 17:35:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.36.214])
        by smtp.gmail.com with ESMTPSA id ev6-20020a0562140a8600b0069aae04b06esm2626412qvb.85.2024.04.08.17.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:35:03 -0700 (PDT)
Message-ID: <66148d37.050a0220.242a9.cb6b@mx.google.com>
Date: Mon, 08 Apr 2024 17:35:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1982110841674603790=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] shared/uhid: Add support for bt_uhid_replay
In-Reply-To: <20240408214253.3758319-1-luiz.dentz@gmail.com>
References: <20240408214253.3758319-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1982110841674603790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842597

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.97 seconds
BuildEll                      PASS      24.41 seconds
BluezMake                     PASS      1687.33 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      175.32 seconds
CheckValgrind                 PASS      245.15 seconds
CheckSmatch                   PASS      348.43 seconds
bluezmakeextell               PASS      119.26 seconds
IncrementalBuild              PASS      4739.97 seconds
ScanBuild                     PASS      1039.68 seconds



---
Regards,
Linux Bluetooth


--===============1982110841674603790==--
