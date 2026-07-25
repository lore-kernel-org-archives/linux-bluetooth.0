Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9938E5FF
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969705; cv=none; b=IRtZd4OUshscuFX/HePrU768Fq5N3mikJXFFtiP+af83UcUNwunB6pUOGujJ2Zxj1cFOTlM/I1rOuJrDcv0SuP8/JjvlgJEl0XRSfIt9EDREUhpEHynQDoQpFSPLRzRwiynQXy0wVW+uq+V/Lj7qVFNVVQbjX6U56pkaW0M6t7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969705; c=relaxed/simple;
	bh=oLuH7AIj1aY9dQAooLNEDDTQsMkwPO77VSIEpl3Mwlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UamqMpXGlVHTGHvXDW/4q6tS+FGQJNBpXLgQbnTrGVpkvGPhcg3g3EQY8aYyJApxUkVMtdAE3igFb4gx7nnJiWUYp0I0A9uaCFvb9C6U+EcPev1xRN6xvX1uiRzhJAUqHQ0TYZfFesPgSpdebmoxi9kO/TvPh/vGD6JrBWzRi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mf0ehrdH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5jnGPbn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mf0ehrdH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5jnGPbn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4mUYJ2105861
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQfpSMcYhxcC26y0rTlIV4OBDgcz3iaKfSPGF3LNv/k=; b=mf0ehrdHyeec9MdC
	FCGhW4cAbH48kxxHgE3g2Z8p/k0xwtIyl54Mrv6bqqy6A3XVeqpOwHCUlB8VfTnW
	YVzs1CxJwM+i12z8rRSm635C+FmvdlJhMTHn6tVENC1hpyReZLX83aYa7S1QRScj
	l8QksMyR51QxL9RRcf4cynr5zSkDFPgSqK4IPo9eF6MS7ufy5p+IE0ey4bijwcRz
	WTrixdbvi60VJjbkZKEpQ4J3pS9d3/G0rjEWThriaUU/y4qmPwczpYemi1AbtdcW
	MigEI/xAJr7E66X8RL7AodPf2G2HHMBmqnpM3LBXnOPuJ0zDhrfNuBw/5EgpAwXu
	4Ngnsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjufrud3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cae7a8b9easo2097105ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969701; x=1785574501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQfpSMcYhxcC26y0rTlIV4OBDgcz3iaKfSPGF3LNv/k=;
        b=I5jnGPbniM2mrYLAyt39plcOHErI10UtSGIOjnFD2hXfBKL7OdpA7hI+yD++BKftHH
         2eFBnMxaWCx3p90wT4bc1SHJOjKsF1Tsrz31+Am64F88STa9/DAph2BMbt75lX8gxioE
         igkYrnc3xRccN3xDz8G1dwGJ14wzz0CqtNZoNGakvqfJQUNmGkS244M/ZJRocgrtCaOr
         aRTbn8B/3G09Jcb2se/adTFZuozDYZW3QF9pCqnET+TvsWSTNoRWOaKIWbFpAbv6BON2
         23c4Aicd1T/Tj3ZLDhdFkSQs4R0EYnOGacVUniYsgbr9uTJYiMdBLO7w+3Gr0M9yblvU
         BLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969701; x=1785574501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQfpSMcYhxcC26y0rTlIV4OBDgcz3iaKfSPGF3LNv/k=;
        b=Ee58A3u1sN8yZnXXJt1v02idA8yeTTlKIn0rZ2USrEPn/e0bDpbVN89L3IxXo4uQRJ
         dX0ce5T5jr2RO5DlOoLHg/EJxqb4OKNGOdrXmJzKxATbgq0HW+9nY/5Jlto9ndHAhrtK
         NmUHbT5/8yC25AmhTSEOJrayQIWDg2/OgdxW2XNUqLEgyi2+jeC4w2HaBBi/meGiys7f
         HkVud41baPqs3b0bJVaCC/eOToGB1r+36rWrtttfGVlm40K79ElflLSN5V105MWb6m/U
         xf4eayOfgIIgYtuYAeXgA7nM8Nw6rsQ/+uAptMpIGUMPioVH6OiefhL5MZ/Oo68poaQP
         wVWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro502ZLdqK56mWfC3n74Re6Wm2VlF8PyGhtwlY+jH307ic5PNZHD5RM0KdRe4uqJE7s8ooEuz6oTy73xhwYapA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaipHdNfYfas5UluYum2hRM4O//sfBJ6hPKgYBjWSOs5O1EJ17
	z8jcB9oy3XVwkO02asglBRt98aPXM3a03I5u+9wuPDI/qM7vnugOijdj0qHPs0IzYfW/j6n1gSN
	heH0n7OGwh9EOTPB/djJzoBHUbYact6JyvIAOFf9os7lXtj+jGhic4hCK5NeG5Cjwac+/hKw=
X-Gm-Gg: AR+sD13sP07iMfihV74YgVi0UX/x9mfkAAOdr4aWIib4mhd4d9JzdgQNLcKLwr8EO0R
	ryXZ0OwW1qvMpAj7KHNLwMO3robIeulFIHfN7sbSjlLIM8OBLhH2SxoSGO73bzBFNYyJKDrjC1k
	KvsKKtX3O8D2YvIjZqlcwfVY6RxDHh9XukVw8Tg3uEoIefAzwke2CrnZW9r+DdOrpRbPlrg7hIR
	uW0q/CEgVMVmJcreStdVbK3Hj2MifHPsFrxG+XSeHApjWemoXiAlJLxDOCAcG8t37PlO0zzRzH+
	9Bj8wUfipoWkyRYDdtJWC+AkBpN575bFdiwx2QVT4naTRfNUe6Janj/20UIvm0LWNyPEfSmMyRo
	RZtuYrVRcQbmXHc1J/iSY934+7H78oQGHg+akE0eyFmYjhNc=
X-Received: by 2002:a17:902:ef11:b0:2ca:ecf6:9105 with SMTP id d9443c01a7336-2cfde792b76mr15067005ad.1.1784969700959;
        Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:2ca:ecf6:9105 with SMTP id d9443c01a7336-2cfde792b76mr15066895ad.1.1784969700584;
        Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:59 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:47 -0700
Subject: [PATCH 09/11] Bluetooth: btintel: Simplify
 btintel_classify_pkt_type() by hci_acl_handle()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-9-305aec261a19@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qpzBNNoxRHw-1LDT7gCJoz74k3m1sPqT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX3mcI53UqEUuH
 HZu9JVLt0YJR0rB6qZMh5xuZfAR1/tbjbx3IqySDkl3F64SR0A5SpKymjxLZ7L8VSa8tlquSac1
 1my3lRQ9U8d5P0seH8TGO7JoYwYRsgQ=
X-Proofpoint-GUID: qpzBNNoxRHw-1LDT7gCJoz74k3m1sPqT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXyKi2X2TIfgdQ
 957qhBnBBmINIZEcokngrhNh5KHHg6OUyDAwPmiLBuHFf8oJ5wZrBkVVItH2dhkSyFbgSd7Fccp
 dhN0Z4Ez54mTdyZ/YlHlsy/0rO0pb35wzGQHgfk5QT6or+gjs30vXFcfI16o2xMMJ9mQcMjfz2l
 zA+0f3tEuJ8ZjzfBtt+7MY8IYn5sL7FfoP7I8XcuUnnXDYIwlpm3efg9L/1SP7vNprodxFgX11A
 g+IcBsM75/WAEs9fUUHrLoafgfWHrQA3BrwMErgdKsQIsf1PPxkhTClC88EBa8tSxn0Tsh0itXA
 J8EdJnQqC+R1qisQzV8yb0dI/WQebUJ9YZIEt3z85vyhCGy+HV2xia7b8bScGPvcxnXsVPhouhZ
 RwBngQNRF0sVVeGZUfT8GcW9ql35xa3gR1lP3Xxy0tViCCONwxjYUiwiqHUlKcKv5uTE8o/CiuC
 l5LhN12s+MoWcVzrGlw==
X-Authority-Analysis: v=2.4 cv=F5ZnsKhN c=1 sm=1 tr=0 ts=6a6479e5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=k-9T60deko6e8epjNngA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Simplify btintel_classify_pkt_type() by using hci_acl_handle() instead of:

__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
... hci_handle(handle) ...

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dbcb3f138477..87a6a11e5b59 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2740,19 +2740,17 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 
 static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	/*
 	 * Distinguish ISO data packets form ACL data packets
 	 * based on their connection handle value range.
 	 */
 	if (iso_capable(hdev) && hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
-		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
-
-		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)
+		if (hci_acl_handle(skb) >= BTINTEL_ISODATA_HANDLE_BASE)
 			return HCI_ISODATA_PKT;
 	}
 
 	return hci_skb_pkt_type(skb);
 }
 
 /*
  * UefiCnvCommonDSBR UEFI variable provides information from the OEM platforms

-- 
2.34.1

