Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00D1474DA
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945120; cv=none; b=DazoYSSaMCqHJnogzrjOJO0bTdL2gv5cm5wGJxDF2uM75FA2/b5ZVhPTqZuLY2542XOPoeEftPVfO/2zKkhaBhnlkr85Y4mKvtrLaARb62yNHHQ0Jdm72b0JzDQjgFuqeFcFvs8lrkzJY7zeP6eRVFp2J07cSf48JUKwj0iSSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945120; c=relaxed/simple;
	bh=EA74sKV08GSdRS8ki6OwbhADnWFX2R+yW94Y51Xk1cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDquyM8mGr8TGgiUwn9Fz2hJ1gzdYxdw7h52/0yRzLAWDI1boNY4wBZp8v+S5PKBA/uIHJzhW479KKtj8Q+7oUXtTmF6KeRudbUopPkeumKKe9B8YMafLCVEadePxZFCFYZ3Uv6mmRcBuz3bAZ0beioUp9TDCZGYnD9MzZr1DiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=DiaQfGhX; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="DiaQfGhX"
Received: from Beast.lan (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id D8468103F010E1;
	Tue, 03 Jun 2025 12:56:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1748944581; bh=EA74sKV08GSdRS8ki6OwbhADnWFX2R+yW94Y51Xk1cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiaQfGhXld53BzH8PMK95iFcjlSYDxyxoIoiZmGAeslFqvAuBHVBdjLG+46NHjQ8U
	 kOFJyOTfVqiqY2VGwUVAJmuoL9wTvCPt+nbsibexWwhl0ALEdaAoFgzscXbcLeftpY
	 r2nLeYjsQfewFGpEvJCcVhtRT/06KUYkERXcg5vI=
From: Egor Vorontsov <sdoregor@sdore.me>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for DualSense
Date: Tue,  3 Jun 2025 12:56:17 +0300
Message-ID: <20250603095617.92785-3-sdoregor@sdore.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603095617.92785-1-sdoregor@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code is very similar to that for DS4, but I found it's better
to separate the matters instead of generalizing it via constants.

Also added a request to enable Bluetooth on the controller to initiate
pairing without the need to disconnect it and power on again wirelessly,
basically emulating what PS itself does. Only for DualSense family now,
but can be expanded to DS4 too (I don't have one at hand to test this).
---
 plugins/sixaxis.c | 107 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1fab8ae59..a583c8b82 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -131,12 +131,36 @@ static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int dualsense_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[20];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x09;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("sixaxis: failed to read DualSense device address (%s)",
+		      strerror(errno));
+		return ret;
+	}
+
+	/* address is little-endian on DualSense */
+	bacpy(bdaddr, (bdaddr_t*) (buf + 1));
+
+	return 0;
+}
+
 static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
 		return sixaxis_get_device_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_get_device_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_DUALSENSE)
+		return dualsense_get_device_bdaddr(fd, bdaddr);
 	return -1;
 }
 
@@ -183,12 +207,36 @@ static int ds4_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int dualsense_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
+{
+	uint8_t buf[20];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = 0x09;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	if (ret < 0) {
+		error("sixaxis: failed to read DualSense central address (%s)",
+		      strerror(errno));
+		return ret;
+	}
+
+	/* address is little-endian on DualSense */
+	bacpy(bdaddr, (bdaddr_t*) (buf + 10));
+
+	return 0;
+}
+
 static int get_central_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
 		return sixaxis_get_central_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_get_central_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_DUALSENSE)
+		return dualsense_get_central_bdaddr(fd, bdaddr);
 	return -1;
 }
 
@@ -230,6 +278,26 @@ static int ds4_set_central_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
+static int dualsense_set_central_bdaddr(int fd, const bdaddr_t *bdaddr)
+{
+	uint8_t buf[27];
+	int ret;
+
+	buf[0] = 0x0A;
+	bacpy((bdaddr_t*) (buf + 1), bdaddr);
+	/* TODO: we could put the key here but
+	   there is no way to force a re-loading
+	   of link keys to the kernel from here. */
+	memset(buf + 7, 0, 16);
+
+	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
+	if (ret < 0)
+		error("sixaxis: failed to write DualSense central address (%s)",
+		      strerror(errno));
+
+	return ret;
+}
+
 static int set_central_bdaddr(int fd, const bdaddr_t *bdaddr,
 					CablePairingType type)
 {
@@ -237,6 +305,32 @@ static int set_central_bdaddr(int fd, const bdaddr_t *bdaddr,
 		return sixaxis_set_central_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
 		return ds4_set_central_bdaddr(fd, bdaddr);
+	else if (type == CABLE_PAIRING_DUALSENSE)
+		return dualsense_set_central_bdaddr(fd, bdaddr);
+	return -1;
+}
+
+static int dualsense_set_bluetooth_state(int fd, bool state)
+{
+	uint8_t buf[48];
+	int ret;
+
+	buf[0] = 0x08;
+	buf[1] = state?1:2;
+
+	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
+	if (ret < 0)
+		error("sixaxis: failed to set DualSense Bluetooth state (%s)",
+		      strerror(errno));
+
+	return ret;
+}
+
+static int set_bluetooth_state(int fd, CablePairingType type,
+					bool state)
+{
+	if (type == CABLE_PAIRING_DUALSENSE)
+		return dualsense_set_bluetooth_state(fd, state);
 	return -1;
 }
 
@@ -297,12 +391,13 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	remove_device = false;
 	btd_device_set_temporary(closure->device, false);
 
-	if (closure->type == CABLE_PAIRING_SIXAXIS) {
+	if (closure->type == CABLE_PAIRING_SIXAXIS)
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
 
+	if (closure->type == CABLE_PAIRING_SIXAXIS ||
+				closure->type == CABLE_PAIRING_DUALSENSE) {
 		device_set_cable_pairing(closure->device, true);
-
 		server_set_cable_pairing(adapter_bdaddr, true);
 	}
 
@@ -312,6 +407,11 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	DBG("remote %s old_central %s new_central %s",
 				device_addr, central_addr, adapter_addr);
 
+	if (closure->type == CABLE_PAIRING_DUALSENSE) {
+		DBG("Enabling Bluetooth connection on the device");
+		set_bluetooth_state(closure->fd, closure->type, true);
+	}
+
 out:
 	g_hash_table_steal(pending_auths, closure->sysfs_path);
 
@@ -432,7 +532,8 @@ static void device_added(struct udev_device *udevice)
 
 	cp = get_pairing_type_for_device(udevice, &bus, &sysfs_path);
 	if (!cp || (cp->type != CABLE_PAIRING_SIXAXIS &&
-				cp->type != CABLE_PAIRING_DS4)) {
+				cp->type != CABLE_PAIRING_DS4 &&
+				cp->type != CABLE_PAIRING_DUALSENSE)) {
 		g_free(sysfs_path);
 		return;
 	}
-- 
2.49.0

