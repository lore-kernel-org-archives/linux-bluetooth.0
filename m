Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEF13D891
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776867; cv=pass; b=Nu2smX0e3MrmenQYyBTsXZXTQQGSxZugbOB85Q7w8hOO0KtaFG34KHoiA10Qso18oMFSGa6xtsaxr7Ktrsui2ZMRvkeloLL+dR1m/WArGszyMAAio+lrbvZaqHzYrmeQV1bL34QlGLycJPPLTEoUUAoBcUWcBP0QeVa+PbzsbEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776867; c=relaxed/simple;
	bh=bkhXAG8SpShFjPVgSW8XlTMehm+cdVh+xvjpqtY/Zq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koNvV7jI/SjI7fE3SeYjAGjsIMOA6SS6MmjxgmEvmi/wpYFT1zYTJ4WS6gPgUxcFGRnHp76hO1vlqc0DkbSQY9cEQom2CaSetOphJvDCq2mu79XmePcHFlimIy5e5sajRDUp0YlA1Up+xqVVksuBT3hS3PscXvKeA330Fi8w2bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=osjNFGk7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="osjNFGk7"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmqjb3BlGzyRY;
	Sat, 19 Sep 2026 03:14:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789776852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+G3Vz3GwyL2aRLRoESrkc1KnuV5o0tjWHtzdtf/Mr20=;
	b=osjNFGk7pBNaBzwyl5ThjK7Sji7K5WW4zV8bs40riYUlYhJer0IZBjrhVmNG+HcvXclpTq
	BPWT6FB7WhiqXkR3IJiudfwlaq/O1qAzuk1ox+V68MnFJX8Dd+3IpCrGg1hKr8ZFXL4aql
	AL1kwSHMqASOH6P/w3U1r0wrjpqAwuU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789776852;
	b=k5wObsBzmBehsNmQwNU3mEcJLr6dnjGKo3FCqs017sStHiYgg9eRceAVIi2/UaE108IugI
	sV64Jup4pp/hZE2dvvki9SSAR3ie2dOrIINJWsHN2VChPZ0ofxgyXOnEidUtOV/QO2XYHf
	sWI0JucED3q6FRqIaaSsaZNnAv3rx2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789776852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+G3Vz3GwyL2aRLRoESrkc1KnuV5o0tjWHtzdtf/Mr20=;
	b=ikcGnLP1zpOLV2qyU/W6KmXmUQLJ3vGkvDJtNQkzlub18WzK4dmB7Thv5UAEDdQ7EyjjGl
	ULsCpxy5utpPeHOsXVz+bgsyQd2/O68g912e4CoKnKZ1/Z3CyncSAAUn3xvMvTq3iSpbx0
	gAORMHXFkSkNWIV/4JpHM/spwJz3aAw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: Fix use-after-free of device referenced by session
Date: Sat, 19 Sep 2026 03:14:05 +0300
Message-ID: <5610cdd036fde69fe30b0df2023875dae8d709ae.1789776622.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_attached() creates bap_data that are not bound to btd_service, and
can outlive the device (eg if ATT POLLHUP -> bap_detached is late).
This then crashes when accessing bap_data::device later.

Fix by having bap_data hold btd_device_ref(). This is similar to what
avdtp.c etc. do.

Remove no-op assign to ep->data->device in ep_register_bcast() +
bap_bcast_probe() -- these just assign the same device pointer.

Log:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7d6513de0208
READ of size 8 at 0x7d6513de0208 thread T0
    #0 0x5594209b7e9b in device_get_adapter src/device.c:6917
    #1 0x55942086020e in find_cig_session profiles/audio/bap.c:2500
    #2 0x559420a3f070 in queue_find src/shared/queue.c:230
    #3 0x559420866cd3 in find_cig_enumerate profiles/audio/bap.c:2539
    #4 0x559420866cd3 in bap_update_cigs_cb profiles/audio/bap.c:2688
    #5 0x7ff515a46b9a
    #6 0x7ff515a481d6
    #7 0x7ff515a48576 in g_main_loop_run
    #8 0x559420b9af48 in mainloop_run src/shared/mainloop-glib.c:65
    #9 0x559420b9b87a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #10 0x5594207192ba in main src/main.c:1713

0x7d6513de0208 is located 392 bytes inside of 752-byte region [0x7d6513de0080,0x7d6513de0370)
freed by thread T0 here:
    #0 0x7ff515d2d3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x559420a29a39 in remove_interface gdbus/object.c:742

previously allocated by thread T0 here:
    #0 0x7ff515d2e40f in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:74
    #1 0x5594209cd302 in device_new src/device.c:5008

Assisted-by: opencode:qwen3.8-flash-next
---

Notes:
    This is another test-functional crash seen in CI.  Triaged with LLM,
    reviewed by myself.

 profiles/audio/bap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5771c9ae0..928796e1e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -207,6 +207,9 @@ static void bap_data_free(struct bap_data *data)
 	if (data->cig_update_id)
 		g_source_remove(data->cig_update_id);
 
+	if (data->device)
+		btd_device_unref(data->device);
+
 	free(data);
 }
 
@@ -1785,9 +1788,6 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	ep->lpac = lpac;
 	ep->rpac = rpac;
 
-	if (device)
-		ep->data->device = device;
-
 	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
@@ -3463,7 +3463,8 @@ static struct bap_data *bap_data_new(struct btd_device *device)
 	struct bap_data *data;
 
 	data = new0(struct bap_data, 1);
-	data->device = device;
+	/* Hold reference: sessions may outlive device removal */
+	data->device = device ? btd_device_ref(device) : NULL;
 	data->srcs = queue_new();
 	data->snks = queue_new();
 	data->bcast = queue_new();
@@ -3888,7 +3889,6 @@ static int bap_bcast_probe(struct btd_service *service)
 	data = bap_data_new(device);
 	data->service = service;
 	data->adapter = adapter;
-	data->device = device;
 	data->bap = bap;
 	data->bcast_snks = queue_new();
 
@@ -3985,6 +3985,7 @@ static int bap_probe(struct btd_service *service)
 					btd_device_get_gatt_db(device));
 	if (!data->bap) {
 		error("Unable to create BAP instance");
+		btd_device_unref(data->device);
 		free(data);
 		return -EINVAL;
 	}
-- 
2.55.0

