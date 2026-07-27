Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56A37C927
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135625; cv=none; b=h3MC8o7oN8VC/l0MH9LuLLXmWSka8Ohzu5arFEH3P/DdkDMR31BEZ+w/1Y3ridZL3huAUGqGl3DvHAJZHTqIbxMrNXi1CVRYE1NiqvpgWUXkqwqNQmEUZX1AdY871jPArHKzIqEhmfHsIPZNHuC/kYRU0jBa958QUXvQGbeX7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135625; c=relaxed/simple;
	bh=3VPg+lnvO7ivmzqcm4LUIskifWD+6wBFu3M6GcQSGdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRnS5TD/x4VBziXU+e9fz+F4wUJuVxkiZIqQ/91BqSrF1TxBSrCH3X8j3E06XdM5N8jCN9dzthphmgRKIQBhKFxybpgV+O2lFkNl5bfi7xU5YvAvOfKqjuIe66+NU3E/AEct3TnbAWjTCb5wHeptv97NxLfiHPM7ZnFTnc/J8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pu1jna6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJij4RfP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu1jna6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJij4RfP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R3HDGW3604349
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2SSZpomyQbD
	bPsrDoEH/Sv5W4141dhE7aHWTd9uzMe4=; b=Pu1jna6AzCLjAs/JzD2u8OFQfnZ
	0vu/IcsJYO9XJ7B1jFdfHnc/GM01+op9/CCW9tYet59r8MuDUXDlENsaxo/ktMHK
	MgOkFxsuzQ+1JbLtC0+Rdcf3qx9eXlsBJi6YxqzNSudkcYWy0yOkRHmT9Kyg2Cq5
	VPt59d4xiskDxaQVGAbiARVFM54UUlBdlzXCq5XD3P3cc2m7I8YClN3rWaaOO7Qd
	ElTGC7zFbBUjBgPVbnrco6KDOwfxP20HqwOb9XRPMRz6RPCw4y2JpvHEHTFHs1w4
	IUsLm7soC91ISRvACYO8KQ0qHX3q3mdCftw15CuGlso2miJDAR+SDgr48Ew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wgknf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so1525557a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785135615; x=1785740415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SSZpomyQbDbPsrDoEH/Sv5W4141dhE7aHWTd9uzMe4=;
        b=aJij4RfPPTt3+mcAx4G3u8XIqByLXZEqhvA+NVonAmU8gjWAdY35Jiz0z5gsxQz2rB
         M5cppR23CXyQ7rpw/c8eCLXKEDml5KEqr7EraC7kf/RXJUojYTQvMkFYeAVEXi2hq2qe
         5bUAO6TfQvrIlO4x2hv7E4J0iAhGpKkjfN+j/K3U23i+2x/aIV7n2wzfww09KhNJ/gfG
         7dXFJKr8jHW76J/U9fgX1n7gm2owpmpxZNr8R4TObxILdryn8+u21v1ubEfm6pHbfplc
         bcANsw9q2a/xjOhBl+7oYcja+YX8KZRnA99IGRv0xWc6rm/jFDLBks0GSBoF6W+cMxk4
         JW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785135615; x=1785740415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SSZpomyQbDbPsrDoEH/Sv5W4141dhE7aHWTd9uzMe4=;
        b=NjpttuIPcT7OKyh4TGlP8w8Na3wF+NnM/8VpjwUGOZ9AWEE8aWrEgf2V6mfIrZ/Men
         hg1JFrgGvFI6Oq6cTgH5RaXctKjYCrixwQnDuEycKGFPryAC3dMOdSYl/VtbJb8RFCdm
         bmsHtqkwJn6t/t4SETgAvdxwP+PNnkkcna6cKhcJ0v07t6FXODVhROSdh3woqcPBu81u
         oRU298KYybj9QJyftT2XkB5o474OG5cvGfTc+IxARQu5CUv9Ykg7nxfGLcSOu2Aqvg6w
         UZVK5wZM/ehgayESrcNjW2ZEhT/gSzYtvhvW/IaH9SX6dffG2dbHMXhnUgH/e4rbeRI/
         qT/Q==
X-Gm-Message-State: AOJu0YwVoeSjB3iXDLau6PbtTMeY+92Tq3vBn6QuT5MWIggxYlkoXkpn
	Ikif4k6K2Dhwi7EugwsBu0nTxh/UiaqPN8nz4SgjlFntrG8OFjjUDfXZkvVFL7VuwHhYtMZUwSh
	npv7E06gS10FAXZVYHayLfzb97BeP2+3VdTBIWxRbH1l9Gc7rw3xdPtRcg4syk3PE0uxsQrbhHw
	d5qrE=
X-Gm-Gg: AR+sD10u2RAC4J35Ema+5pxRkUfijXk9UKjVK6SFSdrUJZAls/b/6ooYotsaCX9J0HJ
	VgILGJRAjrZWUyOFx5a52EmoaSdOtUrnQqkttD+0WTo313B64eBCUeFVCddEalLiK8lFx6di/ZE
	nz0wT/J0cuDCFpq/+5ugQ5mxaUs+jLU2bJhw9mATJmdtDNMjWEnWeoPheE019B9+1kJv6VfpoQ+
	R9cr4bkX7++XC6h69//iOGMeuktUptFwwyqWnJJ0m3F2ry0bsCDjfqnDOLMnHRPgQ6Ht33DMlaj
	kJogGi/msbqT9aRfm7ZZGtEm65RTNf/gujnlLfd7/T3ZDPShRbB4kyVsNbgsDtab6hqZXHHsPhd
	qmAqQXZ2468nLQzfFgmFweyJlwxpOTg==
X-Received: by 2002:a05:6a20:c6c1:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3c67da31072mr6216290637.18.1785135614953;
        Mon, 27 Jul 2026 00:00:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:c6c1:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3c67da31072mr6216252637.18.1785135614391;
        Mon, 27 Jul 2026 00:00:14 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm43432530eec.4.2026.07.27.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:00:13 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 2/2] profiles: centralize reflector setup
Date: Mon, 27 Jul 2026 12:29:54 +0530
Message-Id: <20260727065954.1053484-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
References: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfX72ej6PoNKANa
 gM3YvnNIkz0EW2NEmGX1kyd/E+WL5jWJAD82JfprF1+ZAXjfIXoWXwNDlJ1v7K0P3X1PMH+pUJV
 jfzl6e96zfjYctTZLdgqv33xDCdXWLr9PZP1O+gwkow5ZWsAM7oySEuPhYfdRrRLSC+bP4zJraD
 fS69qfRTSNcAv45+EA3vL0gtAXy+lIJyVm8JnCg0MIy4nr6NMFQJXYlRIoyf9l+Il4YYTl+Eo1P
 KEXhKxnVksfyOUs/ug35aHsuxzyUl0JV6VGXi7BwQFdHO1q13dOgdf0WurbwEUs7g0tbwP4qd3a
 0XpVXnnrVk9Sxlh67ML8fu3kSKK0OkKrkOJTjQ+1o77RlWFm3wAjPhHNW/28LYIeTw1d/H+F7J3
 T1ObF+/ivohg2CgY7oTwl3yMQgjsWCgBSP1xcHZHTkovCR3TkY0W7ljki+QyWosfxcvVNCAlLGc
 Pum0/nVkgqdxGiUTzKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfX8vMyKr/NZMte
 OF6ruQxhdCUZZ4MZP1XDMH3o/DxjhDbut6wXPm6yi9ob6sU/gbDhT+JI420szEIl0JWPstusDec
 wD/Noa5e9kIpIICvpf/hvliWrh96GlQ=
X-Proofpoint-ORIG-GUID: O1rboP-5PVttnfihzSZf6Kk2J9ELS-qD
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a6701ff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=5N9AjBLTd9fcQefjo-EA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: O1rboP-5PVttnfihzSZf6Kk2J9ELS-qD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270067

Add a helper for reflector initialization and track D-Bus registration
state in rap_data. Simplify connection handling, move interface cleanup
to object destruction, and streamline removal logic.
---
 profiles/ranging/rap.c | 209 ++++++++++++++++++++++++++++-------------
 1 file changed, 144 insertions(+), 65 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 082c35558..91f30ac30 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -65,10 +65,12 @@ struct rap_data {
 	void *hci_sm;  /* Per-device HCI state machine */
 	uint16_t conn_handle;  /* Last known connection handle */
 	struct cs_session active_session;  /* active==false when idle */
+	bool dbus_registered;
 };
 
 static struct queue *sessions;
 static struct queue *adapter_list;  /* List of rap_adapter_data */
+static int rap_setup_reflector(struct rap_data *data);
 
 /* Adapter data management */
 static bool match_adapter(const void *data, const void *match_data)
@@ -188,13 +190,34 @@ static void rap_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
-static void rap_data_add(struct rap_data *data)
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct rap_data *mdata = data;
+	const struct bt_rap *rap = match_data;
+
+	return mdata->rap == rap;
+}
+
+static bool match_device(const void *data, const void *match_data)
+{
+	const struct rap_data *mdata = data;
+	const struct btd_device *device = match_data;
+
+	return mdata->device == device;
+}
+
+static bool rap_data_add(struct rap_data *data)
 {
 	DBG("%p", data);
 
 	if (queue_find(sessions, NULL, data)) {
 		error("data %p already added", data);
-		return;
+		return false;
+	}
+
+	if (queue_find(sessions, match_device, data->device)) {
+		error("rap_data already exists for device %p", data->device);
+		return false;
 	}
 
 	bt_rap_set_debug(data->rap, rap_debug, NULL, NULL);
@@ -206,18 +229,19 @@ static void rap_data_add(struct rap_data *data)
 
 	if (data->service)
 		btd_service_set_user_data(data->service, data);
-}
-
-static bool match_data(const void *data, const void *match_data)
-{
-	const struct rap_data *mdata = data;
-	const struct bt_rap *rap = match_data;
 
-	return mdata->rap == rap;
+	return true;
 }
 
 static void rap_data_free(struct rap_data *data)
 {
+	if (data->dbus_registered) {
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+					    device_get_path(data->device),
+					    CS_INTERFACE);
+		data->dbus_registered = false;
+	}
+
 	if (data->service) {
 		btd_service_set_user_data(data->service, NULL);
 		bt_rap_set_user_data(data->rap, NULL);
@@ -281,31 +305,60 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	struct rap_data *data;
 	struct bt_att *att;
 	struct btd_device *device;
+	int err;
 
 	DBG("%p", rap);
 
 	data = queue_find(sessions, match_data, rap);
-	if (data) {
-		DBG("data is already present");
-		return;
-	}
+	if (data)
+		goto setup;
 
 	att = bt_rap_get_att(rap);
 	if (!att) {
 		error("Unable to get att");
+		bt_rap_unref(rap);
 		return;
 	}
 
 	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
 	if (!device) {
 		error("unable to find device");
+		bt_rap_unref(rap);
 		return;
 	}
 
+	/*
+	 * A separate bt_rap session for this device may already have a
+	 * rap_data (e.g. rap_probe()/rap_accept() ran first for the GATT
+	 * client role, while this "rap" came from bt_rap_get_session()'s
+	 * ad-hoc att-only session). Setting up a second HCI state machine
+	 * and D-Bus interface registration for the same device path would
+	 * race with the existing one, so rap_data_add() rejects it below
+	 * regardless of which side (ad-hoc vs. probe/accept) runs first.
+	 */
 	data = rap_data_new(device);
 	data->rap = rap;
 
-	rap_data_add(data);
+	if (!rap_data_add(data)) {
+		free(data);
+		bt_rap_unref(rap);
+		return;
+	}
+
+setup:
+	err = rap_setup_reflector(data);
+	if (err)
+		error("Failed to set up reflector session: %d", err);
+	/*
+	 * NOTE: on failure here, this rap_data is left half-constructed
+	 * (missing hci_sm and/or dbus_registered) with no retry. For a
+	 * session created via rap_probe()/rap_accept(), a later GATT client
+	 * idle event re-invokes rap_setup_reflector() and can still succeed.
+	 * But for an ad-hoc, client-less session (created above, from
+	 * bt_rap_get_session()), there is no ready/idle callback registered
+	 * anywhere to retry it, so a one-time failure here is permanent
+	 * until the ATT connection drops and rap_detached() cleans it up.
+	 */
 }
 
 enum cs_dict_target {
@@ -638,7 +691,11 @@ static int rap_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	rap_data_add(data);
+	if (!rap_data_add(data)) {
+		bt_rap_unref(data->rap);
+		free(data);
+		return -EINVAL;
+	}
 
 	data->ready_id = bt_rap_ready_register(data->rap, rap_ready, service,
 								NULL);
@@ -663,19 +720,13 @@ static void rap_remove(struct btd_service *service)
 		return;
 	}
 
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-				    device_get_path(device),
-				    CS_INTERFACE);
-
 	rap_data_remove(data);
 }
 
-static int rap_accept(struct btd_service *service)
+static int rap_setup_reflector(struct rap_data *data)
 {
-	struct btd_device *device = btd_service_get_device(service);
+	struct btd_device *device = data->device;
 	struct btd_adapter *adapter = device_get_adapter(device);
-	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
-	struct rap_data *data = btd_service_get_user_data(service);
 	struct bt_att *att;
 	const bdaddr_t *bdaddr;
 	uint8_t bdaddr_type;
@@ -683,26 +734,18 @@ static int rap_accept(struct btd_service *service)
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
-	DBG("%s", addr);
 
-	if (!data) {
-		error("RAP Service not handled by profile");
-		return -EINVAL;
-	}
-
-	/* init shared adapter HCI channel */
-	if (!data->adapter_data) {
-		data->adapter_data = rap_adapter_data_ref(adapter);
+	if (!data->hci_sm) {
 		if (!data->adapter_data) {
-			error("Failed to get adapter HCI channel");
-			return -EINVAL;
+			data->adapter_data = rap_adapter_data_ref(adapter);
+			if (!data->adapter_data) {
+				error("Failed to get adapter HCI channel");
+				return -EINVAL;
+			}
+			DBG("Using shared HCI channel for adapter (ref=%d)",
+				data->adapter_data->ref_count);
 		}
-		DBG("Using shared HCI channel for adapter (ref_count=%d)",
-			data->adapter_data->ref_count);
-	}
 
-	/* per-device HCI state machine */
-	if (!data->hci_sm) {
 		data->hci_sm = bt_rap_attach_hci(data->rap,
 					data->adapter_data->hci,
 					btd_opts.defaults.bcs.role,
@@ -722,38 +765,74 @@ static int rap_accept(struct btd_service *service)
 					data);
 	}
 
-	if (!bt_rap_attach(data->rap, client)) {
-		error("RAP unable to attach");
-		return -EINVAL;
-	}
-
-	/* Set up connection handle mapping for CS event routing */
-	att = bt_rap_get_att(data->rap);
-	bdaddr = device_get_address(device);
-	bdaddr_type = device_get_le_address_type(device);
-
-	if (att && data->adapter_data->hci && data->hci_sm) {
-		if (bt_hci_get_conn_handle(data->adapter_data->hci,
-					(const uint8_t *) bdaddr, &handle)) {
-			DBG("Found conn handle 0x%04X for %s", handle, addr);
-			data->conn_handle = handle;
-			bt_rap_set_conn_hndl(data->hci_sm,
+	/* Set up connection handle mapping for CS event routing. Retried on
+	 * every call until it succeeds, since att may not be available yet
+	 * the first time this runs (e.g. called from bt_rap_attach()'s
+	 * attached callback before rap->client/att are set).
+	 */
+	if (!data->conn_handle) {
+		att = bt_rap_get_att(data->rap);
+		bdaddr = device_get_address(device);
+		bdaddr_type = device_get_le_address_type(device);
+
+		if (att && data->adapter_data->hci) {
+			if (bt_hci_get_conn_handle(data->adapter_data->hci,
+				(const uint8_t *)bdaddr, &handle)) {
+				DBG("conn handle 0x%04X for %s", handle, addr);
+				data->conn_handle = handle;
+				bt_rap_set_conn_hndl(data->hci_sm,
 					data->rap, handle,
-					(const uint8_t *) bdaddr,
+					(const uint8_t *)bdaddr,
 					bdaddr_type,
 					btd_device_is_initiator(device));
-		} else {
-			error("Failed to find connection handle for device %s",
-				addr);
+			} else {
+				error("Failed to find conn for device %s",
+					addr);
+			}
 		}
 	}
 
-	btd_service_connecting_complete(service, 0);
+	if (!data->dbus_registered) {
+		if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					device_get_path(device),
+					CS_INTERFACE, cs_dbus_methods,
+					NULL, cs_dbus_properties, data, NULL)) {
+			error("Failed to register %s interface for %s",
+				CS_INTERFACE, addr);
+			return -EINVAL;
+		}
+		data->dbus_registered = true;
+	}
+
+	return 0;
+}
 
-	g_dbus_register_interface(btd_get_dbus_connection(),
-				  device_get_path(data->device),
-				  CS_INTERFACE, cs_dbus_methods,
-				  NULL, cs_dbus_properties, data, NULL);
+static int rap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct rap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+	int err;
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("RAP Service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_rap_attach(data->rap, client)) {
+		error("RAP unable to attach");
+		return -EINVAL;
+	}
+
+	err = rap_setup_reflector(data);
+	if (err)
+		return err;
+
+	btd_service_connecting_complete(service, 0);
 
 	return 0;
 }
@@ -814,7 +893,7 @@ static void rap_server_remove(struct btd_profile *p,
 static struct btd_profile rap_profile = {
 	.name		= "rap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
-	.remote_uuid	= GATT_UUID,
+	.remote_uuid	= RAS_UUID,
 	.local_uuid	= RAS_UUID,
 
 	.device_probe	= rap_probe,
-- 

