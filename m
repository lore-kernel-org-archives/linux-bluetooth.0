Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB02F5097
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475133; cv=none; b=J5TFS6k51IBJ64IAGJKHKkT+52Tv6p7uyR+Wg2+xBpu0RMONnR5tjP3QLydEjpas/f+pkWVLvGX0bWrlaVEEB/S/6oQbYJ7XLIZceLdGkSXsxQQWfx6ZUHcslFRcltVwMvwGyM38wPRW0YLrhnaBlnw+uVvXrYMSecotGdAFhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475133; c=relaxed/simple;
	bh=s884EGIeJAbH2VYrVfafsbsYSYTsYEhFx1l3u8QTd+s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fdKce1ikXgmz0JaadgRtz+KxJXJxnnBB3dhB2L76m9o2nJ0u4s5BLmq2p6kfWnuGDBH0WAnbPmKwSOtxBSqdZlT82jNKvoIhj2Xvpkt2uNcTdHQfBQ9CQd+RGG5FSfySHcgMWxeMwnbYLbVFD2G4bq95fop/R7yF5bun4GXu8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKmbOViz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKmbOViz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facc3b9559so62251506d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475131; x=1752079931; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s884EGIeJAbH2VYrVfafsbsYSYTsYEhFx1l3u8QTd+s=;
        b=IKmbOViznUB2gqAB0cxBk5ZGhePRYkoTj//h7W4zQm+cxJsvRbOnNkK8eLpktNHp5t
         Ky5554xLN5I3tACqHqLUMqrbcyqGR45c/5VxANJ2aVAkxJzMd7e+/Cotjo38Jzk4eEAb
         990i+Aqx2gkxdYFhdbjJ/xPfQsmwp0oXKhV6t7NLAUphnWoEcTA/zpBmX7jrGoq/8Ti9
         +u3pNzo5mkFYwbqJQWqRXJ703t9rV5M/urT3smbY8itNYljYELINvYNlKJQJwy/nT8tc
         XQ+ctgmFJk4geQDFTj3U5J/bybMd8gqfDPNWfmNcqzf3Wq/Uyb2J5qRH1GV318WSjHcj
         0i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475131; x=1752079931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s884EGIeJAbH2VYrVfafsbsYSYTsYEhFx1l3u8QTd+s=;
        b=jeZvy+10z3NnzMYBJbr+t9VyqiiRGdTm12qrvpHcds5Ir2Yf1MBi+OEjSYT5MTM5z4
         kOkCqwaUl74DhfpfJp9XbX0DtloPiMwpwjBMoAes78nhSNSc81rf7Okcc+y37jvpP1+n
         uvS/kW2emEI4bzsHC/aDLakuDxfG3OHKh0lNb5+5xbCeTd3dT2wQwIypBNzm7XXx8wBt
         chGGf6K5B9BCwVU2e+enh96VoXPg6+tdBbsYLqYQPlQkaWMCvAQ17vxAc2USBOqBbNId
         5g+AhBC0crdusxqLIMO/AZli3pNBVSR1psaNiBXNW4cKWnt8zi153WrIn28LqZxvZePJ
         s6QQ==
X-Gm-Message-State: AOJu0YwSVA4Z8Vl9O4Hb20pzOnrwKB9XB59AasID+I1mCxYdOL3kKUVF
	s753uraVPvRHO+nuqmGb6436Dp3ggX0WccdJk9u5VsgF0yv90Co298C/2YWBCeSk
X-Gm-Gg: ASbGncvA0/e3xOkGv+rRDSdmriI4R1q4jvty4bpiGkVKuT6Ip0dmTeXwuklRmFsHgUe
	j3SvW3gNq1L9tQlAoZulCmu3ms5qv7sC4G1vrC1wgBzdYmHE6HUeAFyPtVcf0N3sNv3X4gIMWw/
	oL+zNiuC3pSiMjLoauuUmyEtL9Teo1CMPjii/FK1RhuflgshhsWcusSO7kP1iw7ywg12zEpLJ+I
	iWXWO+oj0Gq6OBhA5fqJ/pEYJ87QqoL8UiAchEVMouZg3DesalfzfdTiVNmdu4i7lsXNhKYWG8X
	XkBOnP5ZAIX99rlEigzF0K5HGVCw9F7NDN7rLaS0J725pl2JcOcKyIYi8OJnwB7Fco6XApcrbIT
	+YKM=
X-Google-Smtp-Source: AGHT+IE10LreiHkgA8ubzrm973UKqdaV39WmoRldCqMyNBV1AtP/PdQF9KqFUa1XCYVSPgb9iVfoWA==
X-Received: by 2002:a05:6214:5084:b0:6fb:4e1b:5cce with SMTP id 6a1803df08f44-702bc91dab1mr63486d6.21.1751475130912;
        Wed, 02 Jul 2025 09:52:10 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.171.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718a750sm102556156d6.8.2025.07.02.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:52:10 -0700 (PDT)
Message-ID: <686563ba.050a0220.2dd6f4.4670@mx.google.com>
Date: Wed, 02 Jul 2025 09:52:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0033264429720243065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
In-Reply-To: <20250702162326.1373840-1-luiz.dentz@gmail.com>
References: <20250702162326.1373840-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0033264429720243065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:1350
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0033264429720243065==--
