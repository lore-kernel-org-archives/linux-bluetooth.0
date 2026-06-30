Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B293EC2F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814354; cv=none; b=qHRQXG9mgueIoQ0Pe8IiDJcNft0kblbZssHQRacmw1jVIforpFCKdPW3rEb8Q2Rebo+errNTomr4298mi7gPDXqcOMPwmqIyF2p8Jd6NzlnY2XMIc68SLMG77CLJOsw7Lb/X0klPCOQ4drbDFDajE4lD0iPaYNUrL3fuUNED7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814354; c=relaxed/simple;
	bh=d2aNMTN8+hunSS38zcukSOmwecqtZC5jpcsM0Akep50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmQ3KrEqvqwJF1ke6KoAiiPXEYoPVyCdHysK5KpGsRKnChjXlbFYLB1Eep0f8b/3iP/H9+jlEvJ/hAJF6KN3WAH3IozhCi8Duv1mbagiwMnvD8TqPeYIuLUqJadpBpC2zPgIG+dKTlOnGCj62ncJaycXN1ypmXQKXEEOmKZN/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ohd7nAh/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ho5t3hc7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ohd7nAh/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ho5t3hc7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mqwZ1541611
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rekD2/6Ee8n
	++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=; b=Ohd7nAh/2caLyTwnG7IGthhEHGm
	BD5DOBeLDduhWqe4rbCM+fNCSOnciwhDZGgZzYDvIN0B1HxQY9ND7L2m7bknqJSy
	ln5hqqawRxjC/B8nOceqlCXdYamB3AsAkTJhidi4PanLi9oPl5lOpTC+9QNGZKf9
	JDkNB4gWk671bsHxPH7GAIRc3ONfxumV0RG98yYHfLQ18LGEl7HMf9JQT536Mnk1
	OKFDOIklD0bMbBcdDCH/tmk7EOq6Qfnz0rmJd5r9jKc/53z3MlzKhSFH1jRCkpIC
	wQWStr3UGUpa0DXbYw3oZ1q9nCGbYjC0vRqIW6iIZe7JGrQZCt5/uMPDBZw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp1ucm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-137f3465368so6330870c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814352; x=1783419152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rekD2/6Ee8n++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=;
        b=ho5t3hc7Bwr02xgPLwk2/COHu/aRl5MtT/avTs3hxTTDm86NMkH9rhRVO+VLb6Rs/0
         2sUoOW0v8hrDguEIA6ldrLFbwVyvtvbJjqX4BUmh+NmJO53SuxKJqsvX4puiHa42Ovl5
         SwPH1F1eKDu+Y6z/M+Eq7BNlz78n+DB86L8DeW92ZZf5lq9cxd5m29OxdCKaYUFuF0Dn
         fBMjWtWhVywGiffTFWPlMvQ2/JdChbr7N9YtnaD2tNata1RByjiJtboVOteytVcXZISH
         kBmplN/DhdKTiTqMu6nwJ7CSJzfff0OVU8B3z836L4fSanWT75Syd/XqYIXb4voBsEbH
         79kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814352; x=1783419152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rekD2/6Ee8n++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=;
        b=DRqsHE1Bl7iLfQ6A1Hgb9KcXNOa2XX2dQx6WhgiTxzJZf7WXWi0UJ/6i/vb4+Ig4NI
         ede+ZlPcxizP+4HSLs9xXAQnt+XGRHHAXn/j52B2hjPKVdM1LgB4eoaARFAGESaMRipo
         4FVi+cyESPGbLs2QDM5dSyr2p9+hlQqAmlXfOCyMamMJOeJG8PAWy4DB8Kkw7t6fmcPo
         6VnxNbrYoZtpplJYMedj1VeHJef4itzwkZtbTqhB67wQclaXD9SFiMfTZcw90G7qj3Gs
         6sdz3U7UugDF5nBf48GUiBQeOR+7YFvMx/aIO7/EjGUNINj43yUGWpHqpjABQQSZJ2RS
         pf5Q==
X-Gm-Message-State: AOJu0YwvfzZccm19qWRsiQXchj4R0zPw1vv8RdxTDgDdPPNtlvKFIJRT
	3esfWzCoVXncVBLUe7bbY52czf3nbabQOuOpYKiukrSv+x+Nn2TU8R1OA+3qjrVBtZwGeu985XL
	GuOmKXqhQ+nrVO40cLkk/BQSUZ/eDlvfEWEen/bXnQTuBLX66d8R1JMGHDH9bumRyFBWCNN5QFt
	XJVf8=
X-Gm-Gg: AfdE7cluC2wr+7eh3xDp7T1NQ/5s6WjsdCJZXc7pcfs99aN/R3ZfcDPCZW1iR9ebh93
	Tkv3J7Tz702VjErk2O3hWyz1uSF6DpRet5ac2JP049TVz3vKZH3yQ0aEvaPpgDWw2dps2RO3Cur
	psjT63J3G8HlQvsj+GiymnIOMeT2IKBsIrj/F2YzkxZoj8ohxOs08ql6tI8JT9pxxFp241nvvaT
	IbEq6n9ecRC1K5UcfM1DGVnQTf272nOctzJ2uYcpkiMmE+5VH9yxgUTWlX5bVbyNGnnMuJkqoFt
	nbwivSPXlhqD8XzVrId7ZCTLHMqFVtEwX83PcsHQTDyek+7wBu7hao3N3cJ+PDe2VVJMFsBU3I/
	2+JDXd0q2nwdU/Oszv89b+/spgt+zPinoZrvPLrbr
X-Received: by 2002:a05:7022:2595:b0:136:c77a:6509 with SMTP id a92af1059eb24-13b2a1aabe0mr1765955c88.25.1782814352446;
        Tue, 30 Jun 2026 03:12:32 -0700 (PDT)
X-Received: by 2002:a05:7022:2595:b0:136:c77a:6509 with SMTP id a92af1059eb24-13b2a1aabe0mr1765935c88.25.1782814351953;
        Tue, 30 Jun 2026 03:12:31 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:31 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 5/6] profiles: replace wrapper API
Date: Tue, 30 Jun 2026 15:41:57 +0530
Message-Id: <20260630101158.2239682-6-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jBTAqtEdxwwtnqW8yRyMRXVZnIkmtVU7
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a439691 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=o7YyXcfzcSjnOG7JtQcA:9
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: jBTAqtEdxwwtnqW8yRyMRXVZnIkmtVU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX9st+Hb0q/IPC
 QXBcN90agVdX47xSxcPBYj+4+GsJSr6jHTJBukgYTVGprzpKbPwVCeK79nu9mj9IbcgT8/ZlVL3
 y0f9mRErMdLYZPnb//76K7sYCXS1Kqv5IVitjiFMNt2urbZyebebnwdzVAz5tpDC+Sfv7EEIHpN
 cGfNKWESj8aolkc6EUb5P8A1ZE8C3OZr9/oEBbEuZw2CSpjWDBoSw/4LmqrpjhP/1tEaHC9JGyk
 Sb67ZaY5rTG9J4EAzTAfauQfboBs8Zqz2mI+pu0ZRQb7KjicTOENPtWsbY0ENC8GBFLT6v58pKJ
 L5AlPtNmDYaexTbPtlbo/UhUqNu0Awkd7LpyYyTFv7nw996iJ0Kr445PoqQHDxmjvBGfAKgtKob
 F9WXVHQG+9tQqE1z5A6OM8Gyt5hCSiXqaDi7T9GXhPT1MVjjNNYnYOrB3RFr6eZUyYYGjFKVAi+
 qb6CZotBYlxIOUN2W5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX9FG2XCI5bdy2
 dRfWsGA//LYxYUjfe/9PaaU0EgbA4EqxOY0ppFncLrKddMlMvQxTAX2s0tTM7ibYFv8V50HALSi
 PBMJF81vncd51OA4tXJcpDTwYuiZCSo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

replace bt_rap_attach_hci_v2 with bt_rap_attach_hci API
which has less parameters to avoid compilation error
in individual patchsets
---
 profiles/ranging/rap.c     | 2 +-
 profiles/ranging/rap_hci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index da6f1241b..a0bd360cc 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -383,7 +383,7 @@ static int rap_accept(struct btd_service *service)
 
 	/* per-device HCI state machine */
 	if (!data->hci_sm) {
-		data->hci_sm = bt_rap_attach_hci_v2(data->rap,
+		data->hci_sm = bt_rap_attach_hci(data->rap,
 					data->adapter_data->hci);
 		if (!data->hci_sm) {
 			error("Failed to attach HCI state machine for device");
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8726ce824..944b7e2a3 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -1533,7 +1533,7 @@ static void unregister_event_id(void *data, void *user_data)
 	bt_hci_unregister_subevent(hci, PTR_TO_UINT(data));
 }
 
-void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci)
+void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci)
 {
 	struct cs_state_machine *sm;
 	unsigned int id;
-- 

