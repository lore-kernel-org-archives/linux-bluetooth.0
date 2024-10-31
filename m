Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DD191F65;
	Thu, 31 Oct 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376696; cv=none; b=hMT+MQD1AWu+udl1VEH7LaG3wKeK2Heq0evlQfkSCSaL0XG+hxzEwrr+nMWFTCdxYbuXV++pHcNxoJ7Zy8WZsH11XWEx0BzkwfEY9JvEqbdJ/4Q0dB2Nc4ZAIQeL1tPUTukVC1ImsGEw7HIFl2+jtSwH0Ydj6Pp4lYJrkhrymPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376696; c=relaxed/simple;
	bh=AjcIyXaZAHmbI0poOFGfWCd9nLkYloalU6kHRzskv64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=utkKEv+tMuicQfXpZtfH7VGhw/yri8lF5VQdzQuoDAdUA8noZNLW/shbTRqhIpa266xIn5e9HoXCB6TBHv4jbt7nlTXfDHKRbYH3Q5KeTz4Hhp5A2q9AgwhBWoZRA6l8wZSTZsof3GkC/EcInh9S6kYaayO4C1/oGCTsQRw/wzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF6pfreW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF6pfreW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1246971f8f.1;
        Thu, 31 Oct 2024 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376692; x=1730981492; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYIf2HjwWeOrqyA8bh/VYoTm/NYlT2fenLJBBh/Gdo4=;
        b=IF6pfreWiMmTYXEXM3tHOVyokLAXViEvZsBpmxofxh3NIwnG3kHRiHB2nYvqvTIX+q
         5+v1A4+rvjF+sWMYT+0WG+npljl7UTvVe1K5iwikCijwPahdHqtaS6eJK4cKO8JuuJAM
         ofKQt3N6y9wGc/mHxYbWit+vkH38Aoh8aQoKn0jQeNqUPGORcc3A0VYk96gAt1rJJHiD
         J1Jko3+pUw1B1jFDl1Q7uAbqyLWk36b3UZaW3qujT8EpFoFlgaDi+lE9Vyyfyaw16RlT
         8Tfn5XNEpssKJopp2ZkQUIVh6Xd11gw8gpglJo/pQ2of+RySyJL5jrzW63ZpyiowHETl
         1DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376692; x=1730981492;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYIf2HjwWeOrqyA8bh/VYoTm/NYlT2fenLJBBh/Gdo4=;
        b=MPyNyBRAqQfmr3RUBpbTXCRhoagCIc79PcovL/N46aLdbkvu6J0xUSo/ejsdFgcAry
         pPkDjtuzixOKIUyr0pbSOG6lq2dknMHJs+OVytxd323XwxEIU5VmgdvHfQBZzuSPno2e
         gyq9bueORYrfctJ7l0DORcVNIxS3dta5fFFjFsVJhnBfwK9i/ZKdt5lJIU6mc0Nhd0pl
         1hUHjSaQzWP0KKxnXfRkhJp+fBaFLt1VB5PsYa9SCx1jPSV+jG/Uol5PtHYEOV8VYY7l
         mb0TrwA93hXTI4BHaehSP70TjECKPOKWBwK6MRqsqVr721ZP0JMjl/nRGhDtBCtHm2Ni
         gf9g==
X-Forwarded-Encrypted: i=1; AJvYcCWH5mgQmdBFSeeRgHY1ebvyTcosGLrm9zGQbEubpqDK95QRb699WOtYyqFroRoRJ229ErL63DNNtTjrndA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXZngb2qZh5sxSHhWjmCTFn4I2yAyXgpbZmrPA5SgFH+kohJc
	XFjK2+rHbSy49gMtmbo5EH6TC5yd0q4BMoS2zpePu1frN7X+Fvlx
X-Google-Smtp-Source: AGHT+IHrtzPOed5WE1Vq4z6/4B4q2Z4fqgyHnICqO/NAWJS6QBh9edI/rR9gby1IvXiHxk/u92vSyA==
X-Received: by 2002:a05:6000:18a5:b0:367:8e57:8 with SMTP id ffacd0b85a97d-381c14a4ba2mr1880976f8f.19.1730376691594;
        Thu, 31 Oct 2024 05:11:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm24111195e9.7.2024.10.31.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:11:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 13:11:23 +0100
Subject: [PATCH v2] Bluetooth: btbcm: fix missing of_node_put() in
 btbcm_get_board_name()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-bluetooth-btbcm-node-cleanup-v2-1-482d52910bfa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOpzI2cC/43NSw6CMBSF4a2Qjr2mDxLEkfswDPq4hZtAa9pCN
 IS9W1mBw+8M/rOzjIkws3uzs4QbZYqhQl4aZicdRgRy1Uxy2QquOJh5xRJjmcAUYxcI0SHYGXV
 YXyCVk0J36tZxy2rildDT+8w/h+qJconpc75t4rf+Gd4EcPDOtqZ3vveoHuOiab7auLDhOI4vW
 ddVQsgAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730376690; l=2032;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=AjcIyXaZAHmbI0poOFGfWCd9nLkYloalU6kHRzskv64=;
 b=UFumaFTuD+2/+/a2o79kaW1AW71drF7RL8PCZyZR5PuresyBgB1FaVpSSB6P2/JnT7aH6v5lc
 jcGAKQxMggwDEE3l9Rr5y/1E3RfI5pYDswdGydrOfoVrxyLJyo2mbdn
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_node_by_path() returns a pointer to a device_node with its
refcount incremented, and a call to of_node_put() is required to
decrement the refcount again and avoid leaking the resource.

If 'of_property_read_string_index(root, "compatible", 0, &tmp)' fails,
the function returns without calling of_node_put(root) before doing so.

The automatic cleanup attribute can be used by means of the __free()
macro to automatically call of_node_put() when the variable goes out of
scope, fixing the issue and also accounting for new error paths.

Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Squash patches for mainline solution without intermediate steps.
- Link to v1: https://lore.kernel.org/r/20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com
---
 drivers/bluetooth/btbcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index eef00467905e..a1153ada74d2 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -541,11 +541,10 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
 static const char *btbcm_get_board_name(struct device *dev)
 {
 #ifdef CONFIG_OF
-	struct device_node *root;
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
 	char *board_type;
 	const char *tmp;
 
-	root = of_find_node_by_path("/");
 	if (!root)
 		return NULL;
 
@@ -555,7 +554,6 @@ static const char *btbcm_get_board_name(struct device *dev)
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 	strreplace(board_type, '/', '-');
-	of_node_put(root);
 
 	return board_type;
 #else

---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241030-bluetooth-btbcm-node-cleanup-23d21a73870c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

