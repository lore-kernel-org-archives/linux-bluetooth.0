Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686478B4E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431735; cv=none; b=t4XokfBQJc2R0CKgayKsEILZjmCj3OnekK8JrbbJ1pIVdbDmdvpdF8ouhsYSVi+g9gP8HaUEoef9Il0Oxx4kP9XZzLsC3OoZEaCsRi0yr8Nduby06P7sEzGbYsdWi7fIFHOCjNTn+78FtCVDCsc94cdbIBGw0Mv5W1caIg1zTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431735; c=relaxed/simple;
	bh=yfDEOhEzXR6vJTmld8Xi8hg9h2LPCwpn3DMuhyNIlB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RHh0FO3yJ3gWnCkmNN2+yxzoCCcd7ZmiaMFPugGXYCRimSnPK/DI5YAsoM1/RsMRLL14qeDaAAKOQtPN9Nw451I4muocvgv0FOeBbLEpDOZplaKU5sg4zsEqcMI5eeJhiZlNTgaCYRc+Utm+5NbP0KJIOtdb0hZu7gcHgjCTGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBG/CRYt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBG/CRYt"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79ef7635818so191094485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720431733; x=1721036533; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6FmX4RSJkAa3Jb2l2ANe6S2G4diV2N0/3ss8mSU7dks=;
        b=fBG/CRYthmDXEfmuB5lFAFR7Uu11DI2xE3ceIO5ag9YovJfWkD7x1xcysYQdh//Sqj
         So7zLLYTHw/09y9CTbSWsZrX9cwLszh6MbJelcx4CfDTKbclP+vbQDDuHTIPAjrJSaz4
         ACo/ezenUjZ+t6LZWxkxENwZ2woMKAVHXiC2RX0uJvLSCEAnS41Mc79vmSMZlSMZSSwQ
         Cw2CwICL3EGYNkNEnft/xL1iA+dzm9fxFKoMEW64sqUPtCnV8RQMZVzRjOilsYaVK4YD
         w7fFeRmZO7VYrR+uD1kSe5xd0rwH1XRIcTwoLbhmNpY6z7aMJn6yZcv5yVYp9DPqvSVd
         fuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431733; x=1721036533;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FmX4RSJkAa3Jb2l2ANe6S2G4diV2N0/3ss8mSU7dks=;
        b=ilq4g5m/q1J1IW+IVZ00b+Jw8U3Uxo2HCcrfOUcuxgAsnsVC50BDrgd44jXRA2i/fx
         5Hzk2mEZAqJJ1u499vSH7kh9Vl89pjR868E/t6ruEgkCl4eTt+QAuPUDexmI58LU5YOQ
         ubefigdquOgqL8sfE4eMBU1Ncyppo32eDcmkB1wX7gnFUGLqVLET/e6KfXajrkxV/ZGj
         XxzThWRX6zyxhBTyNoAhyWFj8/Wrw41ie8faiPXR9j69zZkRJ7xHbZzilIyD2NQtFE8M
         2BekGTCZzuIkOdmPtTL1DGAiTKbDqSTxdlFGTMEHFEQwoRMMZEc3+Z9Mxj2DGg0sQqOG
         /rEQ==
X-Gm-Message-State: AOJu0YzA7k0/OP4wkibBuijnk+ronqD97ZaRtTquICPjk1gmZbQanr9+
	bIFiPxU20hXeRgGGhZrhNTjtmx883NVlDKUCU3eT3DjrLuzZIIQ24TElyA==
X-Google-Smtp-Source: AGHT+IGYp/cl4d54q7YD8JzP9MLsFKk+nT1VpXo+tdwc7hkwiCpxH7f5/WbJA9WGBQKwM3Z97iZWUg==
X-Received: by 2002:ae9:e605:0:b0:79f:839:9858 with SMTP id af79cd13be357-79f08399a40mr490563885a.78.1720431732964;
        Mon, 08 Jul 2024 02:42:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692ed6d8sm1057939085a.78.2024.07.08.02.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:42:12 -0700 (PDT)
Message-ID: <668bb474.050a0220.4a7f2.6ac0@mx.google.com>
Date: Mon, 08 Jul 2024 02:42:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0132057606533137464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Fix discoverable property not emitted on updating value to false
In-Reply-To: <20240708074024.5300-1-quic_prathm@quicinc.com>
References: <20240708074024.5300-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0132057606533137464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869179

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.34 seconds
BluezMake                     PASS      1621.73 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      178.61 seconds
CheckValgrind                 PASS      256.14 seconds
CheckSmatch                   PASS      364.50 seconds
bluezmakeextell               PASS      121.98 seconds
IncrementalBuild              PASS      1382.91 seconds
ScanBuild                     PASS      989.57 seconds



---
Regards,
Linux Bluetooth


--===============0132057606533137464==--
