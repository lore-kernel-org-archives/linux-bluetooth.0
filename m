Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEC155730
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493309; cv=none; b=CpShwFG2eW8Rf2nkWHhUJOG3LAliYikp0UDO1Ra75Wd2Pi4UKTnvcUlsOOpOLudcZ8N/aF5kjraBozmLM/xdNloVD2mLjurDsxRPoOslTv1lhUQRh7GDfeo0hm7aWrEpiMRMKhoB083BGYZ4qj9kR6Ee0oNfcBl/PqOEFHEZlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493309; c=relaxed/simple;
	bh=9TFkBkML4V8Vx8C7Ff0t4ywdRdVjnnXl/oXt2y1Qx6w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOKFCkV9YYEb6cNuL+2Mnj3nT+EdUhUkyzbQY2HU8e+ixLG0dCW9nPGqurE3jRwjggOwaoL7grTA9qQCLsu2b+qagGmesD0R3CTxLdXOJWh+oLbSASg/nrh5v4u5rBYaUcGYc7CXi7/T4N/Bj5TOCNEv7mEFHktTCsQnYeRoNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SVfy+CO4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SVfy+CO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493299;
	bh=9TFkBkML4V8Vx8C7Ff0t4ywdRdVjnnXl/oXt2y1Qx6w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SVfy+CO4kZm3mJw3IGOceGI089LTWfuKMiNxxacqVG9NGqV2sW6sWldK37gRwdNE/
	 ThYPzbh2TCggNAfg+6z2VE9vukovnjGbPBS2+DHVpo4rRMf9KNIp0fLIaYVug6eAw6
	 9Q4AzViYwiiJcg9EePaNAgdiKqsdlk8TYNVlAfjB0JjVEXCUCplBYMNFI9Z23CtawI
	 pGsxpEibFODRjmQ+gnvNL3Wv9zqIyHc6WQmDvRqr2qpEx+/72HcW/V4CswpyPGqtDw
	 3fLmB+HhExyy8GqOqgo19wUQ6VNAsbJUAalBS8ZLK84nmjqlIY/loZu00Y90dfOt+5
	 l9PS737ORCZiA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0726A17E1584
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/9] obexd: Add support for specific headers in obex transfer
Date: Mon, 16 Sep 2024 15:28:08 +0200
Message-Id: <20240916132813.165731-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
References: <20240916132813.165731-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The BIP is using the Image Handle Tag header to set the file handle
to transfer.
---
 obexd/client/transfer.c | 19 +++++++++++++++++++
 obexd/client/transfer.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index a7a85a0c0..879d67d58 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -57,6 +57,7 @@ struct obc_transfer {
 	GObex *obex;
 	uint8_t status;
 	GObexApparam *apparam;
+	GSList *headers;
 	guint8 op;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
@@ -400,6 +401,11 @@ static const GDBusPropertyTable obc_transfer_properties[] = {
 	{ }
 };
 
+static void header_free(void *data, void *user_data)
+{
+	g_obex_header_free(data);
+}
+
 static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
@@ -441,6 +447,8 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->obex)
 		g_obex_unref(transfer->obex);
 
+	g_slist_foreach(transfer->headers, header_free, NULL);
+	g_slist_free(transfer->headers);
 	g_free(transfer->callback);
 	g_free(transfer->owner);
 	g_free(transfer->filename);
@@ -820,6 +828,12 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
+	while (transfer->headers) {
+		hdr = transfer->headers->data;
+		g_obex_packet_add_header(req, hdr);
+		transfer->headers = g_slist_remove(transfer->headers, hdr);
+	}
+
 	if (transfer->apparam != NULL) {
 		hdr = g_obex_header_new_apparam(transfer->apparam);
 		g_obex_packet_add_header(req, hdr);
@@ -974,3 +988,8 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
+
+void obc_transfer_add_header(struct obc_transfer *transfer, void *data)
+{
+	transfer->headers = g_slist_append(transfer->headers, data);
+}
diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index 323332a62..1ed195984 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -47,3 +47,5 @@ gint64 obc_transfer_get_size(struct obc_transfer *transfer);
 
 DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
 							DBusMessage *message);
+
+void obc_transfer_add_header(struct obc_transfer *transfer, void *data);
-- 
2.34.1

