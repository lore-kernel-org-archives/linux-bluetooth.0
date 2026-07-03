Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0AB3E6382
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086347; cv=none; b=c9EDf4QeLVY4XjufZ31ZtgamLewWNKEY/c9PD/2sajdlGaWfx6T1rZj6QF97IxSR3SIXsZCl4TK3Wl3d4TQllhlER6Eo3Je4YzMdIjJnyY0VbLQaEjLQ2d1wzwVWRb/uYspQYdeQJELWdHIkLVizOlcnEPrOTxkSjd9viWQGOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086347; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cA/ZmFD2uMxFhHWB/hWXxjwEAk4XQ7q5DRPwbeVtKWU0jGRu93YKRy5iLAyzqTPT8zL8EqhhYqqvHSrKl/DaQYhMKNgpAy5oqgGWrMu6Kl2kJfQ84unMIniz88UhaDLdWxyn4YGW2OSl1VLJ2gHI9N7tfEiqOiuTU7UU90CiHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRPhwA/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rj70q6qs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRPhwA/o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rj70q6qs"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Aw5qS3108984
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=KRPhwA/oh9GV+uNe
	1MwR120BO+YSIq3ukMGeVBkcNZ5Kq3I5QOL0MKh6GD0UGJx4JioKC0KrZhqHprCX
	/upucVc46jPkUtqpoIH6svQnEQiN1ucR7xoGqS+6VUkQk/x4I6LXRFd2C7rngb35
	bdHPBxAI78RtRL+1+im0WisB2E+fI9770b9Gh+5O7PM4nIxpjTDS9eleXZVGc9kE
	cvk64B0goHWTRwLh9h+RBZZRpzoJHGAvT5zlKLBHvOqgJLfDQdAxd10A/CUMDXUl
	cEl2S5PfetXf8QNlHbKCosSTnlVM6DKsZaOdZZrKZk6CzVLKZHDpox4ONUWWS+Em
	cPOfJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybab7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e6a2f5995so89459685a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086343; x=1783691143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=Rj70q6qsx+bZ6l+AswC7+k9Ht7zn215LQIncwfzfjFTWyP1tQIIp4L1fu6Ldrsb5ZC
         du6QjPOsYSn/inr0AcnrvxRaN3/udaRVic4j9APkre0fFQ7yaLnSCS74kO4LrUevlwqY
         pfwg0Tmkhix1kdF2dfBCZ49+oWOQf7qzW2utDUPPMLkaGev71LV+E+Ctsb7jmkjHHaCY
         FCcXqU4lTE1bLAKV/RN2SNRDcNYXajfdNf/KoR0VO5wJOI47Oeu636aZrlwOzVPQwRzk
         2e4Gf655Qx5PpAEUvB6MVhtpfp02qyXtTDGATWtd7fyC6bS9FVnnUZtzIE4nI4R+ayiG
         XLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086343; x=1783691143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=OYJRZrJraPNRWSnAvxCf3jzs1Neo6kaJ3XVuiXAuGi0iFIG5U/1YmIlRxVqwfuVYoI
         Rf2HLPfb9iBxenEhLG/rrMMDcbjOmGekcboJm9Ylk7uhJULnI8o6c736bx1X/0Di1/u2
         /LmZNJjHjJwjlj4aeBMmKqugKcbrd5C2oe88bz9Z6rv6IZYUqYzgGwotukbnDJRbb/UQ
         H6nNDnFM7R/+ubMJP+rNLg6kL8ThX/2GTm/ZDbLTfAyCRVbWUUt1rjrn/QSXGwZKVDI2
         W/14oI4k9QSauU870T2tg0wkH/NwaYPQ8Rc5W3Lu9lmuxBWV0H9d1N1FTUja5BtVbyav
         tt6g==
X-Forwarded-Encrypted: i=1; AFNElJ99s71l2oTmDq9xTs0DXUr+8b4Nnxu5JMsJ2DEQ4NfLj1qQClb5100tCPj6ADXcMgLfuEjYPuc9EkHWAm82mzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJnz8LyONSzM+3kBfqzgA+8YTHEywJ+PKoIOt3KTdnkgilgP5
	QiZTZYBSTMPJ0hrcKwxkl6bYZjUzcD6Y7lVipFTOGfXgImaWcvnAGto+Ufy65Z+J/okyX3mNj/y
	4uqinBrLyaBRZjYBeKcfJKe/ajKdru1V+Pl7YFTRQwOWcd/kgTR/e/k4jAXS4FlrjWF60yMQ=
X-Gm-Gg: AfdE7cm9e14nRyJdhh3O4FD1rfYl7wWfTFvrWM9ZVsF2zKTQ7ZvrKhvtR4cpUPCbwGk
	Ceh628lxYh3W2izu7kF+nSEy2cFVs9SBEKP99HN77xVuQ1LW1iJdYluYBlQj2R9L0Ze3gGvgM8k
	Dwzr7LGp+WilhFhcndasdmYtWuB+3DlBuJtzmS+mQA6IA0m4hS4G82A56oA6WYsgk9BzQqn7rJn
	FKoawEE6c60inf9KwC7pMJfKR43DnCuHE00VjUX42PzK0gXiX7RG27jtHbS2dUlMqsN0eo5Wrea
	0bXZVidSApj+ESvJuxUUPP7pmKFMX4J50iTuMskDI0adYlzA3vtb88VAB6ycgNdbjEUzOySZel3
	3bSjNd48VGIPCPjGA1UYzEc6KCpw0IV+9TCMFnwaj/dmwktASqxnIUXYhEN4iRcE/Q1P/Ef6Nzu
	PTiWgr/K02NoPnfNxJTTy8SJBsBGCPplNomQ9xv5gtS+9f85fmpGYvoPYmCnezumo=
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401573885a.57.1783086343126;
        Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401564185a.57.1783086342473;
        Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:21 +0200
Subject: [PATCH v8 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-8-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX4ZFolAFl0MSe
 0fEIBUwvudbI9O63FcEBnLgH+yG0jSLox1iq/sOUdx1Cijp1F/TRcnhcb01HRGwecuzlXXDkixs
 dxRkvrxU6/m0noDt2hhOULpXsLIZ/w4cBW2gJTk2AfCl4dPvtOv/oVbatAZmcpqpGFX1J8UiCPR
 aE2mM1dmZG8n5PeFkSJ20OvMpNLizI3ODSSiN89ew7TWylOpfuiCmYhy1Z9azN0msO+bo25jTHK
 TAJx9aOO1VAJykGqKzus7ZVxStQqJheK7t+nb8IDTYcHlnx6/gvW2YKScrzSUjZcvlhatV8Jsxo
 kAnGIqcqXqKAcLLX5sZI7Yo1CCJCDuZKVi9S0jpwHvvvVCKAExZjQD7tW9PHBwwmohDSKgybVK3
 V5bk0tpGf/7pbLjgo+st1soqeLQkxU3F++YMGMBBCC54IRYKTi9JcDzGithqH3z6/wSmTT+eZsr
 kUzJxnWbGcd9dpS1uUg==
X-Proofpoint-GUID: sk3Z_Y_dVnKMSoeOp_PLQkB2zXUrxtXD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXww6TwgLvh2JI
 M0g1ZybZtrYUbOxGVb46n+sM6zd1WjhwEYryD+Ib9zUjQ9hiHVpDf2F+1hIVPXo2m9nBjxHGswc
 0KHXy7uDNQEwfhBNzrd/REAxqexmUy8=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bd07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: sk3Z_Y_dVnKMSoeOp_PLQkB2zXUrxtXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

