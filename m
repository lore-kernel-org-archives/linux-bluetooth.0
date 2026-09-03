Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB83EC2FF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430624; cv=none; b=ETQTlycTuMqKtvWiQyPa2YiT9XQeZgmOhJ4GyrRRYsznxnyWYqI/24+lpLcysv2nRba+KUxJwQIvqFYrGRjHnJ3h1P0pUUG+6d1G6ndUU7h8Y/tGVEGHK9GtesT3Gv25mMO0y/pkVen5ZSZO8qfzUfMo4l86WPsu+yzF/anNwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430624; c=relaxed/simple;
	bh=v8VtOPW9ee/ZqT1M31jfT2iAjVjKQ44qPeH5ehrtY5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLrcDt7tVHQ/w4SYxCSTWnKaL92oioZb3Nr1cJT3XqcxQ1+seksAHpwffqq1m8XrUa/lAh2VCBtRYaMS9VMxbB0eq5Okf6V0eDqANSFjSMHN174HIeBtJYYczuqgJl91bfCWVoo1NKMFRGJW+JItiBLMeNasN4zmToHHk+u8aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UuXcv8DL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bvwgC5eP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UuXcv8DL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvwgC5eP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683923UX3549252
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 10:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DWWFzA6jPd/
	9dVBL/dwORcv8svxSfNpSeIU7fKy5/l4=; b=UuXcv8DLoDBeULjXs2p6apuE0aP
	7kkbyhKUB3thBukc3ww3pzP71DPcBzjFjmf7CDuQVVQXIFyzHdFNmBFHQCb5kTda
	fA3hOVIan6w/+3AI72YJK7Y3L+8P4bBbmIgvNmaq7AEr2TEXQFUvgvRRqJ7fxeTN
	v6u8X+Eomh3XHim6aMsOIt5k+pxHlQzYju4+HlPrGDnZDLcYDmFtirOtkxMte/+0
	HOp4QOMu2oQbwOsfwFu2rif/GwX/JaYRwrUOMPd0qdlMNVsbE1ZbgqOuV3P4XC5f
	TL2bns4ifB0d3lw0e+ZV10uO3XIvD4944/oSXjAe7q7DeS9Xo1dTF0tSQQA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsmme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 10:16:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so39363505ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788430615; x=1789035415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWWFzA6jPd/9dVBL/dwORcv8svxSfNpSeIU7fKy5/l4=;
        b=bvwgC5ePLJJS1Af9rN7hueJBAulLn375aNPc2G4vTszAtVY2rfjo2vD2alpc2lLCcj
         gTEvinPCnXhIPakM6RZmkJD3dLCf4v749qr2oiwIA8mX58KbopUwAXZhpI0RGDDA4S3q
         T2L5sJe9pXc5m8ez8tlBgU8kYUfvFh1fJr2N9X5vTQXYXhvNsCPB1ZXut43p2OUPi/9H
         CUOXoioaIFZHQ8hXiTuaoxYgeNRg9zqF02q04jgNGpNSjFZMpstAxrdQAZwgS0mHbOw7
         GmBxMJQqVNJKnRgkXy8R3j8w00k/aLFP+A9/L6WZlOGCm4/IkIXvXhkyUxTHuvNK+ygV
         tcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430615; x=1789035415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWWFzA6jPd/9dVBL/dwORcv8svxSfNpSeIU7fKy5/l4=;
        b=aSGJfuckGhVp76H71Q2Vu5qaocIqFFiijqeTiE7i9IOO+AwTGRaPGMCidMtjURcMvr
         5QMEZiydCLE5cm7mL3mvTHXqPJecwFc0NYh5ZdyMoNGWWBPHKyjPPXD2aScg0rkj/g/f
         VaSZ0EY1AS9q21MAqkMIX7A43V0XALDN+576Kv0AfgMrohjdNDiB8PuwulE1Eiboelgw
         Jzmr9T3aFjM8OrgNUPNOnI599MaEEQVn34tFQcB1sddUaNu2eECEDzokA7ZU6ztVT8sJ
         YD4oNq6bLPzfs8m2rtt5oiXcW76bRQQR2RHif7qxFtRDJkEJY3OIMDBD6iOkEQrKhpkm
         BTGQ==
X-Gm-Message-State: AFuF++lD8Ct/7oRnCPpFK6CBz3GeBJfE8zgmXPPE/AGf/PjVDPaqVVIs
	mXCyUO//+BRu2Q33vLoxqpTySjHGbqtLIa4sG2/Vf8JWQ9EhSSgkipzcbXjFjVh2+7aNltRy4bN
	T4JAVU4bEsV96/0MJzNPjkFqA1ZL8y3RRtW6np9dam42PYOKx2JDzU85mE/uOdo6KmcELLdf/ET
	gyFKw=
X-Gm-Gg: AYBFou24RVc7UXJUawqyd1x14L+r+ZzppCOSIFWYsE1q2YAsLS6TgAOsXlVabuJcg87
	R0S9U8Z0u358oTse2u8fNvHUPmkn3IyQHVE7dhQxVH/QPThiERAslX16wyJGgY65A83jIX1IzSg
	bbqC8u/oMB5AeyN3KWXuC3GRbMUcTl0b0FWahtoQIyjNBR4h9aW3Bk74DY3H76vSBwguBNqiULy
	z3pTWT21lAaO5d6lWZQ53EU+IH5A4+iB88IHjOFVkLP+wN8J/UUP4w3nq5qzWV8vs1bc75cvzdH
	zipL2JL/O3o55t7GRwHqN1muuuPv7uIc2Vc5cF1ZYowd75tJ5oO61U5o4PkdeSXk18gKcAm67rY
	Aiuo+a+kt1E2njzQCy9Zt0A65EEEQzQ==
X-Received: by 2002:a17:90b:2d8f:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39aee13d992mr18465739a91.18.1788430614681;
        Thu, 03 Sep 2026 03:16:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8f:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39aee13d992mr18465653a91.18.1788430614181;
        Thu, 03 Sep 2026 03:16:54 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14319875cc0sm4933483c88.1.2026.09.03.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:16:53 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/2] client: avoid registering ranging objects as direct children of "/"
Date: Thu,  3 Sep 2026 15:46:34 +0530
Message-Id: <20260903101635.3370149-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
References: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX8H1y1gnr4SGo
 vkDz4Iovx0SrsJ3TeUj19kO0BkipYzpyd1BT4S4u6WlHr6VRToA6vfvDeTdkRoEnA3RHC5JMb/B
 a1lfcqUv2BBEsNg2ylPUrYOJOUlj9/ByINDBiBWbcuWlXZlEWfeQfGpQHzJM0uQi+yG2knEAnJ1
 X7Z9x5gHOHQmbfmjpl+Fom3aDJ5IRs4MmUeqilMgYZbvgzbwoZxfoQzxPIVN/abE5ZStCG4/DId
 GcwlaMHrRJq5UAuqA+h1vIE9umD7UWwu/NYRJhMoG+PjWCkjpqT1dsVgYqAg61qSMuS93r6O5Tw
 5h6vrghG79sotYZkEBiwEdFZlg0+HdK3XvBy6SwA/VmPZNR2uEdAHdPIS6fRtG2yoWbmNdOWU+0
 4JGP7vAdXrriQwfZ4rj5Dl/7O6RMba8PXmuc5WJqTDt3EgHjtSNjeXfNIB3mpl4Nw4eKN3VZpmY
 qY/BtC6weiNAA4W3Ruw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX5vMJ4pPs6dnc
 ugTSGM5DLTN2Juw7O+gov/v4DVXGxBMprzda5VYcsVVn74A/RGwV05UxwcVanalRzBVnqDuJNr4
 1ofxhkMYw5aicEJhf2O4LEju4/IbdwM=
X-Proofpoint-GUID: --ocKu4qrnoEYSKh-u218a-h9aXuhH44
X-Proofpoint-ORIG-GUID: --ocKu4qrnoEYSKh-u218a-h9aXuhH44
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a994917 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pdR5znnjHgW-0o4HiHYA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089

With the default provider path "/", cs_ranging_obj_create() exported
each device's RangingProvider1 object as a direct child of root. That
triggers a NULL-dereference bug in gdbus/object.c's
invalidate_parent_data(), crashing bluetoothctl with SIGSEGV on the
first ChannelSounding1.ProcedureData signal.

Fix by nesting under RANGING_PROVIDER_PATH that is
never independently registered, so the leaf's immediate parent isn't
root. src/ranging.c's provider watch matches any descendant of the
registered root, so discovery is unaffected.
---
 client/cs.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/client/cs.c b/client/cs.c
index be546cc20..7533d053b 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -357,12 +357,23 @@ static struct cs_session *cs_find_session(GDBusProxy *proxy)
  * main()); bluetoothd's RegisterRangingProvider watches the exact path it
  * is given via GetManagedObjects()/InterfacesAdded, so any other path would
  * silently never be discovered.
+ *
+ * Exported RangingProvider1 objects are nested under RANGING_PROVIDER_PATH
+ * rather than directly under "/" (see cs_ranging_obj_create()), to avoid a
+ * gdbus/object.c bug hit when linking a brand-new direct child of a path
+ * that already has an ObjectManager attached.
  */
 
 #define RANGING_PROVIDER_INTERFACE	    "org.bluez.RangingProvider1"
 #define CS_PROCEDURE_DATA_INTERFACE	    "org.bluez.ChannelSounding1"
 #define DEFAULT_PROVIDER_PATH		    "/"
 
+/* Prefix used for exported RangingProvider1 objects when the registered
+ * provider root is "/" (see cs_ranging_obj_create()); matches the object
+ * path test/example-ranging-provider uses for the same purpose.
+ */
+#define RANGING_PROVIDER_PATH		    "/org/example/ranging"
+
 struct cs_ranging_obj {
 	char *path;		/* exported RangingProvider object path */
 	char *dev_path;		/* Device this estimate applies to */
@@ -479,8 +490,20 @@ static struct cs_ranging_obj *cs_ranging_obj_create(const char *dev_path)
 	obj = g_new0(struct cs_ranging_obj, 1);
 	obj->dev_path = g_strdup(dev_path);
 
+	/* Never export a RangingProvider1 object as a direct child of "/":
+	 * bluetoothctl attaches its ObjectManager there, so "/" already has
+	 * registered gdbus object data, and gdbus/object.c's
+	 * invalidate_parent_data() dereferences a NULL "grandparent" when
+	 * asked to link a brand-new top-level child in that state. Nesting
+	 * under RANGING_PROVIDER_PATH instead keeps the immediate parent
+	 * unregistered, so gdbus skips the ancestor walk instead of
+	 * crashing. bluetoothd's provider watch matches any descendant of
+	 * the given root (see path_has_root() in src/ranging.c), so the
+	 * extra path component doesn't affect discovery.
+	 */
 	if (!strcmp(cs_provider_path, "/"))
-		obj->path = g_strdup_printf("/%s", leaf);
+		obj->path = g_strdup_printf("%s/%s", RANGING_PROVIDER_PATH,
+						leaf);
 	else
 		obj->path = g_strdup_printf("%s/%s", cs_provider_path, leaf);
 
@@ -1537,6 +1560,9 @@ static const struct bt_shell_menu cs_menu = {
 				"\t\t\t\t\t\t[path] is the provider root object"
 				" path; default \"/\", the only path"
 				" bluetoothctl exposes an ObjectManager at.\n"
+				"\t\t\t\t\t\texported RangingProvider1 objects are"
+				" nested under /org/example/ranging rather"
+				" than directly under \"/\".\n"
 				"\t\t\t\t\t\tsee test/example-ranging-provider for a"
 				" minimal standalone provider skeleton.\n\t\t\t\t\t\tOnly one"
 				" provider may be registered per adapter at"
-- 

