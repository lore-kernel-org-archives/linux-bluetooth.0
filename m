Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429223DC4D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326143; cv=none; b=ckbMffIKucZLt27RH3vgQfJN97Jdpt4sDcv16MMvAtKNb7xFBCrVaC0mi7kaGh4FElmz8XS+c5Z5El7FspOuwGlowspgLAur3wWFj5ADZTbkdmQ2Vf/ENZ7guYWRjuW+vulFow5XLoh/+epmBFjGIFJg/S8yKtxAGNRNCJhBU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326143; c=relaxed/simple;
	bh=fHse+rS17xUX5GVYWIfKr2FEbD8HYkVCn39BVdXrWpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpf1/76vlBbEvl6gNW7EGYorT5KJPwBLp52WOFj8W1RDirptMuaWBFSoRUqotQ1yEqhLPGGSShJyow26k+4ijh36ynnJ2t+D/7paEJYUZvowXmu2usu/02mkW3tB48L5luTHVJqSkuQFUjZ22n9KwY91Ljat8lu/dPxF5qCWsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Moa+46XW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkXu5WW9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Moa+46XW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkXu5WW9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtR4W2449714
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdutxu1QSPLRQaJGSv++B9jUfnt05l6Eko2CexsSKaI=; b=Moa+46XWBvNd8yYN
	QAq360Sn4DLbWW+1lLKdJ7S/ix8kPSST4m/7xbrN1jqBNRTQcwAKx/x4X+yp7DfW
	o+r94aRKyfk4s35R6Tdv0h1X6f2ft4IFpR2fVbI9ZNqGhU/cwWAiIXhz7zmeuzD+
	ECUOmQrd2Zn8bZD1Lxu6VMEXhS61eMzi0/21L3USWJ+pjsXAQwUB2CoIj7X/FMYN
	i68FQsPOrWpiPmLiaihdN9W6v8lWJxw24m3yxXa1gpOA78jHs2TPXbcPOisovYxZ
	zmepR3psmNDv3gT+j47ricEeYy6vwghauSugSwU7JulbobTjUJufdLcBpr5LuorY
	clB5tQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78trsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:09:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce756aa72eso38032405ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784326140; x=1784930940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdutxu1QSPLRQaJGSv++B9jUfnt05l6Eko2CexsSKaI=;
        b=IkXu5WW9HI/C1kuG2JJn+1I4BVdhqoRNUipFt6tUH+kBgUbj0MeHMPG061fs6YnzSD
         vlfrqZUorkKHpKweblDmMeNiTSuvcqdVZoNZE/4tDK6cCOge2FkMs8PdFgRosu0nyW5M
         TMqvx1LBgEbfnSMEspepUv4Lz6X7O80wRFd95ufp+//hOoJUf7QXaZSCS4PT/U6dBOtO
         bdOuXSXTfYZXqG+kUnDVIxz3U4AsuNZaDJ9L7d6BfvvXvdW70y8czxVp0tvjkkqIotNI
         /+oZhjIQkZzYubOQP2FzvkTw1RNxsFTyGO2OmO6SGGES1/hvGYu95caKzMKywwJkqAm1
         R84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784326140; x=1784930940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdutxu1QSPLRQaJGSv++B9jUfnt05l6Eko2CexsSKaI=;
        b=HBBCpgUEZ+ZzpoH23UKFZV8Z7pjI0PtR5yjWJGhrYMIIcMbd1pnQiIkBDonq6DsAMU
         dO62aJWGXSYAisf5o7OkHErrVNbMohrCYv2s5AQ2urmhMz4mV18bQQ4Uwv64qjsF/LO7
         2JFmZl5Kyg4wXFsZhztgsYDy6wUzgw1sHa+DwzCaXNSBV6BQMsuYuxJ50dfZ8B9YHTWY
         zIcRD9UnZAceusE4XFGuWM8hfBUmQcME1LDxqU2y5wToaRNIioXyMxHx/bCmEYKJRAXj
         9l2e5wn8GJjw4SzZvV+NZ3yf8cl68q39u9mim2bu26YOX1uLOHqCYBZnqiulzWzYMxlZ
         B6Pw==
X-Forwarded-Encrypted: i=1; AHgh+Robn1n3vzG2rVgZUZbkWWva/NsxVB6w5W98Ks6ERE8FUWNnUIKbXUn6Ls7S3XJ13tLMWmVinnlvIWIlvY1Diqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuTvPaO0LBc3quUX3h8DUNSRgjgPYdBMBLAc9aWZ0ga0MdjFI
	3JEC+czx8VyaTF5pgjNJWNdCh6Y4oGZLhjoFmyxdhSgGHVr05W+D7W5mkfewNjHTLjmcDjBtn06
	5YlBNLw0Z3Or6YRozoOGxaSj3Tb4pnYEe82oWui3WPzqj79cpLAFxnw717kH7pksDiNBxhhCObV
	JRsxI=
X-Gm-Gg: AfdE7cnixjFaStQhgG/oR6mK4B67ZWL0Ub6IFrR4wEyKjZn+bFIYcc2I9TN3RNKawpv
	mU8lfdeGotA+0DtICKssH2GgKtyG1nLgFZ8A8rT03RklJFn4HLohBcpAxd6/8rWhhOAKF0pgjmW
	cpC9ASHKIw/aUSzOYyBoiCLcQwH/mzGcTnd5pxuIT6P24Ix00L13R95wuaXe1qdjGju07uhDVrw
	g476Ibb3BbeCeFGklTNXll8MTGxcvYm+adu1xVK18V+mWgGxKlLNbEtdggrRKL4yBpYV35nib4t
	ClXoKLemDDmvHxhwJwQ44IXgb3yNhALhN5+VjCOwzGpDia7FffKiJ8DrkFuY0dQfgguheXNFAuP
	27OEXHyCZVczAesZq8Sg/8l1JGwYjhLsae2Y7I/Dk/S3GtIk=
X-Received: by 2002:a17:902:f684:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf34652e9emr39186375ad.0.1784326139962;
        Fri, 17 Jul 2026 15:08:59 -0700 (PDT)
X-Received: by 2002:a17:902:f684:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf34652e9emr39186175ad.0.1784326139601;
        Fri, 17 Jul 2026 15:08:59 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7668667c88.1.2026.07.17.15.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:08:58 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:08:55 -0700
Subject: [PATCH 3/3] Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT
 usage with HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-fix_vendor-v1-3-f22263c1175b@oss.qualcomm.com>
References: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
In-Reply-To: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX1aWYXrjjXVeA
 1/lJ8F2Wr1CxvbIM3eKWX/TjNJKRZ4KBaUurxu3Bsc1wegGJfCyZxsV6Kg06QnU/FX0bbxh/1Vw
 ZZhFuAUlc+RCnicsvM3NROoH1E6GjeKejvuMZRkV2XvDiM0rVMqH2VubZOsv5GAWDOKCMcFllG3
 8kfmqjGgRS7sIrQaBRPlZZRehxj19pbfz1HboOls5dA/65jOBOEzqXE7UlWeuui6RTzALAYvKup
 lKN/dX5JByuD5igzDnBZ5t/Fq/sorwxAdZKl4eY13p1vsAGhN/GblqemqB7d/VeEGt0dzY+B5Vt
 A0BzMy/T4mMCmpQiPhX33Mlv+fcMAMwrAeAcUvrE0/EC42V4LBMLFM7XgNAgXKCccSsML47Aaw/
 NKDhetPe7YuAA1BhYqYBW1Y1kFsY6NYy3olTJtwXiWEt+GcEg4ULJJcJQjf8v2nA1/e5WnkXVGK
 tPoX2KC22/Gii+E3i/g==
X-Proofpoint-ORIG-GUID: Y3NHA-xh_i8mftvq7Wp13T2s5VrjkiaT
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5aa7fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=x96CrpYRk5hthMOPTrkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Y3NHA-xh_i8mftvq7Wp13T2s5VrjkiaT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX99HukAtNwYmx
 ZMVpAf4HEOctrnXhsAMaClgqzoZog49Le742+eB9sZKrhUL4J30NcPdqKNUnzY4f77X4tfuap0E
 nh0nwXcD5j4Kx7I2osDooM8AzB9x+hg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170229

The macros below have different meanings even though they share the
same value 0xff:

  HCI_VENDOR_PKT: HCI packet indicator or type
  HCI_EV_VENDOR:  event code of a VSE

This usage of HCI_VENDOR_PKT is wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d69eec8b2911..6973daab91ec 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2799,7 +2799,7 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (skb->data[0] == HCI_VENDOR_PKT && skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
+	if (skb->data[0] == HCI_EV_VENDOR && skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
 		struct rtk_dev_coredump_hdr hdr = {
 			.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
 		};

-- 
2.34.1

