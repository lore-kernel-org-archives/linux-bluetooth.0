Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E2286881
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808078; cv=none; b=HoJ/SInhdL3qoC7dnc5X8ao51JDT0/a/DwBZLDL8yDsOFekcuOfil1lW8O+dfoM+fmn3orV3t2yO7zNqKay396oJjro0dDZkUoib6oPZMfxEXTq8srwSPxGAl7OkzE9Hb5rH7LUnEchnbMGzC5D6kqbWlYYwvhpF+jXhH66yPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808078; c=relaxed/simple;
	bh=IJxK4K8BsH+xZgKr+lcettXPycQOe87pG6mnrRR5OOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rv3GRVXkDujDEVCUHtr0buY7XcRDKpYkz9qSFTqnei3GhDOvF50oByjCiIIEpacwwQly1iMJUiLyZB+iVAJCK2I39RIWpn8L+ASPvnx3E9ubg24dTJQOzsc3Tq+o7um1UwYGcwK1TTaNpWz9NohPALp+Zc5uftPmPFYkaiXM52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGA+As7f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IUsym2tH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGA+As7f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUsym2tH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3J5tH2632692
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7SWIFnNnuBf
	f/wXDRhUrvTv/juLMEKVgZD/OScqiSHY=; b=FGA+As7fqffHJWNP4gR/5Syr4wr
	yB5kgEGbFby1WVpa6HKKFzulMmPBZxw7EVjEcnhzOOPu1Nprf9TisWVgqKY/u0ha
	s4mMd+pDFBJVRtUNw0K9txs2xRQ2XplIvVmQXcMuC7JpBdKdzYzbU+KqaEOMYYNR
	tJLdB1Cy8tUzdvYy3rwOyRodk3NFp/xqeN3QYAZeKuEqUJuAitgJLCOC/GI3bjmM
	3kcyyFUQqhq7B+EX+Zz5wx5JSbQOq5PF2jM8Ex10W8fT3MzV3zWaDWOpGdiyxe4+
	piVmt4eHsAy2xvjKb2RESwhArOjBqLXsuJ1Nmh/bk9GuLhPLrQICRnd8pOw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03abakc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3252799a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808074; x=1788412874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SWIFnNnuBff/wXDRhUrvTv/juLMEKVgZD/OScqiSHY=;
        b=IUsym2tHKHp+nVRa7bZW/N2b7loTQlvnx+YK81IvuV6wlE8L/xeFmVOCXiDBKeRUnc
         G9ysWDgo3ZBiLEaWGg926ifL1UM2636GBLCOgfh3DMHkslMkGsdiFkhi7IvxWzYzmL5q
         cSZywOHYOtqGgf21/oKJi7debOsOM22wTkaOJjKnGY6HobMgoioEUJo4W2lnL07KaBPy
         F6hhbKb9v/dwKIw/OqOi27jYS6KPK5ahriKV2KL9MpOtmcK3S7OcWb5EmglNvemK7Tbn
         hmzB3bBFKQrQSsQR9dYVwrdYxHJYUGkFy8RhlbSj+1jeuqAYfQYSWWD21AStNRxGfee8
         Tvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808074; x=1788412874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7SWIFnNnuBff/wXDRhUrvTv/juLMEKVgZD/OScqiSHY=;
        b=aYL0RTo4ODoW2b4zKDHfwcyWZlKRo39x/sVa+AHYbZWCfNNd5J+mIN7K/5ZrLe+5ZT
         3jmzgzUDtwj/XYga/P+xYuhYgvoMg0Vx9NjmXrveNZezk8Kb6MhR/97FUO3Fo0MrdYp+
         IAywXjD/qHDSHgEoeC059u+IiDOutrsrPgAqeBshF/wYrCX+8XGQOh3w0xW3w7sDd1I6
         ar0QYodVpJUMcPArZ61kMSe5gr2XsrGQwItDEELmKEBi0gXQNrkSMPr/eRgIgGdBKl4R
         cPEiV7G9VTDKzMHl0bexHjwmuDq4AkT6NhSmzTv1PrNh+m61RcwRrUxMuEOxrWOQvWIb
         ZQug==
X-Gm-Message-State: AFuF++nQkmozKIUmX8Z+TeZR+0ZufwJWkBwnAjQ+ALJh75Ywg87OLyYI
	d3UN3vLX8Od2piee7eiJO8Q6nKojorTfYAI/zyzOgqJ5phGUNgDwbu5O5OM/zOR0/lw7AwYmuX/
	FMsXbmjxUeHyAksFH7nMBuw9/FwY7zqpWhaSMWlDR44oFkfNRmZiBMh/qUSrIxUVjB8jJang4VX
	CFtuI=
X-Gm-Gg: AR+sD11qPY+9PFLtaXZ1oVVmKoQfTlQF361JJ2wLzb9+ZB7neigEEdvNpdFf/vIpv56
	Du5bh7YkVk3noStmK9Uqxb4oZQ9o/7q6gl4Y8DPJHHOPe5wm2mIRhwja4hYq5qIQdCcLEN1wtHy
	PT8nRFe4hdhcfVFQpgumkYKZlUueG630+3kL16Jw5CD6xE0M52BoyhAGJ82VJyZJkvld1LyLwdD
	fo29hF5eN0+kT4vVXHnL0Aa7Y46gcLOPw7IFbOLZVSw46HPIDOsra5K1Putyl3HIhjEBCOSGrdH
	HQE3oE53z1KN3swoVyeUgJtJjfzLHl6pMbMYk8FjiOyo+2rWAgFfpV8e24kCKA6I2g9rM8uBLNW
	kDiF/g+i2tVEI8F0A4IqoDKeyk47B+Q==
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-3966d13a242mr23350869a91.1.1787808073572;
        Wed, 26 Aug 2026 22:21:13 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-3966d13a242mr23350786a91.1.1787808072915;
        Wed, 26 Aug 2026 22:21:12 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:21:12 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 6/7] client: Add ranging distance display support to bluetoothctl
Date: Thu, 27 Aug 2026 10:50:33 +0530
Message-Id: <20260827052034.1374180-7-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0wv5I7ngWzXGlE4_ocPlKeb4Kq02z1Bd
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fc94a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=2Whrhm8mgv77n_J-a98A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 0wv5I7ngWzXGlE4_ocPlKeb4Kq02z1Bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX5eA3+SQ/yFmO
 gEXHHHJweTfwP9rE4HLZYhYkBNedb15VLZYq53FJauNRKhoMBpKn7YGiYd75/OI7Xnln3xT48Ff
 xb8m3NDiJGqfyX0aXbSnIkTVey2qNyqeh3e8rJITIjVmd4CnNHUPHYIzaeGg6RlD2k6NfvGoGir
 g8O88+LXsZrqRPzgs1I6/Z5G+MC0B+nyzRxX4SJL9nLVu0iIF5q2o6x6ZhTkY5qWrAnKor5omzC
 AGDjakpvzyHHGmxXOyUjIQM/wKFmHm4M0fyxDSCd0AK0pLkj07Axr9TqUkXx4PNf2/P+/jYKDPh
 83thfDG+IX53BxrvJYOiFAHYBSN+uOu5ylaXxZO0BIu3WC4Br6RQ38xF92saRSS9x7UL5LLt5dk
 aiJvAmMTtmn5vwMnppCi3StY4XBI8HtL9FDXuD5XYiYa9SqgIcw8Qq8NZmNpG+YiwfoJfJdRbcj
 notzs6MjRo+h1JsIvhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX6uTNbezbJOxU
 LwFZnF5YLfftVtGYVpRDAJip4Pqamob2/Nqhqlpw9GgsmTQPULlAf6JUoIo1X7+tnYO+6omjSI4
 LvkMOjEFztzhufUxhjk9xhGNRYuCqhU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270040

Track org.bluez.Ranging proxies and append/remove them
on InterfacesAdded/InterfacesRemoved.

Print the Distance property on PropertiesChanged,
and show it under info option alongside the existing
Battery Percentage and CS Active properties.

Add register-provider and unregister-provider options
as reference implementation.
---
 client/cs.c   | 514 +++++++++++++++++++++++++++++++++++++++++++++++++-
 client/cs.h   |   6 +
 client/main.c |  58 ++++++
 3 files changed, 577 insertions(+), 1 deletion(-)

diff --git a/client/cs.c b/client/cs.c
index 9f069589d..8c9187678 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -303,7 +303,7 @@ static const char *cs_resolve_address(const char *address)
 }
 
 /* Find the ChannelSounding1 proxy for the device at the given object path. */
-static GDBusProxy *cs_find_proxy(const char *dev_path)
+GDBusProxy *cs_find_proxy(const char *dev_path)
 {
 	GDBusProxy *proxy;
 	const char *path;
@@ -342,6 +342,487 @@ static struct cs_session *cs_find_session(GDBusProxy *proxy)
 	return NULL;
 }
 
+/* ---- Ranging provider (reference implementation) ----
+ *
+ * Registers bluetoothctl itself as a Channel Sounding ranging provider
+ * (org.bluez.RangingProviderManager1 / org.bluez.RangingProvider1) purely
+ * to illustrate how a third-party ranging daemon hooks into ProcedureData
+ * and reports a distance; the value computed below is a simple, bounded
+ * placeholder, not a real ranging algorithm. See
+ * test/example-ranging-provider for a standalone daemon built the same way.
+ *
+ * The provider root path defaults to "/" because bluetoothctl only attaches
+ * a D-Bus ObjectManager at "/" (see g_dbus_attach_object_manager() in
+ * main()); bluetoothd's RegisterRangingProvider watches the exact path it
+ * is given via GetManagedObjects()/InterfacesAdded, so any other path would
+ * silently never be discovered.
+ */
+
+#define RANGING_PROVIDER_INTERFACE	    "org.bluez.RangingProvider1"
+#define CS_PROCEDURE_DATA_INTERFACE	    "org.bluez.ChannelSounding1"
+#define DEFAULT_PROVIDER_PATH		    "/"
+
+struct cs_ranging_obj {
+	char *path;		/* exported RangingProvider object path */
+	char *dev_path;		/* Device this estimate applies to */
+	uint32_t distance_mm;
+	bool has_value;
+};
+
+static DBusConnection *cs_conn;
+static GDBusProxy *cs_ranging_manager;
+static char *cs_provider_path;
+static char *cs_pending_provider_path;
+static guint cs_procedure_data_watch;
+static GList *cs_ranging_objs;
+
+void cs_set_dbus_conn(DBusConnection *conn)
+{
+	cs_conn = conn;
+}
+
+void cs_ranging_manager_added(GDBusProxy *proxy)
+{
+	cs_ranging_manager = proxy;
+}
+
+void cs_ranging_manager_removed(GDBusProxy *proxy)
+{
+	if (cs_ranging_manager == proxy)
+		cs_ranging_manager = NULL;
+}
+
+static struct cs_ranging_obj *cs_find_ranging_obj(const char *dev_path)
+{
+	struct cs_ranging_obj *obj;
+	GList *list;
+
+	for (list = g_list_first(cs_ranging_objs); list;
+	     list = g_list_next(list)) {
+		obj = list->data;
+
+		if (!strcmp(obj->dev_path, dev_path))
+			return obj;
+	}
+
+	return NULL;
+}
+
+static gboolean ranging_obj_device_get(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct cs_ranging_obj *obj = data;
+	const char *path = obj->dev_path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static gboolean ranging_obj_distance_get(const GDBusPropertyTable *property,
+					 DBusMessageIter *iter, void *data)
+{
+	struct cs_ranging_obj *obj = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+					&obj->distance_mm);
+
+	return TRUE;
+}
+
+static gboolean ranging_obj_distance_exists(const GDBusPropertyTable *property,
+					    void *data)
+{
+	struct cs_ranging_obj *obj = data;
+
+	return obj->has_value;
+}
+
+static const GDBusPropertyTable ranging_obj_properties[] = {
+	{ "Device", "o", ranging_obj_device_get },
+	{ "Distance", "u", ranging_obj_distance_get, NULL,
+		ranging_obj_distance_exists },
+	{ }
+};
+
+static void cs_ranging_obj_free(struct cs_ranging_obj *obj)
+{
+	if (cs_conn)
+		g_dbus_unregister_interface(cs_conn, obj->path,
+					     RANGING_PROVIDER_INTERFACE);
+
+	g_free(obj->path);
+	g_free(obj->dev_path);
+	g_free(obj);
+}
+
+static void cs_ranging_objs_clear(void)
+{
+	g_list_free_full(cs_ranging_objs, (GDestroyNotify)cs_ranging_obj_free);
+	cs_ranging_objs = NULL;
+}
+
+static struct cs_ranging_obj *cs_ranging_obj_create(const char *dev_path)
+{
+	struct cs_ranging_obj *obj;
+	const char *leaf;
+
+	leaf = strrchr(dev_path, '/');
+	leaf = leaf ? leaf + 1 : dev_path;
+
+	obj = g_new0(struct cs_ranging_obj, 1);
+	obj->dev_path = g_strdup(dev_path);
+
+	if (!strcmp(cs_provider_path, "/"))
+		obj->path = g_strdup_printf("/%s", leaf);
+	else
+		obj->path = g_strdup_printf("%s/%s", cs_provider_path, leaf);
+
+	if (!g_dbus_register_interface(cs_conn, obj->path,
+					RANGING_PROVIDER_INTERFACE, NULL, NULL,
+					ranging_obj_properties, obj, NULL)) {
+		bt_shell_printf("Failed to register %s on %s\n",
+				RANGING_PROVIDER_INTERFACE, obj->path);
+		g_free(obj->dev_path);
+		g_free(obj->path);
+		g_free(obj);
+		return NULL;
+	}
+
+	cs_ranging_objs = g_list_append(cs_ranging_objs, obj);
+
+	return obj;
+}
+
+/* Round-Trip Time distance estimation from Channel Sounding data.
+ *
+ * See doc/org.bluez.ChannelSounding1.rst for the ProcedureData binary
+ * layout parsed below; it mirrors profiles/ranging/rap.c's serializer.
+ */
+
+#define CS_STEP_MODE_ONE		0x01
+#define CS_STEP_MODE_TWO		0x02
+#define CS_STEP_MODE_THREE		0x03
+#define CS_RTT_NOT_AVAILABLE		((int16_t)0x8000)
+#define CS_MAX_ANT_PATHS		5
+
+static bool blob_check(int len, size_t off, size_t need)
+{
+	if (len < 0 || off > (size_t)len)
+		return false;
+
+	return need <= (size_t)len - off;
+}
+
+static bool parse_step_rtt(const uint8_t *data, int len, size_t *off,
+				uint8_t num_ant_paths, int64_t *sum,
+				int *count)
+{
+	uint8_t step_mode;
+	size_t mode_len;
+	int paths;
+
+	if (!blob_check(len, *off, 2))
+		return false;
+
+	step_mode = data[*off];
+	*off += 2;
+
+	paths = num_ant_paths + 1;
+	if (paths > CS_MAX_ANT_PATHS)
+		paths = CS_MAX_ANT_PATHS;
+
+	switch (step_mode) {
+	case CS_STEP_MODE_ONE:
+		mode_len = 16;
+		break;
+	case CS_STEP_MODE_TWO:
+		mode_len = 1 + paths * 5;
+		break;
+	case CS_STEP_MODE_THREE:
+		mode_len = 16 + 1 + paths * 5;
+		break;
+	default:
+		mode_len = 5;	/* CS Mode 0 */
+		break;
+	}
+
+	if (!blob_check(len, *off, mode_len))
+		return false;
+
+	if (step_mode == CS_STEP_MODE_ONE || step_mode == CS_STEP_MODE_THREE) {
+		int16_t toa_tod_init = (int16_t)get_le16(data + *off + 3);
+		int16_t tod_toa_refl = (int16_t)get_le16(data + *off + 5);
+
+		if (toa_tod_init != CS_RTT_NOT_AVAILABLE &&
+				tod_toa_refl != CS_RTT_NOT_AVAILABLE) {
+			*sum += (int64_t)toa_tod_init - tod_toa_refl;
+			(*count)++;
+		}
+	} else if (step_mode == CS_STEP_MODE_TWO) {
+		/* Mode 2 (PBR-only) steps carry no RTT timestamps at all, so
+		 * this is NOT a real distance measurement -- it's a bounded
+		 * random filler value, purely so PBR-only procedures still
+		 * report *something*. Mixing it into the same sum/count as
+		 * genuine Mode 1/3 RTT samples means the resulting average
+		 * is only a true RTT distance when every contributing step
+		 * is Mode 1/3; any Mode 2 step in the mix makes the overall
+		 * estimate inexact.
+		 */
+		*sum += rand() % 100;
+		(*count)++;
+	}
+
+	*off += mode_len;
+
+	return true;
+}
+
+static bool parse_subevent_array_rtt(const uint8_t *data, int len,
+				size_t *off, int64_t *sum, int *count)
+{
+	uint32_t num_subevents;
+	uint32_t i;
+
+	if (!blob_check(len, *off, 4))
+		return false;
+
+	num_subevents = get_le32(data + *off);
+	*off += 4;
+
+	for (i = 0; i < num_subevents; i++) {
+		uint8_t num_ant_paths;
+		uint32_t num_steps;
+		uint32_t j;
+
+		if (!blob_check(len, *off, 19))
+			return false;
+
+		num_ant_paths = data[*off + 5];
+		num_steps = get_le32(data + *off + 15);
+		*off += 19;
+
+		for (j = 0; j < num_steps; j++) {
+			if (!parse_step_rtt(data, len, off, num_ant_paths,
+							sum, count))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/* Ticks are 0.5 ns units; one-way distance (mm) = ticks * 0.5e-9 s *
+ * speed_of_light (mm/s) / 2. Kept in fixed-point (1e7 scale) to avoid
+ * pulling in libm for a single rounded multiply.
+ */
+static uint32_t cs_rtt_ticks_to_mm(int64_t sum, int count)
+{
+	int64_t ticks = sum / count;
+
+	if (ticks < 0)
+		ticks = 0;
+
+	return (uint32_t)((ticks * 749481145LL + 5000000LL) / 10000000LL);
+}
+
+static gboolean procedure_data_cb(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	const char *dev_path = dbus_message_get_path(message);
+	struct cs_ranging_obj *obj;
+	DBusMessageIter iter, array;
+	uint8_t *data = NULL;
+	int len = 0;
+	int64_t sum = 0;
+	int count = 0;
+
+	if (!dbus_message_iter_init(message, &iter) ||
+	    dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return TRUE;
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &data, &len);
+
+	/* ProcedureData header is procedure_counter (2), procedure_sequence
+	 * (2), initiator/reflector selected_tx_power (1 each), followed by
+	 * the initiator- and reflector-side subevent arrays (each preceded
+	 * by a le32 count and followed by a 1-byte abort reason). Average
+	 * every Mode 1/3 RTT sample found on either side; malformed or
+	 * truncated data just yields no samples for this procedure.
+	 */
+	if (blob_check(len, 6, 0)) {
+		size_t off = 6;
+
+		if (parse_subevent_array_rtt(data, len, &off, &sum, &count) &&
+				blob_check(len, off, 1)) {
+			off += 1;
+			parse_subevent_array_rtt(data, len, &off, &sum,
+							&count);
+		}
+	}
+
+	obj = cs_find_ranging_obj(dev_path);
+	if (!obj) {
+		obj = cs_ranging_obj_create(dev_path);
+		if (!obj)
+			return TRUE;
+	}
+
+	if (!count)
+		return TRUE;
+
+	obj->distance_mm = cs_rtt_ticks_to_mm(sum, count);
+	obj->has_value = true;
+
+	bt_shell_printf("Reference ranging provider: %s Distance %.1f cm"
+			" (RTT estimate from %d CS step%s, %d-byte"
+			" ProcedureData)\n",
+			dev_path, obj->distance_mm / 10.0, count,
+			count == 1 ? "" : "s", len);
+
+	g_dbus_emit_property_changed(cs_conn, obj->path,
+				      RANGING_PROVIDER_INTERFACE, "Distance");
+
+	return TRUE;
+}
+
+static void cs_provider_cleanup(void)
+{
+	if (cs_procedure_data_watch) {
+		g_dbus_remove_watch(cs_conn, cs_procedure_data_watch);
+		cs_procedure_data_watch = 0;
+	}
+
+	cs_ranging_objs_clear();
+
+	g_free(cs_provider_path);
+	cs_provider_path = NULL;
+}
+
+static void register_provider_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = cs_pending_provider_path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void register_provider_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("RegisterRangingProvider failed: %s\n",
+				error.message);
+		dbus_error_free(&error);
+		g_free(cs_pending_provider_path);
+		cs_pending_provider_path = NULL;
+		return;
+	}
+
+	cs_provider_path = cs_pending_provider_path;
+	cs_pending_provider_path = NULL;
+
+	cs_procedure_data_watch = g_dbus_add_signal_watch(cs_conn, NULL, NULL,
+					CS_PROCEDURE_DATA_INTERFACE,
+					"ProcedureData", procedure_data_cb,
+					NULL, NULL);
+
+	bt_shell_printf("Ranging provider registered at %s (reference"
+			" implementation, see test/example-ranging-provider)\n",
+			cs_provider_path);
+}
+
+static void cmd_cs_register_provider(int argc, char *argv[])
+{
+	if (!cs_conn) {
+		bt_shell_printf("D-Bus connection not ready\n");
+		return;
+	}
+
+	if (!cs_ranging_manager) {
+		bt_shell_printf("No RangingProviderManager interface"
+				" available\n");
+		return;
+	}
+
+	if (cs_provider_path) {
+		bt_shell_printf("Ranging provider already registered at"
+				" %s\n", cs_provider_path);
+		return;
+	}
+
+	if (cs_pending_provider_path) {
+		bt_shell_printf("Ranging provider registration already in"
+				" progress\n");
+		return;
+	}
+
+	cs_pending_provider_path = g_strdup(argc >= 2 ? argv[1] :
+						DEFAULT_PROVIDER_PATH);
+
+	if (strcmp(cs_pending_provider_path, DEFAULT_PROVIDER_PATH))
+		bt_shell_printf("Note: bluetoothctl only exposes an"
+				" ObjectManager at \"/\"; a provider path"
+				" other than \"/\" will register but"
+				" bluetoothd will not discover any"
+				" RangingProvider objects under it\n");
+
+	if (!g_dbus_proxy_method_call(cs_ranging_manager,
+					"RegisterRangingProvider",
+					register_provider_setup,
+					register_provider_reply, NULL, NULL)) {
+		bt_shell_printf("Failed to send RegisterRangingProvider\n");
+		g_free(cs_pending_provider_path);
+		cs_pending_provider_path = NULL;
+	}
+}
+
+static void unregister_provider_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = cs_provider_path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void unregister_provider_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("UnregisterRangingProvider failed: %s\n",
+				error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	bt_shell_printf("Ranging provider unregistered\n");
+	cs_provider_cleanup();
+}
+
+static void cmd_cs_unregister_provider(int argc, char *argv[])
+{
+	if (!cs_provider_path) {
+		bt_shell_printf("No ranging provider is registered\n");
+		return;
+	}
+
+	if (!cs_ranging_manager) {
+		bt_shell_printf("No RangingProviderManager interface"
+				" available\n");
+		return;
+	}
+
+	if (!g_dbus_proxy_method_call(cs_ranging_manager,
+					"UnregisterRangingProvider",
+					unregister_provider_setup,
+					unregister_provider_reply, NULL,
+					NULL))
+		bt_shell_printf("Failed to send UnregisterRangingProvider\n");
+}
+
 /* ---- dict helpers ---- */
 
 static void dict_append_byte(DBusMessageIter *dict, const char *key,
@@ -969,6 +1450,25 @@ static const struct bt_shell_menu cs_menu = {
 				cmd_cs_show,
 				"Show active session id and current"
 				" CS parameters" },
+	{ "register_provider", "[path]",
+				cmd_cs_register_provider,
+				"Reference implementation only: registers"
+				" bluetoothctl itself as a Channel Sounding"
+				" ranging provider (RegisterRangingProvider),\n"
+				"\t\t\t\t\t\tthen turns each ProcedureData signal into"
+				" an illustrative, non-accurate distance"
+				" exposed via RangingProvider/Ranging.\n"
+				"\t\t\t\t\t\tpath shall be /org/bluez/hci0/dev_XX\n"
+				"\t\t\t\t\t\tsee test/example-ranging-provider for a"
+				" realistic standalone daemon.\n\t\t\t\t\t\tOnly one"
+				" provider may be registered per adapter at"
+				" a time; fails with AlreadyExists if a real"
+				" ranging daemon is already registered, and"
+				" vice versa."},
+	{ "unregister_provider", NULL,
+				cmd_cs_unregister_provider,
+				"Unregister the ranging provider registered"
+				" via register_provider" },
 	{ "role", "<0x01|0x02|0x03>", cmd_cs_set,
 				"CS role: 0x01 Initiator, 0x02 Reflector,"
 				" 0x03 Both (default 0x03)",
@@ -1075,10 +1575,22 @@ void cs_add_submenu(void)
 }
 
 void cs_remove_submenu(void)
+{
+	cs_disconnected();
+}
+
+void cs_disconnected(void)
 {
 	g_list_free_full(cs_sessions, g_free);
 	cs_sessions = NULL;
 
 	g_list_free(cs_proxies);
 	cs_proxies = NULL;
+
+	cs_ranging_manager = NULL;
+
+	g_free(cs_pending_provider_path);
+	cs_pending_provider_path = NULL;
+
+	cs_provider_cleanup();
 }
diff --git a/client/cs.h b/client/cs.h
index 243d2a72b..10e7bbeeb 100644
--- a/client/cs.h
+++ b/client/cs.h
@@ -9,10 +9,16 @@
 
 void cs_add_submenu(void);
 void cs_remove_submenu(void);
+void cs_disconnected(void);
 
 void cs_proxy_added(GDBusProxy *proxy);
 void cs_proxy_removed(GDBusProxy *proxy);
+GDBusProxy *cs_find_proxy(const char *dev_path);
 void cs_device_disconnected(const char *dev_path);
 void cs_measurement_started(GDBusProxy *proxy);
 void cs_measurement_stopped(GDBusProxy *proxy);
 void cs_set_device_list(GList **devices);
+
+void cs_ranging_manager_added(GDBusProxy *proxy);
+void cs_ranging_manager_removed(GDBusProxy *proxy);
+void cs_set_dbus_conn(DBusConnection *conn);
diff --git a/client/main.c b/client/main.c
index 069e20485..c4d9a4022 100644
--- a/client/main.c
+++ b/client/main.c
@@ -69,6 +69,7 @@ static char *default_local_attr;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *battery_proxies;
+static GList *ranging_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -121,11 +122,14 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	g_list_free_full(battery_proxies, proxy_leak);
+	g_list_free_full(ranging_proxies, proxy_leak);
 	ctrl_list = NULL;
 	battery_proxies = NULL;
+	ranging_proxies = NULL;
 
 	default_ctrl = NULL;
 	cs_set_device_list(NULL);
+	cs_disconnected();
 }
 
 static void print_adapter(GDBusProxy *proxy, const char *description)
@@ -358,6 +362,30 @@ static void battery_removed(GDBusProxy *proxy)
 	battery_proxies = g_list_remove(battery_proxies, proxy);
 }
 
+static void ranging_added(GDBusProxy *proxy)
+{
+	ranging_proxies = g_list_append(ranging_proxies, proxy);
+}
+
+static void ranging_removed(GDBusProxy *proxy)
+{
+	ranging_proxies = g_list_remove(ranging_proxies, proxy);
+}
+
+static void print_distance_cm(GDBusProxy *proxy, const char *label)
+{
+	DBusMessageIter iter;
+	dbus_uint32_t mm;
+
+	if (g_dbus_proxy_get_property(proxy, "Distance",
+						&iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &mm);
+
+	bt_shell_printf("\t%s: %.1f cm\n", label, mm / 10.0);
+}
+
 static void device_added(GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -531,6 +559,12 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		bearer_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
 		cs_proxy_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.Ranging1")) {
+		ranging_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.RangingProviderManager1")) {
+		if (default_ctrl && !strcmp(g_dbus_proxy_get_path(proxy),
+				g_dbus_proxy_get_path(default_ctrl->proxy)))
+			cs_ranging_manager_added(proxy);
 	}
 }
 
@@ -664,6 +698,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		bearer_removed(proxy);
 	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
 		cs_proxy_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.Ranging1")) {
+		ranging_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.RangingProviderManager1")) {
+		cs_ranging_manager_removed(proxy);
 	}
 }
 
@@ -843,6 +881,13 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			else
 				cs_measurement_stopped(proxy);
 		}
+	} else if (!strcmp(interface, "org.bluez.Ranging1")) {
+		if (!strcmp(name, "Distance")) {
+			const char *path = g_dbus_proxy_get_path(proxy);
+			const char *leaf = strrchr(path, '/');
+
+			print_distance_cm(proxy, leaf ? leaf + 1 : path);
+		}
 	}
 }
 
@@ -1882,6 +1927,8 @@ static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	GDBusProxy *battery_proxy;
+	GDBusProxy *cs_proxy;
+	GDBusProxy *ranging_proxy;
 	GDBusProxy *bearer;
 	DBusMessageIter iter;
 	const char *address;
@@ -1934,6 +1981,16 @@ static void cmd_info(int argc, char *argv[])
 	print_property_with_label(battery_proxy, "Percentage",
 					"Battery Percentage");
 
+	cs_proxy = cs_find_proxy(g_dbus_proxy_get_path(proxy));
+	if (cs_proxy)
+		print_property_with_label(cs_proxy, "Active",
+				"CS Session Active");
+
+	ranging_proxy = find_proxies_by_path(ranging_proxies,
+				g_dbus_proxy_get_path(proxy));
+	if (ranging_proxy)
+		print_distance_cm(ranging_proxy, "Ranging Distance");
+
 	bearer = find_proxies_by_iface(default_ctrl->bearers,
 				      g_dbus_proxy_get_path(proxy),
 				      "org.bluez.Bearer.BREDR1");
@@ -4050,6 +4107,7 @@ int main(int argc, char *argv[])
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	g_dbus_attach_object_manager(dbus_conn);
+	cs_set_dbus_conn(dbus_conn);
 
 	bt_shell_set_env("DBUS_CONNECTION", dbus_conn);
 
-- 

