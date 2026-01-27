Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462822D4C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496454; cv=none; b=cnKThClNGXZkpcA4qoixLy9/XJbP7xMaEgThY2rtZs9QJwMvFY5MySujgGkmsPLB+MegJ2fbcYx78R4JuUYQr4DmVSVW7UhMp8cEvaHZQJ/QNXxgmLbUIlTIblK6H8N/MUiOYoVXBbvIfrg4XJuTPAvK5y0G8gNHQjqmMJ+f1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496454; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQYlCI8YQs5GHmrylRCMxnK9zvPBolB+uhIs6rV8YcS+zMvfwoTSg3vWy7rdhwJKgSQpxMMpX9qA3Hcn5Hk2ferzHNKkKM3qzUsasX9E15DnA7cUX/8CBuh70OuCVpEh2NrgckcOsajnGkXFKEC6k+8Sl03jJ+nv6lm2srkODDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/UszoQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNIOCaFo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/UszoQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNIOCaFo"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UTa6269670
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W8RsW3EFTEl
	jseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=; b=F/UszoQGWYUIivfqxMw0ifqZPSj
	Th61645FSHKtiO88w0GtJ91OuGLoLqtHFsm5bFExGE86XQBq5xytAJEWEgj5dRhO
	uTHbTvuRPnMtXYC1JvJHvl3VF6kNW7OTWNhF0IJz9ej2Wt8GrrtyAv2k0zLnyyC/
	qH4ZUB70e8iUUhCqf2OkAOz2eQQztw1XAA6HRjh+S8jqHVjlRzoXDA+M8wMqavKp
	fgfDbxikq37fxnqMsy2LE1wV4T1fMCdtcL5vez0AJUoWZmj/bd4k3IHwb016/jqu
	fFs8o5aDvcerrcfwrxhqoFJ9sAFYKCxzeGzIsy3AZfxB71iBhj7R6ofSL2g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx0v343et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c61334ba4d3so2619252a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769496451; x=1770101251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=UNIOCaFolDzg9jXakH9+TlbzYJNvDpN02Gne8Um0Ab1LJ2Xfwr5v96ovDzL59DRHqH
         +vGvV6d8c8VK+v71bTC+JaaDKwakiTLTdbrrWjhQ66Od2iwIRgedTFM7pW0qY5y4bgI7
         1kmavqKhkEgshpfyOZlkbxQ03dFy6S73f6kSdE7RpKWvbW1nzOQmiinGgbanZXlftmjG
         nZnK297R+aX0hwtw3xPbm8BH4nZrxHjOMnzIqqavs7kbrwdtTUE4+204Gq49+yWJTa9U
         r8M5xjY6SQU4gi9LmyRfCK+n7gUyeztJCav+X5KXFl34Fx/qwloEpsnahhrCd8aTi0y0
         nkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496451; x=1770101251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=acMFbJ2tfhreXm8CYY9a1msxsmieRdtMsZvzICpWgiOrmrCPzuf3tW+3iGu3u6V77y
         hLFuPV1JyeEIO8J/TDZS/VurxVg2bDYHgoPzxn10uNdUwhflDCoAIuqs//lS1qBkg6zx
         fZHTnJ1uAd51wQSel5tlSfkTM8Gqw2MZEYY4NKcj7r4IJWcweYipIKX/czV2xRsRlUoh
         W6N1Ig1EMI0lEkuDzbjeeWb+6J6MIfGSp+VFNnJUCx17x5mPFyZUapS9sTvQlrmIwOav
         vaS1aLA9UecJoPVLxj8hCv6E1PdeBe6H4tvL5iKi8VdGnL0S+eNsUcx6KMoLGz8t+M0W
         skag==
X-Gm-Message-State: AOJu0Ywec8aBXAv50Pp4NJS5tVu8gc+opNNarTKvghbliRItU6lWr9iv
	vz5Ni3h9nzBq1qyv8p8ftM8jy/ln3DDBfLz3nBHuPgsDgVGngUz5PdPRtVWPs639qTDWLUj+//Q
	huykWtQLIiMfURxPb5z9z6KOb7OEmJe4StX0V8tqhefYuGfQIWeP+e8+KAGuPQ3wcIhojSkw0Ov
	+jal4=
X-Gm-Gg: AZuq6aISYULZNgPR5lUINMYjv2N1aJICtWKsZk5Ht1KzSwHX4yFaY+Smp+zSIzTc/c7
	oIYr9B2epDIgGCBZZdkPw7E3jbvQXaHShMYS59ame6XKSj6Ol1rj+q7vuaAQtTOCvdx4Sh1OvLS
	RuDFnLRzPBadI3A9MZPmfaZh7XY3nlDqw3hMB3/AXjaBoHfZ7aoVs+ttAWIA4tCMUUjxOjNbT26
	ZouQjBzz2E33NyuAqD2fc+SvgCu/C6tIk+VIcq5A0EetURw62RREbjqtQ361VsJ9aPjDndRCuRj
	iDhTurX9HKYZNYDuYX8oCzyYq5i0/2Kn344bNRgQfjrWRMYYe+Qbjuzh/G3KvsQzrVbIYHmKW6P
	wwj6Xpt497by8GyBOTYy8fj/KWTzIg8zgBGFJWualKU36X3D9
X-Received: by 2002:a05:6a00:130f:b0:823:148c:d785 with SMTP id d2e1a72fcca58-82369198dbamr857480b3a.27.1769496451367;
        Mon, 26 Jan 2026 22:47:31 -0800 (PST)
X-Received: by 2002:a05:6a00:130f:b0:823:148c:d785 with SMTP id d2e1a72fcca58-82369198dbamr857457b3a.27.1769496450809;
        Mon, 26 Jan 2026 22:47:30 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm11032924b3a.61.2026.01.26.22.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:47:30 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 1/5] lib/uuid: Add RAS service and  characteristic UUIDs
Date: Tue, 27 Jan 2026 12:17:20 +0530
Message-Id: <20260127064724.2949465-2-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MyBTYWx0ZWRfXwfS3akGTydYg
 CsnOhplyQ3qdBh+nEF8LP+1EjXeJWl/Gd1Ns8ekd/sWF/xGDzGBs51dOjU19KSFtWoN5QIcGnQW
 TfhJLe7O1JV3zTlMJqB4kNre8AEe02HxUSemzFEA/di/XRwV/g+O6TsgHja3zqXVQdcT+XtxQ90
 7qBN6oARt8+HQLyxG6DAeGfRMZdA5C8NqxbwnFTg5xkeGoxh0JjSbeelh345G9EZVY5C6zmJd+G
 vhd+PCzhjMMjQTw61pH8PYiQZlqgX7FLMToqDQ5wXKTpsFs3+78321ws/P0698PZV8GNmjrwpvN
 1WIWpzg3U7SwswrwN704c4YSQ2aYVl8bpPSXsD8mDbFTEcdC0ImRVIsma+PZqErmU9Z12aRMB58
 3wOtWIPYva/kH5BYQNorKG9qN1FbwKx94QhitDhXHetuyyd8XpFI4+LqMUGDYeelK9kDHgUkowx
 +RyTlhlh9aNMCyqRtHw==
X-Proofpoint-GUID: JqjLMiC8j1qtPm5WPRiz8aoE5FMBN4Za
X-Proofpoint-ORIG-GUID: JqjLMiC8j1qtPm5WPRiz8aoE5FMBN4Za
X-Authority-Analysis: v=2.4 cv=JYyxbEKV c=1 sm=1 tr=0 ts=69785f84 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270053

---
 lib/bluetooth/uuid.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 74bd83742..bd3fdd486 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -50,6 +50,14 @@ extern "C" {
 #define BATTERY_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
 #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
+#define RAS_UUID	    "0000185b-0000-1000-8000-00805f9b34fb"
+#define RAS_FEATURES_UUID               0x2C14
+#define RAS_REALTIME_DATA_UUID          0x2C15
+#define RAS_ONDEMAND_DATA_UUID          0x2C16
+#define RAS_CONTROL_POINT_UUID          0x2C17
+#define RAS_DATA_READY_UUID             0x2C18
+#define RAS_DATA_OVERWRITTEN_UUID       0x2C19
+
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
-- 
2.34.1

