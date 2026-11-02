Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607566;
	b=nCunsarixuXHh3Ccgyth8imZlsOZiFUSWkaPsoDRkjcZ0gXpHM3DikiA0WTZasN9YMGN
	 73joul3e20EGy0WLbbiDKvNrXnzy5jNyj/6b34IogcNK5ClAyvmm2XPvHSeNmdCtsefp+
	 V3t6sY6wbUHfSKFHU+TCpTgmhiHsXoCxK9RsYQnlFa0YLUmFGyi5NF+v4ZrG0GQeGoAXO
	 8wZKE01h9is/JjLKJKp7iNJaZij58+Le43fY3PiX3Lau7SfpHIExXfvMvsJBN7mPo18ty
	 MUU436KGKj/uZR06Ce07ROLQqT0Q8BvLdk14vib8aFN1OYPTy6qhqIBZfSbFprKwGOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607566;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tnL4XhEKvQh1p85AWbSgN09lREojyTUx0Ied2gDKDOQ=;
	b=vK4BEPP4gEBCiZSlzOprangAzwlgigP99iDxpH5exqsxQTfirY5mYE+l48HXrGvf/3xR
	 6I8vQEapiyUMejj77Nz95NNqmSPJ27MiTEBxaAnhk6Zoqf1fiuDEb+uWIVr6d7JE1Z0dM
	 d+qJ/q1LjDCutkHbHf2hjPecD6unxTYBuvYPErX0YbQxNjOziY8nK+oxDWqfnFzFAF0LN
	 Zsh+/A7+yeFa7uXpzDwqdP5N070ko78WUj9s33GsyNwM0LXN9qZy1wXnRD2h4LZHXmbBU
	 4JvgwGSy0uXHCHby9utR9dbUl+xtnJy1o2D1MCj8QapYRPBsAMyG+gwU7f+0DNWYbuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdd5pFGt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3965606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3965606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdd5pFGt
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A25W2FA3924329
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tnL4XhEKvQh1p85AWbSgN09lREojyTUx0Ied2gDKDOQ=; b=cdd5pFGt2gq0PcH8
	An8SajsYg6U5/x/wkoMQ/lB07cjOPPhy1weX+BwYHeduzWTnB6jnVqMZBk0HXxgd
	2Y++GZYN79Cszokh/YwGHSgzj3jMPcYoIPlda5rh75XyNNTw3c+p/ffItxap8yUa
	AREHh36rXpRJQihdQTF4UcGmpnj1t+Aa72DmgaGGSTc5sYXjWqpW2v52zHn1y2q6
	qTKeNMcljnXcfHXuBhnZt8ASPHzoHOX9EZfGuo+dPGoJUzadws8DrX8MOjcD2f1v
	gAGR4yl+Lu6i61IyjmnmjsSEWVLuZGw7t4dCFZm13Xb0Owv9rP3/fj5mSxJzWQi7
	YZRpMg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rjya-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:24 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKhl3331063
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:23 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg23331043;
	Mon, 02 Nov 2026 08:19:23 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 07/15] profiles/ranging: Let the Reflector run the CS setup phase
Date: Mon,  2 Nov 2026 16:19:04 +0800
Message-ID: <20261102081913.1623864-8-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: lAP5rIk0alp0afVP5C1g76aXu9sGgBTx
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8478d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=xMBm_ZK4DHOeKkl8wSgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX78INT5bzRgjF
 aHBN8VRuRFsSnvF5Qk9IB+yOX1UjNxZeXu6tIG+Qk8h6VMu9Kh+UDyWtuGsh7ry5pNfdATAOQql
 yqmkeQ0wAERdnQXLx51U8nvC7o1Zt+5ppnou4w3ZO0apprQKGQa9J6dd8WpRBU79smcGNx3kIM5
 Gl8c/kRKAI5Uf/99lEMyrWGWS09J6xv+u880Yz9Tw5zLqugAP80ZDerFd4fs2pEZwDrtHY1nw52
 g2AUM8M1cvmEcf1r91d6ZlGVx9QMs7Rma/ojCMyGqljfw96DZtl7PLbwq0if0soahAuWVffTHni
 Dr/AP9GjzwHqJKwDFlZ2O/4DajQI7Fen0uI2Vd8kDRZI5UZi0NZKqhe/Z5yZ+ZgN9QrIeSTdRGQ
 tFNFZIwXefIZimpAEUUaPLGFKyBwtkA/Y3L5tu/ayU3azswWlnxL6IKEarQ+nhmCGPX3JSxoyHz
 YjhR4obkKP9UuOmvqWA==
X-Proofpoint-GUID: lAP5rIk0alp0afVP5C1g76aXu9sGgBTx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX1vy4hkcn3WYu
 JJ6ZXkxlKnBfSfOL0WCQ5GKFQy0YWUfgWT6Q8GfkQ/moPBOjE3upaQUewID6s5SvJ7GNUzSL2IA
 /ul/i2ERcrB9M8TuL8PX5TrMhPh5rcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

StartMeasurement() returned early for a Reflector, so the local Host
never read the CS capabilities or sent LE CS Set Default Settings, and
the state machine never left its idle state. The events driven by the
remote Initiator (Config, Security Enable, Procedure Enable) were then
dropped as out-of-state, and the Reflector role could not be used.

Run the setup phase for the Reflector as well. The FAE Table paths
skipped Set Default Settings for a Reflector, and for Both on the
Peripheral; send it on every path, and leave Create Config to the
Initiator, which rap_def_settings_done_cb() already decides from the
role.

The early return also skipped the Ranging Data subscription. The RAP
roles are independent of the CS roles (RAP v1.0 2), so a Reflector that
is the Ranging Requester still needs the peer's Ranging Data, and it is
now subscribed the same way as for an Initiator.

A Reflector can now reach StopMeasurement() before any procedure has
started, and the Procedure Enable it then sent was rejected by the
Controller; skip it while no procedure is running or being enabled.

bluetoothctl now keeps a session for a Reflector too, so that stop and
the Active property work for it, and the ChannelSounding1 documentation
describes the setup phase.

Assisted-by: Claude:claude-opus-5-5
---
 client/cs.c                        | 25 ++++++-------
 doc/org.bluez.ChannelSounding1.rst | 16 ++++-----
 profiles/ranging/rap.c             | 11 +++---
 profiles/ranging/rap_hci.c         | 58 +++++++++++-------------------
 4 files changed, 43 insertions(+), 67 deletions(-)

diff --git a/client/cs.c b/client/cs.c
index e029da881..01d92cd9b 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1120,29 +1120,26 @@ static void start_measurement_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
-	if (cs_role == 0x02) {
-		bt_shell_printf("Default settings applied on %s;"
-				" Reflector role does not start a local"
-				" measurement\n",
-				g_dbus_proxy_get_path(proxy));
-		return;
-	}
-
 	s = g_new0(struct cs_session, 1);
 	s->proxy    = proxy;
 	cs_sessions = g_list_append(cs_sessions, s);
 
-	bt_shell_printf("Measurement started on %s\n",
-			g_dbus_proxy_get_path(proxy));
+	if (cs_role == 0x02)
+		bt_shell_printf("Reflector armed on %s; waiting for the remote"
+				" Initiator\n",
+				g_dbus_proxy_get_path(proxy));
+	else
+		bt_shell_printf("Measurement started on %s\n",
+				g_dbus_proxy_get_path(proxy));
 }
 
 static void cs_print_role_hint(uint8_t role)
 {
 	if (role == 0x02)
-		bt_shell_printf("Note: Reflector role only uses"
-				" role/cs_sync_ant_sel/max_tx_power;"
-				" other CS config/frequency parameters"
-				" are ignored.\n");
+		bt_shell_printf("Note: Reflector role runs the setup phase and"
+				" then waits for the remote Initiator to create"
+				" the config; it does not start a procedure"
+				" itself.\n");
 	else
 		bt_shell_printf("Note: Initiator role requires dev_addr"
 				" and duration_secs; CS config/frequency"
diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index e75535b97..6e61ea4c1 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -37,12 +37,11 @@ Only one measurement per device object may be active at a time. Calling
 ``org.bluez.Error.InProgress``.
 
 When ``role`` is Reflector (``0x02``), this method does not start a CS
-distance measurement: a Reflector never initiates a procedure locally,
-so it cannot start one via this call. Instead, all given configuration
-is applied and stored so the controller is ready to respond once a
-remote Initiator begins a procedure, and the method returns success
-without arming a local measurement session. The ``Active`` property
-only transitions to ``true`` when a remote-initiated procedure
+procedure: a Reflector never initiates one locally. It runs the setup
+phase (reading the capabilities of both sides and applying the default
+settings) so the controller is ready to respond once a remote Initiator
+creates the configuration and begins a procedure. The ``Active``
+property only transitions to ``true`` when a remote-initiated procedure
 actually starts, which may happen well after this method returns (or
 not at all, if the remote never initiates one). Clients that watch
 ``PropertiesChanged`` for ``Active`` (as **bluetoothctl-cs(1)** does)
@@ -53,7 +52,8 @@ path are the parameters that matter to start a measurement; every
 other key below is optional configuration with a usable default. For
 Reflector role, only ``role``, ``sync_ant_sel`` and ``max_tx_power``
 are required or have any effect — the remaining keys are accepted but
-otherwise unused, since no local procedure is armed.
+otherwise unused, since the configuration comes from the remote
+Initiator.
 
 Supported dictionary keys:
 
@@ -229,7 +229,7 @@ Examples:
 	| [cs] > start AA:BB:CC:DD:EE:FF
 :bluetoothctl start with defaults:
 	| [cs] > start [dev_addr] [duration_secs]
-:bluetoothctl configure as Reflector (applies settings, does not start a measurement):
+:bluetoothctl configure as Reflector (runs the setup phase, does not start a procedure):
 	| [cs] > role 0x02
 	| [cs] > start
 
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index d23c3f8e2..a7fc95168 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -837,19 +837,16 @@ bad_type:
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
 					   "Set CS freq params failed");
 
-	/* Reflector never initiates a CS procedure locally: apply the
-	 * settings so the controller is ready to respond to the remote
-	 * Initiator, but do not arm a local measurement session.
-	 */
-	if (settings.role == 0x02)
-		return dbus_message_new_method_return(msg);
-
 	/* Nothing is subscribed at connection time unless On-demand is
 	 * configured, so subscribe now if SetRangingDataMode() was not called.
 	 */
 	if (!bt_rap_ensure_ranging_data(data->rap))
 		DBG("Unable to subscribe to Ranging Data");
 
+	/* The Reflector runs the setup phase too, so that the state machine
+	 * acts on the remote Initiator's events; rap_def_settings_done_cb()
+	 * leaves Create Config to the Initiator.
+	 */
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 62760b5c0..0eea018cc 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -716,7 +716,6 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
 	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	int i;
 
@@ -742,19 +741,10 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 		 * to the Default Settings step.
 		 */
 		if (evt->status == 0x11) {
-			m = find_mapping_by_handle(sm, evt->handle);
-
 			DBG("Remote FAE=0 (No_FAE), proceed to Def Settings");
-			if (is_initiator_role(sm) ||
-			    (is_both_role(sm) && m && m->is_central)) {
-				memset(&tmp_ev, 0, sizeof(tmp_ev));
-				tmp_ev.handle = evt->handle;
-				DBG("Init/Both: send def settings (No_FAE)");
-				rap_send_hci_def_settings_command(sm, &tmp_ev);
-			} else {
-				DBG("Reflector role: continuing after No_FAE");
-				cs_set_state(sm, CS_STATE_INIT);
-			}
+			memset(&tmp_ev, 0, sizeof(tmp_ev));
+			tmp_ev.handle = evt->handle;
+			rap_send_hci_def_settings_command(sm, &tmp_ev);
 			return;
 		}
 		error("Remote FAE Table read failed with status 0x%02X",
@@ -774,18 +764,9 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	}
 
 	/* After receiving FAE Table, send default settings */
-	m = find_mapping_by_handle(sm, evt->handle);
-
-	if (is_initiator_role(sm) ||
-	    (is_both_role(sm) && m && m->is_central)) {
-		memset(&tmp_ev, 0, sizeof(tmp_ev));
-		tmp_ev.handle = evt->handle;
-		DBG("Init/Both: send def settings after FAE");
-		rap_send_hci_def_settings_command(sm, &tmp_ev);
-	} else {
-		DBG("Reflector role: Proceeding after FAE Table");
-		cs_set_state(sm, CS_STATE_INIT);
-	}
+	memset(&tmp_ev, 0, sizeof(tmp_ev));
+	tmp_ev.handle = evt->handle;
+	rap_send_hci_def_settings_command(sm, &tmp_ev);
 }
 
 static bool bt_rap_read_remote_fae_table(void *hci_sm, uint16_t handle)
@@ -821,7 +802,6 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	uint16_t subfeatures_supported;
 
@@ -871,18 +851,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	m = find_mapping_by_handle(sm, evt->handle);
-
-	if (is_initiator_role(sm) ||
-	    (is_both_role(sm) && m && m->is_central)) {
-		DBG("Init/Both: send def settings for 0x%04X",
-			evt->handle);
-		rap_send_hci_def_settings_command(sm, evt);
-	} else {
-		DBG("Reflector role: send def settings cmd");
-		cs_set_state(sm, CS_STATE_INIT);
-		rap_send_hci_def_settings_command(sm, evt);
-	}
+	DBG("send def settings for 0x%04X", evt->handle);
+	rap_send_hci_def_settings_command(sm, evt);
 }
 
 static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
@@ -1844,6 +1814,18 @@ bool bt_rap_stop_measurement(void *hci_sm)
 		return false;
 	}
 
+	/* With no procedure running - a Reflector still waiting for the
+	 * Initiator, or a timeout left over from an earlier measurement -
+	 * there is nothing to disable, and the Controller answers Procedure
+	 * Enable with Invalid HCI Command Parameters. A procedure that is
+	 * being enabled has not reported yet, so still disable that one.
+	 */
+	if (!sm->procedure_active &&
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+		DBG("No local CS procedure active, nothing to disable");
+		return true;
+	}
+
 	return rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
 						false);
 }
-- 
2.43.0

