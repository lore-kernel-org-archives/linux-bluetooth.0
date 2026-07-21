Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9D22E3F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623305; cv=none; b=HMwNa9Ck7Aa5iBttPE8WVv1JTKpMBQOSUVPx6tHcfaMsQu3SgLCpv9IdmW5PE924DmRA00Mp7T0PUctH3o16YU5Ltf8opp1wcbAHERJxgrf7uKIVaKof1iGJ3K71nW0A5zVmPyVbV/f/qokQVDRU/aGz5iI+kw2kHzBthccDmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623305; c=relaxed/simple;
	bh=U9vF0ps2Ko32G2k/1DMrteFWg3sY+tijApnpUSbRFig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EaEkLrYRi55wiajveWegKdoSf5ENI04ecZ8agn727l8U+shEbkA8Le2s5zIStYc0c/KlFvOvs5ZklxPwUP6PypegzAUXmLPHH7+ONLUnpYbuvIe6zgKGubAwtyf1AN+OJkgx0qF2JQHcn/z6e+hIjZyIqNUX5qdHPRYD5bWdIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FHnRXGdo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T+2HR/aP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHnRXGdo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T+2HR/aP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6ESWc4107138
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iO86NuwyKvQ
	dnHjwrXJALyjqHujjI35691E1ThLBoEY=; b=FHnRXGdoy0XCCspG47dDW3i+TDf
	h25NzBxed/aaExVYzmHzXbu+f+UiPA7co3L8knffZ6zsvZPMQvgPHFQEPkVv1+m4
	BOuzEnfBjjsgKyNXppif1TzzU85hfp02Mqa42ryczOzqlzR8W1pB86TkAlsvVanW
	U18nJj2OLFKTDbapdlMT6FBjDCnnqWDinbpykKmwsoS9AsFTJJPswX0fI+CZx/6w
	QL4r3F5qwD4sPImIhEh2m3gJ8Mw81Ts78VrnhmT7tcP0Va2us11GPUKnnguyK2xT
	40jszvjbsOfedEpQnDV3k+wdHXx/23GX4jDCOJncfsKnogF7RFzhWOfqZGA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqna5qk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so5286250a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784623302; x=1785228102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iO86NuwyKvQdnHjwrXJALyjqHujjI35691E1ThLBoEY=;
        b=T+2HR/aPGPxJQOfS9WGmY7vXBsAdC7ckwcA6dnlXEac56bS7gTmhWuaigsk0yFCZ5z
         jP9vhloaFEnpZFMvK5jLGRJ2z0cAKjVfDCLFhK3y72bqERS/dbP6wFGF4xHTV8/sLNSa
         cazcAQnmADgK2qNS/byFz3Q2Q0I4BtSsuZiotM0VD6pnUXPZ2NMJlXZPmSRxVK7vKOE2
         q4W6Lx35IYkYs+jfbpv09P48IkUKc5i56XfdEInlKlGGNimcHA43Lih/krztQmOSjHxq
         YyhrARljkxsMIVKjjHNCd1qrbQVYHgrHCWZ+qOqZOCQy/3yYw1uPAr3Z4rIs7tBHmqJz
         B8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623302; x=1785228102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iO86NuwyKvQdnHjwrXJALyjqHujjI35691E1ThLBoEY=;
        b=sbEAo6vcADIoVGfs6AsLAmH4OQUX58U3wyxIgEW9rLNUsR9/oWwPRIBCR3vc/hiO+t
         xzGDZ2z9WzjrIP/UPmZzsu2QzDCRt8ZsMFDvjGI++5S4A0PzgeFQHMLbIY94fAfr0phB
         SV2NqSOwBb8REHdkVCQA4Hai9sqBo07YFx3G+j+Zym0Jw+C7moI4ptniS+tWXFpi/Uuy
         vqhOnn0KNQjyVokoFdvNFf6OiCjAEMY0p9YVuKEOHfLfbQLtqvp+/zfchT4NBVsNdXGE
         BzTFuVh2qL5aeYfCqYUvGvyS+1GUa97hv0cYMH607qwR8yJbpNfCsShyZqAu0l6bAlTw
         bJwA==
X-Gm-Message-State: AOJu0YwuiEBI1X3ROPl4bo38XlLBFaUoWDxEeqw5CkyVryz30XRdARkW
	Y3zUS2EoCCS/jmUQd5DzQrJgAyuXldEagPqj/Dh8y3j4yD4EGtrl2OFpAKm3wLrgCKBgxra0pvg
	7m5wqmEoFaCRphqc/OewdzvvjwjzdDHnSjzC54Y6q7n7AvqhKZqIYT8TccPhttI7akqiWvm9C0h
	zO+XM=
X-Gm-Gg: AfdE7cnUxn9xnQsaDJD4u057mH+MIRqts1pr8aKQgAzVl/FdEqmpygOnNefLZ/kmTjn
	vPLDyvs0V+aw/oiH1y7J0ve13lG6oZ7hyjVOmdF3bwx6pa3P31KZHhDFNd+zcei1FwTZN98bYgR
	JIvNdhcVwKnVi7KotfMOuyeP2RW7CbUUN+wmWjN/TDU+DysmslKLiIBFkJwc5l7iqUyGBvY6r8f
	9Fj0Vh0x3w/Ia/mJYFDkprbXH+wd0noPS9fc3tksOPB+UQiZrdr76bHdbI/BvS2T2X2IZquZSHg
	EhtTJlEj651QTAMx3BhGUG22s1pK+wSNjJHeIy5w0dVgGbNyY8h5znfEo4ykKhHnnDrEAZ5wzHK
	1X1TZvJzZ/HzYjpRotvBouSisCEvu2Q==
X-Received: by 2002:a05:6a21:a393:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c38d90d347mr23892741637.14.1784623302455;
        Tue, 21 Jul 2026 01:41:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:a393:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c38d90d347mr23892713637.14.1784623301977;
        Tue, 21 Jul 2026 01:41:41 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm38063131c88.10.2026.07.21.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:41:41 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 2/2] profiles: centralize reflector setup
Date: Tue, 21 Jul 2026 14:11:21 +0530
Message-Id: <20260721084121.688467-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721084121.688467-1-naga.akella@oss.qualcomm.com>
References: <20260721084121.688467-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MSBTYWx0ZWRfX9EkklyTRDTjX
 Q2t5ixravNd+Aj88NlEPL4vABrJXX8bedUGvMR6ruHcNZIeao1nJ5OwFoCa9+V6ZROJTBKEyK6L
 TmcGMSQm6GyFr/NPei+a5ep7J1y4Jufb7mgmyRtXOWgjbcs7hASeAf1k1Ehy5Iq0+IT+bI1nKMu
 kGTkKhkkb9mE3ZAqYIsT39es32ljiQMaQCOWZeUD0NnW0RMxLTuwbCxG/yzf/SDgeTiPVAYSyoM
 868rO5bQhNtWHUReYPnIMn43dqqGswsV3+oUvYR9TDS4kcSE/apFJWYNRClYpVs+t0b3fzKIQZS
 CPqxQvv45WjTgFfgWIlMavY07nsTkIMMq9qYOVGy1xQ7G6OuYyDM112bPsdgHOoDm8de8a4kJxs
 4AWbp6mFs0R4olH4HI+0vQirx+zhsFLEu5oRfUeBwbQtpdNAFnAC1u4PXahFAlsFx0uuqW+jcvT
 OacL2PPN2nK09u0wgGw==
X-Proofpoint-ORIG-GUID: -R50k16xPww-VjPdbyB9CkUJKJx04t22
X-Proofpoint-GUID: -R50k16xPww-VjPdbyB9CkUJKJx04t22
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f30c7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=uXYGvHFHBPWYZw0bQ00A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MSBTYWx0ZWRfX+VJmqNzPa/jD
 e5KH9mvC+OwW5xrArq3583dUPY7N670jd+hOfe3tqjMwH4RngcDQ8nyufx9462H2MnJADr+PjsP
 WovwbWRfK3SitzaK9TBbYql9frnn/EE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210091

Add a helper for reflector initialization and track D-Bus registration
state in rap_data. Simplify connection handling, move interface cleanup
to object destruction, and streamline removal logic.
Remove the legacy RAS accessed callback path and its registration
handling from initialization and shutdown.
---
 profiles/ranging/rap.c | 137 +++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 3ffc0da76..71cdc592b 100644
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
@@ -218,6 +220,13 @@ static bool match_data(const void *data, const void *match_data)
 
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
@@ -281,14 +290,13 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
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
@@ -306,6 +314,11 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	data->rap = rap;
 
 	rap_data_add(data);
+
+setup:
+	err = rap_setup_reflector(data);
+	if (err)
+		error("Failed to set up reflector session: %d", err);
 }
 
 enum cs_dict_target {
@@ -662,19 +675,13 @@ static void rap_remove(struct btd_service *service)
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
@@ -682,26 +689,18 @@ static int rap_accept(struct btd_service *service)
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
+			DBG("Using shared HCI channel for adapter (ref =%d)",
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
@@ -721,38 +720,70 @@ static int rap_accept(struct btd_service *service)
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
+		g_dbus_register_interface(btd_get_dbus_connection(),
+					  device_get_path(device),
+					  CS_INTERFACE, cs_dbus_methods,
+					  NULL, cs_dbus_properties, data, NULL);
+		data->dbus_registered = true;
+	}
+
+	return 0;
+}
+
+static int rap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct rap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+	int err;
 
-	g_dbus_register_interface(btd_get_dbus_connection(),
-				  device_get_path(data->device),
-				  CS_INTERFACE, cs_dbus_methods,
-				  NULL, cs_dbus_properties, data, NULL);
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
-- 

