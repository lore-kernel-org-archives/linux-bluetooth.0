Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE084C62
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360394; cv=none; b=RIhgx+w8DUAvt6jufUFyNeuGrMMh5kXHZSDkoyRyGEdmLU+kEYx+/Ra6pv4HB3ip6djIMjG859zx6w9R8HNdvnQLlsYvaAHYA6h1pptjKiOnq/K1d/TyKVVNs2JeV3AOPJOpVUxodMkjiTfw0XkP08AYyFCeCRuQSR1zvl0sWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360394; c=relaxed/simple;
	bh=y1yeO4wU3N6j8W2IujkYei4L5Ono7242K5JFDw6qOu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QiW9c7T9HjJGXgU4QNEmCE9YFsZcB7eNbMDobxTMdUWrcOXenR9baMLhfFj8S7aaB6G7X77xXw4818JFCoN5LVDCCobHT+Tt8v9kcKsWsm81uM8S+V1POFCt9fxPCWsyRTPFBWcoIwCfUb1WJZdBaBhWBcNdgwfQswgO5/RL71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QTaHRZmv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QTaHRZmv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LMkbjX013663
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 06:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=XWRkozx8TCowux1NoIf+27F4uip+VIohfG9luFthSLU=; b=QT
	aHRZmvBQloR7BNa/VL4eG447FMetee2xCTRXls8LdS2Nc0yaqsKrSnKGq3jbFD7v
	dLMaco9nvoKJQRT5FEBLeRy4ukhXDADsdsXJ3qSL/P8i0MdjP5DUMjMM/5S/l5Cy
	e+uMhfDj0V1S0iL49m8vPS7Hu89w1RtmchAu/OWepQ9CZAsqg+gGRo1Abvtsh8EV
	u8IZfnF0gZyNblxh1lhPFuHYxYWwn6KU1SI7PQPxFJm0Xlym0qs52oXXWyzc/d+6
	NT7g3ShKRfuvTNW4N2YmeQ4ttZeztwDHm16jxPhC6XD9q6MxIEAcQ/p2q8ZqsBcB
	BwWT3ar0so45kZBu0ZPw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p8kjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 06:46:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M6kUDA022032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 06:46:30 GMT
Received: from hu-nakella-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 May 2024 23:46:28 -0700
From: Naga Bhavani Akella <quic_nakella@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Naga Bhavani Akella <quic_nakella@quicinc.com>
Subject: [PATCH v3] Adding Sepolicy rules to allow bluetoothctl and dbus-daemon to access unix stream sockets.
Date: Wed, 22 May 2024 12:15:04 +0530
Message-ID: <20240522064504.7560-1-quic_nakella@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fxcVEamIA8-50S2-yKPxozRGa2dA-oA0
X-Proofpoint-GUID: fxcVEamIA8-50S2-yKPxozRGa2dA-oA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_03,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220048

Required for using acquire-notify, acquire-write options (Gatt Client)
and Sending notifications (Gatt Server)

Below are the avc denials that are fixed with this patch -

1. audit: type=1400 audit(1651238006.276:496):
avc:  denied  { read write } for  pid=2165 comm="bluetoothd"
path="socket:[43207]" dev="sockfs" ino=43207
scontext=system_u:system_r:bluetooth_t:s0-s15:c0.c1023
tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
tclass=unix_stream_socket permissive=1
2. audit: type=1400 audit(1651238006.276:497):
avc:  denied  { getattr } for  pid=2165 comm="bluetoothd"
path="socket:[43207]" dev="sockfs" ino=43207
scontext=system_u:system_r:bluetooth_t:s0-s15:c0.c1023
tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
tclass=unix_stream_socket permissive=1
3. audit: type=1400 audit(1651238006.272:495):
avc:  denied  { read write } for  pid=689 comm="dbus-daemon"
path="socket:[43207]" dev="sockfs" ino=43207
scontext=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
tclass=unix_stream_socket permissive=1
4. audit: type=1400 audit(315966559.395:444):
avc:  denied  { use } for  pid=710 comm="dbus-daemon"
path="socket:[13196]" dev="sockfs" ino=13196
scontext=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
tcontext=system_u:system_r:bluetooth_t:s0-s15:c0.c1023
tclass=fd permissive=0
5. audit: type=1400 audit(315999854.939:523):
avc:  denied  { read write } for  pid=812 comm="dbus-daemon"
path="socket:[99469]" dev="sockfs" ino=99469
scontext=system_u:system_r:system_dbusd_t:s0-s15:c0.c1023
tcontext=system_u:system_r:bluetooth_t:s0-s15:c0.c1023
tclass=bluetooth_socket permissive=1

Signed-off-by: Naga Bhavani Akella <quic_nakella@quicinc.com>
---
 policy/modules/apps/pulseaudio.te    |  2 +-
 policy/modules/services/bluetooth.if | 23 +++++++++++++++++++++++
 policy/modules/services/dbus.te      |  2 +-
 policy/modules/services/obex.te      |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/policy/modules/apps/pulseaudio.te b/policy/modules/apps/pulseaudio.te
index 65b9a7428..42ed3a1d2 100644
--- a/policy/modules/apps/pulseaudio.te
+++ b/policy/modules/apps/pulseaudio.te
@@ -193,7 +193,7 @@ optional_policy(`
 ')
 
 optional_policy(`
-	bluetooth_stream_connect(pulseaudio_t)
+	bluetooth_use(pulseaudio_t)
 ')
 
 optional_policy(`
diff --git a/policy/modules/services/bluetooth.if b/policy/modules/services/bluetooth.if
index c7e1c3f14..edead1fa1 100644
--- a/policy/modules/services/bluetooth.if
+++ b/policy/modules/services/bluetooth.if
@@ -85,6 +85,29 @@ interface(`bluetooth_stream_connect',`
 	stream_connect_pattern($1, bluetooth_runtime_t, bluetooth_runtime_t, bluetooth_t)
 ')
 
+#####################################
+## <summary>
+##	Connect to bluetooth over a unix domain
+##	stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`bluetooth_use',`
+	gen_require(`
+		type bluetooth_t, bluetooth_runtime_t;
+	')
+
+	files_search_runtime($1)
+	allow $1 bluetooth_t:bluetooth_socket rw_socket_perms;
+	allow $1 bluetooth_t:unix_stream_socket { connectto rw_socket_perms };
+	allow $1 bluetooth_t:fd use;
+	bluetooth_stream_connect($1);
+')
+
 ########################################
 ## <summary>
 ##	Execute bluetooth in the bluetooth domain.
diff --git a/policy/modules/services/dbus.te b/policy/modules/services/dbus.te
index 2d1d09d71..855ce86bd 100644
--- a/policy/modules/services/dbus.te
+++ b/policy/modules/services/dbus.te
@@ -265,7 +265,7 @@ optional_policy(`
 ')
 
 optional_policy(`
-	bluetooth_stream_connect(system_dbusd_t)
+	bluetooth_use(system_dbusd_t)
 ')
 
 optional_policy(`
diff --git a/policy/modules/services/obex.te b/policy/modules/services/obex.te
index 6686edb37..5e2f20578 100644
--- a/policy/modules/services/obex.te
+++ b/policy/modules/services/obex.te
@@ -31,7 +31,7 @@ miscfiles_read_localization(obex_t)
 userdom_search_user_home_content(obex_t)
 
 optional_policy(`
-	bluetooth_stream_connect(obex_t)
+	bluetooth_use(obex_t)
 ')
 
 optional_policy(`
-- 
