Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B639902B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594582; cv=none; b=Hwk6Uv4vU799B6iSoHHJPhfX4euIGB8eqc11af2N3hJ4peMxJBoM1mRtoc/scFPMW9kTaeJkwXKDmUa8NNxGeSn+88F+DGNvEmzF9APuzn56RJJlHWnNHCO8u1EW6hykNtjYqh6/QZLJPkAqK7KdYzoBxYlNRCpwQoRYx8H6Ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594582; c=relaxed/simple;
	bh=sn99bQMnWnCKFolU0Sh9MT+fOPT5TJaE1kAOvhQ8rWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SF2Ybv6c/x6n2B9XJ0h/TWFcoY28oWkP76Ooglfyrkll7o86cJ96aV+AWk6MXFMIYChnNaZT/gmpJRiX8+ZQCWgEjKzcwemDEXETNUbCyQl5+vP/RozM5TVS6SNhbuDAv1Fm+6NRyGUTs89KnW0f/oFQKOJYlCpZrh3WtQZFyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCQsznx5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2mlMPi0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCQsznx5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2mlMPi0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G64cEb2911806
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bHdhicSjT/t
	6YkjzeAchJLrbKzd6RrcddAl5b8TZKRo=; b=oCQsznx53neg6/wkwVx6dhCQAFC
	YCIrQYeTb/q+JfNAHQ2zjlM4oyfB6t4Q4yFWOT+z46ZXs+tbw54kNQG+uPcSx2Wt
	iceX4qsz6ZEEPXSO3Zl1lcawAI8dUe0CKWmG8JaL5hPasILplLsdNLx5VX3r/2It
	o+4ykE1SW4yBTQZLKFKFWMZAtZc9NktYj1ilTZOT2eVQYZD+HUG37jCnpFm+OYuX
	sN9bPnvY7qrPc+Qc2517nvxLbvZ9In8p98G8uSMGW23zqNddN2y81/uZ40vkXoPL
	51uJgRKgLTg+6Lt2MdXqwggSUkR51XQweFiUWVvbXgXFb9O9e4So1Tr+HuQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52rrv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422f987f2eso6989623b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781594579; x=1782199379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHdhicSjT/t6YkjzeAchJLrbKzd6RrcddAl5b8TZKRo=;
        b=O2mlMPi0fpKcv/OBgzqqAm/ITRidjWu7uzso0dGvNyDVA7D0Nb2dWPA2Ev54vsh89V
         4bKtbr9WYjmkStzK8lDEOnm7/9aNGRhW/rt/Y/PpyujfD4efMGjMXSq19K1hi4P0a3LM
         qnzth+mEaVmhv/2HC1LSpMbGCNJJrjXvoM9O0m/+MlZI9zokvGi0egJolCjuiNqmm0kh
         mBCDAzbogsQUWDN7Wqf9alCIuMErlvY1Wo1wSLxduTmdbRM+AGuM+1cfj29DjQ4p7eSB
         CDxiH9ZyFBl3p61gqTAucf1+o8tps/XXZyTsBiPp0/WsHRHbaznzvfXOfKwimzYMXiYG
         vByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594579; x=1782199379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHdhicSjT/t6YkjzeAchJLrbKzd6RrcddAl5b8TZKRo=;
        b=paEI3szcPghtlCaueU+llDNxUUImuFXJD4GQiU7QfPNnrS7cPNQPLhiPKt92kAphpr
         h5HsBz5RbrJaXBxTTCjM4z2g967VPAapImRK4L6uRiWPuYyVFXcAPr2722C4W8ZHmIIt
         HEN2TbtLPWIbl8cg2NL8IULbaLafoVWx6W8C7gDgM+4Ay4xNICJGIqDxF+hhCEFPDZyJ
         jMj7vJcJKs6z0HTwvbMvf6EzWzVzxWkAguLcmOullUhweMwkXAxAbOW5QAQBZ7H/qSli
         jmnJSPS6R7U+e65wCeyuVCo+Ibulm+kjDVeN310sQL327Qj64kKjSq6/0y7s5wISID1w
         gSPA==
X-Gm-Message-State: AOJu0YxwQ5492yMNuc9OcyVR7jtwPS1o/NRYPbSXgCSxlAkLWUoXnFy+
	aRq/P1Mk2zjJHAg6gMBo1/28mOlCEQ4cu6O/cfH8R9rmacffAledFAhWydxnAse1iRWv1IJ0Lxw
	JBZ6hHhz8R2WABrhTxT9ZIFV+bLZauIYJVeyh7jIe3CUoa3Du5TEMZIjMfJlbDBNQK8WvBeKbw9
	loaTw=
X-Gm-Gg: Acq92OHxZT5UGvlssO/KRLgu6r6v+4u9U//WuKEWd+dEjtouXKEFvz5X5kVoEO2qtXl
	eJrR7HvNNHgqEYF0uUhC0vLqF75kIRCXRrbbRn2FycrqYs29nnx1kP5LijWe8Pq7vgCqXpYhPn9
	0qClnEJ/VW87tCCS10+ugFDFqNttRWccrJ5kYvXWVTOrVITwpWVgLhPZORqZO+Iz3qrfy9vmAHP
	NO6WLCnEqdbbGsawWFsAN031Hf1tOEbCbPa2kS8qc7fdlnTPmL/LoH/4V33IzaUH2byRp1cFAK4
	YD1gznsKeiD+3K6yQxxdb8HoZ1er95gT9rGLGJgaLgRA75GFhob82N0RdrX57VUIQa5qy/b5ay3
	vELsUymAIMBWG/ZeRlYLbwbwaw9feAXXpdNQHMkVIPpdzszgN4ig=
X-Received: by 2002:a05:6a00:2e28:b0:835:45bf:9659 with SMTP id d2e1a72fcca58-8434cec4688mr19778819b3a.41.1781594579460;
        Tue, 16 Jun 2026 00:22:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e28:b0:835:45bf:9659 with SMTP id d2e1a72fcca58-8434cec4688mr19778794b3a.41.1781594579082;
        Tue, 16 Jun 2026 00:22:59 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm14394934b3a.58.2026.06.16.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:22:58 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 1/3] shared: rap: Check role before sending CS Sec Enable cmd
Date: Tue, 16 Jun 2026 12:52:43 +0530
Message-Id: <20260616072245.3700010-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
References: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MiBTYWx0ZWRfX4HiF8/Q/GqR3
 y7fPeToaP4vmWjir56dEUfObE/TApYtnb1GvQnQJp9QCaXA7mh3MH7np1tR3FMk5ksZ1aTKiczK
 ns+ZVE56Di1K40EHnYaU15zP++xpaO8=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a30f9d4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=cUIuXaSPidSQRNFqEkgA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MiBTYWx0ZWRfX3/W6VUnHbUxP
 MXFzRlxNRaYcLB6n8ebshfQvUBfSCjYV3b/+GpUC+wgpRF6LgYqLgiZcs4uWUz5rcw5tbEeoyqL
 6wyYVu1VFdrn4sm7uaCPzivvtUQjAVxFrjAAahYP/Uyzz/Cpts/B7TjmVeo/wUvEueQECXKeobV
 J5H/97Agz40oXK0REXi2nCmOFRuW+5k/Bla1O7tJkKjfOT8xhp0pyp9PZgW+IwqUPYxYCCqDkNg
 eC6laFjHHtMdYa9EKI4/vKIbx3ocNFzYi7ChAVdBAkpugm/ia5oHhRLPuQxj8ggreqqySIBrT3k
 vbOZxER8Bx5yBhyzpTy5x2m9yuZPlmfu6qNeGiQzLhrdBAnd+/5nRDu+OLp/ZCaYGYpqLJmNJDE
 rjog17CAfKnVbV8e0pKb3w2nOqZHiXyCz2KHhvHWDNSqRK7gvel1SXvFQmysC18BbpDie7R0jwW
 npCOOpi3ielz7qRMyTQ==
X-Proofpoint-ORIG-GUID: tQX5bfpQoqcT_HDco4ry2mqjuZqQGOo6
X-Proofpoint-GUID: tQX5bfpQoqcT_HDco4ry2mqjuZqQGOo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160072

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.
---
 src/shared/rap.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index d3ced61b1..7db68478c 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -212,6 +212,15 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
+/* Old API preserved as wrapper */
 bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-				const uint8_t *bdaddr, uint8_t bdaddr_type);
+			const uint8_t *bdaddr, uint8_t bdaddr_type);
+
+bool bt_rap_set_conn_hndl(void *hci_sm,
+			struct bt_rap *rap,
+			uint16_t handle,
+			const uint8_t *bdaddr,
+			uint8_t bdaddr_type,
+			bool is_central);
+
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
-- 

