Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2E2141AF;
	Wed, 30 Oct 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303202; cv=none; b=HvxoALjWEPosKuJH5XhGe79HL2Ur2Fr/EX3u0c3ajUT3iKd3EJa97q/iYFdnXFJTrQYA9bu02yYDk3dU6prYo14nYRVw1ZqHfzA0UNIsZd1CAKVS2LaVhL1jszLWpTi2cXkS05V4jr1/LzlkPM9X3SO0B4kresvNGBHCLiC8/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303202; c=relaxed/simple;
	bh=X4bS7jZBrQsTQ9pemudF62VcEvDkNDsGs6ennZLexiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en2kZYiQrUhRf7NRLCoABasCG/qzTtsjCetQ4SvvMEwwaheGh4dQ2eI2P1eUcRDTEDHO1HHcIflBgkBKUjLiG/W+7hup6ZwC2seN0aQLLH+WEq/YNSIECZ2wHX63icDvYAykhZRSS1mkf621ehVpy6oEuM0WtvAg3SMl2VfcxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRsVs12x; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRsVs12x"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so197107066b.1;
        Wed, 30 Oct 2024 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303198; x=1730907998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ywf+/b+4z5TUeH000STbqJxWFX2lQppigAFbBYhUVZY=;
        b=IRsVs12xCYTN9CdsSGfDLCu9lq2+z87NFBDtgrLnP0Xn6/Y7lxw1XmRv8GfeirveI/
         6Yh7kth+ucvWSQiy1ogq8241SIvWrlRcw9VhKvfhiH5kGUfdCgzJCoHlmb3ODHt0deKz
         oYLms4rFKNcIdZmXMUdju8QNZJMKYLs6upxuBCI2Cd7hb1NtwIpnPRN/PTOk+vQJusae
         0jPP14jgohI9x4LV3lKczSBPy+70BnhsjtJG0+u4TM58VUFRtdPbowWSlX6mHb24xNch
         qDwpHbSpWjmyA9xYZxAc+SSnaiBau8OvJOjOmSh3RuNh5OQzHnbUEZWiowjOAjdzbTTR
         tDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303198; x=1730907998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywf+/b+4z5TUeH000STbqJxWFX2lQppigAFbBYhUVZY=;
        b=nAcQZB99Dow71DyGJfbXNijuEi/SPwmLzLMcKv4MAgL84X1jscOJ7KoIDmN0Lr/zv9
         zd1s0IgyPRn+hSl23/4/xDMdrwGtsdJFsY0i6v+vSSjc/3rZ0rRQVEoA/gSbreID+jp+
         M5OEQmGQKr6r0tkNbnLxBudPKtfUufJeoqxlM7ZMeLDaQ7qPurlIZ2vfiNWuOG0MhDMK
         DqUT9lZZzHYrLOD+bAAKsI5aXO4EbZOmm9QiiuBCkH4GKrINmnqQUhpu6uHHy7Om3LLm
         WbKN0FZpWLugAodm2yCWUGs8ruYvT1dsGgXJLHklIiOf+sn88zdtkfJWg5pdyfeghPIK
         6Nag==
X-Forwarded-Encrypted: i=1; AJvYcCVYCFJZwMJ8MQF+E6VydMAUoU0bbsfn98P3LZTbtIxf8hQvp/jq0auCuan/mNwrqhVy6T3SGYWtGpPMTnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLJoqBGBd3C0FacwQETqUcqFUNWnqKZPXVpBrr3m4S4V1jB1C
	S+yQE1cf8D3oCj+amxl+Tyx6wzV64cM4U51/2mjX/fDMCwPKe+DnDyi6DQ==
X-Google-Smtp-Source: AGHT+IE4kMH7781VGRzXLHNlecgeJTSwY7og38Lu++uliRPFZriSjrif96AQ2nPEDjMztByH5IXscw==
X-Received: by 2002:a17:907:3f97:b0:a9a:e0b8:5bac with SMTP id a640c23a62f3a-a9e40fda6d6mr258358366b.23.1730303198168;
        Wed, 30 Oct 2024 08:46:38 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086de0sm580414766b.218.2024.10.30.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:46:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 16:46:22 +0100
Subject: [PATCH 2/2] Bluetooth: btbcm: automate node cleanup in
 btbcm_get_board_name()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-bluetooth-btbcm-node-cleanup-v1-2-fdc4b9df9fe3@gmail.com>
References: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
In-Reply-To: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730303189; l=1278;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=X4bS7jZBrQsTQ9pemudF62VcEvDkNDsGs6ennZLexiI=;
 b=NXX2QxMwsq+yiv1DLUCBmB+gqhH4/ShsIIesjB6CR3K6y+i/WA8HGBl1EmWcGuTG4FUtRl59w
 /NsEm11rEtxBpb8+HxfpCXctYow2djbBDn2x5tmCUmh9eLzzzCzfyTZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to a more robust approach by automating the node release when it
goes out of scope, removing the need for explicit calls to
of_node_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/bluetooth/btbcm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 400c2663d6b0..a1153ada74d2 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -541,23 +541,19 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
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
 
-	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
-		of_node_put(root);
+	if (of_property_read_string_index(root, "compatible", 0, &tmp))
 		return NULL;
-	}
 
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 	strreplace(board_type, '/', '-');
-	of_node_put(root);
 
 	return board_type;
 #else

-- 
2.43.0

