Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6457C9F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946210; cv=none; b=sHqrP13z4xEr1IX5hGuNeRAqK/sWcZMAqPbxFt2P3II2gulZc3nMzwR6i/TFpv7u7rDICbeqFItowV+iWTQ4/3tjVP7y1KPVFXtxLU+pG3FWp7N8/pvJV8ugXhAu0GARkeorI6ryDa360DvHo0qY/DqFgxen7OZWlDyRyoyiOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946210; c=relaxed/simple;
	bh=//rj/OyIA0UUd2FYLVuKrcTlsUhzm7owDnqF56W9QBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gt21IsI1le3G81qHFEHragLV6JveNQ05R/bPqOCiulfpUYqBQwnIigHM+DOJH9hA7a6Dtqt5YrjQyDRbhmLpB0V9UWqshz+cQDnUdvVqbG+fX1FTBRaF1V3rXEWlNKwumBLQ7mDmeECX7f08WNUQBJSzI6j4B0AXmZ5NxUmN9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7tFlPBQ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7tFlPBQ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5599b119b4aso628798e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946202; x=1765551002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WRz7pbBmzuIsuM3fJWT3rTLbaC63BHUBijA8opd+Fw=;
        b=g7tFlPBQW2qtJgzzivo0x+fifaGgN9UaaIp1BfkIWG7Ctz737C5VKHj5we0KNYDXsF
         vNuFX7K+3vy/KV1pP0ilJqDHG+yNAHoRQCTL92FaEJpyVPz7/uyKfBE3JfjnU5Nuk4Xx
         8kd/lI0lI/4ffeFnqPzxKa2Z+CbDwnVzF8ZnOrO+pRlS5xQm8RK8SCqLyiEaDHzJCFWt
         4NzscfbcD2eRk7rbmJpiCTXHy8Ta0PzNDdvQJ7pqzu8UM4vhHRdMYMjRnE0V+l+F09EW
         ROKnU86zhU6DI3HXnxMk0K6/nNrN5CJPKP2tRXx/xjT5uAISJaKodxzbplEQ/J+Bcq3y
         YgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946202; x=1765551002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WRz7pbBmzuIsuM3fJWT3rTLbaC63BHUBijA8opd+Fw=;
        b=ZT4TUXmytMzg3U2V4uq8tObzfMqKqKFX3/rFLsx6/EGWyaxVEzp/Yl2N0jNZZxdWrg
         WcP6mwqL9/CgqzxA/C3sUN9tnSXBRuQDWn6TN7jueZHWwLYrrw9sJ8h6ToHiUujkYr0E
         atJn0bmW/OaioZ7mc0sIDjJspurU5W0t7jcC4ZT1THxh54PO1r9a7MVCEnbnOO0zA0Oy
         l1qRUjorrVZdYV+W7RrQGAap65LniWnk/T60uFNxsPdttEd9FapAX7zAlqdWhxmTPEoh
         OVFaZ16SZjcxSLP1iovxW85ZYWLjtYr1if/KfelDCzz8KNzBgWcqF2wPTaLI58Y2aXQM
         BbAQ==
X-Gm-Message-State: AOJu0Yw/agKGRcyz4Zu/NpyF/ZwBfm7IPnV+u6LAO6KRxKIlX/WUKDTj
	wnILYY3gUv7ovAfgR3qk18kyWuzaWQw9gB2qjIumnG6Cvz3oIpUqHhjSlyUPAg==
X-Gm-Gg: ASbGncuSOWdZmAeNBLbp8Kc1C95cZEH6jfLlLLCfwnHWznSw0PO0Y+p4APiitY2HMAv
	DkaQNPBuMpuBFuDPRqeE8dulPzbWqk1iSnKGmI/69DhOTUg/DzkrNHJmPyvpikhxDG3DlZnsrAD
	1Omw8dxBKUSA5ckTAJWWtFfWSUgTCw1AszNNfWm52LeonmZglZgcACfAXsdwAPNtWoroZ8eeDL6
	kOyv8lFjseSO+rwn9EnBa3ngPsXMIwG+ou5m6738ZLan8gnwgIReCEBPoCedmLuO2DYjcZWT7jj
	AaVy8L1lR9j1Dy/GE1TySMGQdtnjF69WsMk41hzpTo8S+pXq8clmpsT7zy5VgRUKVpCKCJ6C71d
	GbKqOubQqTQp//IirSRw+AnQOSxlUGEDjU0pRURkEdUkRhteI5g2L8UGnqn7L5pkqw26sWwH+FU
	kZdU3Ia54DGLydlg==
X-Google-Smtp-Source: AGHT+IGEeG9sHeaK5J6quHy9J5kkPhJGqmQC+97DIfy3iZXXDwe+KI38XijFLizT3ee1mBgux1RwUw==
X-Received: by 2002:a05:6122:2189:b0:55b:9bee:ff61 with SMTP id 71dfb90a1353d-55e5bf964a0mr3706549e0c.16.1764946202015;
        Fri, 05 Dec 2025 06:50:02 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c5908d9sm2243380e0c.9.2025.12.05.06.49.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:50:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix attempting to create multiple assistant for the same stream
Date: Fri,  5 Dec 2025 09:49:52 -0500
Message-ID: <20251205144952.8373-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream may change from streaming -> streaming when updating its
metadata in which case bis_src_handler would be called multiple times
for the same stream causing it to fail at g_dbus_register_interface, to
fix this adds a check if the state is already streaming then it must
have been handle already so it safe to skip calling bt_bap_parse_base.
---
 profiles/audio/bass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 20c37323bb0e..031f527be9f5 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1274,6 +1274,10 @@ static void bap_state_src_changed(struct bt_bap_stream *stream,
 		data->stream = NULL;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		/* If already streaming don't attempt to parse it again */
+		if (old_state == new_state)
+			break;
+
 		base = bt_bap_stream_get_base(stream);
 		if (!base) {
 			error("Unable to read BASE of stream %p", stream);
-- 
2.52.0

