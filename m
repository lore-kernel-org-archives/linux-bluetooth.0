Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2803955DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451193; cv=none; b=Y/VgJ412phzEXisgZTBMeRkOp8+xrJPSvWLOYP1btU0nPBfOfAnMyxNzEPp4wqc2E5SOIPxXn/T+pVvt+/Jos7ZPNKm0QBQceTc+Bi5/Y/0zeHWVu734F8xXGWZOfxA9WKekJ9SwOtwLva3FuVLxp+GEcqUGokWencYkFI89nNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451193; c=relaxed/simple;
	bh=vn6n+zJuAbBPGl6SW5Y7JbXdnr66MjSLvFQV0xhONcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhCL+n5hU1ASGqMuCJKdQZ6SEM1RW6ktIfEXQ++701GNhs6Zo55mHMnB3LHEUiTaZae+ljE8cXbWl2PLx71WO/TbNlV98D+JR+Av2idIqyVjD0Eqs1bx5GsY7xFG9Z0hDu89TfIQkcC8aGc0QL0QvUTBwF/54Ywdwo95BTosf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkLrSqeU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DWWDYUpA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkLrSqeU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DWWDYUpA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2il2Q120171
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G2finj0/L2eL2pJlI5BwyNIlltaVM52H9u3UOxZ/TJ0=; b=AkLrSqeUo6jjMtaM
	fQX2aQ4s/x+5tBKAXO+TF6qhLYpVhaKId06+pv+YI/NIlj2eUwYqr2EqLYFn+jjk
	YAhOAucULUnX4Mu+spcme+2+Tuk+AuUgJJFWD8HkvIguzAai2SjPRh+zbRxTbx33
	jZO3c/Zqe+apODjveKcvcwTTBHNGOVgpWcRQcyT9kL0pwDw9+HZ7bfbWkxc7pcPY
	Cj6xrlex3/h1M7mjXTAtjuQSyZe+94JtDpnXKRuXNLgmVo5awyqTdgWCL5lBPS7R
	z5lvFOlT5vNsHpCfkdRRvV6eRzH80XOD7wlNR9t60P0VarREcEidrTIiLXgQfTsF
	GYeB4Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1askswvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c86003da9so94548eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451190; x=1783055990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2finj0/L2eL2pJlI5BwyNIlltaVM52H9u3UOxZ/TJ0=;
        b=DWWDYUpAC+/CCatl4xKDLaTbjd5Ma+0QYoM1JyvzRWC98gP6IOfVYNysFniemtJLla
         Av0MRfuV+4+PLQcnmOBa4E3d3xrS9npJsp+8CaLAo3J+5yot3rY/cK1pMJLafplkVWc8
         K2u1a1EgaL/3COqBrXVqS82ahJ2Y8N3dFtb7DG6E46iTvA2XjbmXfK2AQckwI80ExGmq
         1WpdG8Qla3pqaf+oidyYv0rjNy1YDIceS3Um2TThI4SIN6vMkkrQ1KqVpd8RPGagJ1CH
         dF8frbNPbsp8Deny8EZDbqPP3t9/VPzro1OPCMG6iy0R3tdP1eyD6auuNHLwpbl+PvSn
         RnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451190; x=1783055990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2finj0/L2eL2pJlI5BwyNIlltaVM52H9u3UOxZ/TJ0=;
        b=PTNomNQAaw8P5pmq2apPuySZEd3e7tS0+9tdt/KFB40/nQcw541uFIyhnaJFs21w3r
         CR56157Z8wUPH1e4xRRW+qk68rc4xzYeBNyM2iaNbL11dA7jTDMgLtepiVCkQ6Bs8z/R
         3fWSiaIueq4nIiz+rx7KO84IHQhYX7Ow1czeFKpczdXTIqASa6EOrOcC0OGIUv+2c+Me
         IezIFj2JLZtLP3xwdQTKq/vDMh9BitpKlTHgWksbAqp2ooKTk/sUmxMxMftcKQLr3U8S
         jsNTuxHWRrVPIoNSiVF1x1jyUEN2Ck3yuOlDxo8f0WvEX80CYSop5nXDjKnm85BzFwU8
         KTdg==
X-Forwarded-Encrypted: i=1; AHgh+RrtfRPKuuslgiif8kMndwXCDbmlSaXdem9+DPVkE6jVbLAWnp0EOzq4uqYEjBxDDfCr8D1eweBooGqUFsaNl6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2PX9DapH4zzYwJy+jJHxoklGOfMFVehRpi0e8/3t91BSc5DJ
	5cdRuf8ljjI+7Rijby1lyY43FFD49TlrD6XqzsIBjAVV7o1RYZmizCAqanvQQlRxIq5KwhaCQ6c
	Kphi9kxa5ALUnnUiB3uTy1o/1ascS5beeex2+A9LuTnpHCZoqJGpe9GWk/YbklQFY1Lm4vXE=
X-Gm-Gg: AfdE7ck1os1QuGuSUPMJytO0b1HrND8Dky9NCVOV2MX+hGouI/Qm1XDaOSMnlcIlAhJ
	O0644x2p9QOn4LMPSGoGTOEQYm5auvYCHgmbl5KzBxMz7Pd/rwt1nqu7YAmWA1jHPrHJDgVoVNg
	lS91njhOxkM7vpVEehPrHfYEdEwnnUFEEW6qEKlM1dUcf3eKghPhNejP+kpN8nTClmqEWKeWxPd
	hEfpJuQvgD9WPDoCU9trbfGVRRqz1gCfDK/AFcQUsiMWSYeLdLFsDPGv38ioQxvpIPWzk7DhE/X
	3LQqYYSFZQo6KKzomLXR8f15dLzTLgf24g7jS87dK/HuzdoOFmFE6d7z7mrvjKxbBGl7vvE0cTW
	83WJYeSOXEHNG4ayKVs9RKeHAKKDm9VF52eTi4WI5RVsPPWZfBlt5CzKZ8Q==
X-Received: by 2002:a05:7301:5f02:b0:304:4f23:4823 with SMTP id 5a478bee46e88-30c84e49c6fmr2464341eec.7.1782451189984;
        Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
X-Received: by 2002:a05:7301:5f02:b0:304:4f23:4823 with SMTP id 5a478bee46e88-30c84e49c6fmr2464316eec.7.1782451189467;
        Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:48 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:47 -0700
Subject: [PATCH v2 02/12] Bluetooth: btusb: Fix BD_ADDR byte order in
 btusb_set_bdaddr_wcn6855()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-2-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX7rqqcae5W5EU
 SCfMQXNAoXtasHgdxd8Trj6q4wZzg24PWG8ISLQnxIt53xZv67VcDXMsSPdkepOuUK02iRCFFfC
 8+wYLKi/uTDzk58+75EOkx/RlfXFEr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfXzVpmQWCuoLjT
 iZieKVafdoxt05CuqoGvpdt8N/sW0RqshIIYVhf+3GPo8bHTxr3hW+dZ/UkwSsCNa1yTX1dTaOU
 jNa5fpLw4bypwNx7xsL5sVzNkvFQcH1XowPD2ol+6JYxFG9yKkcf1U1H1cw3ImX160SgLwdw6fx
 Qo6FLjSUxkhLf0LTSZIqPIRtXLF8Lmj0bE5Nt6o+gazsmm0G7rAGh82gBItQT0pJjOncx+kwny0
 8wj3c9MfF363Q2bmlMnClb7IQl2SzHl4Y8/06a6mK4s2bku/8suFE2zOHMwmgubYHeZQEJqKJX1
 WqSIsYxk5Xa9UOFrTk27BZRvNPQmYGCMQUbVn233HMzQryEp58b1VZ8UBvqqA/WzgC1PyIQs3iT
 KJ4DajeC25rXkCgL7VubiTI4XSrBC1/SxLMXCyG15rKqO44kGpE3SKb/djPxIkvXFTNuChaWz3B
 7M4oz/VWigNU45xW47Q==
X-Proofpoint-GUID: m5XN_eIXiLCPcpybuNKGfdPXCaG9xeAC
X-Proofpoint-ORIG-GUID: m5XN_eIXiLCPcpybuNKGfdPXCaG9xeAC
X-Authority-Analysis: v=2.4 cv=AMxnnMPh c=1 sm=1 tr=0 ts=6a3e0bf6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TYDuexqLZnRZS9vKGCYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

btusb_set_bdaddr_wcn6855() sends the address without swapping byte
order for VSC 0xFC14, but the command expects the address in reversed
byte order compared to other HCI commands like HCI_Create_Connection,
resulting in a wrong BD_ADDR being set.

btmon log on WCN6855 shows VSC 0xFC14 is sent with swapped bytes
11 22 33 44 55 66, and Read BD ADDR returns the expected address
11:22:33:44:55:66:

  < HCI Command: Vendor (0x3f|0x0014) plen 6                  #3 [hci0]
          11 22 33 44 55 66
  > HCI Event: Command Complete (0x0e) plen 4                  #4 [hci0]
        Vendor (0x3f|0x0014) ncmd 1
          Status: Success (0x00)
  < HCI Command: Read BD ADDR (0x04|0x0009) plen 0            #11 [hci0]
  > HCI Event: Command Complete (0x0e) plen 10                #12 [hci0]
        Read BD ADDR (0x04|0x0009) ncmd 1
          Status: Success (0x00)
          Address: 11:22:33:44:55:66 (OUI 11-22-33)

Fix by swapping the input address before issuing the command.

Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f14ce96319b..17573749adda 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3072,14 +3072,15 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 				const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
-	u8 buf[6];
 	long ret;
 
-	memcpy(buf, bdaddr, sizeof(bdaddr_t));
+	baswap(&bdaddr_swapped, bdaddr);
 
-	skb = __hci_cmd_sync_ev(hdev, 0xfc14, sizeof(buf), buf,
-				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync_ev(hdev, 0xfc14, sizeof(bdaddr_swapped),
+				&bdaddr_swapped, HCI_EV_CMD_COMPLETE,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "Change address command failed (%ld)", ret);

-- 
2.34.1

