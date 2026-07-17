Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016083B8948
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273228; cv=none; b=kr1nEIf0RhqAOv2ULs/aq5N/VAVCVlxs5MX57T2ujoqdbNg6eYDfOP5c5HcYmkeKYd3Qanylk92JOWTXMrJoLkhmxtBdKYKCM+c7o8f9FdW0uWCkhYAVdvabVpE3IgnQJYZF895szTyGdUWfWLcVeFa/XexvzVzPag9m5pcNUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273228; c=relaxed/simple;
	bh=GObPdvRt7q5E30XHclQyjHyy6ZGJHCpcNxk0iTul0AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/h2zxgKbi2+P/3v4MrhlgqIKpVEw1LIky7StWc0lO/s8sSgsF3EAbeDBOVnghFYIM6TjgA5ULdjst1Q3zY2eoMzGrC0IXc+KZdDO6GRJiSl5Qrr08XJQUzemWAG/TUpDbd24TnmxdV2Fd2ye/KUip+9NWmd9IhMB9kkECvt8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7VCaSc7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DnyZog09; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7VCaSc7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DnyZog09"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cbjP979985
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RCf/+XXWj8j
	jJy+Bqer9CFYlyQvissJ2WYW45z9LOz8=; b=N7VCaSc7i5xC+U73wwadQusYyF1
	tLg6qsAQDTQiF/GkoR3mqA/JozTD72Yc4tAQvLmDyobs+EGyEPtg93WuG5PLY7vQ
	MDYWGM3M3yr9r0LenRqub9KlW/zuYYcMIyqdWYWbcKWMHCPivoqhoPIGQ3yP1NGi
	BXr8dWljPsAfOs1Z0SrpN3khngxX9s1+eI0BRsvuBueSZXn3E7JqXkq9fDsWToPW
	WXVAQ97eoApMtMcirwunAtlnN0wdMWWDpCEIxX0klmm3o4ChwZzUNkNogkcQsY2t
	GDGSlwp0mfwmju3q5REngeeZpQJ/2g9nOHkd3JFVGFjdOZLAJFoe+GWSHKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gr65v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:27:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso11017688a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784273223; x=1784878023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCf/+XXWj8jjJy+Bqer9CFYlyQvissJ2WYW45z9LOz8=;
        b=DnyZog09CUXrEKuy0QWDqOWuWQewsiNA3SqPipFpSrf47h9Eacog5jph6R3cATqstE
         5x/WnfTZ+HCuGV6ZVmvzvHs39JguOlXX/7kIlYgnT5Jnx4zzPsPlejsDI1365HampQF3
         62841QeHCw0QUW4fhpB2JC5XjP2mUS3XtTUKMZ5kH4gPT5RdSinskAMn3kMXdTgaXruu
         UVFOjroQJeFK5pjqF75jQQJhiGt7gG/uDet+RXHktD/lRB2wjGV6e66wW8a1HK4USs3Q
         uDGpzR7YT/iVW1eGHuqzG/ZuOOAHA+0iEWlMTBvTQqDwX41sUeQZ6DEsdZ5yW8e9Ip3S
         xfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273223; x=1784878023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCf/+XXWj8jjJy+Bqer9CFYlyQvissJ2WYW45z9LOz8=;
        b=le031NPzcqc2QUEnVAXNm4nnU/K7ebKh4SmBXaB//d2HPUnNalg0fHvxqZfq3PfRZF
         xf1sYRiPZzC8um0wc/bY0VQasULBzyV8iTq4N4WxhBQra8uq8AUy7uInmWOD4WmA57A1
         NFBzVH7PcSRF8CLq7o0aT5qdxpYDn99Rca8+2/Nm4xsM9xfn1LqyH63+z1i9iNxlt92d
         VKB29slL7ca0Mc3Aw96rGcnqiBJu9Tpg0+X9giBes1vwvDUF7PWsV3BNAFGUZgYroaGZ
         +5brrZg3cF8Hyj78ThKwkqutvs+9sKubRRx3fASSNs4Fcgn29kTV3wk9a9YzQOoVvz5e
         +e6A==
X-Gm-Message-State: AOJu0Yy6019WzhXFdTMWDXFydvxtpn4HftO1b8nnPEa7uojBT83T1STt
	BkOAunwWd+CJ+zIRPMVdwB11beMUDiXIHJrrm8XB2gbba+bPsa+PUeSDMEgmCNfkLbrvZdi8QW+
	HsAKbCAsIMAWDdn9P6eX38MrzqYJisLxaVaUerGo/1QI04zXF81+r1AGDdLvqB2oMqHbT6lt9zr
	b3Rtw=
X-Gm-Gg: AfdE7cmFv//v5uS/1iWygDtcwScYo8QJnUyxSVdqbly+rmD/DGOvIpdckrTJJXrYcSz
	fjtln9j07KNZuhA8BswejJ8gqhZzgzhFoMd9l6emc7CVQKuhL1e8iibLisCiTHbOCDUQKnuXyPB
	PkKye5pdPfkVyyGkpsvJAmHIYrRXR9PKAznOK6oO+ZT0LpM03d3u5mSRFgze4rskxWTZ/w/dziK
	/bTEAqREt9PkzKH1FYj/ocywh5yAVyKR0agmk4HxL29CF1oYP+89n96aJC8JewfY6E0TMSPf6/R
	9N7MsjfEIwKpWnk5KnjAobB7Onrenft6gnRfN+0AA/DhJ6n/JUi0b601jjwzTPTJT9FRzZQ83NY
	2hl60pLbVtteZTqLkeDjOzg==
X-Received: by 2002:a05:6a20:3886:b0:3c3:b628:6d17 with SMTP id adf61e73a8af0-3c3b62871a1mr204126637.25.1784273223187;
        Fri, 17 Jul 2026 00:27:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:3886:b0:3c3:b628:6d17 with SMTP id adf61e73a8af0-3c3b62871a1mr204098637.25.1784273222594;
        Fri, 17 Jul 2026 00:27:02 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm455579a12.26.2026.07.17.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:27:01 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 2/2] profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding
Date: Fri, 17 Jul 2026 12:56:47 +0530
Message-Id: <20260717072647.255002-3-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717072647.255002-1-prathm@qti.qualcomm.com>
References: <20260717072647.255002-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3MiBTYWx0ZWRfX21rdIllVTFtQ
 KMmv/VgjnoMmpYsZB5fvYucc1C8hJQNDTa8AnjRzgl0r4Tv5CiS3xxTjJYSVGoFhFuFyOpQMYGE
 QQUyYCVzfpbuMX/hbFBTCcPSe/Dm+rY=
X-Proofpoint-ORIG-GUID: KZ9b9qTv0-6ksI0CFgt2y_yBffOaDp5W
X-Proofpoint-GUID: KZ9b9qTv0-6ksI0CFgt2y_yBffOaDp5W
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a59d948 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Newsqy96Bbjq3UVVxBYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3MiBTYWx0ZWRfX/jjW1ZFtSeTv
 fHOo/jhwZxYVoeIobRYnnkQzaBQTuR/tHEj7sYmNBPOCYC5E4hBVWjayKj15VJsCsvCatgXUBEf
 b41vzZ+6vrxGbHCvQW32XKkJB1O/8KidSV2hCuL6CArREgeh1LiMSMKKnaUaPXqNpO/09QdPVAC
 G1j2RqQm1zpk8JTEmGklcZuZv32MyOL+9iLK83hNCFZwzyArv0874m9VUhDjQrWBhJxXRsHqSxe
 oMYm2dhpeO/mvpDLgFAWXvr7iJqvgqrbSvr8Lj4BEtoLj0Dsa7mvMTRzKVreHzZrmUPfTJ43y2K
 IIaZ8zR+N1lUT/bZfQ1N+pbwM9uWfiE5NLExcWDxsK3CLxL01Sbq8Zw7xfjIXOBwgewHvopqFKn
 v8Pm0HcfUf/NTLn0zhM6QVmJ4Ibbqrv5iWEFUmp9g2Xhh2MtBGnDYd1etUkDyVvQoKT0L8ceqI8
 h+gwooQQqh50d0RiV3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170072

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Marshal bcs_procedure_data (subevents, steps, mode 0/1/2/3 results,
and CS/procedure-enable config) into an a{sv} dictionary and emit it
as a new ProcedureData signal on the CS D-Bus interface.

Register a procedure_data callback on the RAP HCI state machine so
rap.c is notified when a procedure completes, and propagate the
locally supported T_SW time capability from the read-local-supported-
capabilities response into bt_rap.

---
 profiles/ranging/rap.c     | 497 ++++++++++++++++++++++++++++++++++++-
 profiles/ranging/rap_hci.c |  59 +++++
 2 files changed, 555 insertions(+), 1 deletion(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 3ffc0da76..42e1ef2a4 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -379,6 +379,492 @@ static const struct cs_dict_param_desc *cs_find_dict_param_desc(
 	return NULL;
 }
 
+static void dict_append_byte(DBusMessageIter *dict, const char *key,
+				uint8_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+						&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "y",
+						&variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_BYTE, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_int32(DBusMessageIter *dict, const char *key,
+				dbus_int32_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+						&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "i",
+						&variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_INT32, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_uint32(DBusMessageIter *dict, const char *key,
+				dbus_uint32_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+						&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "u",
+						&variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT32, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_uint64(DBusMessageIter *dict, const char *key,
+				dbus_uint64_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+						&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "t",
+						&variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT64, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_byte_array(DBusMessageIter *dict, const char *key,
+					const uint8_t *data, int len)
+{
+	DBusMessageIter entry, variant, arr;
+	int i;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+						&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay",
+						&variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y", &arr);
+	for (i = 0; i < len; i++)
+		dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &data[i]);
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void append_mode_zero(DBusMessageIter *dict,
+				const struct cs_mode_zero_data *m0)
+{
+	dict_append_byte(dict, "packetQuality", m0->packet_quality);
+	dict_append_byte(dict, "packetRssiDbm", m0->packet_rssi_dbm);
+	dict_append_byte(dict, "packetAntenna", m0->packet_ant);
+	dict_append_int32(dict, "initiatorMeasuredFreqOffset",
+				(dbus_int32_t)m0->init_measured_freq_offset);
+}
+
+static void append_pct_iq_pair(DBusMessageIter *dict, const char *key,
+				const struct pct_iq_sample *pct)
+{
+	DBusMessageIter entry, variant, arr;
+	dbus_int32_t i_s = pct->i_sample;
+	dbus_int32_t q_s = pct->q_sample;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+					 &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i", &arr);
+	dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_s);
+	dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_s);
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void append_mode_one(DBusMessageIter *dict,
+				const struct cs_mode_one_data *m1)
+{
+	dict_append_byte(dict, "packetQuality", m1->packet_quality);
+	dict_append_byte(dict, "packetNadm", m1->packet_nadm);
+	dict_append_byte(dict, "packetRssiDbm", m1->packet_rssi_dbm);
+	dict_append_int32(dict, "toaTodInitiator",
+				(dbus_int32_t)m1->toa_tod_init);
+	dict_append_int32(dict, "todToaReflector",
+				(dbus_int32_t)m1->tod_toa_refl);
+	dict_append_byte(dict, "packetAntenna", m1->packet_ant);
+	append_pct_iq_pair(dict, "packetPct1", &m1->packet_pct1);
+	append_pct_iq_pair(dict, "packetPct2", &m1->packet_pct2);
+}
+
+static void append_mode_two(DBusMessageIter *dict,
+				const struct cs_mode_two_data *m2,
+				uint8_t num_ant_paths)
+{
+	DBusMessageIter entry, variant, arr;
+	const char *key;
+	int j;
+	int num_paths;
+
+	/*
+	 * num_ant_paths is the HCI "number of antenna paths" value
+	 * (0-indexed), so actual tone sample count = num_ant_paths + 1,
+	 * capped at array size.
+	 */
+	num_paths = (num_ant_paths + 1) < CS_MAX_ANT_PATHS ?
+				(num_ant_paths + 1) : CS_MAX_ANT_PATHS;
+
+	dict_append_byte(dict, "antennaPermutationIndex", m2->ant_perm_index);
+
+	/* tonePctIQSamples: interleaved (i,q) pairs as "ai" */
+	key = "tonePctIQSamples";
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+					 &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i", &arr);
+	for (j = 0; j < num_paths; j++) {
+		dbus_int32_t i_s = m2->tone_pct[j].i_sample;
+		dbus_int32_t q_s = m2->tone_pct[j].q_sample;
+
+		dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_s);
+		dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_s);
+	}
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+
+	/* toneQualityIndicators: "ay" */
+	key = "toneQualityIndicators";
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+					 &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y", &arr);
+	for (j = 0; j < num_paths; j++) {
+		uint8_t tqi = m2->tone_quality_indicator[j];
+
+		dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &tqi);
+	}
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void append_proc_enable_config(DBusMessageIter *outer_dict,
+				const struct rap_ev_cs_proc_enable_cmplt *cfg)
+{
+	DBusMessageIter entry, variant, inner;
+	const char *key = "procedureEnableConfig";
+	dbus_uint32_t sub_evt_len_us;
+
+	sub_evt_len_us = cfg->sub_evt_len[0] |
+			 ((uint32_t)cfg->sub_evt_len[1] << 8) |
+			 ((uint32_t)cfg->sub_evt_len[2] << 16);
+
+	dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{sv}",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{sv}",
+					 &inner);
+
+	dict_append_byte(&inner, "toneAntennaConfigSelection",
+			 cfg->tone_ant_config_sel);
+	dict_append_uint32(&inner, "subeventLenUs", sub_evt_len_us);
+	dict_append_byte(&inner, "subeventsPerEvent", cfg->sub_evts_per_evt);
+	dict_append_uint32(&inner, "subeventInterval", cfg->sub_evt_intrvl);
+	dict_append_uint32(&inner, "eventInterval", cfg->evt_intrvl);
+	dict_append_uint32(&inner, "procedureInterval", cfg->proc_intrvl);
+	dict_append_uint32(&inner, "procedureCount", cfg->proc_counter);
+	dict_append_uint32(&inner, "maxProcedureLen", cfg->max_proc_len);
+
+	dbus_message_iter_close_container(&variant, &inner);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(outer_dict, &entry);
+}
+
+static void append_cs_config_param(DBusMessageIter *outer_dict,
+				const struct bcs_procedure_data *bcs)
+{
+	DBusMessageIter entry, variant, inner;
+	const char *key = "csConfigParam";
+	const struct rap_ev_cs_config_cmplt *cfg = &bcs->cs_config;
+
+	dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{sv}",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{sv}",
+					 &inner);
+
+	dict_append_byte(&inner, "modeType", cfg->main_mode_type);
+	dict_append_byte(&inner, "subModeType", cfg->sub_mode_type);
+	dict_append_byte(&inner, "rttType", cfg->rtt_type);
+	dict_append_byte_array(&inner, "channelMap", cfg->channel_map,
+			       sizeof(cfg->channel_map));
+	dict_append_byte(&inner, "minMainModeSteps", cfg->min_main_mode_steps);
+	dict_append_byte(&inner, "maxMainModeSteps", cfg->max_main_mode_steps);
+	dict_append_byte(&inner, "mainModeRepetition", cfg->main_mode_rep);
+	dict_append_byte(&inner, "mode0Steps", cfg->mode_0_steps);
+	dict_append_byte(&inner, "role", cfg->role);
+	dict_append_byte(&inner, "csSyncPhyType", cfg->cs_sync_phy);
+	dict_append_byte(&inner, "channelSelectionType", cfg->channel_sel_type);
+	dict_append_byte(&inner, "ch3cShapeType", cfg->ch3c_shape);
+	dict_append_byte(&inner, "ch3cJump", cfg->ch3c_jump);
+	dict_append_byte(&inner, "channelMapRepetition", cfg->channel_map_rep);
+	dict_append_byte(&inner, "tIp1TimeUs", cfg->t_ip1_time);
+	dict_append_byte(&inner, "tIp2TimeUs", cfg->t_ip2_time);
+	dict_append_byte(&inner, "tFcsTimeUs", cfg->t_fcs_time);
+	dict_append_byte(&inner, "tPmTimeUs", cfg->t_pm_time);
+	dict_append_byte(&inner, "tSwTimeUsSupportedByLocal",
+			 bcs->t_sw_time_us_supported_by_local);
+	dict_append_byte(&inner, "tSwTimeUsSupportedByRemote",
+			 bcs->t_sw_time_us_supported_by_remote);
+	dict_append_uint32(&inner, "bleConnInterval", bcs->ble_conn_interval);
+
+	dbus_message_iter_close_container(&variant, &inner);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(outer_dict, &entry);
+}
+
+static void append_step_to_dict(DBusMessageIter *dict,
+				const struct cs_step_data *step,
+				uint8_t num_ant_paths)
+{
+	DBusMessageIter entry, variant, inner;
+	const char *mode_key;
+
+	dict_append_byte(dict, "stepMode", step->step_mode);
+	dict_append_byte(dict, "stepChannel", step->step_chnl);
+
+	switch (step->step_mode) {
+	case CS_MODE_ZERO:
+		mode_key = "modeZeroData";
+		dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						 NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					       &mode_key);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						 "a{sv}", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						 "{sv}", &inner);
+		append_mode_zero(&inner,
+				 &step->step_mode_data.mode_zero_data);
+		dbus_message_iter_close_container(&variant, &inner);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(dict, &entry);
+		break;
+
+	case CS_MODE_ONE:
+		mode_key = "modeOneData";
+		dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						 NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					       &mode_key);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						 "a{sv}", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						 "{sv}", &inner);
+		append_mode_one(&inner,
+				&step->step_mode_data.mode_one_data);
+		dbus_message_iter_close_container(&variant, &inner);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(dict, &entry);
+		break;
+
+	case CS_MODE_TWO:
+		mode_key = "modeTwoData";
+		dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						 NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					       &mode_key);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						 "a{sv}", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						 "{sv}", &inner);
+		append_mode_two(&inner,
+				&step->step_mode_data.mode_two_data,
+				num_ant_paths);
+		dbus_message_iter_close_container(&variant, &inner);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(dict, &entry);
+		break;
+
+	case CS_MODE_THREE:
+		mode_key = "modeThreeData";
+		dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						 NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					       &mode_key);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						 "a{sv}", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						 "{sv}", &inner);
+		append_mode_one(&inner,
+			&step->step_mode_data.mode_three_data.mode_one_data);
+		append_mode_two(&inner,
+			&step->step_mode_data.mode_three_data.mode_two_data,
+			num_ant_paths);
+		dbus_message_iter_close_container(&variant, &inner);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(dict, &entry);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void append_subevent_to_dict(DBusMessageIter *dict,
+				const struct cs_subevent_result_data *sub)
+{
+	DBusMessageIter entry, variant, arr;
+	const char *key;
+	uint32_t i;
+
+	dict_append_int32(dict, "startAclConnEvtCounter",
+			  (dbus_int32_t)sub->start_acl_conn_evt_counter);
+	dict_append_int32(dict, "freqComp", (dbus_int32_t)sub->freq_comp);
+	dict_append_byte(dict, "refPwrLvl", (uint8_t)sub->ref_pwr_lvl);
+	dict_append_byte(dict, "numAntPaths", sub->num_ant_paths);
+	dict_append_byte(dict, "subeventAbortReason",
+			 sub->subevent_abort_reason);
+	dict_append_uint64(dict, "timestampNanos", sub->timestamp_nanos);
+	dict_append_uint32(dict, "numSteps", sub->num_steps);
+
+	/* stepData: av (each element is a{sv}) */
+	key = "stepData";
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+					 &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v", &arr);
+	if (sub->step_data) {
+		for (i = 0; i < sub->num_steps; i++) {
+			DBusMessageIter inner, step_dict;
+
+			dbus_message_iter_open_container(&arr,
+					DBUS_TYPE_VARIANT, "a{sv}", &inner);
+			dbus_message_iter_open_container(&inner,
+					DBUS_TYPE_ARRAY, "{sv}", &step_dict);
+			append_step_to_dict(&step_dict, &sub->step_data[i],
+					    sub->num_ant_paths);
+			dbus_message_iter_close_container(&inner, &step_dict);
+			dbus_message_iter_close_container(&arr, &inner);
+		}
+	}
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void append_subevent_array(DBusMessageIter *outer_dict,
+				const char *key,
+				const struct cs_subevent_result_data *subevents,
+				uint32_t count)
+{
+	DBusMessageIter entry, variant, arr;
+	uint32_t i;
+
+	dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av",
+					 &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v", &arr);
+	for (i = 0; i < count; i++) {
+		DBusMessageIter inner, sub_dict;
+
+		dbus_message_iter_open_container(&arr, DBUS_TYPE_VARIANT,
+						 "a{sv}", &inner);
+		dbus_message_iter_open_container(&inner, DBUS_TYPE_ARRAY,
+						 "{sv}", &sub_dict);
+		append_subevent_to_dict(&sub_dict, &subevents[i]);
+		dbus_message_iter_close_container(&inner, &sub_dict);
+		dbus_message_iter_close_container(&arr, &inner);
+	}
+	dbus_message_iter_close_container(&variant, &arr);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(outer_dict, &entry);
+}
+
+static void rap_emit_procedure_data(struct rap_data *data,
+				const struct bcs_procedure_data *bcs)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, dict;
+
+	signal = dbus_message_new_signal(device_get_path(data->device),
+					 CS_INTERFACE, "ProcedureData");
+	if (!signal) {
+		error("Failed to allocate ProcedureData signal");
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	dict_append_int32(&dict, "procedureCounter",
+			  (dbus_int32_t)bcs->procedure_counter);
+	dict_append_int32(&dict, "procedureSequence",
+			  (dbus_int32_t)bcs->procedure_sequence);
+	dict_append_byte(&dict, "initiatorSelectedTxPower",
+			 (uint8_t)bcs->initiator_selected_tx_power);
+	dict_append_byte(&dict, "reflectorSelectedTxPower",
+			 (uint8_t)bcs->reflector_selected_tx_power);
+
+	dict_append_uint32(&dict, "initiatorSubeventCount",
+			   bcs->initiator_subevent_count);
+	if (bcs->initiator_subevent_results &&
+					bcs->initiator_subevent_count > 0)
+		append_subevent_array(&dict, "initiatorSubeventResults",
+				      bcs->initiator_subevent_results,
+				      bcs->initiator_subevent_count);
+
+	dict_append_byte(&dict, "initiatorProcedureAbortReason",
+			 bcs->initiator_procedure_abort_reason);
+
+	dict_append_uint32(&dict, "reflectorSubeventCount",
+			   bcs->reflector_subevent_count);
+	if (bcs->reflector_subevent_results &&
+					bcs->reflector_subevent_count > 0)
+		append_subevent_array(&dict, "reflectorSubeventResults",
+				      bcs->reflector_subevent_results,
+				      bcs->reflector_subevent_count);
+
+	dict_append_byte(&dict, "reflectorProcedureAbortReason",
+			 bcs->reflector_procedure_abort_reason);
+
+	append_proc_enable_config(&dict, &bcs->proc_enable_config);
+	append_cs_config_param(&dict, bcs);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(btd_get_dbus_connection(), signal);
+}
+
+static void rap_procedure_data(struct bt_rap *rap,
+				struct bcs_procedure_data *bcs,
+				void *user_data)
+{
+	struct rap_data *data = user_data;
+
+	DBG("procedure_counter=%u", bcs->procedure_counter);
+	rap_emit_procedure_data(data, bcs);
+}
+
 static DBusMessage *start_measurement(DBusConnection *conn,
 				DBusMessage *msg, void *user_data)
 {
@@ -534,6 +1020,9 @@ bad_type:
 	data->active_session.cfg           = cfg;
 	data->active_session.freq          = freq;
 
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_data,
+					 data, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -588,6 +1077,11 @@ static const GDBusPropertyTable cs_dbus_properties[] = {
 	{ }
 };
 
+static const GDBusSignalTable cs_dbus_signals[] = {
+	{ GDBUS_SIGNAL("ProcedureData", GDBUS_ARGS({ "data", "a{sv}" })) },
+	{ }
+};
+
 static void rap_measurement_timeout_cb(void *user_data)
 {
 	struct rap_data *data = user_data;
@@ -752,7 +1246,8 @@ static int rap_accept(struct btd_service *service)
 	g_dbus_register_interface(btd_get_dbus_connection(),
 				  device_get_path(data->device),
 				  CS_INTERFACE, cs_dbus_methods,
-				  NULL, cs_dbus_properties, data, NULL);
+				  cs_dbus_signals, cs_dbus_properties,
+				  data, NULL);
 
 	return 0;
 }
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index e57f967a2..3da98972e 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -442,6 +442,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 	DBG("Sending read remote capabilities for handle 0x%04X",
 		sm->active_conn_handle);
 	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
+
+	bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
 }
 
 static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
@@ -873,6 +875,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		cs_set_state(sm, CS_STATE_INIT);
 		rap_send_hci_def_settings_command(sm, evt);
 	}
+
+	bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
 }
 
 static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
@@ -1162,6 +1166,46 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 			&rap_ev, sm->rap);
 }
 
+static void rap_le_conn_update_complete_evt(const void *data, uint8_t size,
+					    void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
+	const struct bt_hci_evt_le_conn_update_complete *evt;
+	struct rap_conn_mapping *mapping;
+	struct bt_rap *rap;
+	struct iovec iov;
+
+	if (!sm || !data ||
+	    size < sizeof(struct bt_hci_evt_le_conn_update_complete))
+		return;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = size;
+
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt) {
+		error("Failed to pull LE conn update complete struct");
+		return;
+	}
+
+	DBG("status=0x%02X handle=0x%04X interval=%u",
+	    evt->status, evt->handle, evt->interval);
+
+	if (evt->status != 0)
+		return;
+
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (mapping && mapping->rap) {
+		DBG("Found handle 0x%04X in mapping cache", evt->handle);
+		rap = mapping->rap;
+	} else {
+		error("No mapping found for handle 0x%04X", evt->handle);
+		return;
+	}
+
+	bt_rap_set_conn_interval(rap, evt->interval);
+}
+
 static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
 				int16_t *q_sample)
 {
@@ -1662,6 +1706,8 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 					rap_cs_subevt_result_evt },
 		{ BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
 					rap_cs_subevt_result_cont_evt },
+		{ BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
+					rap_le_conn_update_complete_evt },
 	};
 	struct cs_state_machine *sm;
 	unsigned int i;
@@ -1781,6 +1827,19 @@ bool bt_rap_stop_measurement(void *hci_sm)
 						false);
 }
 
+bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
+				bt_rap_procedure_data_func_t cb,
+				void *user_data,
+				bt_rap_destroy_func_t destroy)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !sm->rap)
+		return false;
+
+	return bt_rap_set_procedure_data_cb(sm->rap, cb, user_data, destroy);
+}
+
 bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
 		uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_type,
 		bool is_central)
-- 
2.34.1

