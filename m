Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AF182715
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361426; cv=none; b=RF/ysEQXdAlvlY2LZwHbq35tAfm3npqqmextrR2dC64B2b8eAg1wuWD3Rks/LOZ8l4Hwm7OgQrojsPVY+vRh4NzN0FyQm3weAAqFJCzXp5YOAm0NZhJk/typFGh7swMv0swHiSQuKAbFpLem7PsrdQekzdARhEutJDla2ez15Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361426; c=relaxed/simple;
	bh=Mrzg63EbUwF336V6fWMIk5vRiUljxb35ctM9m77R3XA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sOezjEY+yp5o0IF/FnaEhdy6DKG7W1McrhGxpWHJE/vS76064NB+XTJU44mUb6+WuHZhKrdeOI2ktWXXcXkdLukNMjIz66rx1N9BeFjOuhLfyTMccCa7Gb1VeHCXRl/n4PDp4v7iNE8Ta6Jp28berKEWQhKcHgRhCh1WLKVPFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odDDus6C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odDDus6C"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so4892085276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711361424; x=1711966224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rPoDdA/17uei8EMpsiKpGk6NmEsfbhCRydX+z72OfVk=;
        b=odDDus6CVA/s/6GZUFs1Vc+/peEjV3qBc0hMoZAxbXaJh1oT1wR6tgKbIapnh1Xbck
         BaejVxBxp/8iI7U12lHjoAuPXTElFiZshlc+HEacYfU7BOKepusxKQ8DtiNN6i9Jbbjl
         fvC2h9M+UxiGaFhKjyO7WRSeZE9ORHHy5V+cGXme257kiczbqJaB2+uZQ8wrAoNHubII
         Jd1Vjkgo6n4YYOb0p/OFmPQp5fpLy8TmY4K6PVjTeOoyl86mT/Bci2Ie+5FTdMlv6KDW
         u43R96vjwhxi2wI03pYWWH95U3EkTBb5gXf1QHQF+ArlkuvfVV8h5joS6eAbVFFc17PY
         DyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361424; x=1711966224;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPoDdA/17uei8EMpsiKpGk6NmEsfbhCRydX+z72OfVk=;
        b=g0jnD29Xe5s8pRapmAqPuhoQJu7i1vnQUAiLl4XcLZsNeZRV6bpToIv+f+DJ94lSTM
         A8kHZz8CanP1n3DKLKDSZPM/Ik5R1RnwqUGrar9RtnXt4usjJUXjsP6rSYKFyZx0e/qP
         L4vR92MejrjEPcNpHd01ZkxkYh9Te4EVcto2mdxMQTx7cxsLzzvV/5l5mi1ReCbJ4Z01
         3/GkAHS2i8FHFF4GVqm2Tmc80ThTUwsWCxBZHeBcyNhJrP3z/mzpD9YHJkahYdW6W0wo
         mTZ9xxxFvcHcAowJ7yauCtRyrXWgQeWDLWYg0Mcr0WYqUTfyJLdZIlr7GuGc0BHPIChe
         AfpA==
X-Gm-Message-State: AOJu0Yykr1cJ6vGMv3MxoL46w30mGjMcV8w0mlOVL0d5NGyhtbQTvmjQ
	l+L4HLUKNcK1F5K7YgnAjnKOS03Xdel3uuxxViiRnlEGwwo7Jl+9WnmOWhJ8IuPQAkAqb758VKC
	/n1XDz8LGOh2NHh/QzkLDdo5apl/ZOL6iwFXPuGdeZicpUUqe40RbE98Ulea2M61M4WpOhcZ/zU
	sxg1A9HPHikz0HJ8n8cvjfZqRiCfPtb7wjf+tIwTYT9nX8k3PsA+B7htJOMC0CwxLTLMlQDIU=
X-Google-Smtp-Source: AGHT+IE7x4dNmSMZhpbA+mPgkeKs/hJJUxNSZ9MozGG4iWR+eII3XtuR9xq83ae0K6LQhQ9+JW8hgNGtFm16nr1t/A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:e49c:63be:93d9:c243])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1207:b0:dcd:3a37:65 with SMTP
 id s7-20020a056902120700b00dcd3a370065mr237433ybu.7.1711361423434; Mon, 25
 Mar 2024 03:10:23 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:10:04 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325181004.Bluez.1.I8b0ed6ef2fa5a273f990a5c9f0872aaa539b8b39@changeid>
Subject: [Bluez PATCH] Advertising: Emit features property update
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Yun-Hao Chung <howardchung@google.com>, apusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Yun-Hao Chung <howardchung@google.com>

Advertising manager has some properties that relies on kernel
information. Once we received the information from kernel, we should
emit property update.

Reviewed-by: apusaka <apusaka@chromium.org>
---

 src/advertising.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 0131fc1c7..7f55a20e3 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1890,6 +1890,19 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 	/* Reset existing instances */
 	if (feat->num_instances)
 		remove_advertising(manager, 0);
+
+	/* Emit property update */
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+		adapter_get_path(manager->adapter),
+		LE_ADVERTISING_MGR_IFACE, "SupportedFeatures");
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+		adapter_get_path(manager->adapter),
+		LE_ADVERTISING_MGR_IFACE, "SupportedIncludes");
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+		adapter_get_path(manager->adapter),
+		LE_ADVERTISING_MGR_IFACE, "SupportedSecondaryChannels");
 }
 
 static void read_controller_cap_complete(uint8_t status, uint16_t length,
-- 
2.44.0.396.g6e790dbe36-goog

