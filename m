Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471554FA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829939; cv=none; b=lrVUKCttnpF5t8gFvXbZPEnjmxkiQ7wjeeHgh55URJzDiIMB1AbR/9KU9PyHo1XB2OjL2rSTfgcinC9L1ldhGCUKatvSC+Ucg3gv5qDhxtPpzEz+0qXx8Wr2WPcKBj0CZsTCa3nhkZswDf4+QPdY9/eRtWs0LBlTU+TkKeg2eqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829939; c=relaxed/simple;
	bh=8fxfnTIPMb2tnA2szCe2OOq/NJL/AcZBFVPZvQynbxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rhZ3S91cDpgotJLXYXVAPJ7gxhmwkM3IHQiS2vD+mK9VLAT2FRsUqY+jBY9mRHjDdS2ER49u2MniQBWimzXeksI3xWphsD7J5fukMlwlqe3+lStF5IJSTLGadBfHsHbcWVc3z9oeCm3FM2hD32WhGezukTQ09m7O+mj1O3eslN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6hN3n2Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6hN3n2Q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d1151b497so54775066b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829935; x=1708434735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3BU+7FRfR3+9d+O9WCXoUhbfOb5KYxgSeXacKQ/Ukw=;
        b=h6hN3n2Qz4wF5FadPoPDz4dFJuDOu+vTWZjOw/mGXnB3VEHPFijtBK3Ip75OPYSeO1
         xHk5caQK3eEoT7WULBnRp6zt4ARBLq0/v4zE587Vp9Wp84xGYh0dgwQeK5fNlP/SZoCh
         kG8KT0vFfI5u9ntIXpSh1GBhTfJWD52+OzEqlswh5//WjukJIF6kHbnrEA2z70PSPY2i
         zh9yl6pNN/OFesIXwWCYxw/HZG0T49iIsKTC6cEhJb4LwsPbd0+JZeiLvNDsbjSizn31
         JPPL+TM7l93HmuFh6GVoAqvFhZBdUfOKOZ5pRo4CnNg7yu9bOyiMmYVcCjiF8//z4VbK
         aVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829935; x=1708434735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3BU+7FRfR3+9d+O9WCXoUhbfOb5KYxgSeXacKQ/Ukw=;
        b=o5WZ4M4bpFFJhe2k4aeCJ8IMw+V/6OTzxjqenEfEg9CHSYOv3SHX51lbm8m2ly5sn0
         dXPG+lGyHyviF/1MmRUDyQyA+w8rNi3ukhGYaMjJm3XoRjkrSQSF/DruXghDfVIXPxAm
         5LxLMh6DBwhgheyaWWdXcJ0Wn6cTvQSkiqpuO2fG7cbpx1h8CgeTOJ2iYXF6NAa6V8TO
         a3jmOhhSU7DOvacQ7JAz1zrqR67euybKy+oCEu170doKGKKipklWWBgbZSv7PVLwEfAd
         0iKjaGH5BbVL5ZXH9OMJzBfGPMwqnxU41GxvUwWuHe8jjwEF8gHuTwrZ/BTALUrx/46p
         hGbA==
X-Gm-Message-State: AOJu0Yy7PKZ/a0PUYi26q1EJsjcFEKtxXaTZc6SRZWWsJv6+oid528F1
	HaYiVKBiDClLJs65FWfixQcHJspa8hSWPc2hJPwW+lOaJH0ZrYL3HZtGqAGU
X-Google-Smtp-Source: AGHT+IGk8uaq7DLbjG/4T+57uO1aZT1taXfL32nbNifa/VpOu2id5wPUD43qeERMqPemvxQhoI3g6A==
X-Received: by 2002:a17:906:af87:b0:a38:33bb:a7f0 with SMTP id mj7-20020a170906af8700b00a3833bba7f0mr7187303ejb.58.1707829933385;
        Tue, 13 Feb 2024 05:12:13 -0800 (PST)
Received: from raspberrypi.home (46.205.193.64.nat.ftth.dynamic.t-mobile.pl. [46.205.193.64])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a3cb30d6271sm1293512ejd.143.2024.02.13.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:12:12 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] advertising: Do not set timer if DiscoverableTimeout=0
Date: Tue, 13 Feb 2024 14:12:05 +0100
Message-Id: <20240213131205.28250-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to org.bluez.LEAdvertisement.rst documentation, the value of
zero should disable timeout and keep device in the discoverable mode
forever.
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2c9a5a443..c036065c4 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1065,7 +1065,9 @@ static bool parse_discoverable_timeout(DBusMessageIter *iter,
 	if (client->disc_to_id)
 		timeout_remove(client->disc_to_id);
 
-	client->disc_to_id = timeout_add_seconds(client->discoverable_to,
+	if (client->discoverable_to > 0)
+		client->disc_to_id = timeout_add_seconds(
+						client->discoverable_to,
 						client_discoverable_timeout,
 						client, NULL);
 
-- 
2.39.2

