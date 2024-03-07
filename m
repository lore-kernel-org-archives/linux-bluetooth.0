Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BC17F0
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772291; cv=none; b=TphGfh1amxOJrzh87MgFBd3pmdH9lIYXh0X5xb3aJ0YxhTMpqpz6XFmddHq7b1etuN5+sb1EIJhoXLKWGW+9SRXA7nJkqfZ0yop2+vTa/tD6h/yx6nrfp5jOCGWmBcivgcpS0ny3OW+T3mgsunhdBfZON1+/TXiZQJOPrrGbJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772291; c=relaxed/simple;
	bh=k7WlSYwuiYEMSgHN22ncg9ZNbgNPpnfmBz7e/tr6HaM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cna5RYj3ysukwjtt6DoYpo5Y6b9O2Ni9RlnwXgYFMo/wYtBYmaedqLJe8DVxsn+tUGWRDsBtVScaUWcfcsj9/G1vCghMa5yDGXDawUCsthY0HhTl7o1mOVBvRQeXKyxWpNVmFutZJLUJ38FdzMFD3OelUjA/vazd5LsVjJdrhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqB8H6sL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqB8H6sL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd2dca2007so2761075ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 16:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709772289; x=1710377089; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k7WlSYwuiYEMSgHN22ncg9ZNbgNPpnfmBz7e/tr6HaM=;
        b=QqB8H6sLLkxQxxPsTn5WaPw83s+3GPwNcXdl7HHpG7Gr4ftTsCRpGlhIy+dulWC695
         x5oz3T6U/C7a0gSRQqOOwyfxTElKHoBCsPq7M4LC/mHcGRa7YZiIDWiTKLQFaRtqoAOl
         JwMRYAhx0TYbB3Imh3ITjkfu3nnOPVtihQGBJeLSJb6ZIoufbxr/N2BZK0y+JbrDS/Do
         ckAZ378+STjnOpTWMbmHkAcAZuUprAV8fDtNOUguUQbzncOf8IlAmbbgSE1fvKfk2M3t
         V4bq9a7lYQkptZa/Qnbz5G7Xxs6AyKfw5K473StsSedrwC2OE6WNNu1w35ISrHoG9xQq
         wQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772289; x=1710377089;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7WlSYwuiYEMSgHN22ncg9ZNbgNPpnfmBz7e/tr6HaM=;
        b=CGZwxP2vxAJz0TwMPBml0QlLcIB5vBnd4lF11oFg/IwFZCqQw/cu0QVT95XW+IX4Wc
         eff0LQhzNu2/QhkfCSEKeE4ZdSrvjx0aFyrmbvea7VLVSAx8/lLOcF2is74Ivmh7tO6r
         U88LYMfrz7OVGMINpdhvTTtHFCL8ABY/d0SiimtXmFcv87TAQ20eTiF1PKkYg2IV5raZ
         cXkvzCOW2+otSCepLotNrWWtflsZ8QMNbN7THqYiHjPzw2Da7Q+1RpIjAQTL8hRQj+HG
         AQr1GKbnpgFGR5yZ9R/4svpcIOsCn5kMIUhMSLmmF2foG3UGkHp/JNT8n/X35KCTKdgv
         3D6g==
X-Gm-Message-State: AOJu0Yzt3i1W6QXFj9zckLyJamQ/Ax+f0arqs9fBFrtUx+0/IwSNCVZd
	2ymCU75YMMp4fu4tXcgsS5KJwlx4UrQ0lYIXY+NUpfdW+ZkVE2RvBpBefHQ4q8I=
X-Google-Smtp-Source: AGHT+IHQB6XrZzkkL7ZEtltu3FPZt8Fw+Eq8sMsAjuu0XjdaP4ysd+24Mg8PEgPy7JZP60XHrgOjMw==
X-Received: by 2002:a17:902:768b:b0:1d4:4df7:22ab with SMTP id m11-20020a170902768b00b001d44df722abmr5807326pll.55.1709772289466;
        Wed, 06 Mar 2024 16:44:49 -0800 (PST)
Received: from [172.17.0.2] ([20.168.23.50])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001dc819f157dsm13213071plg.251.2024.03.06.16.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:44:49 -0800 (PST)
Message-ID: <65e90e01.170a0220.52371.3411@mx.google.com>
Date: Wed, 06 Mar 2024 16:44:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4708602252959479879=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: obexd: Install D-BUS service for non systemd
In-Reply-To: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
References: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4708602252959479879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Makefile.obexd:10
error: Makefile.obexd: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4708602252959479879==--
