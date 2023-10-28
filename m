Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED54C0032E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Oct 2023 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjJ1Ojj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Oct 2023 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1Ojj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Oct 2023 10:39:39 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F89CC
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 07:39:36 -0700 (PDT)
Received: from monolith.lan (unknown [185.77.218.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SHhxz0mp1z49Q5M;
        Sat, 28 Oct 2023 17:39:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1698503975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gyxvYQlCsyGRbzKojenkvssi/QhYUN27zqvGG7nZXU=;
        b=o4P2RMFml3l4JPdws69E9L3wULEoQeqflMkhqbpgeSgLtbWK2TCWfY1Ewj1V49tWLLOYdH
        1kJQoqZjbZuRhsUUcDsxcSOFRZmUHJUCjjRbv1p6FSeCtrqOOPJgXDlAN+pSDPguDqsbVr
        xw5hLLabfVwkqv7T9sEL6aQCVajeVPVd/48d7IJ5JtDx3hQytTlcDYBWIQY5yT+HAEmNQE
        +cz9XwZeqgXHE+QJ8UKlJRclAH5I0DO+4E2ISBEwFiiPZwDHYFMButXh9hlic7E/TddLea
        r9dLwK8cmQIyvotqmXl8R0jfyybXkj5lc4jGX9uTBrXHZ53pS5Eon4kRFw57kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1698503975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gyxvYQlCsyGRbzKojenkvssi/QhYUN27zqvGG7nZXU=;
        b=N8JYgrfP40e/NSImDJes04ZzCmmlljtDyqOqpRFLT/z03YxCozdUWZdaKpijT94vU7IiqL
        stBx7QbJf3PCpQnPJ9szGRiZZ8x5wKyOZRcxT2J6Wf1YyRuJRblEJLwIA0VwWaAlUJfTzf
        4SbUh1giFErhVx7EgFXZz8p5uwXeVzEryD5S1JGQtBcoHU7Nzx8JOKDMBpzbplG+QRfsOV
        xu4S9qyzts0iYzQX87ptBLsuXV4dvDRs/uszqdvKDjpRuzNUCoTGfhIR2ORVfjO7fu/TSy
        7SEMgddF7x4PpWoMAbuVuzKfzfbmyrGp+0nzBEdYsHTV+Z7i7y/TAqlqST2RsQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1698503975; a=rsa-sha256;
        cv=none;
        b=lWVkK2noey8TWLgQHoKIxHM7w0By7p2+vlt6ZUZU5ugQw5IlXus/42PLh0+KbXCI4hfpuD
        +5flEBAfsOZJMPvjQSwMHSMlX05tDpiaqS3YPLK4crd/htnISDWFkO3bv727c2q/M4J/+3
        fT64g+JVxvuLjNC8S1H2xqJkXgDlUa38zEk3H7+/FDAB7r7m+o6/Z1QRbr55NIhqmgk1vL
        6qczt3crMRY81IKJc51D/j+Ar1e1HlVozxP3jQghsMuI54I4OSBtSLf/jC/5d00Q0/ZlR5
        kML7aFCRfMCRprmHpf2erFh0duavhdRPCyFZYCWEBtnAtnR4Y6JRfwBkh0ufCw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] client: implement SelectQoS
Date:   Sat, 28 Oct 2023 17:39:29 +0300
Message-ID: <c00fc1a3659ec7e7f77a6c2029e25dac3e6ee754.1698503903.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
References: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implement SelectQoS() so that the server-provided values get printed.
We don't take them into account yet otherwise, though.
---
 client/player.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/client/player.c b/client/player.c
index 715598aa9..4ad6b99d9 100644
--- a/client/player.c
+++ b/client/player.c
@@ -91,6 +91,7 @@ struct endpoint {
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
+	struct codec_preset *codec_preset;
 	bool broadcast;
 	struct iovec *bcode;
 };
@@ -2078,6 +2079,8 @@ static void select_properties_response(const char *input, void *user_data)
 	p = preset_find_name(ep->preset, input);
 	if (p) {
 		reply = endpoint_select_properties_reply(ep, ep->msg, p);
+		if (reply)
+			ep->codec_preset = p;
 		goto done;
 	}
 
@@ -2130,6 +2133,49 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *endpoint_select_qos(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct codec_preset *preset = ep->codec_preset;
+	DBusMessageIter args;
+	DBusMessageIter iter, dict;
+	DBusMessage *reply;
+	struct endpoint_config cfg;
+
+	dbus_message_iter_init(msg, &args);
+
+	bt_shell_printf("Endpoint: SelectQoS\n");
+	print_iter("\t", "Properties", &args);
+
+	if (!preset)
+		return g_dbus_create_error(msg, "org.bluez.Error.Rejected",
+						"No previous codec preset");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	/* TODO: we ignore BAP Server supported values here. If they are not
+	 * suitable for the preset, we should prompt for a preset again, and
+	 * call SetConfiguration on the remote endpoint with the new
+	 * configuration to retry.
+	 */
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.ep = ep;
+	cfg.qos = &preset->qos;
+	append_qos(&dict, &cfg);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static bool match_str(const void *data, const void *user_data)
 {
 	return !strcmp(data, user_data);
@@ -2248,6 +2294,10 @@ static const GDBusMethodTable endpoint_methods[] = {
 					GDBUS_ARGS({ "properties", "a{sv}" } ),
 					GDBUS_ARGS({ "properties", "a{sv}" } ),
 					endpoint_select_properties) },
+	{ GDBUS_ASYNC_METHOD("SelectQoS",
+					GDBUS_ARGS({ "properties", "a{sv}" } ),
+					GDBUS_ARGS({ "properties", "a{sv}" } ),
+					endpoint_select_qos) },
 	{ GDBUS_ASYNC_METHOD("ClearConfiguration",
 					GDBUS_ARGS({ "transport", "o" } ),
 					NULL, endpoint_clear_configuration) },
-- 
2.41.0

