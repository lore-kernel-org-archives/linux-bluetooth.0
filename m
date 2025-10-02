Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A32EB84A
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412467; cv=none; b=eMLQj0qddzgSTPQarfXXH9WxfadieLxG9Uk8ylygnMW4KiMyuN1Zqlg5t/EAmCSBn8MjUTxKh6P1faZKvAlVtrV7OZueUyM7GmqB/0roSiYXhrKelevhj6gBjVpIrgi3ekEq+Q2RFMatNabIwjLYwJtYloX6x2mrbjk/lB+cZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412467; c=relaxed/simple;
	bh=p8zJXE/TxvmLVJJEMydEmEGRGy1q17AXH9ICU36aeNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G87nTtRRfNGPYMy+Q4RXSJpyOibOWrEdCvoMLBixOK316SYA0y0DpwHtaV3+98W7w0iARzqkxOUCJEp6+wS4SvA0QaTgj+SpxvfZGMuswKkw/PsC/gUl7benskCWeMugGiabxd+ZhOSDjt/2BcLwP2ZqTyzi+5TX304Da0d2RBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdiIJmFW; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdiIJmFW"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so373171241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759412463; x=1760017263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=FdiIJmFWVdAbP4hUKHOTryg2S2v+QzkvtEF52Tes52yal5WMdFlmbioH691JDOrn9y
         GdS9lw+U/LusPgBQBG3l5BqAG2zP55pT6hDYKrCBGQecVE6OzJfToadoD0bVSsd1gAxh
         ebXedmJn69P8s+Atsinh03i0/Ql5ZIzANJJX4CFB0W06HM8os+USLfO1wDZCAJ3+2qC8
         j14XnHf9Hgp+gHtMUKrQyGICqajEEfI8H9HT8Tm90LJW62A4aYcnF065V9YvBkQ0d3ft
         +e5iTignJeX84UMPjf1Dixli2TqdrqQvfNg+wJ1r/HA4lcOqASVDwipswQCpOzqFzDgG
         4L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412463; x=1760017263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=s/rys2XHG/Vuq0ldSboOe4xymNKpE9ein9JE/82nQqpY66JxsTikYdgBZqPvNI79k6
         JQaSWzSJFUwWeVtLO5TSrMeb/fFKqs+ZXWxv0wUrPBFrdEMmqUreI+Ui3XTOR8MM6USQ
         hcsK02T/ml80SuxzxiiMkBCaSM8jeUyMMnZ3fms71/eSRsAGEQnX3fsN32Ydm4tJtkq6
         2RAsKXGDKKLckXrP7t2OvWFsUjQ5yu32iVaCG4K2pMlR1GlGRUCm7nMZB1DJdVnrXs1u
         QiMEhudh/ByYSrblhtauUiezqpZ0b+2aTHsB+YcLbdi62bo18tE6kBtj+M2QyVBQSwmr
         VMeQ==
X-Gm-Message-State: AOJu0Yz6QLDysNf0H2CbJDt8jMZ/tBjiD4dTy8dm5QFwbC5zQd9+eVyn
	cUJbh/n73aAkV3xPNfw5JlFMKFB80WSNgmUaKdjXKDQ+W3Hy0GQc37lrdjxSsU1b
X-Gm-Gg: ASbGncvFLi8R7xr6OBPuDUng5YrZb/fLbpLL+Wc0GhXVdJn02OSxg53G9qHBktO+80h
	NbcQDCPT9EBpp/Tc5QmnnJHheDmFTl6qw9pmb7hncRrF5IAKiv7X+FPTOQZUVUuSt16W8gG5Tc2
	oWF7EzHr+Yy9ZXa7EBidSjQZTF4sr5SF/ExtAqsijBhY8GJNG1cxdr0gv16BBS64URmx3MwfRDW
	NWJfIhJ/JUctmnEOjIiTj1yiZ6lov3bF93R1GdPmo15W8bNuqOgh8hNrarAmdsMY5naHIz2+Hf7
	eVLtKGpe2YsQZvN88+jntOU+bz9TqcFFl6YzJKrQ8wjDte/nZaj/L52dG4Cf+D1R/WikdQnToKm
	czpXn4J/8DLcn9zfSI5cuVCWQS6LlvfCc55VDuzMXmNBNtK8SEeByRMBrKwU0Iv1gb8qPFj1lSi
	g6W6K2N6MX1q/QYnQ0qGJBuvF1
X-Google-Smtp-Source: AGHT+IEwhFdpeGlnVTGhYbUx8owlPDTVz1WrPVvizwo+HDz/ufZTkdTI6EBxN9YTP75lnFJ6vKgL7A==
X-Received: by 2002:a05:6102:f09:b0:5a1:8e46:5c92 with SMTP id ada2fe7eead31-5d3fe50f2d9mr2936196137.14.1759412463361;
        Thu, 02 Oct 2025 06:41:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf6558esm490157e0c.22.2025.10.02.06.40.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:41:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] client/player: Set QoS.Encryption if QoS.BCode is set
Date: Thu,  2 Oct 2025 09:40:43 -0400
Message-ID: <20251002134043.196760-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002134043.196760-1-luiz.dentz@gmail.com>
References: <20251002134043.196760-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.
---
 client/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/player.c b/client/player.c
index 598ad7f6dfd7..bb193dafeba0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1870,6 +1870,10 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 	if (cfg->ep->bcode->iov_len != 0) {
 		const char *key = "BCode";
+		uint8_t encryption = 0x01;
+
+		g_dbus_dict_append_entry(iter, "Encryption", DBUS_TYPE_BYTE,
+						&encryption);
 
 		bt_shell_printf("BCode:\n");
 		bt_shell_hexdump(cfg->ep->bcode->iov_base,
-- 
2.51.0

