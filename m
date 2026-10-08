Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F84DA9D8
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472381; cv=none; b=b5M65F8DclV4J3xTqqxNdc832OgXuuglrFKkYMffuiMRbKnFF1CFeCxj7LDykwate6DqzXrLr2wUIzWS1tLH8U9hqZ4UOcuAi24NQLHaWJvfCrHNxfV1lJrDqcdDyFM0BuJvXqVBatlRqgyZHtawCmGQ2i9cB1sySggGry468cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472381; c=relaxed/simple;
	bh=wZ6CozmUkheyMWSqRGV6kcV+PJZj5pgj7ODypAQ9KPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7s0OxblmAbFHCi5+l1eeFr/ZYzl2fY78QdoKMLhhDe1oZvUspKotHYXItxI5bavh5KCjNBY3vM5Xo63aS7JoKQx9YAvAqxd0dshpTGhVkqHhhiiMNA+6zpt+t+k8iaFEjRlpHVNypwWFBlq7ActB11/JweWiIVCxXUEknPMWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVHiU3fu; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVHiU3fu"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33c10faf6easo108487eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472374; x=1792077174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=lVHiU3fucHaqrjiXuf3DTtjLwmrj+TgW6gJsFLrBIAh4uhqPXx2kC8B91fD6/PiNln
         ihbb3uFy//Kz3syT7nWBTQ1hIG+S+zVa5OxdLBh6V8XJdXyTT8HvhIVn5ade6T98qBP+
         8hZydkjM4j5L8BCI1VxMbXPgs9qMSgU4hUYEGdLLJ/PPlRPAzRqD4/PXcuXAm5//4KRo
         2AbG+cHqVBzzYop81tU97xeWZmbr+5UezbV1+esFokEYnbij9CETVad0BMs8Z0IaihzF
         jBGQzCrCI9cmEzmnvBdq0NuITBi9OWdegih6DUnCdqDkArzGDoT5uxhgiHLeqQM2fA1b
         d/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472374; x=1792077174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=1h3R38GUbCb+LVDOU24J6eB+vZzB+/tSXUxL84xaK914y4OTKmBwnc85FxE2v/RYKW
         K1sYZjUY1LWZOyXCFATIfH+7Shd32NgN5B1IEam0+6UCbrT0GsGFsHmvdQfjZchAnIdZ
         badcd7jEAFOv0wEEG1Pd6VQyYRtRqbIy44AlV7eK5KLamw0snVtLXkYwgP5oTmZoM5w0
         +El0WpHi2O6q8s21NmUpEl0csgo164psaQtqxIlTPO8TVNc2tCZN1ovd16qrQWwl0j0C
         oKkZ3+AQVDVSbt8xeLXqUFvnCQsmnz386dLkMjs7zX3uOnB/BZ1jocKe1rrw3tYpgWFw
         K3+A==
X-Gm-Message-State: AFq9FYJICquUxCgC9ueBYawFkNG882gUrOo+xHqKcuKfBv3vrqZ4kE99
	cAAfZcE8eGnj6aBP5IeX3rsoq+VzwmdOznjvHUYaQwK8QTKKi0AREHdNgjNhDy2iKLc=
X-Gm-Gg: AYBFou0xneoH/+iy7RxcSHUpdwiyBZEbSAehgcQ0qJuctGP27TMx5dG1Z8KDpkVeFLf
	FoCLEFVJe5aXmyllYielumP2hjXEYThOohwGuCU4ETp5Q9QfP/Esb5vJIK/1m0eniTlLMDzqb34
	ZqsClZ+92r1W4cmKdGTZa8A++eYPiDowqiqM89QURBUBp4lITdY/cmdzWohkDMrqEgUuu610zeP
	/LHlEHRSuxOT8P5e3YDxmSokq3tziwRiwQ2hUaRmsAOxV4JMKi3RP2ZHNciIyDYjdo0x2DGK7Vj
	lzCC5DbIkccw2PLtFXU1Gq30feh5Je48x2Nh28wDvWKbg/HfiV/8Q2A/NN/NLEVv0kStcRlTd0o
	t+wMVvUauoYk0hMfMyUK4vlfOeGrXxW4HjnvSqlZUblwVPauP1hzayOmxMqxp0bTtmDF+QB5hJt
	bUnkllfsRF++kssLNaX5VJQANHFSrUnZb2iB4g8ZQcn6GSkKqDqi1GS/9ADD/ZzN5b945jIvwS2
	4KOlgnmGEf+K0w0HHOp3W6toZC895N5E5FBSsf3
X-Received: by 2002:a05:693c:8111:b0:33e:6714:3945 with SMTP id 5a478bee46e88-3517566b798mr6293965eec.2.1791472374184;
        Thu, 08 Oct 2026 08:12:54 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm18052389eec.23.2026.10.08.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:12:53 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v2 2/6] Bluetooth: hci_conn: Don't set up a SCO link that is already up
Date: Thu,  8 Oct 2026 11:12:34 -0400
Message-ID: <20261008151238.2138665-3-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151238.2138665-1-enghitalo@gmail.com>
References: <20261008151238.2138665-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), a SCO/eSCO setup abandoned while pending can
complete after a new connection to the same device was made, and it is
then matched to that connection by address. The new connection's own
setup may not have been sent yet at that point: Enhanced Setup
Synchronous Connection is sent later from the cmd_sync queue, and any
setup is deferred while the ACL leaves sniff mode. When it runs, it
sets the connection back to BT_CONNECT and sends a second setup, which
the controller rejects since a link already exists. The connection that
is up is then failed by the rejection, or left in BT_CONNECT and later
deleted without a Disconnect when its socket is closed.

This is the order of events in the report: the second Enhanced Setup
Synchronous Connection was sent after the first setup had completed,
and was rejected with Invalid HCI Command Parameters.

Don't send a setup for a connection that already has a handle. In
hci_enhanced_setup_sync(), take hdev->lock before checking that, and
check under it that the connection still exists, as
configure_datapath_sync() runs without the lock.

Closes: https://github.com/bluez/bluez/issues/2562
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_conn.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29da3fe2b..399c7db77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -290,6 +290,22 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	configure_datapath_sync(hdev, &conn->codec);
 
+	hci_dev_lock(hdev);
+
+	/* configure_datapath_sync() runs without the lock */
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+
+	/* The link may have come up while this was queued, see
+	 * hci_sco_setup().
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
@@ -302,8 +318,6 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 
-	hci_dev_lock(hdev);
-
 	switch (conn->codec.id) {
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
@@ -625,6 +639,12 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
+	/* The link may already be up: a setup abandoned while pending can
+	 * complete after a new connection was made and be matched to it.
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(link->conn->handle))
+		return;
+
 	BT_DBG("hcon %p", conn);
 
 	if (!status) {
-- 
2.55.0

