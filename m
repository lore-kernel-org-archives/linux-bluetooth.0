Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242241D224
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529070; cv=none; b=j1nhUAdY76LebSMZsLNVNLGe2xLar7/ZKs8yP4/RDl+vAp4ZMNtOpe2Ob4xcX/4xaka3/n8Xg7KPorbTUrFdvIp5w2MloJyWc7nVGLIrR5zTpmBTx0EnqYW8L+w7OaHqLq8vWR1L/xxBmZC8Ad3Kv8KjWDkNRPMHiWkbLaF8DAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529070; c=relaxed/simple;
	bh=aqvzxd6Rnbvd72Ue41jpIVgD3EkU52pzud0G7hIz5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRxDQMA2oRjd4+J7kp+yxJKm148EV19j+0hwq3tX4puvnxSl0QqGBp5PGaqFUSWjr5NavPBT6UvdeUS27+gSSxkhHgaV5Tg2v7jRsMvAwZhnbqKFj7Bw4eXhJQOYHZXvSwWSoEujtry8i6Zr2ju1uW9TIrX6XZe/yh1YJiIdzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ntj21rYz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZibIPIFX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ntj21rYz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZibIPIFX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fdn13082673
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0s74vLHPefv
	CJYu9Vmodcb0zj7rhL2wWUwDVTrX9xLU=; b=Ntj21rYzZjX3RFqxlSJo5+C2vtS
	7NPZIF7DkptRTzlU32QjvnFiGHz0VNRXYNm7UXzoi8XojcIT5E34tNoHhusMxRra
	NtKQNlY3Ob+jwQdI+3ZDg1fvbZkTQ7OgUYBswyVzPha6Xkt1PcavlUsicB/AmEWT
	TfOYku9ekQWhDyuFAg1qptdzVQVY3Fv9iuV4jZSu+vrHNgwVFA8ubQSmnympBir+
	yVrCLSupKBd3u6z2P4bYeQ18PUjR2er2rvRAEmU2RhJOca51TzN2bHcHrsrLHgbR
	m1EQ11iWPleGpbQ39CEhVy0VPNAl8AKnVPROolrEF8Tgb++5ZapEvR00kDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrk98f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedf42f199so754133a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529061; x=1787133861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0s74vLHPefvCJYu9Vmodcb0zj7rhL2wWUwDVTrX9xLU=;
        b=ZibIPIFXwrIPm4nVC9eKqje07uGzL8D7SRPloGj9hKox7xG2j8o2deImyay1a7SUXx
         R4fYIhRHiO82SZ/G3g5zLDvTs+ZyhASBgUmR0dFppEgvhnQgW8pV3mD22i9OKFhdpon0
         m3sr0R5Aew8GhGf9vFTQbRzKvz8cqGJXeaQEbPf8qGcdtey1fN462ibJXNSRMccUB+Zd
         KUHeYw8NWK9oyVfGiWbMNAeaeYsSU3JhbF1MALY5KvspTVXTra0wSa3pblXcCuq6lbYb
         8YalIrz6hnU/40wADzUcXR1LW53h2xeoVLZw0LWhE7STf4cB7zW0KJdZo/YNXhmn6Aye
         QRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529061; x=1787133861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0s74vLHPefvCJYu9Vmodcb0zj7rhL2wWUwDVTrX9xLU=;
        b=M/FtNate4922uassyDVtIvjX7wvMNpK2ZmCQr7zWj3UngyfoGGm952k3AGJzP+qAH+
         MIsAMBD4ZfedZq+IFiYBWi3vZEi3b7enEZC+WrbcEdrDRF/0PIKZh26dTbeDla/ZmAg3
         v7P3DR2D6rbo9frsrsLvMtQmigFZiwLZ/iydF8upF+KIjvqNiSsrMjQg+iulaD+i/ThF
         I5TlxhZuMMTUfKAb5Q3HzbvlRaapMJoPQt1Xwm/uXtot7BnhiL5f4N+9Fq3X2saFpVUp
         6GTIMifV0KxuuGdBD6s1qUrScBcIDA3QNRSJ99y/XIhphDy88iwRrpd+qcRE25B0sWa9
         CFJQ==
X-Gm-Message-State: AOJu0YzTKd00bk6MBUcIxp4jDw6JEk4V5zjKq7aZUJNd1g0eOk2zcQ7T
	5q7QEStkO0MwwVNemOUSXiepIZKCMzIrxAGctLXjw7yHeZsoONN6/JD+c4UV4bZnUvwgNa9EVAi
	bz0YOKdVD6WErjDg0BBIxMd8/PpMNJbGAYWw1s5TgIDB6duU5BWiIOIJbZQv8n8SvUbA3bEbdz1
	46XqY=
X-Gm-Gg: AR+sD13ovRHnwMNQ+oeRlAnt1CUwC35SQhx9yiBcZcNRaH8baIYiDAxIRKiF+hfkd4V
	bpEEwZMCl8Jw1useZA48C2nJE+tQtXKODRpA5uH0ei4JYF0wM4nwvIUrKU1esmmXwJ9sbyvgXFd
	JyRJ4ncwghHKyTdsskb5EPcx1dixGgM+Dfc8VRJq1DxMXit3iICvTMrSlrS6j/lY71lBklyDGe8
	XuL7+bW3NcH1VUK7l7luzAgaal9G+IdOubV5pSsAT9uIWBYF/+UyGkQIWzwYwJyFwPuNSG/S/8d
	PlSCjBKngl9/AmV4Z8U2/BsEVtwJLc/cPRHkHfSu0PVUujkZ5QXkJB8DqRDTxohBXb7BhKvKVgQ
	lTkiO78eYZr/q51QVlHKO0833cpUt5A==
X-Received: by 2002:a05:6a21:482:b0:3c1:c6e:9360 with SMTP id adf61e73a8af0-3cc3f80acd6mr4699747637.32.1786529061369;
        Wed, 12 Aug 2026 03:04:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:482:b0:3c1:c6e:9360 with SMTP id adf61e73a8af0-3cc3f80acd6mr4699681637.32.1786529060788;
        Wed, 12 Aug 2026 03:04:20 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:20 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <nakella@qti.qualcomm.com>
Subject: [PATCH BlueZ v2 5/5] client: Add CS distance display support to bluetoothctl
Date: Wed, 12 Aug 2026 15:33:45 +0530
Message-Id: <20260812100345.2956271-6-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
References: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dNblh7TsnN7LabygkuqFSnEUet3do6uT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX22ZbZugseeJn
 Ko84kXAoxXxjb4AVZC0RlYv3B88+LuldCSUZhhQyicIJDtF1Q2ekPKlofS498GkzLcng1XAc/ed
 UqLywzD6nGMtz3IKIhxXdSH/wzR922k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX57JsECFusOl+
 TXfS+hlGVHeWknEc+StVxSmfRim+JnyYMdiuFDKA19bAJyVZyTUQroAh6Zr/viGSHIKdqr2MWg/
 gL3p8LQNiB4sqR94TESOzJhToKbthewdQW9SD9fXhUYLUHn3IzeKSBGRJy0j2wCMrd0fjIEAFYY
 TuqQeolL8zN06FxHGVxSq5HQ6fIZ1bVd1jsDuCZ+F8Qb5VQh0IdbSWfXjuOJWHG8YUnWWjMBrG7
 ceBcRQjJdpbvgG+ofuHEsyr8d7S6VE2HTHmijNLRfri0+QZe7zih0x2UDhdTZtsSs95fK0YIFaC
 SVmopsjKcuXcuKVGGcjaL366Po0i771rDsi24aA2272w8i0rKRwq2fv/ZCw8XqY8wiasLDta2nU
 TE2mfNdtONGV2TNTAymuKG0KvTCkqgCjZOciqimuBXQzlYLbZlnT4yW2rKfzPnnGQdDkd7VZbIe
 TLcIaVsrZnJacoqIjow==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c4526 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=vM1LWfXSHWswkbsn6CAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: dNblh7TsnN7LabygkuqFSnEUet3do6uT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120080

From: Naga Bhavani Akella <nakella@qti.qualcomm.com>

Track org.bluez.CSDistance1 proxies and append/remove
them on InterfacesAdded/InterfacesRemoved.

Print the DistanceMeters property on PropertiesChanged,
and show it under info option alongside the existing
Battery Percentage and CS Active properties.
---
 client/cs.c   |  2 +-
 client/cs.h   |  1 +
 client/main.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/client/cs.c b/client/cs.c
index 9f069589d..fd2270a51 100644
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
diff --git a/client/cs.h b/client/cs.h
index 243d2a72b..fbf7ff954 100644
--- a/client/cs.h
+++ b/client/cs.h
@@ -16,3 +16,4 @@ void cs_device_disconnected(const char *dev_path);
 void cs_measurement_started(GDBusProxy *proxy);
 void cs_measurement_stopped(GDBusProxy *proxy);
 void cs_set_device_list(GList **devices);
+GDBusProxy *cs_find_proxy(const char *dev_path);
diff --git a/client/main.c b/client/main.c
index b5cad8afc..1fd00a786 100644
--- a/client/main.c
+++ b/client/main.c
@@ -69,6 +69,7 @@ static char *default_local_attr;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *battery_proxies;
+static GList *cs_distance_proxies;
 
 static const char *agent_arguments[] = {
 	"on",
@@ -121,8 +122,10 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	g_list_free_full(battery_proxies, proxy_leak);
+	g_list_free_full(cs_distance_proxies, proxy_leak);
 	ctrl_list = NULL;
 	battery_proxies = NULL;
+	cs_distance_proxies = NULL;
 
 	default_ctrl = NULL;
 	cs_set_device_list(NULL);
@@ -358,6 +361,16 @@ static void battery_removed(GDBusProxy *proxy)
 	battery_proxies = g_list_remove(battery_proxies, proxy);
 }
 
+static void cs_distance_added(GDBusProxy *proxy)
+{
+	cs_distance_proxies = g_list_append(cs_distance_proxies, proxy);
+}
+
+static void cs_distance_removed(GDBusProxy *proxy)
+{
+	cs_distance_proxies = g_list_remove(cs_distance_proxies, proxy);
+}
+
 static void device_added(GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -531,6 +544,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		bearer_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
 		cs_proxy_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.CSDistance1")) {
+		cs_distance_added(proxy);
 	}
 }
 
@@ -664,6 +679,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		bearer_removed(proxy);
 	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
 		cs_proxy_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.CSDistance1")) {
+		cs_distance_removed(proxy);
 	}
 }
 
@@ -843,6 +860,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			else
 				cs_measurement_stopped(proxy);
 		}
+	} else if (!strcmp(interface, "org.bluez.CSDistance1")) {
+		if (!strcmp(name, "DistanceMeters"))
+			print_property(proxy, "DistanceMeters");
 	}
 }
 
@@ -1882,6 +1902,8 @@ static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	GDBusProxy *battery_proxy;
+	GDBusProxy *cs_proxy;
+	GDBusProxy *cs_distance_proxy;
 	GDBusProxy *bearer;
 	DBusMessageIter iter;
 	const char *address;
@@ -1934,6 +1956,17 @@ static void cmd_info(int argc, char *argv[])
 	print_property_with_label(battery_proxy, "Percentage",
 					"Battery Percentage");
 
+	cs_proxy = cs_find_proxy(g_dbus_proxy_get_path(proxy));
+	if (cs_proxy)
+		print_property_with_label(cs_proxy, "Active",
+					"CS Session Active");
+
+	cs_distance_proxy = find_proxies_by_path(cs_distance_proxies,
+					g_dbus_proxy_get_path(proxy));
+	if (cs_distance_proxy)
+		print_property_with_label(cs_distance_proxy, "DistanceMeters",
+					"CS DistanceMeters");
+
 	bearer = find_proxies_by_iface(default_ctrl->bearers,
 				      g_dbus_proxy_get_path(proxy),
 				      "org.bluez.Bearer.BREDR1");
-- 

