Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=YTEefuSUvI7gspXnjNUvod8XbSaq0CUksDSCBQ323im7P2/OB/Pkue8y0qUTLWoRHxDs
	 dXpFHpTbkF7HW11KeU7UzEIR6+7Tl7ZfZ26rRWlYvdg3J9EdHDuLYTTpglzc73Y5QXA3e
	 rbEgR2oV6G5d2ZDqanlbMoDpotsiI1wK0NY83IAY4oCVy8uUmB8VqNlHmj5cLAUzzaSpu
	 i3TJEx07s8x50u19x3CA73PL2nHg+KLJeNXzhB0rVaa/isiK7tZuMCDnBQT83JCwfO2mW
	 6a05sWeosEerR3h2U2xkKxD6cCP/IZl26yGNMwUa8abc0GlFs8OVpISUKX7bE5JenLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wqp8/eH2TgHBG574tI4yg0fKJ3ptLqR4+grMk1//fg8=;
	b=Y5UYQmfysGeBEKVq4VgfYr3Bvkx+6HhQ2jdG02c4fTR6oQERrglcGUwIuA9iGesTE0Yp
	 upIIYiSFaf/0m9GDvuGWhN5QNxxaz0z9BnWqJaY/yV2fN6hH1mLc6I0VDi7j8tNLiSXs2
	 OoT48m5z4P55CFNsX82PMJsm/3NpQ83606rShAnYUFFyQMLKXNlbX+xS9GIVzSG4oTb42
	 RAV82LxAqdaHmYEquapOT/u3SR5wUy3UERdZg3Y6OrkoHRpHDbG87PZtfZkd5ch4cM8+a
	 UNLp+N7gxfEw1E5p5CaM9XnKQdpUK7/+ExH9cljTvtRUR9KPmlcqNi9puQuXst0Lk/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kyMiNrXF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF685606A33F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF685606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kyMiNrXF
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ewA33488771;
	Mon, 16 Nov 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wqp8/eH2TgH
	BG574tI4yg0fKJ3ptLqR4+grMk1//fg8=; b=kyMiNrXF6xuS5+9rIjDuC8jwd5q
	PowdaJUX4T45PWk6U5HRp/1KeWQBCHq9nS10K1KhpRY6O0CjW0isrXXEk7Qa11Jp
	ghfjeXgJ8345tddVObVXcX64vfIbFw8YVFLgFz3g9M238Puv8qaksv7MiZRzjSNz
	vCp+Cisvfk0kPwHuDPd95kVRncLdQzRvhShv+vgVKM1VVQsVUCvximkIexq1vq3P
	7Ark2HeiyBhuPW10O1djZdPK0QSfTBysPa0puwK0XwMvNlStbDAaIIbo6T1IU6Rs
	wOKALcMqRfzUSq1EfU7S7Gno73Vig1WqA5IhEdyn4zYO775jmmneU1seLag==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcdmuw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tr52942877;
	Mon, 16 Nov 2026 09:06:55 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96tbp2942843
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 967BA27A01; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 06/20] obexd/pbap: Reject listing without Name in telecom folder
Date: Mon, 16 Nov 2026 17:06:20 +0800
Message-Id: <20261116090634.1222593-7-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXyuY2JUlUtyXb
 t1BkyTVVjadLJUBh1VMZAmd7f1mHyHIgxupq2IGK/j1kge/5GBVQexR319c1xvY7HbKJ0OJJRIH
 2rfhCi7zKO4BOzXFeigZ/RwVEM1xi4Q=
X-Proofpoint-ORIG-GUID: KcJgdVvI4r3Kd3zfIH-y6Zcnw131jlpt
X-Proofpoint-GUID: KcJgdVvI4r3Kd3zfIH-y6Zcnw131jlpt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwUnoZ8UXKwKL
 gvRuOuUBdFIeQxVwlX39aNXTUQyLJEGY3WEtKcHmcwg/xMjgOtcUiFduLbpps+ccyl98001AGHt
 fpJhiy29OqwknAgSwemaY2aeUcxIacd2JI9OkmXeiqva8RX8YoBnBQbzcYoGDevZchA3ENrxmQo
 uvxHDBONMX7dk68wm8ndmtqpicMS9d0LFNXSoXb/ETEF7Hn8x+FHv3ZaBQ7Ub+iOWPP29CiJVLZ
 WD/Blmn+/MumY8myZ4wv6BW5jAdDEEGYY9GlYVC9w/bTtjQGu0syaK7JjJPTnSobi7z/mp88yvE
 eoODS6788wkjYHy30IB9f687GWLqnoCQrAB2KyksfdSYsxweAw6na6TbcP4cW+fapDs6zg+DM+h
 3gty3e9iCKvR+7QgAgOsMmGdTx03k4vH1aZSaDDKNWWTBcClDql3GWCkseswij0zea6Q46x1z2q
 2bSj1fsCoxHHqS6tL1w==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afac7b1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=tXj-jVEF51iBFPFnddoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Return an error for a PullvCardListing request with an empty Name when
the current folder is telecom, which has no vCard listing.

Fixes: 2e2c48dfc234 ("obexd: Initial support for mimetype drivers on PBAP")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 3ee54f1fe..436981a4c 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -544,6 +544,10 @@ static int pbap_get(struct obex_session *os, void *user_data)
 	} else if (g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
 		if (!name || strlen(name) == 0) {
+			/* telecom has no vCard listing. */
+			if (g_strcmp0(pbap->folder, PB_TELECOM_FOLDER) == 0)
+				return -ENOENT;
+
 			/* Current folder */
 			path = g_strdup(pbap->folder);
 		} else {
-- 
2.34.1

