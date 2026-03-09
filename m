Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD487FBAC
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030066; cv=none; b=bywk2VI/q3LAkyjtOKx066lgPnySldTCYP8C7nJOsVLgZ/yGG7ofWYRfWbsl/9Fw3xcVPCbUfVz7ZC+wgKtpW/cjo5PNMimob4lJ8V0n1DmJGMifBIfm4TpvDcpWQliDBfUBmPRnpOeFYmICtTdcg4sR3mSGs8sl8Y85npXenCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030066; c=relaxed/simple;
	bh=cg/O/fKjnHHlOcPwUraJVpbQ7eaGEFQMcoXM9MLPKBI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fcBHEU/qeRxDLNNUOzRemqf7ADxQ+N+RYub3w/xmKfUEQFwHNgSA61fRK5hw6IEjKirSGoDBxedrm25BbbWNP+6iZhuBpQZxP0YcXjp4KobOWuaRPt25WUw4H2Py3oAv/FAUfly76QxHCjpnuG4Knsl7SLEzIzZxkbM377daWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsFvZ8R; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsFvZ8R"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a05955720so102202006d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030064; x=1773634864; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cg/O/fKjnHHlOcPwUraJVpbQ7eaGEFQMcoXM9MLPKBI=;
        b=iIsFvZ8RBUIgFDfxKvO3NC81pLnG0l6mOpHuZEPkrhedmbor+9OIwf1hKCRK53lsDz
         qVm+xJf6MhcKXnqiPvLg9PTXTj/z+thxIarPfx2r0StBPrzg0gX8KTK2viZl7hItJhxx
         BydJZXGFbdI0PN9gmNAE7WaEYnEL+K4djsfcI5+uNFG2IaG+sPg/f/Ll4fHqOC2GEqlZ
         9pVAJ8SsublYn0W5kA5IQnTzVfavTJ0o0X0vMmBYMYFJZeoLsyXPJHOKy1Q3Ow5qllOA
         SM+juWPY1sDvmx5WSNFGjJdMW0zSVXJvXQ2poJGQ8+lo1tjGJ4BAUTtP0jQSd6ph7+GR
         mRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030064; x=1773634864;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg/O/fKjnHHlOcPwUraJVpbQ7eaGEFQMcoXM9MLPKBI=;
        b=cl6N1Upn/VTPnxX5Tz3QGHkzW15/pdx24PWh9vPmDGDBD2yi8WkHx0O+DAUBAmhUZS
         3OnJz5qV3fbPM2Fdxk6DCuFnTfmzvHx/Q9BxtJ3JTRY6zj78hMa3mGAK3a22AONQfZcq
         nPXITBTkJlAvYUWbMfKgFQInmHzI0xNAaHngKlpE6Dh/onFFhKYEZHmtxR3XK3FpJ5ZR
         2cGNJ80uyn9qrEa5GOtwBooBNdYo3LU2zOtuwpPp13m47zwH8u5uqtXfmbCQhRwn/tK4
         fvYyI/257YduzmdtVkWwPVaN7g/RpY4R6w18ZSA53T7br1GHPEEm4odtNE+kydRiIOtP
         0NAA==
X-Gm-Message-State: AOJu0Yy1tS14LHVJVUnKYt/N1+sr34aTXJpqp1VW5i+Pqv6j2R4FnaWP
	CPexuJnOpK9GC0vettr9HjdY9L337mZoGJXob6SJJ8bGmIeab4uq+cZTgcT7/g==
X-Gm-Gg: ATEYQzzvIuBlklVz9m0sUSsJLcGE+b/I9Dj/3CekwGpOmUJtuGoTkYd7giWGmbfWKRX
	88ue1iV+3+5ms4oSVgQbRPUPbi/6b3uTRNoBSdFcIIk1fNpIEzNlBjny9/J/ST/lkFOS/8KdYh/
	E7EOvrr4+71vd9wEDeJ9mr4MLr4lGufNpuRLhWjizhX5FpR/FWnJcLhFCUY9yvnpXylC50S0Iua
	MsUXWbQH6lbnZCvxEcVLUvc/HEFJ1c+x3AfkMIpSyx3zhdFizMJ8Rdd9ZiHJKjII/8hGOLCfi1Y
	Yv1kY46Mf76KALLeGz+ya8kxMQDdNVa10WoEgzTNTLG7yyjNSAluGky66tdrJtjxsrmRyFF8adq
	ZELWa2Elo9UaSOHijA6BE/DTKhAjZS8jF+BZtsPFeT6zaXmdfS4LCexZ9K0kaWgrj3mML1+pCEQ
	qwilw04UMr+xaRirk+K3j/h/XmDJF1Nmus1fwiXA==
X-Received: by 2002:a05:6214:21ca:b0:89a:149:bef6 with SMTP id 6a1803df08f44-89a30aa03e0mr142699516d6.40.1773030063813;
        Sun, 08 Mar 2026 21:21:03 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140d9edsm66470416d6.7.2026.03.08.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:21:03 -0700 (PDT)
Message-ID: <69ae4aaf.050a0220.169afa.d3dc@mx.google.com>
Date: Sun, 08 Mar 2026 21:21:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1602177178404608401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wolozgabriel@gmail.com
Subject: RE: Add missing string to list of commands in mgmt
In-Reply-To: <20260309015745.1720-2-wolozgabriel@gmail.com>
References: <20260309015745.1720-2-wolozgabriel@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1602177178404608401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: lib/bluetooth/mgmt.h:1199
error: lib/bluetooth/mgmt.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1602177178404608401==--
