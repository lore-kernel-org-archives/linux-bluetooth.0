Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F981225397
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004917; cv=none; b=qh/3KtJsl25gmz5raPa3wKhTyhShTN/vMqpZgmcM3Md1h6d/fYJR3+PiUBl9aJqfpsrblJ9SUSLFiXC8wvJDaYxtkcEikrJyCVH7VDCx89UW6QBmoK/L2kOI9z67btHh3FLunZnVSE9p3pLPCbCrwfMATZg2gRYN5uZ6UJ+OjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004917; c=relaxed/simple;
	bh=yx/JrMKKwx8oPAGEXjY3BT2/C5HYrLFdyHNgpcJmYt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjJcJKAsg/CQEkTRhtgNPEmZMYrIqhJbbn7yFUdMGDV6sjOvX//8zD5iBtzER2ebDAo9IciivqzzSZbDZNBUA9KTeNjsE7HTz25plQ9n5We2uA2DXRVE5sLWU8NTYrcxf60BsWb1JxP0K+mnYV0uXerij+ugQA+KyU/abpQ6KEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FfL+zdIR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dJF76fnZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FfL+zdIR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dJF76fnZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NMN55O1823375
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 04:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8ViiRTzPBHFC4fza9srnrdbCjKLfqUC6J9D
	YuJh9Y6c=; b=FfL+zdIR/wIXdMdjvGx2exCu2wERif8jK8aWf9a6VJAsolwv4Zo
	i0CLhXF3XQMDXkfl9uPOOOjbjeDVwCLhMA3zg7ymCB5YwzsyJUGtNhwyrbcvqN5h
	EHg0GvwxhGBIvy16gjhZ05I9iVzQ+qOlWoSRnocCHzl1CncNZbpE8/0HkA53n726
	toxYHrfRNj8LgOicAY/vQL78Wf0yMNLDMEUK73QdHeeL/N/KtCqSj34B5VhP+ocQ
	EJIawwHGxrGlNaPC1EmIRp91619xr7d2lFzmaX2LWs5bZLlDkrVRCK3JK67gVjPP
	3bP7zPgi/l9unwk5U68/3fFQehJ+F4hcj8Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5rryfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 04:28:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso11001916a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777004915; x=1777609715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ViiRTzPBHFC4fza9srnrdbCjKLfqUC6J9DYuJh9Y6c=;
        b=dJF76fnZqtkg8va6AjlafKRQXGB4qNXk4Yy245ugmlmaPRvnOqtZgGvRV2mIitWZz8
         NTugL8cAkIsxjW6KOwBxRi+xSJ26tTVQA3qsYBn+ooBdACfAdxtLi5vtUXOmGRkcE9fk
         84X289BrBwk8gjyCGyvL02oeabNi/QfXTK4/EYFrRoDofoexGHkCy9YBIt9fuKgJa/Yp
         i0gbo4b2xUZBV34Thlr1g0/cdRBoKNUR7mCVBb070/uaWF/gORTAAnsuFXnIjxA4QHaf
         M+FBXeo+srj3y3zShkR/4+eXL5DQFcTYOzPOtmIDcqPwyIvPSzVDQEnjeLOvuvE82VZO
         K2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777004915; x=1777609715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ViiRTzPBHFC4fza9srnrdbCjKLfqUC6J9DYuJh9Y6c=;
        b=C0wNNt9phgXi6kEVCozIBEfqvxbNkVXiWUWMXkpvLHMKzoY/M7LbXPDafIrt7NcMvg
         l/Lgv0yEIufohDaZhNO8++beE8DkR4WMaSbKiwma2oDpzoBBhdv6u7ho9g/xdQRwKL6/
         d8VSAIMo0D8tcXvwGqA0G7Kna+nW6xWPLtmjkaRqHjTvBWOMjBkQD1YZ1frgiVdRSMa4
         OUouB6RUiK/CyNq9Ic74mu79ziDS/8Lhhk1H2LnDkhQurUj/YQSaDVDI4UgKPVVK+IYd
         WLcQCEfMnm8AkpbD/fnNhM9S0SWJZkoRUsNoKWjgUqZi+n7n0abPa81HfFPEr/pD2aLR
         cHRA==
X-Gm-Message-State: AOJu0Yz9Vb9NfsIUMMtpQ+x+Oh6o7Y1O55M8ArFaUAifO5AEBKUyGLmc
	f+1bMc01Hg5XIU+e756s5awJ5jn/vsM56hqyFTk6C2nBDFgO2POntDtIdpMQEFTJ+uCw2Z7gM+q
	gJZ9JUZ90N6z9TwAiCxSErK4G9WkT0eDbUKvt2Vhx3WxFP/PmEwqwFAfzVXP8hKYkplngeUlO6S
	M3AiQ=
X-Gm-Gg: AeBDies/ztMHwyRN+SPq1za2JOHC/NvJ/l3AVeCUI+Vs/D+YNv52uok1ADXpY/DYJr/
	dHfEhMne0r1Fx+1kfIGicl7jp3MGg6FEVlTDGZiTlqeFIHHpyn9uSq9RgqPov2/lVLLemZj1V2x
	1NxhWWYu+3B6RGjcJ4seX28d5UrMrAEVzuC5bzc9MYze5eO/G4sVgDUXsU6MVcV9g8sj/4p4kwm
	6YtvTB57wnTX0ugnsihRpPyG7SbE82tAdA0Z+jZAUeI5shoaTaknrJdbnif42P7+ENqTlmRLqvr
	4lnrwPYfNdGn8nSxJ5yBbnIjqBmcw3Kv9g4VEE+aWprjVv9ckHQwWNpCcSQgZNAh/60jlCMsSf5
	/rlFsUD4WgikCIgexhC/rP4F0fdnj50Ari8sPcsPmZdyE1fDbuMf/GA==
X-Received: by 2002:a05:6a20:3947:b0:3a2:e26b:2940 with SMTP id adf61e73a8af0-3a2e26c9037mr18760247637.0.1777004914639;
        Thu, 23 Apr 2026 21:28:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:3947:b0:3a2:e26b:2940 with SMTP id adf61e73a8af0-3a2e26c9037mr18760189637.0.1777004913893;
        Thu, 23 Apr 2026 21:28:33 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm22813751b3a.60.2026.04.23.21.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 21:28:33 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2] src/shared: add custom CCC callbacks
Date: Fri, 24 Apr 2026 09:58:30 +0530
Message-Id: <20260424042830.2374708-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eaf173 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=YFgapOvgPKZBqhaLY10A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: uswvL6vC3fEvBpMw6LygbOSWGmXhgqy5
X-Proofpoint-GUID: uswvL6vC3fEvBpMw6LygbOSWGmXhgqy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAzNiBTYWx0ZWRfX4+UKxOFA4OfZ
 WZRYyXns1A6zqGiJ1/cmn6/WBoaTNZbOjQq6md1+V1vrEOObivRtsYE/KaVh6+blAUTmCKVMt8X
 eFUx5Ty1ariZxuZ7ei4qK0ZhH+cXVnD0Yau/mBnh+++k4ZJM0s0/RSJngnN7YgeuRQwLMJc3cfW
 naZld8Bz0HqSZcgLMzDgccjvtk6NrmTrRqIyEFK/Jee+DSKqUVo/N6FwGZoP5HT/p+qv556BcjQ
 9d1iEt/lUVrfb1XD0ym3H5wD7VDdZHRSY35OOaJngK2uiKCqq24kse+G+awqXmvUMGfx88LaOxL
 H80LXvHz0OBprCBXzG8fjyp3MH1SCX7Vs5mVnWfMjLMKVtdbN3URN9xjCR65yGLrxZewbF2k2Q/
 30fgbLlOHr2sxt3JICN1hBadfD5fGAushiVnZ2wX+9tEHm3+Vl3WB/+hpHt5agNwSVlZ/ZBjCmQ
 1UdwtriXoLgBFJYP0fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240036

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Introduce custom CCC callbacks to allow interception of
client notification subscription changes. This enables
stack-level handling of CCC writes.
---
 src/shared/gatt-db.c | 119 ++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-db.h |   4 ++
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d0e149d6f..87cc61cf3 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1214,6 +1214,112 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 	return ccc;
 }
 
+static void ccc_custom_read(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct gatt_db *db = attrib->service->db;
+
+	db->ccc->read_func(attrib, id, offset, opcode, att, db->ccc->user_data);
+}
+
+static void custom_write_result(struct gatt_db_attribute *attr, int err,
+							void *user_data)
+{
+	int *result = user_data;
+
+	*result = err;
+}
+
+static void ccc_custom_write(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct gatt_db_ccc *data = user_data;
+	struct gatt_db *db = attrib->service->db;
+	struct pending_write *p;
+	int err = 0;
+
+	/* Create another pending write to handle results from custom write
+	 * function.
+	 */
+	p = new0(struct pending_write, 1);
+	p->attrib = attrib;
+	p->id = ++attrib->write_id;
+	p->func = custom_write_result;
+	p->user_data = &err;
+
+	queue_push_tail(attrib->pending_writes, p);
+
+	/* Call custom write function first */
+	data->write_func(attrib, p->id, offset, value, len, opcode, att,
+							data->user_data);
+
+	if (err) {
+		gatt_db_attribute_write_result(attrib, id, err);
+		return;
+	}
+
+	/* If custom write function did not return error proceed to call the
+	 * default CCC write function.
+	 */
+	db->ccc->write_func(attrib, id, offset, value, len, opcode, att,
+							db->ccc->user_data);
+}
+
+struct gatt_db_attribute *
+gatt_db_service_add_ccc_custom(struct gatt_db_attribute *attrib,
+				uint32_t permissions,
+				gatt_db_write_t write_func, void *user_data)
+{
+	struct gatt_db *db;
+	struct gatt_db_attribute *ccc;
+	struct gatt_db_attribute *value;
+	uint16_t handle = 0;
+	struct gatt_db_ccc *data;
+
+	if (!attrib || !permissions)
+		return NULL;
+
+	db = attrib->service->db;
+
+	if (!db->ccc)
+		return NULL;
+
+	/* Locate value handle */
+	gatt_db_service_foreach_char(attrib, find_ccc_value, &handle);
+
+	if (!handle)
+		return NULL;
+
+	value = gatt_db_get_attribute(db, handle);
+	if (!value || value->notify_func)
+		return NULL;
+
+	data = new0(struct gatt_db_ccc, 1);
+	data->write_func = write_func;
+	data->user_data = user_data;
+
+	ccc = service_insert_descriptor(attrib->service, 0, &ccc_uuid,
+					permissions,
+					ccc_custom_read,
+					ccc_custom_write,
+					data);
+	if (!ccc) {
+		free(data);
+		return NULL;
+	}
+
+	gatt_db_attribute_set_fixed_length(ccc, 2);
+	ccc->notify_func = db->ccc->notify_func;
+	value->notify_func = db->ccc->notify_func;
+
+	return ccc;
+}
+
 void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
 				gatt_db_write_t write_func,
 				gatt_db_notify_t notify_func,
@@ -2338,6 +2444,8 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 					struct bt_att *att)
 {
 	struct gatt_db_attribute *ccc;
+	struct gatt_db *db;
+	void *notify_user_data;
 
 	if (!attrib || !attrib->notify_func)
 		return false;
@@ -2350,7 +2458,16 @@ bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
 	if (!ccc)
 		return false;
 
-	attrib->notify_func(attrib, ccc, value, len, att, ccc->user_data);
+	/* For custom CCC descriptors, use the database user_data for
+	 * notify_func. For regular CCC descriptors, use the CCC's user_data.
+	 */
+	db = attrib->service->db;
+	if (ccc->write_func == ccc_custom_write && db && db->ccc)
+		notify_user_data = db->ccc->user_data;
+	else
+		notify_user_data = ccc->user_data;
+
+	attrib->notify_func(attrib, ccc, value, len, att, notify_user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index dc2daf7fc..da0600c01 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -112,6 +112,10 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 struct gatt_db_attribute *
 gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions);
 
+struct gatt_db_attribute *
+gatt_db_service_add_ccc_custom(struct gatt_db_attribute *attrib,
+				uint32_t permissions,
+				gatt_db_write_t write_func, void *user_data);
 struct gatt_db_attribute *
 gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
 			struct gatt_db_attribute *include);
-- 
2.34.1

