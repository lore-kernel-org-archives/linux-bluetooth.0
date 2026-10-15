Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36C4825A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095022; cv=none; b=R/aDAOb6+MfnMbWA5+wF5sZ8aeyZA3ykwQOU3UqqYkAfKwsTHtsySKe1COWTI3PfJaLCrgv2GQey8CYTTEbWWhtw4MWZxMX/6UWi0W+TqZWCttXQUTjk7FNsYNXOJFjISKnt4TGo6cMn7iWcj6PXEGiup44fgpSsS0n1d5FzQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095022; c=relaxed/simple;
	bh=K7R1akPo3cksKqRiD85S6eOjxaWY/gorE+0eJ5B439A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RSpt+cALqdWpHGzL5unigzHuNWNyUl2IvLHxS7+y3PW+gcI744zqB2eBDeL+rEICJxUdCQ/QHsECLal+vSyJSZN/MhG3obZgGhhApxPfJP2+0hnMW6skbfXSEs4bGEsK1iavaB6lOIYcGUuMblaUc0s5NJZiW5fKmtqyA0qMDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI2i3VBE; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI2i3VBE"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15354aa70e8so1044894c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095021; x=1792699821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zrPG4+8K8RcwZMPE9zKqVkehBAh0nSIUnyTLAqHd1kM=;
        b=lI2i3VBEqGWEIZWY/pYAccplsdYScotKJ+NFWhNyfC2weL+pXm4S4BxdlcRKM1gCrG
         +r0E66HB3AuMNaCJnBjBmZ3cpyjqKikcC2vVib42DO5RBfOOzjSdGNFPH3zwM5nw6+L+
         1luNyEEjaWS7W6Nkskc7m2RVZw4Vxpbj3pdb85sg+2/V/bpuzj8h1nAR83YO3g4Fgyjw
         Cnw6rPcdXf7wnojML5vfOsFSBpPMJOwU/2CI/x70P76JaAckrVyrSHylHsFZxx2Zr/kn
         iUIEjQaevvGCEbrxL7RJV75l//EI1hTCksK6a5cOcg+WMmfj0TxVhcaWTkcHIOzXjSPC
         UzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095021; x=1792699821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zrPG4+8K8RcwZMPE9zKqVkehBAh0nSIUnyTLAqHd1kM=;
        b=b00gwfhy6wRFta3YybwePcb00LHCbU/pEauSPmRITDkitbuwNOJ/d90SARLPmmCQiI
         IQz+s1QpKAR3dD0/fBRyED2K8GKxbmCy2pIuyCoy2jdGED1QaE+TJisd/pResjrBWQxz
         YwWVhSd0jy7r4pUYf0IGwbcMOFOn2fx0wuczYQYrWrBW7ze3FVw/kbu7HMbCHZPzEqu+
         RmZ5wz1huDO0E36/hKvhiWnNM+ZkjJFjtuoEfzYfHNnEnPqXYwIsxQNG/bS1+K2i0fLS
         yG2YMA4ZiG3Ee9z3J0cW+c3gq06/z2YuH0IlqmVXvKnH5MqcadajVVJUAVsUHjcyFhzR
         xVTg==
X-Gm-Message-State: AFq9FYIUYHioC43Vmt+2jC1J3y5TkoImq2qil76/KgsouGGlkApZOFOA
	+8IDHpRkX0vz/z1iOV/GWQi1ZPq89GXLVB7rMAhpnYmnErgl63ayBKzq8lls/w==
X-Gm-Gg: AYBFou3QgYzyG++uEaSuUIR/hV5RLrzrroL+f79VGMdoLAwxY/S1hxQr3d9DAWbNbNw
	xUf9HPrjusvqkABgE4wOfsfSh3KMgzUe3s0lDKvh1pxBSr+FZEkZ9XWMf8Uk2gkv/UWki2pZOkL
	6451GW04lSechMC670SEJLW3Ieh2Grpti5C6lNHdS/OCg7yyFVTv8J2uyXWPgokVBE0Kxrs815s
	QK1/spDYo91EWUt61kMs61uMvsRd1KHaIwJ457SHkiPp3qb+mnfDKmCXUQ+n+jYI2mZXpXYIS4s
	oW3fB8Du4bt21Go2l4cYtzClmsb++YEn44IW/wcoL6WRNda5PPZDv7jvmVMKG/UFp7UaEvs3mll
	2hRzF7uZ/QXg+Ju/yl9hAwN17G+3SvOMGKVnyBAIkgQ4H3xeu7bTybzE+zpaqRSyMlkSjVv/5EP
	7yvkAPPShmlseOMxAMKdCA9iJsUly+iX8GLcl1skiL3NtdJN54yI3VF+Fp1HmOrctC2whVzVTg0
	aDlFQ==
X-Received: by 2002:a05:7022:7f1b:b0:15b:722b:4bfc with SMTP id a92af1059eb24-16a6043ce08mr31288988c88.31.1792095020543;
        Thu, 15 Oct 2026 13:10:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.103.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a751d522sm1079845c88.15.2026.10.15.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:10:20 -0700 (PDT)
Message-ID: <6ad1332c.edd3b74b.2b2069.0036@mx.google.com>
Date: Thu, 15 Oct 2026 13:10:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5964360949163166377=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aurelienrivet@hotmail.fr
Subject: RE: mesh: Fix Command Disallowed on random address change in generic IO
In-Reply-To: <PAXP250MB0544C1A2B8FE7294B7757FEECB8B2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
References: <PAXP250MB0544C1A2B8FE7294B7757FEECB8B2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5964360949163166377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       mesh: Fix Command Disallowed on random address change in generic IO
   Pull Request: https://github.com/bluez/bluez/pull/2615
   Created:      2026-09-30 19:17:30+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5964360949163166377==--
