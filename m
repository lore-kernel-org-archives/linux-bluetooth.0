Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F635849C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431849; cv=none; b=LhPHXxS5NrNGBxAx+fQZxJDjDB4Hn41sYNcGQjliD1qhdURwwzyNDnnYHLFqj4361+XGXqSJl+u7+B3puf6iHN9XAvFoquhyWEq2T49Bimx3yjOS5decUHqjkENEer3tlC9FrDkJ7Pr/ArQMA/9RHU0R+vBXEBkid5+mM9+16fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431849; c=relaxed/simple;
	bh=3ujQxUmolMXHn0yaa+pM1ABZ6FPV2yvGMhjt9M+rTnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J/vjN3YLCYon+bVHjHsQbN2+yE8Cp5p8eLU6i/qLEwe8Vr6nsO05vKEskz20eoMg4luXFrTBIWfs1PjOnGu+p489NMJogeUvEVtTOnOXYXEhRk5u1K1MXmJEA6GpkpQfTpzzkA+Dreep+rn6oT/SQhA6CYruR7h7AXBlInKeTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWKKiCle; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWKKiCle"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb1c69e936so17461605ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720431848; x=1721036648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VRuZgKM0jjXttSrkZKXJ5fLd3pgoCc881XtNvEBLnxE=;
        b=dWKKiCleR72DcdVRDMw4GnAPDaR0KrVbwEvn+lWnoRTXaOYDWqClGrq34DNnaYszxH
         +Vmh4XOIMH0lSm+QVCoGql8+lBTgTmvkdMTq6YqnrhKPvcdK4IjlCyLzcHPOG8CQKtEb
         ZBSaquTta0fcH3LUdCV1e8Njm3ngHVNHAhnX5zxrdzWVN/dQJdnZ+a8gYvatXrvgduvU
         CZoV7HewbGJcyP1IuA5t1Dqp2hDncccMsr589Rbc99ZtZmMjE+XpF8UqfPpxH3Ci2xPy
         ilL5Iw+IcuaU4r4vmYH2Mc3hKNxNhAPDyP6rLIcRTsdbC+vrKrRQK0Rn69I985l6oexy
         LIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431848; x=1721036648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRuZgKM0jjXttSrkZKXJ5fLd3pgoCc881XtNvEBLnxE=;
        b=ctxEeCVXak7w3CsXRu4UsPagyIpqE3nbvxHjGIxS7yfC+XzWdQ0xlClNu+LaE498en
         nGMjt5sc2D9288L64UKhZavfTUienfyzI7Xw+hI+XejrAng5TNFnScPKstEsv1kVbM7d
         /huzf/biCsnQQCKt4GYjpJaWNTdXCPWkyOY9+BSd+KTNp6czSKWWpCrc9zDZQD+KZBHS
         H2CI1qZbS5Bb+r5ONOX8hzsRa/rgT7EaqolrNfrlAcD2/5lccC72pOD348JleCL6h3hP
         x+Q/z9ygGyBL2HmRf5mHzgNMHmIGxWObd2zbuRAAiPgYAYQQgyToj+uvX54L+dvb18R2
         9Utw==
X-Gm-Message-State: AOJu0YygAQgGxVpITV9DuvsfhfOhIY8B35YQMF6m53niWVojQH6nXxCx
	u/Z/Z9+64fDWo6RDxCEZhOuzlqTg1JSNh1p7UGrpkBBbEd02FmcwQ9oMVQ==
X-Google-Smtp-Source: AGHT+IEizFMLEbg/94zs3BA4OpbRqF0UxYtv65p72nXzjKm6CgdkAwvd8Fgb57H3dkTl9+huMzNCeQ==
X-Received: by 2002:a17:902:db0d:b0:1fb:5a7a:2764 with SMTP id d9443c01a7336-1fb5a7a37bfmr41783335ad.37.1720431847507;
        Mon, 08 Jul 2024 02:44:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.78.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1aff7469sm91786115ad.189.2024.07.08.02.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:44:07 -0700 (PDT)
Message-ID: <668bb4e7.170a0220.8625b.ca58@mx.google.com>
Date: Mon, 08 Jul 2024 02:44:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1101765964913656715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240708074454.5891-1-quic_prathm@quicinc.com>
References: <20240708074454.5891-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1101765964913656715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869180

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1623.95 seconds
MakeCheck                     PASS      13.69 seconds
MakeDistcheck                 PASS      179.01 seconds
CheckValgrind                 PASS      256.87 seconds
CheckSmatch                   PASS      355.04 seconds
bluezmakeextell               PASS      118.64 seconds
IncrementalBuild              PASS      1489.47 seconds
ScanBuild                     PASS      1004.70 seconds



---
Regards,
Linux Bluetooth


--===============1101765964913656715==--
