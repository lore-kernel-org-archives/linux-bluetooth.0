Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54511917D6
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640462; cv=none; b=HvPeVqfIW5NkonhpqgwIwyDZQGH6O+M040mpPBJFDhE0Es9MksfOatybtdaNksl/n1I23UVAwMCvu2AhkBeSQlU0HXVsHVEaL09E64ggjjN/x8d0Uyzexo+xHH1NLv8A3IEHfiErbfOf4b+KsBq22vDUacMijIFkeoMsX4mc79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640462; c=relaxed/simple;
	bh=eKKBx7o0N5OUou+fjRI0q8kwinzpESaXSwSaLCSZZ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJfe3WhvI86C1Xumt11qAh7o2epzOiw6QT6Akp19t/ZCPt7aFu/FB6OJK52NG3eOvxmMyIUc4fT8mM+zdZmRuv24cpn6zn+Hv3S6RO01JACCIZy9XTINOA0PdtMAgcHxpaOefL7epucCXeHzZUmjdKyfr5NknKYo+bzMjQe0VCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T8Ikp5ZM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T8Ikp5ZM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a365a6804eso476921f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751640459; x=1752245259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcqBYfe0a8O+cCCxr9qxFOZy/LUGrHysRh3pGTlrgho=;
        b=T8Ikp5ZM8w79RcackrCaWMd67e4b2Y4b6rB2ZasiijpOmsU86hJsr0I0Oi3RbkGi6J
         XGSY6w8m6tJvttoONFLmF46T4l/LNkJTC5ngKejlKDTmVUlWId21nvAWC7cVbG5Gfhoc
         HMIVv7EFy6LkGYEyUzohMO7jXovTAKjI6YM+3p25kDY2cXBQ4kMfRIX8WIoGrCzR/OIV
         Oc3B97sKol1IZj1XvtNVTV09gmkqhrWy4ZsPsqXdRCAcDAR5FB4fD5PoisNTflXy4B0I
         d1DKpgTXmlA3xTUbzP78/u+fBuVMk1B4bdb3OC/Y2Y7MOk1jCZQrRf9r+bXeu3tEI5oa
         Tq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751640459; x=1752245259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcqBYfe0a8O+cCCxr9qxFOZy/LUGrHysRh3pGTlrgho=;
        b=MRI9Oa4PnW0HBAWIsEun26PZN3ST78K5nJkMfRAV09o3bQeP7Vdr73mdOFZyJsHWu9
         z8U9neTF6i462vqjRC0B6Ve0zznmYtUXPFfb4FbRdw8wr50hXAr+784xdxeMjPcxNYRD
         p6xTUGx+kN10NI96wsxEcshj/imlRIdOeuw8flQLTagXeH9yYE+Ky3tKJWCb4pnQNyMe
         ZDkfExpicDS06Z49Drt3nJ7dVPX2B9/5uAWWFI7SNHYor5uTFlNrUXrJ2GvBd8mxBlts
         /yYlEoVOY3Y5fE2iXvUNkXNu0aS/0P/QvhuYKYfxzT9HyDUghqDhNzCPIHMuR61SZnjO
         0sMg==
X-Forwarded-Encrypted: i=1; AJvYcCWxNRdCF0VeG+bRDeW2HvQ+4Va2Not3AuvcNExBmFuuu14jJrdpzZhV1GiJyRdOYJ9lOQAS9NgxYbxn3lB5ADY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHKwiFTtAQYXGivzKmYNa4vog1eUbsx15yHZrMjrixxHK8lgc
	rdZNoP0O7vzPzi4vXApCanO5KuNJWkFM4SsSBUrTgvVccUkFuI0NKasttvYLdRoP3h+v8wEJbtr
	mbHWl63M=
X-Gm-Gg: ASbGncvhnILaRlFP9VqOis0Xye9Ek7Nh6e0tfXpYgfh+XHXL2IeKGUqqMfSP1xoikxD
	3Q1+ax5r6yFaONp8aYmPP7BLDQCHK1PLAgmeKifX7O7RlgV4f7tx0j0kQXe3mG7SDLonEFuwyd7
	3qH4vYSZX17aXor2iUdAnBbxyHWwRjjK2Uy2tvGXXRAXjx6qxebTkHBs4MbksAJKDA9yEIfoRnW
	SiaVrAK5PuocHLHLIOgjOe2gXI3Qo/A3YrxZ0ucgNGRneA0HOhqzt6OQ/VgwKP0XmL7w3evRS8i
	P1Q/3JX4RMUl27VnQdFF9Q3XwYlOowoW8uH30DLOz+gWoRcUpf6i68WEMgp9/w==
X-Google-Smtp-Source: AGHT+IHGtZCWjPLCd8ll7G0W0O7rhS5w+RvGTT6+ns5X11cAJVZ2tzPWQuy6V45xzCWyz1JvOCsyhw==
X-Received: by 2002:a05:6000:2004:b0:3b3:9ca4:ac8e with SMTP id ffacd0b85a97d-3b4964f7b7emr2517650f8f.44.1751640458912;
        Fri, 04 Jul 2025 07:47:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:876:27c7:55ac:40ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm2721539f8f.11.2025.07.04.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:47:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
Date: Fri,  4 Jul 2025 16:47:24 +0200
Message-ID: <20250704144724.63449-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
can get notified about proposed changes to it. Add a sub-entry that adds
the mailing list to the list of addresses returned by get_maintainer.pl.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcc77c93f8db..7fee3d38baf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20441,6 +20441,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.48.1

