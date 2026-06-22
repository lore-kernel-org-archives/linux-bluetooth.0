Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753831E848
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139948; cv=none; b=CTreQgikHs8lH7gvxLT1zZSa2nk3K413+Hqy/JYB6Itp13sHvlMsquNtH+PDDuNPb4H/qASj1qlyeQGIytzHHhTsDi3mEzBXRlzEFAL1U1GF3hBDjPB2DwIxI5RsX8tSrC+CRIcSU8jeKShGoDUkuEkc0WAZXTIH4ffDsbuH310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139948; c=relaxed/simple;
	bh=godFh3XClGWYOD/13MM75KUQ5HsrEM9evqoKLd6UxAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fybdJ4EtZu/m1i9SsJuNGERabeIqMPxdwTrIl/ul5i0YTP/FhlqbCS6VbS0RM2opa4YPPKENR91am9x2qIBRhog/IfWFBchguADl41GFAcuFEdEdajT5APtride97G88oMg3AwPTtT8JTruWREtgShOrg0fcY+3VTu2ruP95Ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PbQjFj19; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8zQWQol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PbQjFj19";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8zQWQol"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFuTs1060887
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+jMt3mRcxAV9ld7CzQ2hfD6sxJ/UqAqyCYYaMjeqBTs=; b=PbQjFj19YXK0JdzJ
	Srn1wW17QL7GBoHVQQdvzlmxo+UXlCKtrB2XNxQPWojJeHyF1uDa+++Rk/zYQi3S
	Bdz71b4zP8ZmfnrP+Mlga+GXnY4si/tkTD32HQbMFSUmyWAX+A3wJKMAA3r25AKm
	DciTnrUUTgOeGF2JmVNSg32JbnBrFxpxIn2Q5wIizv3XpQaR13ZQQITyaKpj9+iN
	QKnw8C7+fyf6a452aQ4nc8CUQS7zre3E03n8w6J78303xfv8oifvfh9bwMwQSLXm
	1crGzCJTvKkbOaEGSMtnW1uZVQ2U9pm7eOfWsMox8v3bc4w7CTKjgE669EbgmUXK
	LdQRng==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1t0td-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:25 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-13825f68028so334671c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139944; x=1782744744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jMt3mRcxAV9ld7CzQ2hfD6sxJ/UqAqyCYYaMjeqBTs=;
        b=g8zQWQolppbY5o5lmgQwSmc11gmQ6PCkC3MHDUP+QMC7KU22a1hm7HQya1u6U6UA/5
         KSiHMOTrJ7WxS8T+WfIcqF1sgpjGy4+k2Ej2fLPMLOI4VCSly8eGIRP7rg4mg8Tsji7p
         gIx+ePQ6Be+ShcOMMoRp4VRJuz5kJ/khiQqjvAbhYbdKLBuBzzQmIwDPTZ62gkjti0+L
         yIyva0gU2fhIs9WUlIcWp7nusvmpqvNlkLLPqJ+WbNF31N+lm7NrkzurplXI1qSNhhuo
         +g51ovYARBbpCUUQGKO4k3Y0yHpHqIruB3fKCQBSiEeYNfs8eoFdmicuimfE3cpJHgZJ
         PV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139944; x=1782744744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jMt3mRcxAV9ld7CzQ2hfD6sxJ/UqAqyCYYaMjeqBTs=;
        b=aNJFMVFTdAKs0fWEolyRAH4B3qaIxXtH3Ya3lgTsx67NjRdY+qripUg7y50mG680/k
         AmGD7I73ySnM0XYThQ6Vuga/bUfo6b0+2v63+NdsyWgVW9FMLKiSyi3YGzHCdRKXbGaE
         KIEujcPhABbzSYFMjEQAvFvxIC6iCJSgs+PUp/bhosgrir92N68UicYp+3gPTt3/SEdo
         rD91tit5uN6OvY5vvDhDvvBVWDNXYFzV6ifuaznTFaxoMas/t1VgckAcL2eQRh9oTa33
         4jD+yE9doJl3CzHbgdWwsL+TxcIuYD+XjA+k5046U/9xXaZ2iya/pRZ36vn1j4YwGrwP
         r/hw==
X-Forwarded-Encrypted: i=1; AHgh+RqzVIAy4OXcCZ4r8n8Rkeh8baugN8IDlofwhpmieLUxzeJi/Uiola0g7xKieBqxLZV6HzYZGZcn+3f0hAf714Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6MlrN9OyKFDDNMs1kD7aLBoCdIdFIgiPH0PKlnEt9Da0oTHW
	fih+6swO3rJkHqTy/libGz5lHy4Evs9GbgC3vGxfQ+1XtDb6Ou5vexyg/ChkorOYo2segbm9R5k
	5B7+bhbU519RILiKRjVS/J+d+2PVZY/3j2UxXGu/c248V1473ahGI1/QTRQtQmqtJGhQ751g=
X-Gm-Gg: AfdE7clqQvWYuUWVD6P6xzfHpR6ZInL+/RBR40BDuzWlZRIm7786sex6j9Y26eckYhU
	4grYun8IKuUVypfIYzt3OSOxhRLfI/RRiJv/x194amFhm+GnFYvTZ9eCHH8C/A45ZylND+frLRm
	c0MUCBw235XcBz0Y2tsPXdchcw2/rVOL16ehQiWCaZzKsraRLAxtrfZRUKJYGRZFeD7wstuHMRf
	Hpq4fzJEpJF3dmUGKcT18M64Bgp8rg5oJjucTK93hJWjfAkDpMM1Nqyg2OoMn9ppFvhzbVGLSfI
	ftpkZng0P0eW4QSxULtaHVzIZqvQsCf5rqLkchQYlLtjYIQ3Re6BVGFgfNzz3BHckiHbqnxjVv7
	24eVnDz6HhGGjl/ZWNvUmSKY5w11lQaNRHSc7Pju0kTUS400j2q5/jXPpbg==
X-Received: by 2002:a05:7300:72d1:b0:30c:2932:dd2f with SMTP id 5a478bee46e88-30c51e22ecbmr234392eec.0.1782139944292;
        Mon, 22 Jun 2026 07:52:24 -0700 (PDT)
X-Received: by 2002:a05:7300:72d1:b0:30c:2932:dd2f with SMTP id 5a478bee46e88-30c51e22ecbmr234373eec.0.1782139943757;
        Mon, 22 Jun 2026 07:52:23 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:23 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:22 -0700
Subject: [PATCH 09/13] Bluetooth: hci_sync: Add __hci_reset_sync() for
 device driver
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-9-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Qz0-jdv64CRY_4T3fsw9tcZz3ZLcFJmS
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a394c29 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kQ_UBjYZPz6FNnKCBYIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXyj5SShpPMuGU
 Zavbrtk6itpp88KZeG96fEfV9XrvBZwu+zHZRHApf5NkegXmbgQ1rt9O5xBhTbCuhMToftodh5y
 eVhFt03DuQQ34WS1SbDvy4blbkFuANI=
X-Proofpoint-ORIG-GUID: Qz0-jdv64CRY_4T3fsw9tcZz3ZLcFJmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX/5BnhYf03+u4
 2yur9pyKvHgXMPq8Xq6fFLSGbH1Xh5uvzkcE8vC4Umf+jBgnggV5zogYKdWxwVAVsRpLGXhIM+W
 CnIhRAsm0RFY6OACSEEYKxbmBaKhbUfMtDCTiY63ETCNhfiFbc7OgqPUd9+21AJUZc0ENrPmux/
 J9Jw/8ncESJdvdaK6YDz6iwWQuSfsLglcJo9g4VEGqoHQx/2N4Gdd1GrjPIf4tbh8oHfo+IIx8r
 0acvdJr6zLooalOQvQdTjnOJ2CjTw9Uet8x5vDK73/7bHF8v+YLhvEtuenxnPuz6/ddv7n72Vjn
 UEGB87A71KMeaqxiX6ZEg2tAbpKscRdgdl61eBeSXS30o1lstdx5rJ4flikjXA4txp7eTkZz8Zk
 tHFoC4TLrWku8ewcJVBICqNGdkxCDLrzPKsngCKjXk40aH3BTNbbSegKxask0TwbbpJNbgImHV5
 gWnSdV/EdZwfZIJ7nyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Many vendor drivers have requirements to send a raw HCI reset
synchronously with HCI_INIT_TIMEOUT.

Add a dedicated API for them to use.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 73e494b2591d..7005fc9f257a 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -59,6 +59,7 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u8 event, u32 timeout,
 			     struct sock *sk);
+int __hci_reset_sync(struct hci_dev *hdev);
 int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 			const void *param, u32 timeout);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 601d44ef975f..40c9725585cb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3684,6 +3684,20 @@ int hci_reset_sync(struct hci_dev *hdev)
 	return -bt_to_errno(err);
 }
 
+/* Send a raw HCI reset for use by vendor drivers */
+int __hci_reset_sync(struct hci_dev *hdev)
+{
+	int err;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
+				    HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
+	return -bt_to_errno(err);
+}
+EXPORT_SYMBOL(__hci_reset_sync);
+
 static int hci_init0_sync(struct hci_dev *hdev)
 {
 	int err;

-- 
2.34.1

