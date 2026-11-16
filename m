Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820025;
	b=F0L1A2WTXj2ZFsNI9zR8ROFCGtzcRPUt77LJQ1m/wrNnuGVX0q/EiEMNBKuJw+2vYPkO
	 G6JC31TjlrEU4T/oKAy954X3rK7w6wca6ldf6Q00xfHLQuWVZ0kOESXjI/38PFpC7qZ+d
	 q6LmaQF6hemTFhfzBgWH8F4uNTFWqj4+qwoJCzQzPQWkjfgGbCUqutTC8XAhjOkB57l8i
	 TSvxR4hv13CYQ2dkP4v0LJAgQ5zFx2Sx+3XHr8uRJlXjQGZSLRxv0rGBANSVMubC/Hlsd
	 hE9b9GopjqRa54j7QFXhkYkXldLi25fHUp0Juf/BDtuNThn+2O3Ce/HmORwYpJFC3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sa/nBZbLaVvfVdOspOPbxC74pQg9iBW59WbSpO/KrpM=;
	b=o4wDhMKzlAnpkd7wrotvUkDq5n80e+G3XdNGNEjuruTTyfbvZ8lh247tPbzXkS15mbpf
	 JlOGluyqEPCSbz03/f43n3dJlwsj8dkGCkQvTfeAO8cfNKjOC+Ae/qon31V7fGEOC0VVE
	 36k+ZldexpjYX6kuJFUc9rqqS9azVk/5JPkUiBcT6eyi5qsES+DYs8uVQNOvwES0FB/If
	 s+/UMkXY6ROfGFacZ8s9hOff4mM8sm3mtKWfZvag7/QmWGRCGmKx2dWOlmM/UiIetbEam
	 nppTYepcKyGMa5J4HIcI33FT4w0pcN+QJfBdT6M7D/A5UzDaH/DLdIgHv0pQCayAeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NGQ1roak;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791ED606A898
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791ED606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NGQ1roak
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f0de424051;
	Mon, 16 Nov 2026 09:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sa/nBZbLaVv
	fVdOspOPbxC74pQg9iBW59WbSpO/KrpM=; b=NGQ1roaka2iyH2tltLEEwCLarKO
	1H0V+HLSdAtRP0ez8YHXt5HXagiXjKtMSVCRm/RWbu6c0QnniEdjInY79ltm747X
	Ej/SOKzi8Vo8Qwwgl9KY2491PjfmzutCH/2nzzCqZrilkXL+YknCKMASm5HHlmOL
	bBX3FIY4JDFkqsJJogRQjaugfVC6uNsaAfXFRH4ViCn7HZaDo/+Nb61d+OP7jSBV
	VcprDd5rbddxEE1ajMa1IAyLoYosL7UOOif6LHFaMpOupn+aJswC6TkZvi3MGOkg
	wHvbT4AVcOxnR/MSXobgyyE9IXsjKFxdlRShit6ooVe1LgHqJuOYCRY6kyA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwdn5d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:07:02 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tsS2942810;
	Mon, 16 Nov 2026 09:06:55 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96toK2942781
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id B407A27A08; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 13/20] obexd/pbap: Parse PbapSupportedFeatures in connect request
Date: Mon, 16 Nov 2026 17:06:27 +0800
Message-Id: <20261116090634.1222593-14-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX1hCey0k/Cq5v
 kcg1Ts7tlQF9l03E7+cwE2boEmWxL5lCjcIoh6s4dOxrt84nyKwBTZWlSvaxQTub8G7jT7CcXIo
 0tmCZX3OqswoZuZi/sflxuMpGpMbd+Owq2AHL+t4R5u9mBBvQQmij7Mcfq8rtLtaTbg4ND1yc67
 TcTrJvLvM80zrp1mF9DoFEBRtJOGxO2XeLluOTFL8gqy/YKRz/kaIG9wESVA0D2j2UthobF9n66
 VdBKIXnm4PV+WihFjEBCW9UFIgJUHfhz4Y297b33zfXirzW6We8qVBeMF2qSjjJIuiCu4M+eHk8
 Tv1h8XUIy23tswoXFGTCyojR0YbGxG8Dy4wtE9ri4pG1jVA/M2FuqUrJ/aUzEDKBbSXxbJc39MR
 M6JZ/tcNEp0A1bSafYlHteu9GvbzgdhESyrC9EgajGRgM4jSfZ3Mios1HLr85qz1G0maMpw7UOe
 o01bJabM1fskGMbgUUA==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6afac7b6 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=_H_TX8z6i7KVAPa1vQQA:9
X-Proofpoint-GUID: Z98MQksSA0n7ud2Rb1k83hD4EQnveCZD
X-Proofpoint-ORIG-GUID: Z98MQksSA0n7ud2Rb1k83hD4EQnveCZD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXyTzHUjnWBJGK
 EtPde5UwZ+rNGoM2yDvrJ5edpF1ESCbJiTgj6tP3CM/NUZfAqdZYrNowRiyts6TnXKVaHZfTEtg
 GlEeD5diRFW/AGhoJTeCxsSfQnhDxlI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Parse the PbapSupportedFeatures tag of the CONNECT request, combine it
with the features supported by the PSE and store the result in the
session.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 83256c98c..92794b968 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -42,15 +42,22 @@
 #define VCARDLISTING_TYPE	"x-bt/vcard-listing"
 #define VCARDENTRY_TYPE		"x-bt/vcard"
 
-#define ORDER_TAG		0x01
-#define SEARCHVALUE_TAG		0x02
-#define SEARCHATTRIB_TAG	0x03
-#define MAXLISTCOUNT_TAG	0x04
-#define LISTSTARTOFFSET_TAG	0x05
-#define FILTER_TAG		0x06
-#define FORMAT_TAG		0X07
-#define PHONEBOOKSIZE_TAG	0X08
-#define NEWMISSEDCALLS_TAG	0X09
+#define ORDER_TAG			0x01
+#define SEARCHVALUE_TAG			0x02
+#define SEARCHATTRIB_TAG		0x03
+#define MAXLISTCOUNT_TAG		0x04
+#define LISTSTARTOFFSET_TAG		0x05
+#define FILTER_TAG			0x06
+#define FORMAT_TAG			0x07
+#define PHONEBOOKSIZE_TAG		0x08
+#define NEWMISSEDCALLS_TAG		0x09
+#define SUPPORTED_FEATURES_TAG		0x10
+
+#define DOWNLOAD_FEATURE	0x00000001
+#define BROWSE_FEATURE		0x00000002
+
+#define PSE_SUPPORTED_FEATURES \
+	(DOWNLOAD_FEATURE | BROWSE_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -72,6 +79,7 @@ struct pbap_session {
 	uint32_t find_handle;
 	struct cache cache;
 	struct pbap_object *obj;
+	uint32_t negotiated_features;
 };
 
 struct pbap_object {
@@ -513,6 +521,10 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 static void *pbap_connect(struct obex_session *os, int *err)
 {
 	struct pbap_session *pbap;
+	const uint8_t *buffer;
+	GObexApparam *apparam;
+	uint32_t pce_features;
+	ssize_t rsize;
 
 	manager_register_session(os);
 
@@ -520,6 +532,23 @@ static void *pbap_connect(struct obex_session *os, int *err)
 	pbap->folder = g_strdup("/");
 	pbap->find_handle = PHONEBOOK_INVALID_HANDLE;
 
+	rsize = obex_get_apparam(os, &buffer);
+	pce_features = DOWNLOAD_FEATURE | BROWSE_FEATURE;
+
+	if (rsize > 0) {
+		apparam = g_obex_apparam_decode(buffer, rsize);
+		if (apparam) {
+			g_obex_apparam_get_uint32(apparam,
+						SUPPORTED_FEATURES_TAG,
+						&pce_features);
+			g_obex_apparam_free(apparam);
+		}
+	}
+
+	pbap->negotiated_features = PSE_SUPPORTED_FEATURES & pce_features;
+
+	DBG("negotiated features 0x%08x", pbap->negotiated_features);
+
 	if (err)
 		*err = 0;
 
-- 
2.34.1

