Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E42DD60F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500502; cv=none; b=YJP3r/oXi87sSe3f7CEMob7G0zt5WExi8QYng2q6O2y9GHnaYld8EfDYjwDqJzjbhTPLud8HjcOUBbulGkCtZ/W4mN6cM0R2uLwtf/LbJsnjuvoBdFNWnBbxIi5b+OXkIaZBv3lAbFJVgR1eOAVrnGOu1IFgV3TBcLn1NQebdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500502; c=relaxed/simple;
	bh=S5zjpi1UN/PWW59Ub/JmTTsOkI4dZvpHGZQDnc8JCb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ms+3jwtZysE6kvHvC7qVpih7271Nlk9N20asdmvKQ1P312ek32tLaHyX3eTXLIrkT4kCPtLgQd9VVObEj4BdrgfuxsRHDfCQ4isDg//Djjdnccx81y7A4iLFySQOUxYZiH0i1fdsjN04HEu48M5EfPHZPLcVWUAjmlw6ahfuF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCmS7DD8; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCmS7DD8"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014e8b1615so57866131cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769500499; x=1770105299; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S5zjpi1UN/PWW59Ub/JmTTsOkI4dZvpHGZQDnc8JCb8=;
        b=bCmS7DD8CFEzlUlCDAXjNUkKddPO3e9yOe25ZDim5mzubbaziDxw0mBs5NAxuAC9tU
         VGmBhYWTi0tKPavKWG3e2k+PwjTixGEpFlOWapaAPlEScBEqIksGBfGovC/mL68YD+um
         2Jo1oypyS8FcMZQHxZieRNQsa0L4EEDq+qdLDO1eAIEBSOdsEoXixvXSp/mNy6vt2sod
         y9opfJs2AXTlfKNRp459M/fc24d1fWZLKJV5aNOBdVKbtpRHtyvGB3QN4Ubo5NT8R8XS
         2Bs7ljD/gP07nvXC46skTm+cKVHtjaPxnzu9dnDdd2CzC9L09kJeAfjEjT0uDrNqUX9m
         FpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500499; x=1770105299;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5zjpi1UN/PWW59Ub/JmTTsOkI4dZvpHGZQDnc8JCb8=;
        b=XGf3kZ68prXzfbNg98HMVTg2BbiVV/6QaAWtw+tQjgC3gXU7fq6Rx5vq3AZe4fR798
         WC5raQI3ds8+O96jnkZpAnf0/vxcHdd/78QpsJ/CfFxNmqqvMmOFelsWk3FKK0DjznS4
         1xnSY58qC4tpEJQxdO3nNDZTsjWhMYySPfq75GhN7cgNViWNU4qOCIX6Aew+ALu23m7+
         +DbjdxTC/ffKPwYkg9cJcRaRokGG8hQE1qXfrN3NkE0t8XUbTKxKtQAQf0aPAr59wuvo
         jh8gsaB2UxV5zqOs8ULCSKpWTE7otHA5S4XDTSz2dizrV6+Ya4HRiDs2kNutvkI+dOus
         IWyg==
X-Gm-Message-State: AOJu0YxJm6xguv0zSG5b/LQEhcnK0AcedBg7gxhr4ZYzUyyKzyo5Scrp
	JVzxbY0QTqiii/TFfnyy1sZlutAgUuRxbJgHm9NnUvKf4Sf56HflSQERX4NJ6DFK
X-Gm-Gg: AZuq6aIP+S2/ZdZ+dRBEBW2M9RzY+BjFUaPMVkPolR5rkyikEYBUn7qc9CG9e23hkr9
	ApRSUKtbjN0cxGdF1cRHNHYDee/3bsw/VxOSB/d95xlJq6BJl7wOONYGqtDVzXMsHbYK3SsqdC4
	ScK3ZpxCoVMGFiLjmxLNMdyfm2lp7RAhKNIqI5w+w82io99XkVZE9kFsGyPUHEC1EWQUIggEIUE
	jsv5H4HNsBDFplCkyMRCBFevGzjsLaHtbb7Gv7D+MiE5vQtzpi0hN3B0huG4Grp5+vuzoA/LjIR
	u/CqPnGBugC40mRB5sNDHYLZv7Jd+fjx9U7oAK7Vx26wWHWs4wDG/WKiAvRcKSXb91i1QPVohvG
	DQL+nAYcNeB9WzsV2X26MiTtguj8l6tFI0sCcfGn8kG2WKid0wOKfDD4ftwgJRZ+Si1YUzVnfGI
	f/KLQbe24SCXK3ARxKlmA=
X-Received: by 2002:a05:622a:60b:b0:4ee:56c0:712f with SMTP id d75a77b69052e-5032fb1b101mr9112631cf.76.1769500499419;
        Mon, 26 Jan 2026 23:54:59 -0800 (PST)
Received: from [172.17.0.2] ([145.132.101.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854a87sm1194805185a.42.2026.01.26.23.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:54:58 -0800 (PST)
Message-ID: <69786f52.050a0220.3a85e4.bdc1@mx.google.com>
Date: Mon, 26 Jan 2026 23:54:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6949298459415037882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add Bluetooth Ranging Service (RAS) support
In-Reply-To: <20260127074745.2984874-2-prathibha.madugonde@oss.qualcomm.com>
References: <20260127074745.2984874-2-prathibha.madugonde@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6949298459415037882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 956
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6949298459415037882==--
