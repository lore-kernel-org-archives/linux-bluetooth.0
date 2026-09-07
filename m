Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD78471CF0
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789381; cv=none; b=pLn5GPLIGME09I1Q36IAnLMuhUn8za3RXo2ftX9BUm0FqVu0E+GuuP2ZLANKiXFTsly/jfmLI7+TUkjW5b5plp0Y5rtpnuZvOSII2uI/lrZu29otXlilrbb5rX5fMne1M6VJ4WZPJk9e09VINLVATW9bUodqUADgi4a3UbltUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789381; c=relaxed/simple;
	bh=luj9Cjr1nD7xsRYvYFg5HjxUNMV95ikIVXtGTblX4I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lF4Ez2N2N1PfwkAdQIlCVLpHmIE1ExNioPGcEkdcQ5/zeKDeMV+s6SdSkp0KZn9VzlzRw02QKrA4nQjTnlPelKr0FBcS/cEPLtNH1CupfF6hiADSbvZiqYEFUzVpEOGNWhqvCSTExEwe5FJrmzCrxy+OpFScY1vQ5mppq0oYelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odthYuIZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxsDIuCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odthYuIZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxsDIuCi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdRxP051470
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 13:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gmk9CZzgHt2
	Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=; b=odthYuIZ/owx2bjQlbCEfpbl8L1
	aIkeaAnMSA2rVThQW+34DaeW4lxY0aBL38sTNUZ8Avc6JSd7uTlWyWn43N2ilGar
	Nra/D0iTbRBBIqPM2a2toHz8rsqRuJpgw0ouP3RycW/VkW2a8L6Q51JLF3sqQbI9
	4sIxS21G+zeOa3i5VngGyKy6YcljAPsfS0Phr89or0Q8fuECy242ye1JBDEyAngo
	dKkCbwwEvd/gLLUC4FHmfPc8rv04M08tFs40h9MGS7OseMpR9p2hIcp1/2EFoNtr
	scGNUyM0lawIlYYIUvC8h8rQD9CGAxHgyLxcQ9xcrTNti7yLUPRP/tTA3FA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj29q9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 13:56:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so22887a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788789378; x=1789394178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gmk9CZzgHt2Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=;
        b=TxsDIuCiQ9x2KOPs9my3xofbgXbt1rQTkpYPo3bC0d9heihg9tiyZ8NSvFvaxrxZb6
         6VLsrKNQSL+ncOl90Ls0cGxc9ND+GQytqgj/n1CzlsgtyFzOekc9mAy7cWgFl6fEq9B1
         Pz8IjNBdXUDMZ9D1Wb13NfmgY/CpuF48KF/vJna+h5FyeoAAH0Pe65yoB8RSqvbqT5Xa
         HyO9MUOgBE5j1LKIDC2E4i92a/sKpxRQqD81/KVh0EcPeoPT005FwfGBit1lMubZUtTs
         jiaTl+dA6ESnWPWILyzs3n9IjcrbERx7KR8GLsRJwQZ1gtVOtPFKkBIAFNs4kxCfdqnt
         6m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789378; x=1789394178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gmk9CZzgHt2Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=;
        b=IKqbvQqK/BnaKrGr9BMpr+z5wBb333nwbzCczSgqpDPdG6vf8ftkn/OAdGzUnfv21P
         Lh8JRkQO6UfAYCyYCtCT1MxMim5nV9cidqB0H0O7ZTBkEtpdp12Eka77dHYyms0dVT5h
         lIa9ew7nQbZi9YkVm3A0G1DSOyPxcov3+8gRPt+gaYiruirCGXwpax+KIJPHw9/8UWhD
         HhvA6jdEVxpBjLlpi0wAJmV/i5x9w3M1CnZSoqua5gyFtf4cm14Jg27SrclhD0pJhLOb
         eFGAnazFu29G1xSP0x5svVrwit97a80hz6HoYvNYPyNzdSs2n1JdkTxmjCfSa/ffCwS3
         HEWg==
X-Gm-Message-State: AFuF++ld2swedGQkC/9k0KqFvnFRdvsockDR/YA6yUorw2pX7uaqeNqi
	XgSRybSWOrNrbb2319bY+XEKxSmFxjIMzomeGLX96IWGXvACz7Z1Xr6/opKHjxt1jttqSJzRj4I
	7ES3k2AGI1YZ0XITXwJtqM2BfFgIQ1KZvdfxnOfjxC90x/aBHx0f2wH+nE7oWKtsk+k5JNChBxZ
	FQqjQ=
X-Gm-Gg: AYBFou1OlUX8rwNHo5+hbeAD3uJf7kxf5/ANYketCxK+qgiv6N88qgn5lZmoVcWvM3Y
	5TAwIWaswG5DbTHYkyCM6cAReeVVxxisfRLqxgiArA/A0MtFWjb2IQcr3kxL4tfRKceXIb7YpCc
	KsKHHcKuCMxEeAj9BnelqbZIQkDsctej8FuDcnOQUm+UXkBGnEEbWQ/sTuLW4zaDXl5mXgFYyyl
	ybvPOrymQ/mnYUgtow1kd5kKRyXIzg0NGnDkyrr5VIWqtsTzo+Bz29BBzDj3o3R48l1Hg7l3xKb
	9M9z+kO+W/C/6yme4PuPcOON4IoQ4zKuhvs2IsEGCKci9jQ6OFAD4B1Vj6184U7SGAdqKfZYpuQ
	UVR1SNr7S9BpHdLhS8g95anJTulHpww==
X-Received: by 2002:a17:90b:4c44:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39b261cdb38mr33265895a91.13.1788789378354;
        Mon, 07 Sep 2026 06:56:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4c44:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39b261cdb38mr33265823a91.13.1788789377813;
        Mon, 07 Sep 2026 06:56:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm31561116eec.2.2026.09.07.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:56:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/3] rap: Add OndemandRanging configuration option
Date: Mon,  7 Sep 2026 19:26:04 +0530
Message-Id: <20260907135606.824752-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907135606.824752-1-naga.akella@oss.qualcomm.com>
References: <20260907135606.824752-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE1NCBTYWx0ZWRfXxoqGIaufYO2F
 QodJ/pV59DIf6VzdEGHRKiqUKA8TFusJX6o0yXEouzwW0iSVqZGzK0pnuF1CnjdcMBruaTbst5H
 CkNKDynKFZVR94QdzjOEXjAB2gIqZCyud1sfovwdcJdfaoDHCbiEU97X2d/qzNaMne3KhZNPOYj
 SgKrqHrCylAQpYwcTm61rYfcH6Hhext1nWahz3RnzniUOMBhiT5wnjnE2glF01HJY/qI9npIOXK
 8qJlZIBJipoFJYfpBelXQf+yGDyxXV3hmTiVakesr6TkDklHlY8pWFud9C7L5BTSzDaR8kXpI0W
 XWv2ZhVOCaYHzc168BrAFnqqW1gu1Vod4xrGwBtzd+Vzn5up4pyXAn40NPRNgvrbZVIGnQls1yT
 KTXPLo5DpKfjW1F96lnJ/4l3ciYxO7D+AdtwGfz0MEnSn1MpT4P5/vm1B4MEpr45+xwsmE0I8yo
 dcGGcST7mhXm1p4shxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE1NCBTYWx0ZWRfX/4M2kcgYQHCo
 Y2WiOmsq3/zMKYvkDxtgjorMktLaYCVROE7qSRMERHyZwAxIanvLc3TWnzonCUFEcSo53xl+op2
 W+UNw+193r34jeiubawfJG1Nr/ilCqI=
X-Proofpoint-ORIG-GUID: O4IPihagfbMIk_fSbyeuxfN19avxvDzQ
X-Proofpoint-GUID: O4IPihagfbMIk_fSbyeuxfN19avxvDzQ
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9ec283 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=0HA1kYP0LkdLL_d7j9cA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070154

Add a per-adapter config knob under [ChannelSounding] to let the RAS
Initiator use on-demand Ranging Data delivery (Get_Ranging_Data/
ACK_Ranging_Data) instead of real-time notifications. Defaults to
false.

- src/btd.h: add bool ondemand_ranging to struct btd_le_bcs.
- src/main.c: parse "OndemandRanging" into
  btd_opts.defaults.bcs.ondemand_ranging.
- src/main.conf: document the new option.
---
 src/btd.h     | 1 +
 src/main.c    | 4 ++++
 src/main.conf | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index db2e81239..d70276b1d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -98,6 +98,7 @@ struct btd_le_bcs {
 	uint8_t role;
 	uint8_t cs_sync_ant_sel;
 	int8_t max_tx_power;
+	bool ondemand_ranging;
 };
 
 struct btd_defaults {
diff --git a/src/main.c b/src/main.c
index 8aa19a3e3..c7a55d30f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -160,6 +160,7 @@ static const char *const bcs_options[] = {
 	"Role",
 	"CsSyncAntennaSel",
 	"MaxTxPower",
+	"OndemandRanging",
 	NULL
 };
 
@@ -1301,6 +1302,8 @@ static void parse_le_cs_config(GKeyFile *config)
 	parse_config_signed_int(config, "ChannelSounding",
 			"MaxTxPower", &btd_opts.defaults.bcs.max_tx_power,
 			INT8_MIN, INT8_MAX);
+	parse_config_bool(config, "ChannelSounding", "OndemandRanging",
+			&btd_opts.defaults.bcs.ondemand_ranging);
 }
 
 static void parse_avdtp_session_mode(GKeyFile *config)
@@ -1437,6 +1440,7 @@ static void init_defaults(void)
 	btd_opts.defaults.bcs.role = 0x03;
 	btd_opts.defaults.bcs.cs_sync_ant_sel = 0xFF;
 	btd_opts.defaults.bcs.max_tx_power = 0x14;
+	btd_opts.defaults.bcs.ondemand_ranging = false;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 80f4a3a0c..1d8e97dc6 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -323,6 +323,14 @@
 # Default: 20 (Max Power possible)
 #MaxTxPower = 20
 
+# Enables on-demand Ranging Data delivery for the RAS Initiator role.
+# When true, the initiator subscribes to the On-demand Ranging Data,
+# Ranging Data Ready/Overwritten, and RAS Control Point characteristics
+# and fetches ranging data via Get_Ranging_Data/ACK_Ranging_Data instead
+# of the default real-time streaming path.
+# Default: false (use real-time streaming)
+#OndemandRanging = false
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 

