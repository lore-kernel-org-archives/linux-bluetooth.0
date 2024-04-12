Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F52148FE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939286; cv=none; b=AhNLVUthghVkqy17ge5xl8F24HMs5Ml32FIYuV84vyOcPJE9C4sGS/yC2Qjoxu52gXIDDjuhpqzWR6RSzikJuOvSkkyL1nltU/FAs0J/DYcvc0OwYGgSwKRQgW4MWnkTfqwKgfBqsGlDOLOH3mocqr/5T5Sm4BFP/9aEn6kmp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939286; c=relaxed/simple;
	bh=Ji53xIb1oJLgi13FbeqdllcwUsq+ukpei4/aHZza1Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQPjT30kRwrMRTt9myMLCL/AcllcTaAohgvRCqp6KM4VL4pligg35/gnAzFJ2z0354/WHIrVwUNNv0mFJ5rnWXxV0iC/8mt40JNnVGloAQE+OBlUwWmPSF3aMcj/kHZNql302OX62T2iW+m8ax4GKjP57YLaQjJ4OP5BMW485ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PJ7wkuZ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PJ7wkuZ+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CEK2wX011563;
	Fri, 12 Apr 2024 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=rr3i0fGyQmBeiuP/qcwi
	asMzCm31H9+1jc4tCFA79x4=; b=PJ7wkuZ+GsaS+ZZL241CXzRAzDHIHHC/nr1c
	OesG8XqC7+mdOBbhy9HLRA/++Ky+JgKP173G4VgfZDKGZid9x/b5LsUyH/CylPxr
	aQcBTP6AymsyS6EylidWb6hYXA2vLDkcMofPv/CFc2mDXg0nvhICmjtUMPqyUudd
	COs6OEd3lizttaRvg2UgHWIfSIieygis0I2K+atCIbYqbrlNXlP1B8RqUl+CjSXc
	DYK1JX+OKDYJwDQF+4dEevLG0mRloTZWyFw//1zLqor7r59R0s7Vi6tBw5mY0Ln1
	8amJfoMVTh6/sFbCMAURLl4sr7w5MnjkqejA0APeEnmytoGKhA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf6khr8e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CGRwdt014051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:58 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 09:27:57 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH BlueZ v1] tools/btattach: Add support for more QCA soc types
Date: Sat, 13 Apr 2024 00:26:28 +0800
Message-ID: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JupBVmgHvKY58ibsECo_Fy6ftMvHo9yB
X-Proofpoint-GUID: JupBVmgHvKY58ibsECo_Fy6ftMvHo9yB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=741 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120120

Tool btattach currently only supports QCA default soc type
QCA_ROME, this change adds support for all other QCA soc types
by adding a option to specify soc type.
---
 tools/btattach.c   | 29 ++++++++++++++++++++++++-----
 tools/btattach.rst |  2 ++
 tools/hciattach.h  |  2 ++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be78d69c..024b0c7a289c 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -97,7 +97,8 @@ static void local_version_callback(const void *data, uint8_t size,
 }
 
 static int attach_proto(const char *path, unsigned int proto,
-			unsigned int speed, bool flowctl, unsigned int flags)
+			unsigned int speed, bool flowctl, unsigned int flags,
+			unsigned long soc_type)
 {
 	int fd, dev_id;
 
@@ -111,6 +112,16 @@ static int attach_proto(const char *path, unsigned int proto,
 		return -1;
 	}
 
+	if ((proto == HCI_UART_QCA) && (soc_type > 0)) {
+		if (ioctl(fd, HCIUARTSETPROTODATA, soc_type) < 0) {
+			fprintf(stderr,
+				"Failed to set soc_type(%lu) for protocol qca\n",
+				soc_type);
+			close(fd);
+			return -1;
+		}
+	}
+
 	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
 		perror("Failed to set protocol");
 		close(fd);
@@ -181,6 +192,7 @@ static void usage(void)
 		"\t-A, --amp <device>     Attach AMP controller\n"
 		"\t-P, --protocol <proto> Specify protocol type\n"
 		"\t-S, --speed <baudrate> Specify which baudrate to use\n"
+		"\t-T, --type <soc_type>  Specify soc_type for protocol qca\n"
 		"\t-N, --noflowctl        Disable flow control\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -190,6 +202,7 @@ static const struct option main_options[] = {
 	{ "amp",      required_argument, NULL, 'A' },
 	{ "protocol", required_argument, NULL, 'P' },
 	{ "speed",    required_argument, NULL, 'S' },
+	{ "type",     required_argument, NULL, 'T' },
 	{ "noflowctl",no_argument,       NULL, 'N' },
 	{ "version",  no_argument,       NULL, 'v' },
 	{ "help",     no_argument,       NULL, 'h' },
@@ -221,12 +234,13 @@ int main(int argc, char *argv[])
 	bool flowctl = true, raw_device = false;
 	int exit_status, count = 0, proto_id = HCI_UART_H4;
 	unsigned int speed = B115200;
+	unsigned long soc_type = 0;
 
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "B:A:P:S:NRvh",
-						main_options, NULL);
+		opt = getopt_long(argc, argv, "B:A:P:S:T:NRvh",
+				  main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -237,6 +251,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			amp_path = optarg;
 			break;
+		case 'T':
+			soc_type = strtoul(optarg, NULL, 0);
+			break;
 		case 'P':
 			proto = optarg;
 			break;
@@ -298,7 +315,8 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags);
+		fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags,
+				  soc_type);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
@@ -317,7 +335,8 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(amp_path, proto_id, speed, flowctl, flags);
+		fd = attach_proto(amp_path, proto_id, speed, flowctl, flags,
+				  soc_type);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
diff --git a/tools/btattach.rst b/tools/btattach.rst
index 787d5c49e3bb..4aad3b915641 100644
--- a/tools/btattach.rst
+++ b/tools/btattach.rst
@@ -62,6 +62,8 @@ OPTIONS
 
 -S baudrate, --speed baudrate       Specify wich baudrate to use
 
+-T soc_type, --type soc_type        Specify soc_type for protocol qca
+
 -N, --noflowctl            Disable flow control
 
 -v, --version              Show version
diff --git a/tools/hciattach.h b/tools/hciattach.h
index dfa4c1e7abe7..998a2a9a8460 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -19,6 +19,8 @@
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
+#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)
+
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
-- 
2.7.4

