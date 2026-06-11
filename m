Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB83CB2D4
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179262; cv=none; b=cFvHs7UIdBZ2/wQGoOAX5NNl7phNnT+MHFs7gcs9u/a83vOQXaOhgXGGbvLiQdES/CAspgbzy0pcO7EJOp5VY6Cf8BNw8JPhCiUjK41UWGb3RJNRDyCPzd0dczO2VNvn3TxMhXJtY/pZNzsXOqMOlTkeAUfUJq12/g65Bftsvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179262; c=relaxed/simple;
	bh=Rc7JOgM8vhIlvOVXnFRA1ekfDdmZueZLpi7JLnnKPf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiHis8AL85SGttd44yhltKxl/QkCCiUMJ/2ePtih6vAQt5QVxhTyKLaJRwaoDcn8x0sJTZMG9xuqrgv5+Jj4MxMK22qJYfmGCpcjgozuMaJRHpNZWlmmBeK5Z2PD4ngKBXYhP4MVetjlED7n1qTDm7M0xCTJ+BHAK7EhYuvCIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDnlsa98; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/jnX/Gt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDnlsa98";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/jnX/Gt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9x6hP267533
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6ngz0OTzzBQ
	wbwRh24mKsswW+E/ZosmTUBGxLeOnY1E=; b=cDnlsa98fUprk8bsqJKARML5S80
	cPhjE1lyvHh6Ft7GdV8qDgKKbzE62oK8m7xhLgZQtiXbmAcPsqtXhT5xBqiMIWrc
	i2DyiNn4T6ab6HFuSU0X2NwBN5fA50ns3AIzau5MJsB2N/ZLLXoC6qA7CsO7yFbr
	v3SZcqbe8PKtezlGfw9CWXms6mIsVbhXpXyw4IG5gn95o6/Xxcvo6V1jrwhPlAAn
	17x/dkgwb2tI6gCtu3cJMpWSQxuRGom8UyYUZE9/X5DV4p9mQF7cEY+5hRQJNXeV
	2Qp9DBebUQhAy637cL10xNJ2nywyawkIOGqwLZ4ZLorLfYVgTUewIZxiKRA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u38fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so12704232a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179260; x=1781784060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ngz0OTzzBQwbwRh24mKsswW+E/ZosmTUBGxLeOnY1E=;
        b=A/jnX/GttSPIs3dDkwZtmB+R4hA2yLNKIh+pWTDyE6Ts71e+fn/O/kylK6IqDkXT1U
         dusvFs5PVirsE1duSSd/7nU6EvVxwqxhhHtSDT5AEDNnAqx9aQSIUhF40afzCJaUreDT
         bffWDxa/+eLZAZYhzy5SMEMjz5a6k7iQe4NWkuv+QCoBiarwYsdkAEkYdD5zzrQpgdit
         241RRGM1sI9xOEEveGXIUxim83wWEd22wja+7j3CNWqQetzGImlrnw6BRCw3V2SvHxiI
         hebVkmq7YXwM6ldsdAEyzdn3ct7Q7BxsL4irHKzbXEbRCkraPebIE99x0JHlXHwKoeOZ
         9CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179260; x=1781784060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ngz0OTzzBQwbwRh24mKsswW+E/ZosmTUBGxLeOnY1E=;
        b=IvGjmC01DcO9CEPfDFYAHL6l6kvNTTSRuIScVKeC8pOOfstHER+4tJkTRPDJNIBVHj
         2GWVXxhFiGYppcYbg9gsOjVaDs6kWdOGO4JYZwyV0zW4nsb4DHwpfNTViiqqm/1jr3S4
         rwNzanELE/oir3jLLL3Mh8Glp0U68rTlxaCFO1TaQZHxfqoU7FtakDK6f+QyTQzYfQ0Q
         52lu2+qQFgeujsBHjGyucebKziAQPXmAgLHlpFjJQ3FrDz3BEqrQSVYbiiNxs50AgKJv
         WyEt47dI07g6f/5VXRC/b3bShcSR26YV5x5Q8F2RAM4gYyhJ/GRfCSVSl16csFX0+OEW
         9JFQ==
X-Gm-Message-State: AOJu0YxoRkXOxtVUFXm2ZHxD8WIAW4IBNiPX6V+fPBlnJnhAqwPNxunv
	2/N1pRdLwJZrzIUOTi4iJfcwXmqZhPtqMNO1vOM3Ip15ssYxFbewbjsn0rUXyv8E4pBY1UbxtRq
	lbp/YylImFk8AiXqMmvHUbOLp4yyrYCLNndDwjkMr+KGmUK89xoF3xtsDtJMJ82ais2b7U/8gpX
	2nMa8=
X-Gm-Gg: Acq92OF5ubb/efqrwMTIkgSKb3hshJmSlApRcY7eswjzttKJBGUSMtVjzIfAJ8s/me+
	PK8xJL55z/VI5zjX1VAED61+Xdr1qdFxeuWoHFuVx3rgAXR9S8kLpf784wePaSdXAab7jyzCQtc
	IWLJ7FmrjD2/wKlCy+4GmNZ32IoV6qsvG+j9jvdGy9+gar44ut/BLZ+gV8Jf5RvrJrgHGEEUQO0
	moAAGomEI5aL91AObnZQ8b1djzL7ts/5xq4ZEieNfp4xy0I5kAhv6uQwFlX2R+xtsTXfE2lHk/M
	SawS7JR32FVu7778Ip6dBsheTF80abnFd8RMYXgRlnriW8wZVEleHNaqvQEPsltNtwK3Jkoe+ng
	cOUy3eRH0wbqBHTCrOlBXUBUpeHzc57Qxf/pO01hidolxsdtgrvOhM0MeGUfTUw==
X-Received: by 2002:a17:90b:1642:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-377a5915432mr2707664a91.16.1781179259629;
        Thu, 11 Jun 2026 05:00:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1642:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-377a5915432mr2707623a91.16.1781179259101;
        Thu, 11 Jun 2026 05:00:59 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37755e5c283sm2437402a91.15.2026.06.11.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:00:58 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 1/3] shared: rap: Check role before sending CS Sec Enable cmd
Date: Thu, 11 Jun 2026 17:30:42 +0530
Message-Id: <20260611120044.1641009-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
References: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MA1CJ-HeY8YGLtpv--oZ8lM27xHgHh1I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX3BFydUU6p7TV
 t/Nbs1ErO1wIUrNjFBktv7ApzBpk4gXozo9zRXluo48xfbzzSiTS+WxbNTXmMc009cBK+D/2HXV
 uPUXsEgeYWneHHS4Yr0y/+HFpnThPaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX0j/p/SKempC+
 qSBRhfO1ow2XJafgIN/b+pms9WJLE/2vjU53jmBIKm1M9QMR5Ge+Skxwl/dTlCPSa00CQ7qyuqV
 utnB0gn9XhCS+V00CKj/gVu2cHPRFOLB+SwryCFtv4ujMM8OW2qseFTyKBrIB1NpMwQmBZ/5c7O
 IsF/ghvEoVl9oX08IZKPI0R3Rt5FgGyKmcjLYXNL3lJaoT7DkZreu1muxmCVu4XjV7DjMpfxU3D
 wpnMJHIHkUlSEQxAHzpeyBUiZOt9RkPHNLXvynS2QOQPnxxjs4cbPNXKlw4txU2S9YuzP9inL9a
 MvVkZYDFtAQssanR/rDdjsBjCdSlP9dTr354wJ8Zvd555i9Fx30n47l0JThXgG8Acj/5wFbynda
 1pfx3SeWky7RSL/0HkVTGVU0uJmpS32wFoK9es//JtNQ9363t0EwngGO5pQchkNpAZQWJXLWy38
 por6wV1uz3CZVRGXNZg==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2aa37c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=TBJnjMSLc-rruMzMLgQA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: MA1CJ-HeY8YGLtpv--oZ8lM27xHgHh1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110120

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.
---
 src/shared/rap.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index d3ced61b1..a5095aa35 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -212,6 +212,17 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
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
+
+
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
-- 

