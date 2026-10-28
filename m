Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169969;
	b=k2a/3VMIpwi1ZI5Ut1Dp6FDoaeVBEC86NeAPloDC1bltR96wTYxtcnU36tR1p64bVGN1
	 x5J3MZHsW3tt8s2pUwiVH52FJP+lAYUdapwkPQR2aK+oZMgz2YyoM0Ci6EhraeuOFa+7F
	 55C0OaVDkyM8QhpLidWXvK3r5Ht3IleZHshTVGXoBWxWnEnOKP8kG53bybQlt7i8oJA6W
	 SOm60vaYL8/xxSQ4VQDfUJY77GIZyDHHEiuHQ5PHdWQRAlKhLu8mP3RvL0gTVkGDg6zO6
	 vy84H1O52zNs1p/E+G7l4dw17N8cL2tOlU2TvAOa4F8ESvx5GPG3PSaHhfomaGs/wXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fNZLE6g13OUkRAJQh2g053ezFujOCllvGhTaZvGIa/w=;
	b=z4cXNI3TXywf0qBBILB66oBt/3OmnLqIrgLBrSbDvjuaOia2oQ5G1kcHj8XxOfXEZnYK
	 I8655pSk6MI3IbKtW2U+caElTTqYI0cuJy9EjCioe0YA4Aw3bWpBETFJTMLPJYbKy0Rt0
	 3y+7H/y2YkYhTcetEgFS22d8kUFwMsvjEvv6NLLYMTB3LC5OJujtPwbFiJofRXbtGTMTP
	 WXr+XB2I3rbB5oKPmgMWsVvZK9paTL5gpnJc9GoR4fZQZqNuyswrh2RltXBWbgsYnGVMs
	 5Lsk0p8McRczOAQfKULI9FBCNQaXUyx/zX5r6+98J39SAeORTbVAHA95ss6IqpxOmJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pj8oBhJu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOtYqReV;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CC606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631CC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pj8oBhJu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOtYqReV
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4Pd2i3749793
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fNZLE6g13OUkRAJQh2g053ezFujOCllvGhTaZvGIa/w=; b=pj8oBhJu5/ZZdJ8l
	7/EDThTPLYP62orXP4P+P0oHUtcizPruNpd7yDYEjYC1Xjc14Qi8TVta2MnWxuiC
	qYYDom8iBLuGmwWxoI896XGYg9uLN/MfT4+rbs4K2fTKmDcJMdbNs0BnZBCMCbkN
	rIsMN3/Lbf1mAFH8H+BXX5YrrWsAEKkUDhG0lDTJh4McYSEROYyfKIaOtLBhStVV
	jbnEJdr5TVlEGVFIC9c9JUxarsabDxzuVnad5LjEIUBQkxV5Q72yczyR63rTy2e7
	zN9ZuJkCoTRpbB2Gc8H3FTh2ji3PDn1kgRdiPqj/qYPBxv8/zKMoRmpSbpTGDw2X
	+E0vrg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g2v2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:08 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-483ee5899ffso84200fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793169968; x=1793774768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNZLE6g13OUkRAJQh2g053ezFujOCllvGhTaZvGIa/w=;
        b=JOtYqReV/qd2xHLsz7dwtm1b9BiKx0rni9s/vQOU3DrmApDpg+QjHSYtHVrOdfKuJw
         jjQ/0oisew66WHwkQB3bJGkjgJA68oEuDqCwrFY6qU0PTLyEGzq8AdXdQqlD0GOZZB5g
         pkN+e5n5lS7cr/05tH1ZsCTZ43rFKndjl4SKsm2OirZCKIntczoYFfecWV+qpDAOhjNE
         zv7zjAyjVpYjJK292dkwSgIgGhlhq8X15tBWp1BpH0hWB+U0egStd8+V0YEQXRLI1Y9t
         h5loDLmbfAVo3jnmitFTgYSl3BpqDZRJiKh27JSw2FInWQ0CCaYtwYhUKmKYDT7M5Mao
         QbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793169968; x=1793774768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNZLE6g13OUkRAJQh2g053ezFujOCllvGhTaZvGIa/w=;
        b=GAHvQDtupH1UoQ2ghzayIWlcSi/+es6A7RwwqYpXpd4IyGNivLLbBo+46/+2efOv57
         tQPMPqzrMGboDrorIYpMV+AjJVBqi3cdWu3ErCFus84i6/tdOum2ySd9J/CHYzepykCN
         CB+cZamHsq3zumpiBAIegEik7dCdv02jZJXMQ23QU3wRNmttOydJmHBR85WPzvpm9Nk/
         k5QwmfmuwIhfijSfPTKKY8PUGwIiAANFgX+OTkAXJMRr1mZKEONEaZ4PPYkh2UfhXy+D
         yny6ziMIfsTEgG0JlIJBWJBDYauUMyhHEIUBJVst+lMjHOK1OLXPdI0+ILbm4cpfe4ji
         sUNg==
X-Forwarded-Encrypted: i=1; AKwUvBy2A9cIT1d4vwpTGKoYEsM9zo0IoMqDjuDQya28dRS9REjoIau8qnA931TfUE6ajzTJBZ8YUp95paPQBIfh8bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBjJXeYeVWVJjmV6QpRxbloXqvlxM7AH4Tr+Mm/7vYC4ilRWiC
	M207YvrrjjFLYWbfdxjDMPyhdjXuZZypUjcWEIXV5x1GVGuCQXCrmFU0K+EbMrYGKWIg7P+xg8C
	zanwRVbGZNs3K14KOTpTBDkXWHOA4rA88oMxsMaoueZomxtXCCTsoN0q1e7PbDym3vg5rXQk=
X-Gm-Gg: AYBFou2l9MnYxzIKSjFKNg73zK9CDyeXpwvFYyl8dJ0jqZa499n+jVHcC/dybKyCFIh
	HxkLvRVsNIGiOXqU89dJZGQG2GmmqnMVUR957YTop1i+l9frtL1gFkwcimiJLFmGMICgf2qFVju
	wGCVUZKCw/+CI+2TkYZaWrUfKCKb+Ktmhi0G+O/6MVSYR8EahhZMk13TYeQxaiG3qIEa8o1eS+k
	aF/1sOKqONvYzuQPRopexMZnFOHrAyWoRH6f6qrPHDTSdiIFr6PqTVf+obl67v4gx0qE10a4KMS
	TCp/+iRgvKUNq0A33geQyh8euWHFlZiXTH7BEl2qojRrdcxsFczURW45uu3t2O4WhwV/CILPyOR
	RVDKPdVMH1c4nGUiA2hsCH+Gw8kQGi6pTnUiLdzHMVVVrR4EDCJlEvf/W3oX5LehgyupU3nVLiz
	MwytnwZBMl0n7V4Cubtlge
X-Received: by 2002:a05:6830:67fb:b0:843:7bb5:28ad with SMTP id 46e09a7af769-85abf097011mr1938742a34.2.1793169967770;
        Tue, 27 Oct 2026 23:46:07 -0700 (PDT)
X-Received: by 2002:a05:6830:67fb:b0:843:7bb5:28ad with SMTP id 46e09a7af769-85abf097011mr1938729a34.2.1793169967375;
        Tue, 27 Oct 2026 23:46:07 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd30d98sm860727a34.14.2026.10.27.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:46:06 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 23:45:51 -0700
Subject: [PATCH bluez 2/2] obexd/bluetooth: Clean up redundant code
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
Message-Id: <20261027-fix_obex-v1-2-3d91aed181b6@oss.qualcomm.com>
References: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
In-Reply-To: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX65tUmtWvS5o9
 WWQtrxCkvdAfY4fkUmQavnpvSd5huMil5b6MFp7YFy1Tw9TodoCcBC+kVikyzClKxtIauurFJOw
 SDeTXmuBi7pmUdyaZK78Iywrg2NRB/jWX7FrQlO8nasiB4W6HtLaFankvhjrAcOp9bugEvkGhz0
 1T+zzRiTuIDCErkxzhMKtXrUmkgiQFe/mTZvdwAhF6NMCtWodAD7YrOfoTI8k9mvbZNTbv9mhl4
 8HPD1TmEl97swgHy5iPN6ZF8MmnO8lDLV8jD/FezRHF8K34jjq0yDccszZcxzH32vRRDgpVfT9Z
 rjvhJ8jyf7xVlDpVvukT5tApYRFOQoh3CjyXQ9W7yBR642XCEOtWymIY8EuOgkfZ7EEel8OMmly
 GVnidEsepFD7WTmTR9nPg+U8nsTVawmYYYXUruJvDtT/X8eHy8O6KXRw9rXuv7yjHPpKB5Psb/E
 4Tf7VR8NR5tVIeoPs1w==
X-Proofpoint-GUID: G21LC6BjjMz1DFkxYUCgB66mZNdzSyah
X-Proofpoint-ORIG-GUID: G21LC6BjjMz1DFkxYUCgB66mZNdzSyah
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfXwxBj0eQ3hOkC
 pOc7IYDGwCBNG0DjfAYA4Nghs+j3JwHVRY3pyLrRa0YhmmPiOfXo8iWypu60d9f3bsWM1zBEnFe
 jbB4Ja4E9ckwI7Bo96/AgqUQFY8Uxt8=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae19a30 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bBOUa_hTYMcDMAnvo84A:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280026

register_profile() already frees profile->path and sets it to NULL when
it fails, so the same cleanup in name_acquired() does nothing, and the
error message always prints a NULL path. Drop the cleanup and print the
profile UUID instead.

Also drop the trailing return in void functions.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/bluetooth.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index b70090971119..0aeb1becdf32 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -88,17 +88,16 @@ done:
 	if (obex_server_new_connection(server, io, omtu, imtu, stream) < 0)
 		g_io_channel_shutdown(io, TRUE, NULL);
 
 	return;
 
 drop:
 	error("%s", err->message);
 	g_io_channel_shutdown(io, TRUE, NULL);
-	return;
 }
 
 static DBusMessage *invalid_args(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
 					"Invalid arguments in method call");
 }
 
@@ -324,22 +323,19 @@ static void name_acquired(DBusConnection *conn, void *user_data)
 	bluez_available = TRUE;
 
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
 
 		if (profile->path != NULL)
 			continue;
 
-		if (register_profile(profile) < 0) {
-			error("bluetooth: Failed to register profile %s",
-							profile->path);
-			g_free(profile->path);
-			profile->path = NULL;
-		}
+		if (register_profile(profile) < 0)
+			error("bluetooth: Failed to register profile UUID %s",
+			      profile->uuid);
 	}
 }
 
 static void name_released(DBusConnection *conn, void *user_data)
 {
 	GSList *l;
 
 	DBG("org.bluez disappeared");
@@ -479,14 +475,15 @@ static void bluetooth_exit_cb(gboolean at_unregister)
 
 	obex_transport_driver_unregister(&driver);
 }
 
 static int bluetooth_init(void)
 {
 	return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
 }
+
 static void bluetooth_exit(void)
 {
-	return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
+	logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
 }
 
 OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)

-- 
2.34.1

