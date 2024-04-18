Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145038DDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411569; cv=none; b=Emh8O4LQC9JXXj/gOBRa55StEXAWHJFWV4k4SPcVLkad8KwF7SensIebYG87GDFf4cD+ggP49Jhe87FLbqfDf0AO9XamiDVIyxnyd5Zi47u/3nMHweMEs5+pRpB9yGlg25QnNiXCl/fslTkpFGH1pcB349cCiGk1xd0C5vguoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411569; c=relaxed/simple;
	bh=Ahvl//tDsmG+SFagQTSkIuxMUJMOSOhoO0kfDBBEkXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSAWtqyEw+O8awplwM86fJZH4L5jMQSROo7hZN9CaQ91AGxe/scwKvSf4YXlUUOSKfzVsbmsdGmDMmfXZ5i0FRH9/6DkFMo5nw5axQx8OgfniduJYEqRrvbe6KhxKzMwEjcZCSkbKYLg/HcG4jNLQ0RohchOFx7h145QG3V9d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aF6in1t0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aF6in1t0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I3cpwD015625;
	Thu, 18 Apr 2024 03:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=D6sGXr6WON2fYtcxYsJQ
	+8lt23phLuIAwt+97ftM2AE=; b=aF6in1t0uhC8Pelafp4ZERhrRUxjzTRpPOZl
	JHbyzGpE+1Bkvd7TkGeKVLl7GNOY8bi9/1phhsf2xVjbIfAFAoA2NfgXUzM6EcGP
	46aESsALyiCps9Rm0stGqd4nkDoZjc38HnuHpVrYKmmA0foAY3zntl+hDIfp+6o5
	tlWtQX8Tmn+yofU+offWzRLPXELbjzvWWnW4V5l1GrNHRp3bBRKa8/3B/Ejcq6fE
	imifvs5qV6C4MsN4A9YGQ1MpBePK9ZrwveS/Qak1DVzxMikPK3u10+JzEVtvdMiU
	WOtqaIfbJcx7ZsNC2QaMii1oXvDl6sxYLOgiCVbM3aPbi+NnAQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjk889csv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:39:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3d47K019781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:39:04 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:39:02 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH BlueZ v2] tools/btattach: Add support for more QCA soc types
Date: Thu, 18 Apr 2024 11:38:58 +0800
Message-ID: <1713411538-28578-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
References: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0rvxIPs60_u-fhBgoy97mdS89U9v8zAV
X-Proofpoint-GUID: 0rvxIPs60_u-fhBgoy97mdS89U9v8zAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=781 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180024

Tool btattach currently only supports QCA default soc type
QCA_ROME, this change adds support for all other QCA soc types
by adding a option to specify soc type.
---
V1->V2: rename variable names

 tools/btattach.c   | 29 ++++++++++++++++++++++++-----
 tools/btattach.rst |  2 ++
 tools/hciattach.h  |  2 ++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be78d69c..08c648f44248 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -97,7 +97,8 @@ static void local_version_callback(const void *data, uint8_t size,
 }
 
 static int attach_proto(const char *path, unsigned int proto,
-			unsigned int speed, bool flowctl, unsigned int flags)
+			unsigned int speed, bool flowctl, unsigned int flags,
+			unsigned long proto_data)
 {
 	int fd, dev_id;
 
@@ -111,6 +112,16 @@ static int attach_proto(const char *path, unsigned int proto,
 		return -1;
 	}
 
+	if ((proto == HCI_UART_QCA) && (proto_data > 0)) {
+		if (ioctl(fd, HCIUARTSETPROTODATA, proto_data) < 0) {
+			fprintf(stderr,
+				"Failed to set proto_data(%lu) for protocol qca\n",
+				proto_data);
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
+		"\t-T, --type <soc_type>  Specify soc type for protocol qca\n"
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
index 787d5c49e3bb..8f554a38181f 100644
--- a/tools/btattach.rst
+++ b/tools/btattach.rst
@@ -62,6 +62,8 @@ OPTIONS
 
 -S baudrate, --speed baudrate       Specify wich baudrate to use
 
+-T soc_type, --type soc_type        Specify soc type for protocol qca
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

