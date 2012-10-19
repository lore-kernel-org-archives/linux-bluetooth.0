Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 05/15] network: Add network .connect and .disconnect
Date: Fri, 19 Oct 2012 17:39:22 +0200
Message-Id: <1350661172-18125-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the btd_profile hooks to connect and disconnect all three network
roles.
---
 profiles/network/manager.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index eda0bbe..87d263a 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -47,6 +47,12 @@
 
 static gboolean conf_security = TRUE;
 
+struct connect_req {
+	struct btd_device	*device;
+	struct btd_profile	*profile;
+	btd_profile_cb		cb;
+};
+
 static void read_config(const char *file)
 {
 	GKeyFile *keyfile;
@@ -73,6 +79,57 @@ done:
 				conf_security ? "true" : "false");
 }
 
+static void connect_profile_cb(struct btd_device *device, int err,
+						const char *pdev, void *data)
+{
+	struct connect_req *req = data;
+
+	req->cb(req->profile, req->device, err);
+
+	g_free(req);
+}
+
+static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
+						uint16_t id, btd_profile_cb cb)
+{
+	struct connect_req *req;
+	int err;
+
+	DBG("path %s id %u", device_get_path(dev), id);
+
+	req  = g_new0(struct connect_req, 1);
+	req->device = dev;
+	req->profile = profile;
+	req->cb = cb;
+
+	err = connection_connect(dev, BNEP_SVC_PANU, NULL, connect_profile_cb,
+									req);
+	if (err < 0) {
+		g_free(req);
+		return err;
+	}
+
+	return 0;
+}
+
+static int disconnect_profile(struct btd_device *dev,
+						struct btd_profile *profile,
+						uint16_t id, btd_profile_cb cb)
+{
+	int err;
+
+	DBG("path %s id %u", device_get_path(dev), id);
+
+	err = connection_disconnect(dev, id, NULL);
+	if (err < 0)
+		return err;
+
+	if (cb)
+		cb(profile, dev, 0);
+
+	return 0;
+}
+
 static int panu_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
@@ -88,6 +145,18 @@ static void network_remove(struct btd_profile *p, struct btd_device *device)
 	connection_unregister(device);
 }
 
+static int panu_connect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return connect_profile(dev, profile, BNEP_SVC_PANU, cb);
+}
+
+static int panu_disconnect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return disconnect_profile(dev, profile, BNEP_SVC_PANU, cb);
+}
+
 static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const gchar *path = adapter_get_path(adapter);
@@ -115,6 +184,18 @@ static int gn_probe(struct btd_profile *p, struct btd_device *device,
 	return connection_register(device, BNEP_SVC_GN);
 }
 
+static int gn_connect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return connect_profile(dev, profile, BNEP_SVC_GN, cb);
+}
+
+static int gn_disconnect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return disconnect_profile(dev, profile, BNEP_SVC_GN, cb);
+}
+
 static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const gchar *path = adapter_get_path(adapter);
@@ -142,6 +223,18 @@ static int nap_probe(struct btd_profile *p, struct btd_device *device,
 	return connection_register(device, BNEP_SVC_NAP);
 }
 
+static int nap_connect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return connect_profile(dev, profile, BNEP_SVC_NAP, cb);
+}
+
+static int nap_disconnect(struct btd_device *dev, struct btd_profile *profile,
+							btd_profile_cb cb)
+{
+	return disconnect_profile(dev, profile, BNEP_SVC_NAP, cb);
+}
+
 static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const gchar *path = adapter_get_path(adapter);
@@ -166,6 +259,8 @@ static struct btd_profile panu_profile = {
 	.remote_uuids	= BTD_UUIDS(PANU_UUID),
 	.device_probe	= panu_probe,
 	.device_remove	= network_remove,
+	.connect	= panu_connect,
+	.disconnect	= panu_disconnect,
 	.adapter_probe	= panu_server_probe,
 	.adapter_remove	= panu_server_remove,
 };
@@ -175,6 +270,8 @@ static struct btd_profile gn_profile = {
 	.remote_uuids	= BTD_UUIDS(GN_UUID),
 	.device_probe	= gn_probe,
 	.device_remove	= network_remove,
+	.connect	= gn_connect,
+	.disconnect	= gn_disconnect,
 	.adapter_probe	= gn_server_probe,
 	.adapter_remove	= gn_server_remove,
 };
@@ -184,6 +281,8 @@ static struct btd_profile nap_profile = {
 	.remote_uuids	= BTD_UUIDS(NAP_UUID),
 	.device_probe	= nap_probe,
 	.device_remove	= network_remove,
+	.connect	= nap_connect,
+	.disconnect	= nap_disconnect,
 	.adapter_probe	= nap_server_probe,
 	.adapter_remove	= nap_server_remove,
 };
-- 
1.7.11.7

