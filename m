Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAD1A2C10
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326355; cv=none; b=NSdEZYD9mtKx5m2Yhi36YgGzQBI1nhLj+8gp+AggF8GR3l/XrII3imuPNmN3ufUJhANRV/ZZ4nu+1Y/d4oS5dK7sJlWE2dix1Mxb49mgTXVfD15bvNEq6kqxM9DSULZbuKtr+1lqE1zfoW77cQejz3AFnJAismOBenT7KPxPpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326355; c=relaxed/simple;
	bh=nRKVotZdtVqWU/aqukONs2IK/vIujXjNZ6vmpFByfUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiKD45r32TcunbOIRUq4xF5JvyVTxPOGkaqthl0IW+LWIzYlMDiczJEhGBGAOAC6kszwaxVU0a+lKTR4wWei6QYTGwXmSEz57/xrt+32vn9DZS25cKFBL6053emfQwTfTqtOosDOSn5eZ9HbzDFNeh8q0Qg48YAVStgNZ5AWK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7HZyIJc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7HZyIJc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so3213405a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724326352; x=1724931152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXKBvCB3Mkkqlg0VZcfzGE8q8tdRK3d/QKk2HF5/hDM=;
        b=c7HZyIJcLDT+uoY8e8QtMCxn7IgEvI2lytNo4Fy+F2ocaSrDTIwJJ6c/CGvuaa5c+U
         GApTFjZjV8VQtsDtsypRrLJMjx1ot84BhkcfdXy5QAXNoASR9NvVYNi3TFwvb+c0skLX
         gTESb7U3qiPq6fzTqlN2OZPzHaVhA98dDHIBAJdRNB0q9X/MXIngCGNG65/NKn3qFJJ2
         2p9NA3Qrzoc5I5/IVpXktSOfH8tlihgWE/l79bvhmE6px5BxkgvYxIQOkbULW0VXD7Pz
         ft2q3dXBAxOdyaWVf3YqxYhJPi0ZKsiq29LkrVdfx/YSbRtyurJ2mGxnoEPDLM2U1XMB
         +q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326352; x=1724931152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXKBvCB3Mkkqlg0VZcfzGE8q8tdRK3d/QKk2HF5/hDM=;
        b=w+wYiCuvP9t9YwHJ3pMlgeB97OmzqB6VZ0/I4nHIgDbLIn2l03E8S9oIwrsO/jChy9
         xl0bsZYgUjXPMZyCHUMT13vBYG3mbdMCpvvU77W/b+YLs9+DhgAmpjC2plpEZtKy+WT/
         7ocpJih9tJQ+THr3sRCWR7aVzlMzj86YoY5XWGYnXRsN5odPapU5lFjw/0IsH2hS08wL
         JLNpY0jeT4gl2FQqKy+u0SQ2LxYyLO3RpWgoDp2m8GshXkhvRGg11wWDFDCd32BWxaSv
         MlGuTMb024GtNHuhZRQN9bCgoBIDViRM/Qt/2rXE4URl9VEEpAUGJbVcin+S1yuR/M/N
         memA==
X-Gm-Message-State: AOJu0YzONMsl8SqfmGbDFYmZNeg9Vky+Bxn08cp3X3+fSmngEe2XGIDC
	8TWQLrSseafcHUtW6uIroiRBDbTEjo+OmBaPSxufRCErcWpyGyG+QdM3
X-Google-Smtp-Source: AGHT+IHGfuWsO/FeqM4jyxIFhOdnCufG022t5hAToNmSZtkrq/03A3Eww/3tl1s7fq9JGUm7hlccaQ==
X-Received: by 2002:a05:6402:2711:b0:5b8:eb1d:7fec with SMTP id 4fb4d7f45d1cf-5bf2bfd784bmr2281745a12.6.1724326351711;
        Thu, 22 Aug 2024 04:32:31 -0700 (PDT)
Received: from gmail.com (83-64-154-210.static.upcbusiness.at. [83.64.154.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbee6sm852544a12.9.2024.08.22.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:32:31 -0700 (PDT)
From: Benedek Kupper <kupper.benedek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benedek Kupper <benedek.kupper@epitome.inc>
Subject: [PATCH BlueZ] gatt-client: allow AcquireNotify when characteristic has indicate flag
Date: Thu, 22 Aug 2024 13:32:26 +0200
Message-Id: <20240822113226.223790-1-kupper.benedek@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benedek Kupper <benedek.kupper@epitome.inc>

StartNotify / StopNotify already correctly allows usage when the
characteristic indicate is present (simplify this check though),
apply the same to AcquireNotify.
---
 src/gatt-client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 8d83a9577..a67e04eee 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1556,7 +1556,8 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 	if (!queue_isempty(chrc->notify_clients))
 		return btd_error_in_progress(msg);
 
-	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY))
+	if (!(chrc->props & (BT_GATT_CHRC_PROP_NOTIFY |
+			BT_GATT_CHRC_PROP_INDICATE)))
 		return btd_error_not_supported(msg);
 
 	client = notify_client_create(chrc, sender);
@@ -1601,8 +1602,8 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	if (chrc->notify_io)
 		return btd_error_not_permitted(msg, "Notify acquired");
 
-	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
-				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
+	if (!(chrc->props & (BT_GATT_CHRC_PROP_NOTIFY |
+				BT_GATT_CHRC_PROP_INDICATE)))
 		return btd_error_not_supported(msg);
 
 	/* Each client can only have one active notify session. */
-- 
2.34.1

