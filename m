Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD63333434
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299664; cv=none; b=G02abAdU+hIepGSaGR8BJfiNcz1V1dYBN5Lqya4mAYtw1dEXs3ZIkyYhbIG/ODsdP6C2f78jFJWS6PVjcm3+OhIhsAwOZZ3DH847ynSo7wgZmus88ZzvU1UCqmce7oAEZcs6H8YsKclgzldyyMQ007JahEuZsYrcK/8au3CL4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299664; c=relaxed/simple;
	bh=MK97o0XNN84za3Yqhl3sOHyq/paZ3xuy1SRzaPhHO4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVZxdTYX6Q4zYYMUHe9NwlAVzzoisy9rfZVdlZpE2omr9hrVnYr2bcpavqfC4WRZxmesTHGNYpHjSEHivmKcPtjYOKoSdhXzi+IKBOfELaZkFZQXNgEl1H4QY1TrHWUkwwfctE5jrPtnhsTYBQuLcMGNHgqyzNDumG9TtWCaJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGTznkP7; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGTznkP7"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82418b0178cso1810242b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299661; x=1772904461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm5fMedlqYlq4YrH3Ah2187clARA0KM+24lg+ENYR/I=;
        b=dGTznkP7L/Z00QSbHu+Jj2tkxTYAqWfY7XK3Y/c7wexVJIIGqYO+L7j+6ysQyF77x2
         O+3IiAozCDv0LeWfV9wahC2Sr2Mg0c0Vj2s50LMiyvllOyWndr1vMNnCoClkmekOrF0V
         53ITCqWGyF/ADja4XMSrPJhyWsMHZI+4pQYNDikXlHIwJWYBkDlRIyx1f9mfuNHq7Xv+
         eM3Kl7esIUqj+Rb3ucBAHM4mGD71VMHAcn6vqwvjPt2gd/VmBSdIS6r0ohXzNySnL4bp
         z/bLTK3xvdxuZrIeavIU3O9BLXxLz3p0YkwMPm/eVSm+M3IZmUePYp+1GUsJeQKPj4eg
         K1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299661; x=1772904461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qm5fMedlqYlq4YrH3Ah2187clARA0KM+24lg+ENYR/I=;
        b=Q7OYeQW88GwOt0QYiphA+RJ1tawG3kC+nWsUY+61IvyG4eBQgrMsPs4rhFWTIBmbdO
         gblBChM29C2QMuCANrHkL9isZ8466UV4OAaLXT7JD6hIPmYzXpMtdE9W5jC75KXEhBqu
         qVyu5MHOBB0FEWNMDSpwHMmt5MG5FOcgMm8TFlGx8XbWLAXuoVF0/umlN/y5HzmuRAm0
         Kd10PMVYMq8VAKTGQdp+Ox17Z5Tz1vSpyEBPdKnLFQqnd2pl8Zv/PXj4CGQH9saEpWPA
         W0drlzuFOlArxXAKxK+Gows0TXQAbPA00OzbJFf1bB37ffJxKkRJzc5eOfWUu9jqbitm
         zLPQ==
X-Gm-Message-State: AOJu0YxbG9W0YmDm8cXbJkgJf7u6/4KphxEqgD1HJDbyolhuer+npomZ
	uZx5HvCVbr9tlwCosYzLPPW3+at6ZFceQcRidGB/Q56VhEmg0qk3QguU
X-Gm-Gg: ATEYQzys6FPKR4JmhycKhKf7Z8OYdDL+qSAHUw+5lALT7zVWi7/NbA/GasQObgheunu
	TJFRU0K7eJZ6uflemjHPYD/UMuIggxnlQstEiky3Rx2N8Z6WHRxv+jhdGxPkmi6SOxjnT5vRFuR
	oKCK2SwzfV3LgKjS9deGnVx1AtGNqBybueZLkfvNtaNYlDQDlNmd0hTscNhtGwlFWpCMQgr+XpP
	YZJefO6lTzPksdqr/P3IUhfUKyuydeFh4hno13+cyY4i3AqKK9tuqfZUtMYqJ9VnnNTYEC1idSo
	1L3OwK96UnuvIfkAMqaeY76at3NMyxja6HvmdQCfHXhgpSjjkuGyn478AwySqBMUZdSbGFFhhHX
	dtdciZ31VaNLOqiMTMd0PrhjiRa769vnFZiR5eXo4LP+h0OCy4UtP432PHX6LfhFnbCWumDZDf/
	ZGrjiR9wWucCOabMTgko+wOQgPpnW8440b5DJoL1bLcLDlR77RdKMJHYp+KMKHtC3cEd5syg==
X-Received: by 2002:a05:6a00:2d84:b0:7f7:2f82:9904 with SMTP id d2e1a72fcca58-8274d93366emr7021390b3a.5.1772299661274;
        Sat, 28 Feb 2026 09:27:41 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4dc6dsm8678289b3a.6.2026.02.28.09.27.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 09:27:39 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2] Bluetooth: HIDP: cap report descriptor size in HID setup
Date: Sun,  1 Mar 2026 01:26:57 +0800
Message-ID: <20260228172657.53040-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
References: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=ericterminal@gmail.com; h=from:subject; bh=A7GL+k99vFDW3xabOAkcMVC5EDRSrF16Tzq5tcpWDdA=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQuVvnvtuHkuePNx9Yrnxc/8NZi6hNf2fQLli3u1issJ 5vyr7Js6ChlYRDjYpAVU2S5+3/f3FyvW3Oucx/OhZnDygQyhIGLUwAmohHO8N8ryP2NxD3VQ3YV T+WiNp5s7tvcVdOhnMhn+eS81nTDB+UM/4uKN+nwxH+zbvryarmvwbbOo1I51Y6HirxfzlBP060 N4wUA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

hidp_setup_hid() duplicates the report descriptor from userspace based on
req->rd_size. Large values can trigger oversized copies.

Do not reject the connection when rd_size exceeds
HID_MAX_DESCRIPTOR_SIZE. Instead, cap rd_size in hidp_setup_hid()
and use the capped value for memdup_user() and session->rd_size.

This keeps compatibility with existing userspace behavior while
bounding memory usage in the HID setup path.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/bluetooth/hidp/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 6fe815241..31aeffa39 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -755,13 +755,16 @@ static int hidp_setup_hid(struct hidp_session *session,
 				const struct hidp_connadd_req *req)
 {
 	struct hid_device *hid;
+	unsigned int rd_size;
 	int err;
 
-	session->rd_data = memdup_user(req->rd_data, req->rd_size);
+	rd_size = min_t(unsigned int, req->rd_size, HID_MAX_DESCRIPTOR_SIZE);
+
+	session->rd_data = memdup_user(req->rd_data, rd_size);
 	if (IS_ERR(session->rd_data))
 		return PTR_ERR(session->rd_data);
 
-	session->rd_size = req->rd_size;
+	session->rd_size = rd_size;
 
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
-- 
2.47.3

