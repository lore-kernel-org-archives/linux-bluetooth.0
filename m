Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F038E5DF
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969705; cv=none; b=HHZzWe2OSbyw6F8gVLY0RNpzZdThkvT9NAJazx8D/YD3oKPIpgCH59fBPojg0RU0mhXqTDdwvjtLl6JDC0GS0UA+Bc0BAwuLqYYXKxwf3cH8jq8lDLo/ysPAJjguaNTHlQcb7ntGGAARPzKrTu8lUdM0xYzDfoBDEZeVJ/Ng+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969705; c=relaxed/simple;
	bh=L09civLxPxeXFfsyP3kv9bJnh0tvXnvagIsU9ZD0/2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NelcXO88ek5wS00S9RveH/cpcN6DjmDLrtoVN6+OWEv6Jc418h3Y7eHVOLkyyzBWBJhI+SXqxPZ7Zr/N/OyilcKWTjevOkiR4psW7+oxBDSjbKMsVle2S53DuJd8305NLquI6VFjTKlhpqz91LfJwYsC1vTLyyKIZvAKMOH0E28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayYo1Y2A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbG1dP9z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayYo1Y2A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbG1dP9z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4ltHp1260455
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M47pihUqMh4R/6oAMu2wW4d4dS5yNymJCLseD8qbms8=; b=ayYo1Y2Acgwj34ui
	zGg/NGBxS604uO3FZWr5mGsUFXWUUehbGkcSk63tyiQN7LSH8caSHmaVclLyMCKQ
	+YPAracuhU/SMvdqjecViem6n9SqcUZkRYF4ySMpgQheYMEPfAI++acON1KCEWk1
	B6sVtHrtOFK8NOXRDoySTmR0+NKnfPiBkZ49EKYX8eDde6W+h4G6bWhnyTboJD3N
	myk+yltDVQYN1KnImBbBaJOGMTlURYCFtI4rMPMdDTgJ/U33D/u7vnSMmuIdDlhD
	1qgi4/a1heciZTTTROO6EEEocZ/o8VymVBx4fcWWicCazRaLfD39lLA+k8YskCNA
	p46q1w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3s8pfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f005ae3d1so260128a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969702; x=1785574502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M47pihUqMh4R/6oAMu2wW4d4dS5yNymJCLseD8qbms8=;
        b=YbG1dP9zlwd+d1Sr5HzkK5FB17Pcua76/qwrwtSZt73kZaoPdnn4muVRUEXtDzJJ0P
         vDyihAA7aoGW2XVXaFtaRD0zJsIW3WcPmgV0QVfXHV9vD8gab5wPH6x92NbmrN1AFgip
         s781EQBJ++ze480AsryhoczVR1uK0l0Y7iF6nqt16fsAp+THGtLuwmNev51wO3t/mKlm
         vfwXwrDF3KLYXtqEwHXh3Q/d9D2EiEQZqfLKodGbPLyD278wlaBhtYi34SVFsog4F1hK
         6JFvdqcK6i7pjikkm/E1rt3UQF0uq/FnffHmQMlFK4ARdHRlF5oJw89R54JMSMMYZzFM
         L7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969702; x=1785574502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M47pihUqMh4R/6oAMu2wW4d4dS5yNymJCLseD8qbms8=;
        b=Kw9tWR9Hz3FLeSccCCIhcC1PSk1AzD2lCr8/W1kWhZsJDEFgCWbz1wo4w6XXix+3yF
         LVycYaZCYQCO5fW3nsmRZ8k86wsuQOasiL6pDLhhL8YJpBGxysSFmCtHX+HQeV4nB2zl
         L3H+gEY8E7978jit2OKZXq8WFLqGbFqVhbv7YhxpM0E9LUspKvDGasjeVcEt/3qSn1ik
         fe2hWHzVBq8IapFBqU6eSJ4Wpky8bOik3vZqRksd3CeJk2dbJsPDHaRUtdYFE+ky2bEV
         BV8tmf2aIEaulDmSUGDBr+paYFLE6QGH2/4PtIy2nauuW+vmVAfBQEGKi0IycQugEUp+
         15Ig==
X-Forwarded-Encrypted: i=1; AHgh+RqKWD45jSxf5n89+jqWSwtfh5HEytAJN9ztdulHrR7+gm/z1gZjhnKzhNI3LUKoNleaAvmKVYnqj/AYUmkXxRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kN8l2yG7WNKH8h0NM5AS22ashN9XQjXGTJ22rAAQWg5R8Swa
	g4kMedvLtxgp4IbXot5TMut8vkBWonWyOTPrjkpOwB9TOp/8NML211Ly5pfyZkilAN9DPOLIItW
	44fNX55+TAfIsangeHp22u18ri+pazi6ISgvC5L+J7iBc1/sT1+b5lDySKFYohr6wtJWGNqM=
X-Gm-Gg: AR+sD118uJp+Rj4hND5F4guw0qm0RJ7GGL/WgjrIbOx5d3wojRQojYTsSmAkuNpGjBM
	QYgysVhogjRvQyujfpAOi2GBpmeaaT1FvS6GNqU89lSpZfv2xowgF+v2R5ytjJ6A2dhdoE43xuW
	FaH2GstoBWyiIUe2H3vJi3erF12uIS01+DIkdjuVRH943kl8jh8be4dfVLyVaRzy6ouRllObdWp
	+32ETFMx3jjYI2pO7oVLP4kSvxcwT4n4ROTC1y8SinxR3C4OauzwXxLN0KxDAf1FTqskUcXvu25
	YLh/2AovE0dynNLeuNU1objXC1egb1KRDrlIH7VFWW8e/qX4VdEq/rqU5kDHHEyX+iAlKmZIu/M
	wW2/jRdrqqGmfvyajvPxMJ2PElodwzEG8E+koERFL6e9Ff3c=
X-Received: by 2002:a17:90b:390b:b0:38e:746a:b5f6 with SMTP id 98e67ed59e1d1-38f2926b211mr1878449a91.0.1784969701820;
        Sat, 25 Jul 2026 01:55:01 -0700 (PDT)
X-Received: by 2002:a17:90b:390b:b0:38e:746a:b5f6 with SMTP id 98e67ed59e1d1-38f2926b211mr1878428a91.0.1784969701407;
        Sat, 25 Jul 2026 01:55:01 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:48 -0700
Subject: [PATCH 10/11] Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT
 frame by hci_recv_frame()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-10-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX3ZhTIRHxh0iF
 Tc3J6E2hGIPG03EJT94Q4CRcgfchAzE66ISh+3slyPkRDrI2DMwAxE+jebtaWd5ydbQpEm5U4up
 Tb9BYD7SYa0canLUihJ/g3o8oUx5p7OXBH9VLwYjINMWRnwq6dkmvf69hNLaLmFVRW9LqfRPm9L
 d1JBoYA6dHwzIGGdXRM7HQTioWkXXobliUXMrwkHpCbiZnMGxI+hhpL5n9OLn2OULj5dlTKel43
 2M093jJIq9UfsU8BwRLsy6VDDXFmmexFjMBerBJiysIitroDcWvJ/eSAq5F/hmF+Crv4UVgVQaa
 hVYaVM3Vo63c7APgJdWH1fNRZADSPLe6ZEtAA9/LFkBU2lVzIjWliAFa/FlGmKC6SwsfxtUp7ZE
 rodGxy5PTUFLuQjfPei55LVgVVbUscVa6UWOxxgF1yhLvmeyuFGqUagWxcS3gueUEAex5FHPHKi
 cIfiaHhRH1AMqzZbYHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX9PGvJxsuw6s2
 VieTwh18KEQzUOcCysFlx/J5ylAMmgwE1o9L4SQL7ZZN6sTPm4jln/pbmdP58De9BiuV69xxFX2
 TuVxFLyvYp7Ja7fwqV8S3m1ZuGFi6w4=
X-Proofpoint-ORIG-GUID: BjbCHns9Bwf6F_pQrOMYvjhN0hAtyguf
X-Proofpoint-GUID: BjbCHns9Bwf6F_pQrOMYvjhN0hAtyguf
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a6479e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0kn5sLbUNQcYQnAqCM4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

For a HCI_VENDOR_PKT frame, hci_recv_frame() does not accept it and
will kfree_skb() it directly.

But btmrvl_sdio_card_to_host() is still calling hci_recv_frame() for
the frame.

Fix by freeing it with kfree_skb() directly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260722-support_vendor_hci-v2-1-132b506460a4@oss.qualcomm.com

Changes since previous version:
- Improve commit title and message.
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 93932a0d8625..b91fc63bc9fe 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -794,17 +794,17 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		break;
 
 	case MRVL_VENDOR_PKT:
 		hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
 		if (btmrvl_process_event(priv, skb))
-			hci_recv_frame(hdev, skb);
+			kfree_skb(skb);
 
 		hdev->stat.byte_rx += buf_len;
 		break;
 
 	default:
 		BT_ERR("Unknown packet type:%d", type);
 		BT_ERR("hex: %*ph", blksz * num_blocks, payload);
 

-- 
2.34.1

