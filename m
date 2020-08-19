Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4ACC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE59B20882
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="kHWR7b2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHSPJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:09:59 -0400
Received: from ns.omicron.at ([212.183.10.25]:36800 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgHSPJ4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 11:09:56 -0400
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07JF9rja006636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:53 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07JF9rja006636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597849793;
        bh=Kmfb1ak+O3JR1DK8ZEFZVPytQ63/ubyHrserK1hM8qw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kHWR7b2TIebTLFjSjFTxEiFu6XfX+mkoTq5Qo11zE5o9XG1UxofeW5q5zeiN7hHn3
         qa2/PFusFJuJhr+wQaVyVfXBKdJj86iqC36iTtNyXC9KoPW00j6mVN6lOr/j1cIG9d
         I/t5jQCft2hufQFjJ6yUjwAmPmsg7VcvlW4zUJso=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 29114A0062
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:52 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 26DE2A0053
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:52 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07JF9qjn027219-07JF9qjq027219
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 17:09:53 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 17:09:47 +0200
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Mark Marshall <mark.marshall@omicronenergy.com>
Subject: [PATCH BlueZ 2/2] src/profile.c: Add a GetProfileInfo method
Date:   Wed, 19 Aug 2020 17:09:31 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819150931.3005-1-mark.marshall@omicronenergy.com>
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
Message-ID: <2303f692-bb7c-4851-86fa-befde45b4b32@EXC04-ATKLA.omicron.at>
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a GetProfileInfo method to org.bluez.ProfileManager1
---
 doc/profile-api.txt | 13 +++++++
 src/profile.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/doc/profile-api.txt b/doc/profile-api.txt
index 8c7d0a06d..d13703ab4 100644
--- a/doc/profile-api.txt
+++ b/doc/profile-api.txt
@@ -133,6 +133,19 @@ Object path	/org/bluez
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+		options GetProfileInfo(object profile, object adapter)
+
+			This returns a dictionary of options for the
+			profile.  Values returned are: UUID, Name,
+			Path, Service, Mode and AddressType.  The
+			adapter parameter is optional - if it is
+			non-empty, then two additional values might be
+			returned, if the profile is active on the
+			specified adapter: PSM and Channel.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+			                 org.bluez.Error.DoesNotExist
+
 
 Profile hierarchy
 =================
diff --git a/src/profile.c b/src/profile.c
index 10850f305..e287a66d7 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2509,6 +2509,96 @@ static DBusMessage *unregister_profile(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *get_profile_info(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, dict;
+	const char *path, *adapter, *sender;
+	struct ext_profile *ext;
+	uint16_t u16;
+	GSList *l, *next;
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("sender %s", sender);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				   DBUS_TYPE_OBJECT_PATH, &adapter,
+				   DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	if (adapter && !*adapter)
+		adapter = NULL;
+
+	ext = find_ext_profile(sender, path);
+	if (!ext)
+		return btd_error_does_not_exist(msg);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					 "{sv}", &dict);
+
+	g_dbus_dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING,
+				 &ext->uuid);
+	if (ext->name) {
+		g_dbus_dict_append_entry(&dict, "Name", DBUS_TYPE_STRING,
+					 &ext->name);
+	}
+	if (ext->path) {
+		g_dbus_dict_append_entry(&dict, "Path", DBUS_TYPE_STRING,
+					 &ext->path);
+	}
+	if (ext->service) {
+		g_dbus_dict_append_entry(&dict, "Service", DBUS_TYPE_STRING,
+					 &ext->service);
+	}
+
+	u16 = ext->mode;
+	g_dbus_dict_append_entry(&dict, "Mode", DBUS_TYPE_UINT16,
+				 &u16);
+
+	u16 = ext->addr_type;
+	g_dbus_dict_append_entry(&dict, "AddressType", DBUS_TYPE_UINT16,
+				 &u16);
+
+	if (adapter) {
+		for (l = ext->servers; l != NULL; l = next) {
+			struct ext_io *server = l->data;
+			const char *ctype;
+
+			DBG("server:%p  %d %d psm:%d chan:%d",
+			    server, server->resolving, server->connected,
+			    server->psm, server->chan);
+
+			next = g_slist_next(l);
+
+			if (strcmp(adapter, adapter_get_path(server->adapter)))
+				continue;
+
+			if (server->proto == BTPROTO_L2CAP) {
+				ctype = "PSM";
+				u16 = server->psm;
+			} else if (server->proto == BTPROTO_RFCOMM) {
+				ctype = "Channel";
+				u16 = server->chan;
+			} else {
+				continue;
+			}
+			g_dbus_dict_append_entry(
+				&dict, ctype, DBUS_TYPE_UINT16, &u16);
+		}
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static const GDBusMethodTable methods[] = {
 	{ GDBUS_METHOD("RegisterProfile",
 			GDBUS_ARGS({ "profile", "o"}, { "UUID", "s" },
@@ -2516,6 +2606,9 @@ static const GDBusMethodTable methods[] = {
 			NULL, register_profile) },
 	{ GDBUS_METHOD("UnregisterProfile", GDBUS_ARGS({ "profile", "o" }),
 			NULL, unregister_profile) },
+	{ GDBUS_METHOD("GetProfileInfo",
+			GDBUS_ARGS({ "profile", "o" }, { "adapter", "o" }),
+			GDBUS_ARGS({ "options", "a{sv}" }), get_profile_info) },
 	{ }
 };
 
-- 
2.17.1

