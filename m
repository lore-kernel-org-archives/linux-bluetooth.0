Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605720896C
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234516; cv=none; b=Bl7qw2cPtvH/dqwRhYPhIHH6mmKpC9vXTvMF1OmReLxtW0a8IocQe/hSJKcLUomHNVwtPohZ8f2ZSVOOEkMH31rJbL++pu5mSiarOVJys2iXj0ZraUps408vTOZysh7tGKjS2E/+ddevAcMx57I6GKQCFBHJcEvtuFEIim3Q4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234516; c=relaxed/simple;
	bh=xXzNuq4+ATp3xjm0ikSdiHL9HblNN/TUI6m6+lpugR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMfqTNy/JCF9GoGw8mTGtU6MZaUa2gDypLUxkPHCbWmt6408AQp5Tcb/vgoZyfDg+sVt+XUGwpCTU5G6EQ6vyWGsUoKriWDSYOzrCX8YQ8KkDlkzwOs8bA4XhwE7YhdMWb2Dcrxsyx0K/7NYQvV1WiRNc8iLxAv21GVsXu0hMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLQzjjkK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLQzjjkK"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb587d0436so61101971fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730234512; x=1730839312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snZ94FSUlvSkoQ+H9qkP/AbQ/wfGoboZpB9Rnau7uAA=;
        b=cLQzjjkK1pYRM0nF1Pq6g7q2RjRvCI5lOCEPPxw8+nL2Z+myEdw0x4jLRdOzC+VaZd
         UyX8IdjTZmCm7/DxNrp2FJD3VD4y5ah1uLMCOlSwPyTrajNHlWNPBgpmrQ/BditRvInA
         J4AQCLHVCk6CT5zz8OWJAuTHU0NvI6W9uboonWXs6qDWUH3RFbJv3IEJlh6xnldgTy7y
         WtPV/19YCXZ/c5d/lzjzIHMeePOqhrCicIuA40loH4irdcqpjU0RYx4USoNkoufzJTSd
         //LmTP0Dkk1XXGWg1+56xz8EZQM73X75eCpQdv0c85kb75vY1jtfy+9V9EwB/uzeIkzf
         5Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234512; x=1730839312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snZ94FSUlvSkoQ+H9qkP/AbQ/wfGoboZpB9Rnau7uAA=;
        b=DrYFzyCOZE8tRCAuPuxU/o9lVtX1rTJZp+IS3uvG6BmwEmyaANzzYKA8G137FwaCD2
         arX8+Uj+HY9u5v328xtow5kYW8sngyGuH5BEv4hN9KyoRM6TK05xI9luLMQEgvCQ3SbF
         EHMDt9QAaCq4xJgUxa42woLjhibz48HPMIdoR0RmcAH02vbBhCb4xY9TtnDAvE17OeaL
         2mcKMjYGptgG6iY+W66puMxNQ1z4C1lWpvcbro4vp+yrCkOzFC3EDMVWFfk9SrqUcOa3
         tqTQv2DUFi4CHiqR5pWm9hOhg12cN2PnDbzgdRK6DUA/ZkYIrqRidLbF++2SalDdfmRB
         1Lxg==
X-Gm-Message-State: AOJu0Yy/l3a612nSLQwymKZD83RvYNfl1HOR2SPwesRE9VC9e6beZihG
	VeoZanWO7iBU6wCUkhZjXyh8nMzRt/kO1CwbGv7M42ZQeHdgUVMr13DtSw==
X-Google-Smtp-Source: AGHT+IE+Ro6Sciba5GQCIK8vnE3tH8XQU37Cq6lO8h3FNwBJKSH8Z6oSq3MbeqRlTJKAHgYRqYdtrg==
X-Received: by 2002:a2e:a9a0:0:b0:2fa:c9ad:3d3c with SMTP id 38308e7fff4ca-2fcbdf621e4mr65932101fa.6.1730234511194;
        Tue, 29 Oct 2024 13:41:51 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fd53603415sm435251fa.85.2024.10.29.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:41:49 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v3 1/3] gdbus: Add g_dbus_pending_property_get_sender
Date: Tue, 29 Oct 2024 21:41:30 +0100
Message-Id: <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABBYNZJyrKnWGcFb9k2YbucPub0hkhG-OH=RWEhdKPJKLVLfpA@mail.gmail.com>
References: <CABBYNZJyrKnWGcFb9k2YbucPub0hkhG-OH=RWEhdKPJKLVLfpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows to retrieve D-Bus message sender name in a property
setter callback. Message sender name might be required to limit write
access to authorized clients only.
---
 gdbus/gdbus.h  |  1 +
 gdbus/object.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d7be17661..c1b182adb 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -308,6 +308,7 @@ guint g_dbus_add_properties_watch(DBusConnection *connection,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id);
 void g_dbus_pending_property_success(GDBusPendingPropertySet id);
 void g_dbus_pending_property_error_valist(GDBusPendingReply id,
 			const char *name, const char *format, va_list args);
diff --git a/gdbus/object.c b/gdbus/object.c
index 72d2d46e3..e40c7c5bc 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -430,28 +430,45 @@ static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 static GDBusPendingPropertySet next_pending_property = 1;
 static GSList *pending_property_set;
 
+static int pending_property_data_compare_id(const void *data,
+						const void *user_data)
+{
+	const struct property_data *propdata = data;
+	const GDBusPendingPropertySet *id = user_data;
+	return propdata->id - *id;
+}
+
 static struct property_data *remove_pending_property_data(
 						GDBusPendingPropertySet id)
 {
 	struct property_data *propdata;
 	GSList *l;
 
-	for (l = pending_property_set; l != NULL; l = l->next) {
-		propdata = l->data;
-		if (propdata->id != id)
-			continue;
-
-		break;
-	}
-
+	l = g_slist_find_custom(pending_property_set, &id,
+				pending_property_data_compare_id);
 	if (l == NULL)
 		return NULL;
 
+	propdata = l->data;
 	pending_property_set = g_slist_delete_link(pending_property_set, l);
 
 	return propdata;
 }
 
+const char *g_dbus_pending_property_get_sender(GDBusPendingPropertySet id)
+{
+	struct property_data *propdata;
+	GSList *l;
+
+	l = g_slist_find_custom(pending_property_set, &id,
+					pending_property_data_compare_id);
+	if (l == NULL)
+		return NULL;
+
+	propdata = l->data;
+	return dbus_message_get_sender(propdata->message);
+}
+
 void g_dbus_pending_property_success(GDBusPendingPropertySet id)
 {
 	struct property_data *propdata;
-- 
2.39.5

