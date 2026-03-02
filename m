Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C532694E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430220; cv=pass; b=N3jfwFDR9SiNUxX6cIIaUbAQlDt9k6lV/76/nH/ae5dlUJY56g6FZrv/Dj1ZaCXk9XLBnlItvBZJbeBVQYej3LEmOJjfMjvLD2zwi22nlVQoxfBk8yb6CTzhoM4/wTtvCBcXrHC8jvI7BiN+nRZShWNTbyy5dlppNb5hcTSFHF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430220; c=relaxed/simple;
	bh=GzRoDw/cVnbOD++qwOgp8DduUf0yhZ42DwP9jsvTLDA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DCXM5vbLRhrnxb5Nrw4NTB+yVRXJADCYDKLoDBdozT0L7Ay7YY6aDRChBtIpaD+FT1xFH7zmULOmNgotc1qxSoDovwXix+7TCrNcfIuiTRdrBvGL06mmAHwqSPpjkDfjE8baktNLHJNDSozGAiDVG7B1ODD7j/EoO/ylP2YotBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYv6TU3H; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYv6TU3H"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2248014eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 21:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772430213; cv=none;
        d=google.com; s=arc-20240605;
        b=Lnd/US/94WkJeprHwuwsRAICfNkLfPbe81rxTEX1SNJPUcvlVJyCZbQjaaIFf0PXbe
         /52KvFmI3B45VEi1SWLV0mKDKUXT4xP8Vt0FlO++GE2YQ/HtM79bqlH1aF/83rxisabb
         cDy47WZHV1veEOQWOMSuaJCq481QZKkN8H93L/qqSLcJS4Uj+wVJ1ROBASgB7sZCIFmo
         t3CGGqWHQXI7odW1+0Yh+S+QKWTqygPHdsdOcFBmxTkTSsXUKa08KVHYqsM2lu+C/Zmm
         KguYwWc1jKeg7wFdqj9I+uL+QJTyZkTFyoxgpqiGr29Nrabxat1ZINA5DcqA5DeqPW02
         K7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/x0h5eXiZ9M5dSipoH0OAOhSBeoQ6PmVPJ36Yi6lNZs=;
        fh=Ym7YLtscl/gkr8SJIPrMfBraFgWSnnIUx9nPuBfk5fA=;
        b=cbXja2byBdkugQDPhWrSpp+4DdNTjwnYsBUKebCzYqb7FwOR5YzizePLgCi/TlAtE9
         M4gPEjxdjs/OCDR5mGsX9LvAuxUa1XiyE0C0vQfMlJN+YSkmw22tU1BJUYY7YX3iVTOr
         ieVtrnJteIFIMrK7ubRRqv6/zLDBqm+uL3o/GRws4ix7vr2T8sRIzivVddnqnzjvJXUa
         B32mRGUnoSrwFVOUlU6/Vat720fSHckjRohLYMoRkOw54AixOvB8+/QOWZ920cIH9uUP
         PjTMADpXzQ7+/nYWmnDneLizihaNLEzuhCihOG5kCiuJmc3x3XK2MgSCDzRTFYd0wu54
         RNcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772430213; x=1773035013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/x0h5eXiZ9M5dSipoH0OAOhSBeoQ6PmVPJ36Yi6lNZs=;
        b=nYv6TU3HyV6w0F/+AKYjLJjevC59MGtlB0A/spoaEm/7RIsjGUBfNiKmMYwj9zyyJQ
         vTeK3KUPkPa1RS1DM74XsDcSCjK0yd9k5E0SpVe28GSUMZ7Cr/EaL4SlDl+NaVG1iIGA
         cOA6L4YMmKWDHkIWrvkREsmrMoxchDrdJuXZ5VY2DU/kO8h0FMkoPz8CGiea9n/lq31M
         xeuE4PBHcHrNWugzCy7By+mQQ6JIQkMCyFPXN9/EEMY/E80GfaflFMJBx0E/YDXPkGRW
         KFloepzVorVwYBgPOo262cyBFODwMZkQINj1lVKl2rZTpdHYJVBSS50Kr62KWpEgzR0U
         8xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772430213; x=1773035013;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x0h5eXiZ9M5dSipoH0OAOhSBeoQ6PmVPJ36Yi6lNZs=;
        b=BU/wjKKrPBvUGpuJQ81ZGjQ9xxZNKINtJmCAUVhidPh+sZS6/2XDQYcv9jsGDqSy9H
         v7mjg4H91O3Nt2Z5PQpL/d3sJIleqeCjtn8B9Q780J1zgtHbTT7+gicYUWa0O6nFOB0B
         YbaNyyD3cLPLC4KLtjkh9VNDbhf8p5lTwj2TuGeWQHN+A2UYBZ4JufcxtIhF/H2D4tEv
         5t+hdUY6HuD4Q8/Sa9q+nHRo4BP+IoUQMnRKTIAttw0hLaQ7O4AJBEQOVx1cJQCLX7V/
         bX/HO4Yc43dqmw7aFHEcuMk8WyKecuRXCWTS0+cPE7sL6HdHjwq8Gzf+Z/QGfHxKYD2o
         FIuQ==
X-Gm-Message-State: AOJu0Yxj26TMkskVz15j5UpETSEfoIB7dUnwO9YwqR9GYlksiPXRozcl
	SXyAzS0GxszJnSPANo1I47cfUt4T+buqF4aLYsaXXK0lOqEE6a1f6EiizdacxzLViD8/RcjmTRD
	xd1KVe6CvKygc/P3wXniEe3sC3JAInQeL/QJ91FP9
X-Gm-Gg: ATEYQzz9ZlpDtDRV3ll+6vhYRqXlIhpRVRGSvDH2RnI2zYbn5TZZ6n2BuVeKR/IXaNY
	BG2rvjLcdQeYz8LGlFV2pLs5gXjQRu3m/etLiaiZ9wf4JjWNdvVulNWMZDwFh1xnVJyZcdDu/Xd
	Ety4+hwa7O5dZQ5dNnD+2NpQuDxL+b989Ascf0+ppf8SwJPozki4koEg5iHbjY2SzHNJ9ckfmlQ
	cNwlbIrtTO8qNsDhYCo69cW54uEcrESG1WE1ecV5t7ko6phXiDiJOfr2VaJhjFU5Mx4pt8tTmrb
	0TtFsg==
X-Received: by 2002:a05:693c:3110:b0:2be:1779:3287 with SMTP id
 5a478bee46e88-2be17793972mr244372eec.5.1772430213233; Sun, 01 Mar 2026
 21:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Date: Mon, 2 Mar 2026 13:43:22 +0800
X-Gm-Features: AaiRm50lYrpgMV6Q2QRw3Dj4EORPKRW4CFzZUTvT3LUhYgBKHba8I3_h0wiMgGU
Message-ID: <CACrSQ4GfZJCBCONtT44myPR63pA7_kJ=LU-b32zGVMPE+pvrFg@mail.gmail.com>
Subject: [PATCH] Bluetooth: Add Vendor Chip Support
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From e852fb087d2635951adf9f28327447b7412c2943 Mon Sep 17 00:00:00 2001
From: kaihsin <kaihsin.chung@synaptics.com>
Date: Mon, 2 Mar 2026 13:37:30 +0800
Subject: [PATCH] Bluetooth: add more BT chip support

Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 2 ++
 drivers/bluetooth/hci_bcm.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d33cc70eec66..7ec871e1118f 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -515,6 +515,8 @@ static const struct bcm_subver_table
bcm_uart_subver_table[] = {
  { 0x4106, "BCM4335A0" }, /* 002.001.006 */
  { 0x410c, "BCM43430B0" }, /* 002.001.012 */
  { 0x2119, "BCM4373A0" }, /* 001.001.025 */
+ { 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
+ { 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
  { }
 };

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..e8817e597a65 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1594,7 +1594,8 @@ static const struct of_device_id
bcm_bluetooth_of_match[] = {
  { .compatible = "brcm,bcm4335a0" },
  { .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
  { .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
- { },
+ { .compatible = "brcm,bcm4384-bt" },
+    { },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
-- 
2.43.0
