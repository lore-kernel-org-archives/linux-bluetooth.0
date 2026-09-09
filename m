Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD5448D18
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981807; cv=none; b=ddizTz1y4/gLYPPJ5zIT8NRyZTA25Vs45X7C8UTDoOPQyvZ5tu5HBo2IIp8F2zhHAQU2yH1vpbSDBIpWe8ghA1oJspX1xZlnWEe9UzAr14IzW+PFSyXEIZtSrayAo4sKQM/iWf3ItsRjZR3QbuqX5ajVaYNvjQn7v5ymHDsk8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981807; c=relaxed/simple;
	bh=osY7HgqlbkdV6PDacRISXX3v+8HBtjNnYsQxeCY8OSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLG3LIQy57eaR/DgdqfJg8HkkvUuVxwLb0GV/YDmjve1XPB2Tmq7E8mmf35vB4fJHIf1GAowabaHltkB5BoImpe6eYBksBB5BN64UBj2hdw3usdghtPNI+qO+67OPhZAMUrHhxSQgnaGc8Z3lu0RHbBCbS2GNdpbYwG+M12rnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHYoALs5; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHYoALs5"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96723c7151eso1642957241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981804; x=1789586604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7MOkVOeKlHdvs1HQX2fHG8lRUVew0QMSyHSwEDHoBy4=;
        b=cHYoALs5cDaxCstlNkB24eOiMxRzgyFVnDMbUd7Y89N3aEJQkjb/Pt4V6aPuXQv8Gx
         eJS2v6GndYCBNnqMNOzg8XI3imFwXGEU3TZRXyBZofEgbg1s9n4ci55FmGCZKXxrC7Hq
         VsOKno0Qv89u9ZyPiK7kEC4OhyeZNAYGUGNcjpI957auv9dTcbmHntAHYO55+NWFiiT6
         zwrvS3uHK6xRl2+eighK4IS1PSFNF+XOUDAJ9Y0i1VaooMwRXFn/aHXZysTtPyB/0Wz4
         76Fq/85YbWUolsibBVJ4YzUAYI1z0kx+iy1r9ZmXEUtp2lXu/GOGUfSa9vvvtvZNt/3M
         RsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981804; x=1789586604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7MOkVOeKlHdvs1HQX2fHG8lRUVew0QMSyHSwEDHoBy4=;
        b=DVjCfBB3WLwdmwX6zNAkt/fdVDoeGT9bt+NBVk3xtIJ+Mi6LdbRITfbuXKNRZoYgzA
         XHEuf8WUkhChvhpmC0rKw/jBjJp4xPSXUjXDWyGSGC1ZXNhsZ4Bpv3Chf9ywEA0QcMgL
         PPk2pFIEc057GLCBjBBWwqNlxn6TMNcj7kxSrigVnvw1RxTCOIrFK3Jemlbd3hR+bYmY
         ltE5UdLIiciVeJzPoeoJSoWraAJ0GshLWHKHCAusattT/DRilkiGiY+lTjJxSBgcXz5O
         mQCEgwscgamaPCBO/YXXIQPszuUtN6FFUGWZ4KxeatdF2/C5ZpqXDbyR7zegT7eltTXk
         bfsg==
X-Gm-Message-State: AFuF++nUiIP689f6pjRcJq9W0LQgtbiIN3dFPxdBXASOX5FSGaM3CnFf
	Wlxz0Ni2LxjY4fJxKTgO27H3C3dM9r4F/2BEv3L6pOt4w+C20/vBoOCbiFrNPAI2
X-Gm-Gg: AYBFou0EMrQHWyHVJtcgShC0QvnbptNUFanBftQ+t8lL3xAu9iv6NhRpoJYeyUfHESF
	96QXztWe0OVANFccvnD0Pom/HzQ9UehYm+ez4U09Hz7Hor0nVlhTFfqEk71QJEIWU9PWqfkFNiu
	b01J9AGws9MOBVoi1XUJcoLo5FDIEvqZxqMsjCveaFN8syh+YK2z2TLUMwlV390f+YZkUMHyF3C
	TwtQj/Ae0aWgW10OkxtTXk7q7q6xEjN61Ay51qPQUO+rwGWtpK4or4EyoZPwqwulod9rvTwsxyy
	TYmd0FW8UzZukojUTxS8WMgo9qxUCLYQ9YDPeqIX3qpilszCI6Jww92Z4P7bgL4AJKlQKz9pb9Z
	8AXe8Qp+0zglIwZzCuSq/kezIn7xtnr5r8vFfNLpQe8quQf7F8xOo9fqCYoEmKf/tWJGKgV/Xd2
	YDPtZK5oa9NZ2PdX5a5MGLnyd6qIcUNUJUt4gwLikVPm/p/NhseM/rDkkRzAm535N09UlmG7SvM
	XU42y+mSiSJ7l/o2PLWIC4J9YWVX34Etbwz8yAQ/dkrlQmcbYlI8urlDcholIOijA==
X-Received: by 2002:a05:6102:38c7:b0:779:e75e:63c6 with SMTP id ada2fe7eead31-78a4a99f93emr15678106137.12.1788981799633;
        Wed, 09 Sep 2026 12:23:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/12] build: add doc/test-functional.rst to EXTRA_DIST
Date: Wed,  9 Sep 2026 15:22:57 -0400
Message-ID: <20260909192308.1306567-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The functional testing documentation was not distributed with the
tarball, unlike the other documents in doc/.

Assisted-by: opencode:claude-opus-5
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 3840bdbab17c..7895c3b2ab73 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -496,6 +496,7 @@ EXTRA_DIST += SECURITY.md
 EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-coverage.txt \
 				doc/test-runner.rst \
+				doc/test-functional.rst \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/hci-protocol.rst doc/mgmt-protocol.rst \
-- 
2.55.0

