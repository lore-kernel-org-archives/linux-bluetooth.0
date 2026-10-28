Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169973;
	b=Pg9rU03Z29od5vxoW6+7yuhMpPsoQ8NBCmrO96BtyWxe2j31jRxYW2S+bfC9u98+B9AG
	 8SpIyCpZRhsIeUfZfBycC/suiCHsECm8tPJeqgkiNDQvHEE0S74CvcMCRY3GCuUnENG0j
	 /Jhntd/pZg76j6DxnudPZBa+xPTyLYd9RZPWW6gAgZnSoP45VcFH2H4syvQbSjWyIGZah
	 ryTUgRK34Z7k0Pb+epIvGsE+FYgoXXJ1wN7unCQdf1ZgiW0lOjn87UJ0xM46N5aldqegi
	 //IER7HUZaoaNY339fi+UDQbLCe4vAvoFg1RRD1OW6TrNDVFMEkm+97EA0+cPz+TdMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ikrSiZhzBMBxrmeIgAuxyX+6kJMDsb1nA1v3nDc7WPI=;
	b=Z1fBj6tiCYwo70XePNavL+RNRZiNiIXcHlpIggnBcBmzkB0kb8778g0uKsKacfHt758m
	 nW/ahXAwvt3c90Dy884BS334Ib9MNegiDrAhEH/gN4P8DxZjKAX7d43Xs88UFXiNGENhd
	 csvoMSmO2pt3ZAOr6hh/cC8cMbkaV4L0irQOpkwGqWxJIgsPYSccnK5FpvPp1TadmIxLr
	 8qyWqlDnUikiMonEo0Dc+NYv+/bof8mdq8qaDKnNUcT381gtrxZLcvciyGuN9yqYfcoi3
	 ybxS801+IEnbK+uUribvnn4vSSlU7VIaZ7nb6CdT9FdLmBD3LypIcPSw3W9mReuMQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B31gd0kp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5gHGLxG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE6606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1AE6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B31gd0kp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5gHGLxG
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4PTE9587912
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ikrSiZhzBMBxrmeIgAuxyX+6kJMDsb1nA1v3nDc7WPI=; b=B31gd0kpNmEGnRRU
	NB8I+iZAv4htc9GUFcnw6SgSE4/pi1gClYl4sSxXmo5fPu2EH54Moe/KebBDTdOe
	/j+QY/1ah8TAyrtP6tnkgAVcXeFH4Bqz/RfEwzwqVtXEYYr/yRTV868LfFSKv94c
	PIV7QyugRhmq7fhmeOrzgxw5IP57MbLNKxPHBykZpDs+1sL7bqGPjh+fr8cRBwl9
	Hb3oT21YXkghl9mUzUtsstTYn/X+ayG9BQUI4ABsrJJrAMqUowq0ovTRg1nmijFG
	d+HDOE+qWfqvyx6bQQ+PX1yyE+KkWR//Z7ncqKdur+3FSFaLCL3heMj4ev2XcYtQ
	SygaeQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk2qe1wgx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:06 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80a67aa4e52so149740a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793169966; x=1793774766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikrSiZhzBMBxrmeIgAuxyX+6kJMDsb1nA1v3nDc7WPI=;
        b=W5gHGLxGzaAGR9iUdxCirK7WeF/nWPTJYrj9cJu+nNA+8ZpybKu3X5iwyuPXc0g5qa
         4ht5CJ24RMTu5EAsecWDbZQya9aVPBnLBPgDfh6vVxEZZjzF+vjcBc3SR0jK8BnxLxiC
         MFVXXRZCtDyk1fUPs8QdGN+I+9IVYiX9d/Lo4GVL0eJbe+vK5Cn1XThr5SLnwFVKCn6d
         nTxacPQ066qgFV3vGdLXkYwNqPS8BZsPy4AtLlSmOv1YAN30eD4pBvgK9GIEu2GY9lJT
         1gGgQQzKx2AsxAZ+P7GyJbcF1Oz3i0fMY4OjC/OVA+qCx87jeQyd7jrnQu/JE58+c1Gi
         CY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793169966; x=1793774766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikrSiZhzBMBxrmeIgAuxyX+6kJMDsb1nA1v3nDc7WPI=;
        b=PMl6TEb/Ggz0AcIBvgp5P8Ss7dcUn0lsHn8VrL1cGC1C6UOMBCSS/PnuilyVAhRFnZ
         0heohOeaYhklJEdiwfG4zL87l+X6URDxQCLS94HsuNSDtzzcvQ3lswY1+oQxom1aOVa5
         Ct5gRURYbXccbJm3CZxva8tC3P15O2F0zhKou8FSmmodZBDlFXCYkkBFIPmJ37zXFEsN
         o19jeRsqTkKEEEJlaoOeH9oinHuLh88GvAEhHLAOenjRdtnhpzs2n5yU+6yHhfs4/Xeg
         lrMBwjhU+6vbPjmqzItN7J7GzRmepUseP5iwL0XkfFxNjlu6SyMa3Vklc0+FyRMhsj6C
         OhsA==
X-Forwarded-Encrypted: i=1; AKwUvBwqxuxGB2BdVGmf++v4FpClh7/0M83hhygdAytgeWyMSSE/25rnozT3q5g5Gu5NwyGInP8x9XYAnq3IzEEy0rg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5GT0OgppuSRrSnKlZwOVI0Xj/0cCPYPKm4ykN1iG8UkMfn9H6
	fFv4jEJnv11pngXos5W/PeHHJ6tgzd1M7+s5Z3M7Ct97QVRTBxPzGFyDSKZeZ/e/0cDxey9jSxD
	3y7bQVdhnGcI0qW/mCZPL07bwiwk7sg8mvYLdZPw7ynlL1jX//t7B1IDcm50Z5AYFqiqXBbQ=
X-Gm-Gg: AYBFou3SqqkZNeTktWQ27U59DKgYGuBtdZXnyQqK60ngc1mnJDXBoSFQZmG8m5rct6q
	5W0onfjMfklKxPw6meZtduA3MoBtNVJfK/+yDYjNq+xiQmUBAiFOjKugim0KLr8jWHGjr8ui1Ob
	FGO+6McTAz/rjsk6/UlIhzdeQCiU0N215Daon/fOf4Q/XO7wkVfs7RNA7sWTqJ3GLrz+97/iiAS
	Wri886oqmvcosCsyKecjTvpoenclOUJdVBiJw5Ynivov1DZlxg6+Ay5JzRhgfEMuzTXQexSDzGl
	yToLml5w+GF8xaTyDBzslzyVlYkJRxv7984+CqXXHCUSQddHuHlld7bNIyRu1vImViJdZ7E1bYI
	KXytWkb7NaiCkJmcKbfMr6PeNeOUVw4+3a0I0lkU1hu/RPs0rgIMkZhj8QfHhBLXhANjy96+nGP
	DOyLApInB1roNxYYkscYju
X-Received: by 2002:a05:6830:1214:b0:805:98ae:2160 with SMTP id 46e09a7af769-85ab97782d5mr1620823a34.2.1793169965788;
        Tue, 27 Oct 2026 23:46:05 -0700 (PDT)
X-Received: by 2002:a05:6830:1214:b0:805:98ae:2160 with SMTP id 46e09a7af769-85ab97782d5mr1620806a34.2.1793169965358;
        Tue, 27 Oct 2026 23:46:05 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd30d98sm860727a34.14.2026.10.27.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:46:04 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 23:45:50 -0700
Subject: [PATCH bluez 1/2] obexd/bluetooth: Register profiles added after
 org.bluez appeared
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fix_obex-v1-1-3d91aed181b6@oss.qualcomm.com>
References: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
In-Reply-To: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: KUBdWJZGkuFljljw6YkU9HZQlAGBqdAI
X-Authority-Analysis: v=2.4 cv=YuGa1IYX c=1 sm=1 tr=0 ts=6ae19a2e cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=R3qYbWmKcKoroIU813UA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX4YgDuY9iJri5
 o1HsvrfwiA4sggHcoj0gaIGbrUNy9mfIgV9lyyDBF32ElaDy76q96CRd7tSdvufLYuaoWyDzIRQ
 ly9ijq6wIClJ58fUeLwZPs5edsIleF4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX4V+FQwwfBEpD
 vkvjsqqa0CXILFR3ugT+sVeyeqNngUy210MSnWyUL/u+DM6jUIZT095CSROQVXYYzf4RtoYyH/l
 fn10i2hhRkWU2waTTlmWPtQcY0Qhw0n7TcvrkcXCe94746Wiwdr5vUDLzYdlwooxfWPKH/ZoXwC
 RBCrhMJh6+BXNSvew72UajOwhk7K2woH7RktlsOZt6ZgVvaTKKisE2Fgsqz8cr9rwWAS48iUfNr
 TK/r0TmDB/0+12KHFKjiifudqFsoGG3u/vIZBLymxm9ht4B68+YsE1FMbMOU5nPVDfqeObxHom0
 xJUQQGlJcbPWG83jegh1+BDE/2u+Yvy5N+h6h15OWKFgl9q9xhNngU7IQxr2RZVOjTVf5k8YavZ
 s7+TspjJ83KEMBqLv5Lc+kqy/10x3fBkj6pLLX3T692s1bQnxZ0LrmRVub9KM/67BliA3c5RipS
 TeE8tSoL5XjmKnWNizw==
X-Proofpoint-ORIG-GUID: KUBdWJZGkuFljljw6YkU9HZQlAGBqdAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280026

Issue:
After boot on Debian, bluetoothd and obexd are both running but none of
the obexd server profiles (OPP, FTP, PBAP, ...) is registered.

Why:
A race between name_acquired() and bluetooth_start(). The profiles are
only registered if org.bluez appears after bluetooth_start() has added
them:
	plugin_init()
	  1. bluetooth_init()           start watching org.bluez
	  2. pbap_init(), irmc_init()
	       e_source_registry_new_sync()
	                                sync call, fails on Debian
	  3. name_acquired()            fired, but the profiles list is
	                                empty, so nothing is registered
	obex_server_init()
	  4. bluetooth_start()          adds the profiles to the list,
	                                but nothing registers them

Fix:
Register profiles in bluetooth_start() that name_acquired() did not
register, if org.bluez is already available.

Fixes: 23b28ab759ee ("obexd: Port bluetooth plugin to use external profile support")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/bluetooth.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 3af1b504d591..b70090971119 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -45,16 +45,17 @@ struct bluetooth_profile {
 	const struct obex_service_driver *driver;
 	char *uuid;
 	char *path;
 };
 
 static GSList *profiles = NULL;
 
 static DBusConnection *connection = NULL;
+static gboolean bluez_available = FALSE;
 
 static DBusMessage *profile_release(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
@@ -315,16 +316,18 @@ static const char *service2uuid(uint16_t service)
 }
 
 static void name_acquired(DBusConnection *conn, void *user_data)
 {
 	GSList *l;
 
 	DBG("org.bluez appeared");
 
+	bluez_available = TRUE;
+
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
 
 		if (profile->path != NULL)
 			continue;
 
 		if (register_profile(profile) < 0) {
 			error("bluetooth: Failed to register profile %s",
@@ -336,16 +339,18 @@ static void name_acquired(DBusConnection *conn, void *user_data)
 }
 
 static void name_released(DBusConnection *conn, void *user_data)
 {
 	GSList *l;
 
 	DBG("org.bluez disappeared");
 
+	bluez_available = FALSE;
+
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
 
 		if (profile->path == NULL)
 			continue;
 
 		unregister_profile(profile);
 	}
@@ -365,16 +370,25 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 			continue;
 
 		profile = g_new0(struct bluetooth_profile, 1);
 		profile->driver = driver;
 		profile->server = server;
 		profile->uuid = g_strdup(uuid);
 
 		profiles = g_slist_prepend(profiles, profile);
+
+		/*
+		 * This profile had not been added to the profiles list when
+		 * name_acquired() ran, so it was not registered by that call.
+		 * Register it here.
+		 */
+		if (bluez_available && register_profile(profile) < 0)
+			error("bluetooth: Failed to register profile UUID %s",
+			      profile->uuid);
 	}
 
 	return profiles;
 }
 
 static void bluetooth_stop(void *data)
 {
 	g_slist_free_full(profiles, profile_free);
@@ -441,16 +455,17 @@ static int bluetooth_init_cb(gboolean at_register)
 }
 
 static void bluetooth_exit_cb(gboolean at_unregister)
 {
 	GSList *l;
 	(void)at_unregister;
 
 	g_dbus_remove_watch(connection, listener_id);
+	bluez_available = FALSE;
 
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
 
 		if (profile->path == NULL)
 			continue;
 
 		unregister_profile(profile);

-- 
2.34.1

