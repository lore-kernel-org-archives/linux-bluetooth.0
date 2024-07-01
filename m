Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA216D9A0
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850016; cv=none; b=kyq0/YJKCX0Hr+8bC9+u31xERDWJSbPtZf7thq9FANUGQD369kHrOhmXXMsClXAkqqwEYYdmAzXFA6KeUOKhozURkEGNgDsP+oxBfUOvBl42hIT73EPzQRB2wLKqzpQzcg1FXHRhiMJ3xZlHzmRwQdHPx8yiEmTTz1EpJWWNYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850016; c=relaxed/simple;
	bh=QYCQP6l0BVIiDmjJGRLzyaL2g89Dai3qjXjejjlqwd0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gn/HnyT1GAOgQ9WidX8y8teGMsOyuSxY/7PB7mK0Us0LsatY5JCf0Td/dzRwR1IfD4JRl0Fh44ptzVal0qLRha3V3vOeYllqlsCPB0+kbztyEOLVr+hFllkzwh1LJy8lypHDkqTgexs0aVOJ89aaNUHx704W5mX/BPw/8ChgvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgrCXfYK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgrCXfYK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c81ce83715so2330802a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850014; x=1720454814; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdq3FUFjNpu04pHHsX2chl05YtH3BmVB+WG67W1jHSY=;
        b=lgrCXfYKGds9C1Dq5WcTK7riBRuzX7pxJE35vBJAYeZ+oSojVFa7AiJquS/48RUtyq
         JFM21SmPQi1UmB3IvkHVqnB3D1sQF0De5nTn2PFmUCHezFWsScTuhiViSyqUdGLtm+vg
         sGkhHe1njJRytXddSUVJEPNTQIfXNcwK+XdRGr0L/xE1fANwPq2zpayTVAFdMDZtmRw1
         iAa0pr11X+jX9+q7KHDtjSMo4LMOSsVLNteXAxDN88tdRGILX6hI6ofx+WRoOpM6o1Fd
         OY2lQpnYJscbAO1q0I1bPPNZd0Y8NS0fiR06jBDTPsmJLeHtuAG7l3re8Ri91GAZpQLD
         fOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850014; x=1720454814;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rdq3FUFjNpu04pHHsX2chl05YtH3BmVB+WG67W1jHSY=;
        b=UfPHolP6Rj/IwFxJRzTo0S446CfipLhp/2N62daP2zQtepq4lW39ycQwEZOtCOaMKW
         /YSTVKYz0gsmB61/fhGGcDfODi17dS17nZaj46WWugvZpR2FVaeWui6AilDn4tJC4D2E
         Ci9nrU3fnrcnWypq3lEbRmM/N6tiYkGFiY1TBf8gKNtb/oF6I2aPFRmC8z2Dbp4+uiaa
         QQAjSa1jt+ZA3TEJBwyvrNbcM7aGzpRBRiDrSTg3nOZJhfBY9TSwW0NYVJe2KLU9FJEP
         AEZdf7Zb47uzyfY9DfEs/a0VWYcQc/otyvr7hT11AiCxcopbSEdZ8mMVyX23UJRZ3AOZ
         f7Qg==
X-Gm-Message-State: AOJu0Yz88BtmMdR+6F/WWORsLwWTcM/hTj9g9jhSWvfOvuZl0Ifr3rwl
	StvTXs8tFLYTD4VOgY+HXs3IGGg4McruB1oTtfwyuOri/Ay9sXgAk23Iag==
X-Google-Smtp-Source: AGHT+IE5ktpUhISxmslOvAecBsX7hXzuziiTkfjmlxl4ph8JOf4RXW/pj9JRKtZBUXs7/KJnYLmn4Q==
X-Received: by 2002:a17:90b:a42:b0:2c4:def3:b88b with SMTP id 98e67ed59e1d1-2c93d713dadmr5076566a91.23.1719850014278;
        Mon, 01 Jul 2024 09:06:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce4333esm6969879a91.18.2024.07.01.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:06:53 -0700 (PDT)
Message-ID: <6682d41d.170a0220.7d25a.6701@mx.google.com>
Date: Mon, 01 Jul 2024 09:06:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0038736327911591053=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: doc: Add initial MediaAssistant rst
In-Reply-To: <20240701143135.45677-2-iulia.tanasescu@nxp.com>
References: <20240701143135.45677-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0038736327911591053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867170

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      24.99 seconds
BluezMake                     PASS      1772.75 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      180.39 seconds
CheckValgrind                 PASS      255.01 seconds
CheckSmatch                   PASS      358.25 seconds
bluezmakeextell               PASS      120.46 seconds
IncrementalBuild              PASS      1548.34 seconds
ScanBuild                     PASS      1026.80 seconds



---
Regards,
Linux Bluetooth


--===============0038736327911591053==--
