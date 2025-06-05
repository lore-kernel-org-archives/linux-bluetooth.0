Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7843B19A
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147351; cv=none; b=lpy68KqLfMpX0eXqNBmND+ba/+GY3Fhn71JyhU9j+xOcUeLMINBsCFxbd64v3AFfbZcEjJVmP9/128F03G9ZzqTJcuonSkzgX+B9OHFw1PvIDEensZ6oE2i0NTXjBHo64Y3NOJ0TKWFXuuOrAKs39Aekv2TJlwxDyhtpKJ/wgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147351; c=relaxed/simple;
	bh=kjhTJwglcjkEhioVcxh595UrrFL7Gd+5BAWCjT8LMBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmh6D80DwrZvNKUmjK4dbd0EZ5hk8zaKArA8M753Pjna/vT5zexeOp2xUmFpcyIhlHDqGE0hCjCStgEj+Tao9NP+dbwyghuhO5+30D8fEZ+o0D/Xf6HrYHtgsmkbyGiFRFsvDulAt8lH3xNsyY+HY/NhPx/43qgboLmzYXl/rA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfU0FuF0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfU0FuF0"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e770bb7b45so71406137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147347; x=1749752147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy68w1SPsN+lEw/aGfDr3yCSXHRlnfwtQXbb17shfZU=;
        b=JfU0FuF0z6qlzwA/PbzFt1XxqpkDHdpdgakOj/LtAsbnLCxuAeF2QRuPcQRTGx9Lbk
         Hu5KKWe+5/XNqZ+bYf+SMGw/TbLqD8nIoIPjqQ5XGm86Cw9ftMh1mqa3vEtcwp7nHD+A
         tKm4llgJHleWzwWGNoD/h2W+x1PKy24MVxmz8xmTdMk7qaGFWnyOQUdgKHAXsMegzJYx
         ls7RyIJ8C7UkReSvR6as0bR9ycPjRuSZc0klb8VdSMNnYfEA7CmEwCKMQlBJNwLHGpdN
         ZPvlOWCkrijMVPcSDsC1fA8piC/+yrQFN63BEZnfprTFrHUXHYlTyuvuX8utDG8DzRm7
         4G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147347; x=1749752147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy68w1SPsN+lEw/aGfDr3yCSXHRlnfwtQXbb17shfZU=;
        b=IWK9nJ7vFQ9Fa71WgdVcN7b62FiBcIqwmA76Xwg1M+pLBBTRQ+9C1YnfyEgvbEYQKu
         8eHHa/BBwF77bm+Qpaptpu8rDjPvtgYGgmHVm2j9ljIDWckWSlCRFRk+W4QDuBBouknP
         QkIJFoAZt1wf5Ml/9+yYuDwbDD310aFs4gTqL5AQpAdZKPJGi1IgphMbbLia8Da8WUue
         4AVFIYD5M+GfwCt+v20No9Mt1VSdJe8PkLeiJMLaYBY9eH5y5pHX6UPaghxrIiVj04gW
         PGhIia9GB9gglHpGZ2gy2gxUKRWtmK/ARI3lRKxDviQR3wa/DC0mFex7XB3Jy7vvBFf6
         fNgQ==
X-Gm-Message-State: AOJu0YzzR+CiAwi+FeOH6ZutThbrYoLCyrVNQ6FllZmELeNHxh8cqNUd
	rCgmCa37L2EMzoQ8ofv5yXAjlhlo93sFP/mEZvG9U69ryGA/f5LGOgMCIOlZB6mqDew=
X-Gm-Gg: ASbGncuTi9jEoE2PdKqVi4qfejdZBBYDEt8tk6qrYdMwgcUyGhUVM+8/YNLek9gM7SI
	f+G8iqR2Y0MQVjTkCf4jgQUGNNr2LpxMj2FT1dd4hLv10sP53k1lHYBdB+VTp93Mrb//Y16ftHm
	GMpClBWJoWtR7f+D6zWLV46hmPCHFu7LkTg2fhogWvJinKGHNa1XXy6ZrKA01tFctN27o22UkqU
	8XCXQ/QALlCHKPiRur8yN3608zhykaQ0wc/1Fvz7zk4JWTjqYRvsSdm8L5Tljnuyd9u4pThuOql
	GbNkot5XPJKNuXrI5NbNSeh5CLuNQfHKXeXFaYJZR1C3f3ro2Cp93BmOjxJToTK/k99hP960Dgn
	kEM0v5s5EaKa0yrne2j6o+vYgiOKZkyM=
X-Google-Smtp-Source: AGHT+IEG8Y1Ce8yg6hJ1r92nzBFxrCn5sJs2JKyBAkIuenaMbgSQRzkMljtxt65hka5T/Y/ZW9TNmg==
X-Received: by 2002:a05:6102:3e8a:b0:4e5:9c06:39d6 with SMTP id ada2fe7eead31-4e7728ce265mr510925137.2.1749147347076;
        Thu, 05 Jun 2025 11:15:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f7ff2sm11932499137.27.2025.06.05.11.15.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:15:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client: Use -EINPROGRESS with scan and advertise command
Date: Thu,  5 Jun 2025 14:15:42 -0400
Message-ID: <20250605181542.854629-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605181542.854629-1-luiz.dentz@gmail.com>
References: <20250605181542.854629-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses -EINPROGRESS with commands scan and advertise since they need
to keep running in the background so they don't exit but shouldn't block
other command from executing in case they are invoked from a script.
---
 client/advertising.c | 4 +---
 client/main.c        | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 382ae420e663..6e1c70309fb5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -238,7 +238,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 		ad.registered = true;
 		bt_shell_printf("Advertising object registered\n");
 		print_ad();
-		/* Leave advertise running even on noninteractive mode */
+		return bt_shell_noninteractive_quit(-EINPROGRESS);
 	} else {
 		bt_shell_printf("Failed to register advertisement: %s\n", error.name);
 		dbus_error_free(&error);
@@ -874,8 +874,6 @@ static void ad_clear_service(int type)
 {
 	g_free(ad.service[type].uuid);
 	memset(&ad.service[type], 0, sizeof(ad.service[type]));
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static bool ad_add_data(struct ad_data *data, int argc, char *argv[])
diff --git a/client/main.c b/client/main.c
index c2321952bd4f..d99a5158e35a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1219,7 +1219,8 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Discovery %s\n", enable ? "started" : "stopped");
 
 	filter.active = enable;
-	/* Leave the discovery running even on noninteractive mode */
+
+	return bt_shell_noninteractive_quit(-EINPROGRESS);
 }
 
 static void clear_discovery_filter(DBusMessageIter *iter, void *user_data)
-- 
2.49.0

