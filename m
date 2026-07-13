Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832F40802C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944080; cv=none; b=CC+DM9x135K5JAYXBjnL7t3ZSGSA2WnMm5ySBUX2QGuBN9mxy7fAKHscPst89u4IlID9c+zTX4kHJf3T9AadmrWXA71C0t35Hv1BRRuWKtyb0GKMBc3PMTWYa3iSOIm3tjojCYn5B5kmwVA9KOxZaUIPVF4XMeIELXQwa1Fbe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944080; c=relaxed/simple;
	bh=fThl71VBoQKNY9M48Dbn4xaRnSRIaAD6uiCF0mTpntc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hW5K9xS7oJ/ge4tNT98wFwzg0XXqaxTOcVkHYAMmS0IIBxGCpxBYYE247o3/tHgYa+iDlaNNdLhjWfb+lWLDy26LFtoHFlgUaU+w+T5gssJDxpXRvuLBKAK7W946GdOKfbDcdgbmgZflnTnw5NeMmo+f+H56rqij4ZublAUZvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBK5LYYv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VpvX877i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBK5LYYv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VpvX877i"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DAbbgO507347
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWkmu8acmD/hQ4LomHFD5jhBIewToNxfLM54D/qFWNI=; b=pBK5LYYvAg8EhWuZ
	301xn7nD+TtvcEzdAGzBr2HAOIvI5SeGOR+wWWrycFqqWqLq0voBuW6EM3GlP1tI
	BefHtN4/nR/eefDDOlODN3CCKSPWMb9H/M5FV+5hNoay5lBdl493MFiC6SEfHN1Q
	azTcwz7VGOjoqfo8vjuaG6t3Nes5fSAVc6dYAI5wRtGypvwlx+oaM9TyHa7OKZkm
	jWsjrRfAITEk/qgTGb+byeGZY8Z3t3+qOgvf8eOyyUT+yiXEWVH3N6flN4gTR6ZJ
	kx7Q013jsHbh+xH6QIgeZWtFGfWlyslrq4UzSotXkhZUDDHzFzWGHCYn4fJGQgtD
	z82GgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8hcb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-382befb9555so938580a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944077; x=1784548877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWkmu8acmD/hQ4LomHFD5jhBIewToNxfLM54D/qFWNI=;
        b=VpvX877iHRJvTVBFmGGA4R5ekPpViY35knMYLyyjIHWmB8fXUEZC4zib7DkDRe9nso
         drq9usME6YMlfH7gzu6MnXWEd4FJgPY81kvuiFSQjOLRbGYfFNmmPCa+rkM1I9U2rUUt
         4QE4lxPluvPO8L/xPDHaa4F42kHnJSJtax+r06wP792fkV54puOMER9i5d4Ql1lxWILE
         SLYueAPFt2pjxADrgnB30206catMt7iWzg/49qqI7mFqoGamZsIzvV3M7q/PvG5+2MQZ
         5LSHUvs3+Rcbp1nTOvEfZVpCKphfKHuSyTL4fnpOM2O22u2UvN6vnzCYdLitKp73EkHr
         evFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944077; x=1784548877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWkmu8acmD/hQ4LomHFD5jhBIewToNxfLM54D/qFWNI=;
        b=shFpNlaktRcC1BSya8DdG7NdkO2V3C9q85g09PdwSMZdvGZDJIYBmk5n/CxR6r6B+G
         x57BZRz9UytN88Jbj4OG4OXfqSFyilgYgAox2Vug/S6l+1Koyqi5zeaQnk/PsaZjfV1d
         65jAMToexHA0fYFKly2mqPvD3zl7Asyh6vIuJhOQZ8dDPBacQZx+mrKG9j4P+B3GaJWK
         qr20ge0GCik48CP75BRHgr78lFD09cSHaWs+r62+9vxOYnLOIJwLNe82LzKdp8JNY7sP
         mFf6Mse9dtyA1Wz46+DqbJUpogdelrAfLM7ZCh0S6SG3LQoIJKbD8Dn5QM3PguzOvrMu
         5KOQ==
X-Forwarded-Encrypted: i=1; AHgh+Roc2f0j8vSjEIFXbNT/6fZzZxmMOqYX/Imumf0fVXuAxGY+QF76QkkT5P0B8I2eRN1SFyWOMzVoBekVY4D23sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIguE0cgT0wPrm4O+4BfFDJJfCMJQ9QwC4OI6u9D5I05km33f
	XlzEnAdoDtLU28MWG4PJrKSu/8trG68iVFNXdkoBUSKLYwhN0ul+jmpZuZYXzgHX4f0C9uB+zY1
	Me6Ami138vQJTj/n13ObwdYeV3pJW+1ldNelh5ya6R6BmJ9HbQF8m16ALdevMFx6DxcKQm4E=
X-Gm-Gg: AfdE7cn0uznCPzR5JhYz44H99WBVarrss6UUBHfMHWPb72v6g6sWdWT1IboBcn5HKlu
	MQUerHn5Sc8EK4hQncSuGr08FLvjHyrYrR0OS39z87OZYlZQJ//FNjdsM0lS75cOoZWqB1R4xbo
	+PQO35cHqtSpS1Zq0yzVUqfj0PT6fqFIzIFClSEZDNo4/FmLqi++htM/UiRanHJDpC9S3gZ1zWI
	PFadwE7UW3ANHJh8W4V0UveNc1Dy6PP5fhcJNE7sPw3IzEZ4PmCgEudIympWOZDy7G8pFrbc1ye
	Wg+fdsXs49H+eAoml0s4MHbOS5ZQR4D7usvsKundwIjbLpvGY6HUI9MuNBRMQTXTYfXp/cXfEze
	d+M9uJsgXmRQLeAY3Bn8rDApKNVQi4XgXSnFX7gMwyn2jTAA22eVzcJ85pg==
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38dc7c111a8mr5998680a91.6.1783944077210;
        Mon, 13 Jul 2026 05:01:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38dc7c111a8mr5998655a91.6.1783944076786;
        Mon, 13 Jul 2026 05:01:16 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:15 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 05:01:15 -0700
Subject: [PATCH v2 5/5] Bluetooth: btusb: Add a simple static
 btusb_prepare_reset()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-btusb_prep_qcc2072-v2-5-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: bN5GeEybY-LRV9UKgo7nYhRELS6KtGbL
X-Proofpoint-ORIG-GUID: bN5GeEybY-LRV9UKgo7nYhRELS6KtGbL
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54d38d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VT25rOb33v79RPrqpfwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX58t/NhTUb38p
 /HMyEfL5T8drQ4hFsGROLPrM5WZhz0SVEv+Ekoj0kdSILHOzrePVxAqSXv0GjkQjClb2c7i6wSd
 OwRQrkm8fc35O136gC270MdWOD5Oc5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX4SspySfaLSqd
 vmPbhDdCp2ufOo6ztN+mQFDtZUYGbnpcjrnW0skFOX8JIMNPioM6wCqmjnHligm5MUuEknAcsvS
 ExQALGU+WY2jBqaBQhcpdMDqnHgQ29lnKrodpQjmRltG6VIBgk2xsGDpIOb7SnQXcIDvqGVbyfd
 C44c5Z4FA/6jWcD0QEGoDk/sy9+T8dMvE6EyqDatLTgzdX9UWDDA50/li0HOLinfiHYWxEq3AVF
 czpbMT6PNIFYzIp9QNn4h3aTFf8WcDulRbEZTPpIc/fXKYIcML42Y29Bg4z9IZXp+dDZC/ZkaqV
 As5MESWxpfjAbDZqb2MonDEBh2aokbrEYGFasNLSd9/nRIwYhtY/R1UPu82bTUiPkCnkGPYe8P/
 ZpSmOnESaiPHb++acx76ykfLKhOdnynRE1NiKTEnfhfeaSTsIhkjHS2ugdl6UQqlZkTIVmzqG28
 Keryskk7hDs3P+nJkCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

Add btusb_prepare_reset() to do cleanup before a reset, and apply
it to btusb_mtk_reset() as well.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f4f911c3de52..8d3bd98fce8a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2075,6 +2075,14 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
+static void btusb_prepare_reset(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2917,8 +2925,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	/* Release MediaTek ISO data interface */
 	btusb_mtk_release_iso_intf(hdev);
 
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
+	btusb_prepare_reset(hdev);
 
 	/* Toggle the hard reset line. The MediaTek device is going to
 	 * yank itself off the USB and then replug. The cleanup is handled

-- 
2.34.1

