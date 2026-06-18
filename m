Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BC3F1643
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786761; cv=none; b=Mjtq1egzVH8fD2w0b3kyBLx3+oNxY4DSD/wYgsc+bKtcRI3MuC29mx5fV96PvScB7zGt41CRFbkAdgVU9X01RuwRDpmoMIiZBtGuhwHD0yLqkwjxtcX4vwEIOfPmpdjKao3QOgQVBz7ubvBKowF8vJ8dIo2hgZ9+0MhClMlmmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786761; c=relaxed/simple;
	bh=+iZ/OuqtgmWvnlnUZb8A6AjQaBAJvNi+qdj6iT+5eLc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pkf5VFCY9wHX7uFP9bd7y9OMaWinlvPUloQTnu0qHo96zNXb+WvqvUFGKuN4Ub6IveqJOjggGEZ6IDhbpoWTH2/RhARlw10CpDDuKEPNzMayFfTlJpULcD17KRH+p6ONrbrYZ3bOTZ6xjqWTrnHYGeMCdG/puYIrmTiKsjw9Q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMN3Gf0+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMN3Gf0+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9156b74006aso65491785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786759; x=1782391559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+iZ/OuqtgmWvnlnUZb8A6AjQaBAJvNi+qdj6iT+5eLc=;
        b=iMN3Gf0+se9QMTyBHXa6zTu8uxj4EdfmTAsgLOjfkc3rS4h1blM/+LVFlm3PbyKCvG
         mzrccobq5H4AAzv3wFv4A1CJO3Ozugzo41HJPofwt08A+UBgGiQKmD1GLVFlROy7Zimi
         QmZ/JrJnifKVyYTZseBxlEsQEzps6aBUeftp6vQuRBOPSA3s5frane40pa+Nkmy901/i
         uj2V8VShuQKeYMTyTJ9LMKLAbXcIj6YzDd0GbwuGu5qRvo6IOhsaLQYVw2ytuOn5DxcY
         ZOqv7d/q+uQnzWVRteCrdePVaWUrb4Adv7dWfhRi8eXQMjMymODSgYD+rcy78LZGiJly
         P1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786759; x=1782391559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iZ/OuqtgmWvnlnUZb8A6AjQaBAJvNi+qdj6iT+5eLc=;
        b=klV5XWTzhtj/mcTXu6a2nqRIaj9Duk4TrL1s9nV4jHTHmDC618uwZBJWsI4dM4VMJ6
         xK77hREqB9KWmSDfa1EHi8zA47V0BLykbFYjFLu3Wmq1Hv0Tp3BuG3FAVMP0qjOKMQOl
         zuTotDul5Hgx3dT7q/7BL1NjSTS0pyja/jEBoUZGOIowyqEJ3mPMbz2U/VyNBiLZWxgF
         SnBV/DqBjvDI9Huremz13zcwP7YlbFYPJ1eoZYrS9PM71B4uAQQFE60kO+FuoaIDDtt7
         wZ7QIo0OrcgCyqQkChpnz8YdXLLuEtmPOeY/Pyp8DgXIPw9qg2pLOUrdEo+4Kf8Zii8O
         qtyQ==
X-Gm-Message-State: AOJu0YzSiQVaDKRFsYcrcA2j9TwmbxCPni+YB1BkqyvnO2BGAf4zWeXF
	o/taAuvuy3VUHHmxNZhl1SDpijEn5UP4DgfzkTV1h7rCfjcA3OS5OoeqojCmSw==
X-Gm-Gg: AfdE7cnLnpmPa8uVA5wcOK3s+8IoL8mpet6FujZJ2F4sAIMtP7qT1pMYrGHMpxpfbLK
	/BA/GPaWif6Q+uDhgQ0GNDR21YSvRE53iOiBD0EImL/Jvi0O5yy6BOuTw063wd37sGrLNP4VJN4
	5TVZ34F/fkneNG31n3duGDs2WJyObaH4G1gM2YWxXvojCfB+1QhOp0QGGRPGkm1TsNXnIF+G/ig
	vBB0dMQ4IlFWASavzLK8kQnW3X4G4I6dgombJbjdXX9G28ypr4ysRSttexYgNbdFYWgnHz7ah/0
	APgVCLoQeg5AfOIu73dw23v+m9izYIkNYyTZYLBNhPSqMJl/3LLemkFtNHKxW9RiklEVQwCjn7+
	QPuNZ6P9/162JdhEFzcbEchqGwZeRwkHLn6DHYf6W3yvXunTX+Zqa6Hun6nfzj5mj4OAnVl2kp3
	TCVUD/yQ+f1lb9HhTExOzzYZdeLYozftpX
X-Received: by 2002:a05:620a:c42:b0:90e:2f56:2f0b with SMTP id af79cd13be357-91d8a7f1464mr1480750385a.7.1781786758936;
        Thu, 18 Jun 2026 05:45:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.118.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm2176590585a.27.2026.06.18.05.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:45:58 -0700 (PDT)
Message-ID: <6a33e886.07a8f466.63119.7bea@mx.google.com>
Date: Thu, 18 Jun 2026 05:45:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3328979224225179922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260618101047.4185497-2-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3328979224225179922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pci-imx6.c:1382
error: drivers/pci/controller/dwc/pci-imx6.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3328979224225179922==--
