Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5F2EEE80
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652332; cv=none; b=kImLagjKgwtFxMw5ocMPk6Zwd6ShlIcFpMmMMxXwcLo2sucXRejYcm3yGgmCGgrmyAE3YrYBxiJaJz5ioWaeWccyYny0mqFlGKIpcQdrepzdkeSzcmsuSJCeoRN1AQPzX94m+jDavG3Nad7bwXWhp7Ph50fzfSwtOqWEjBETLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652332; c=relaxed/simple;
	bh=U+YLom3K9hCI3E9+sFHDKiYNaT8iae2wgJ/r3dITca4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AM4wACz8ZpX6GyifvVnlMGL5Msxel2dWg5SSA1a5Y43op5lL+NLzQIilmS/B0IZXtAk9PGVIR3HSBrid5j0ZMhPG5x1TTA36lq2Nus313g0Z1ZgQ8HZMHcmehzKcTj3BLdW6XW+Uj25tgTJm5Ap41E1PCJBnaxI24rZfFmCEMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqIU4yy6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kh1uguU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqIU4yy6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kh1uguU7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724ag5l691408
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzjwE2JNUjZJG7GNM9lIOzvEvbIfawSlgTzlRj2Bsco=; b=eqIU4yy6V61bTyag
	XwzNMgpzgJyvjc+Aoy56vO3mJzQPP0HVB7U8u/q+BBu2G64IxaKif4tIKmKsTeAl
	RxmzRtYwLe2WmEz1+rJ+4yBB6KeF9zsWbVb7bIDSXbpdGHrPHLcvIoczc1J9Nfoc
	kkOGTNBSP6RFm7OZJn0uTY2OZI8IC1cQ8B4cKW6MhPSSFh9WM4eRGt7fl6WWO/A6
	OTbx3LsBmV8wfBAGF22eZmcaIq5pm7CVEg0om9+9K9I2aqR7bnng6NkqbVjF1jRr
	b9t7HrQzNN1njsGhgVgYZEdZz4WoIc54Vy7WEW0mPptVsnC+AJ8ro2cmMdVQ2DtE
	nCcHOA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6jdfa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:32:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca0ed258cso7245105ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652321; x=1786257121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzjwE2JNUjZJG7GNM9lIOzvEvbIfawSlgTzlRj2Bsco=;
        b=Kh1uguU7haXneDHAEyYpUnbfdJ+RGnl4QHUrp2U/7TTHHm+huBNidY77oUX9exGCtp
         0PZ2v3RHasn9X2P4mIvhXlxXy0PinCcm3x9aR/vAD0WNjQF96RZXtYhhRbJ420F7Aqcs
         8tlwKuvv6+1rxWvibLVoro9Dgp+Kx3lP4X7rCDAz8zdhK/O3J+PmkoFIWb9IWrow2uHy
         AHGOI8Y2swQ9bAJNjeZfr5RKSatv59JU6r20hKbtTrsFOe6/Uk2xYJCmLliZO+OsFnio
         24TDl+jq393InLQsnVelQyEmxp6kxEjIPuRS5iuQCcfjwszyCuMeTwbO1slPT0I9mf1E
         l3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652321; x=1786257121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzjwE2JNUjZJG7GNM9lIOzvEvbIfawSlgTzlRj2Bsco=;
        b=V8qx5hBNxfhYwWuEn1SgQXhSUeiHvfeN6BZLvWTPDE46f7CSrtU1Av50RwVqjn3wM0
         yNdsM/xG6KnUpO85aB3VDqYUZNkOhKERVQRH0+agQ0Jh3yH365Bba6orKpCvo0XfiCB5
         wop4Csdym5hHH2yn5kBHWXxFHINILr3HE7ECenZz05gdoMotjX9LtatRIlar5/AMTNDw
         x1povQTe3bvy4il/hcUtBmaxHHKTLnYEMDW+kxjKASkjgwBlv0+MOy474fTYXO5exgDX
         V9knm+b6QfyOmoTFTSil0uxsH344ftKzluH6kLhH0rGw2V+RfugxNLO2h92wxJHmgvGX
         tKfA==
X-Forwarded-Encrypted: i=1; AHgh+RpaKn8UjnLTPPpPZG7MoIO81qzA8rAJtl4fSp2Qo3xiFcARpZUsxr9EN6yEPuFDlr7QBUf+oF4+9Ez0iBBJcZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKOOkoPjzrTsiRk6+YirUNYh5/PYIcuZ1pJ5LOSCStIl/cbEl
	ax9U1+ADTtPZ4YQsauC3ICcIYyFOyjibJsyW25PnwJLNxGVr4yNZZWIjSyGygH6USJG3Hvz6jNw
	3KZ1WXlxO+ms6RFMo9VrfMKhGHSZYsDAErZrLn7ZbiShwmo0E9sOh7FySJLsZgZFAahaIeZA=
X-Gm-Gg: AR+sD11xXkKi/rztaeoZFBmqWYjPr8Os+oLuAj3bNKtuENlOqe5/OUZfTjmjASKNSZl
	7Yv1jX2ZxQ6cih56GsPwAonCAEIg8nhE45+zi0yb+86otnFk3ItjbE0PvfypekgkK8YrQbYHlwB
	2RTeRI5xm/XlvkNOFlQIOEgYvNY8OMbaQbQgizqXGM6XyL/6JSgZGxcAQmq7XywFLXrrVPBnM6/
	X26NHRPZMHcseyGhdUPfbmNFWvc1pgc4gBpg2vCXsmHVxkENwTd0VKu7BGLn7P4IqPNiGt+elCl
	32TmaoCnFhU3Pw6+/1wfZESLFbKLyqYXD9cWCCczw4YrzIz5yUdmPDm+mFddWlQZ4i6Erd7F9Yg
	tZlwN5rnCgjt9xzPlzu4vBJ1D8XZRauMWfMdYeY0djVtIm2k=
X-Received: by 2002:a17:903:2443:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d0524799d8mr76560165ad.4.1785652321466;
        Sat, 01 Aug 2026 23:32:01 -0700 (PDT)
X-Received: by 2002:a17:903:2443:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d0524799d8mr76559865ad.4.1785652321023;
        Sat, 01 Aug 2026 23:32:01 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:32:00 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:39 -0700
Subject: [PATCH v3 4/7] Bluetooth: hci_core: Introduce __hci_reset_dev()
 with a hardware error code
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-4-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX3QX2b1UHuAB0
 13SHD9u3+0DQu26syKjqpmxy/Byy0m4889rAaXU9N1JBzhhsW7iNf/mNtRzZJYDw/WW7wqGwYxd
 Vx955dtLWLAiG23Tf8mtd71ztO7JDjM=
X-Proofpoint-GUID: 10q1dSUpM4qmifPQU9wKpm9remHClqHr
X-Proofpoint-ORIG-GUID: 10q1dSUpM4qmifPQU9wKpm9remHClqHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX0YR+DM1A9ybp
 2AzOgS3akCDLfVbfnlnup8jART0Au64ikbjpXh4BFYwFO1q6/NZTptjGmLfyfQoCpFrGXxdmLEA
 X7FsoF4tUQI7h+Tl7posmkxjLu7gDm6nrNKToGxi9/3veWBIX7IpENkamIaP6k0YXWYHQoSfRhM
 x/gYGFyaRVnyEUsZcdhmHJgUUDLHHChc4ePL3cDIwjDig8cIZxjQASmQRQ+ff9+FVWoL+Oj3Pc+
 9FcLFvEl3AYE/oj1y3BROJp/We+6pmE5ekGyt3LgG1fd8tifUmPE2GL8Yqhp3Uu+fJw26lW0swJ
 VbYtdD1yORsenKNLsry34rJCNdLkJkiWXURigB1LLZ2LJDLh9a4NA9mfnqUuzADPx3aXEFhcCuX
 EGG4Yyb5wDa/+Z0yMrxzVRJR8jZpZdzKYYc2Ru3Siq6wnQdoRlGqRx4ouH1QDjbLiTAcF+dxbqy
 UjdhLznsErKwTeb2GPw==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6ee462 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kDlZC9PIADDXUGC2KDAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020050

hci_reset_dev() injects a constant hardware error code 0x00 to restart
the device. But a transport driver may need a different error code.

Fix by introducing __hci_reset_dev(hdev, hw_err_code), which will be
used by a follow-up patch.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci_core.h | 8 +++++++-
 net/bluetooth/hci_core.c         | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01b938c4b24a..b7e71733f360 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1780,17 +1780,23 @@ static inline struct hci_dev *hci_alloc_dev(void)
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
 void hci_release_dev(struct hci_dev *hdev);
 int hci_register_suspend_notifier(struct hci_dev *hdev);
 int hci_unregister_suspend_notifier(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
-int hci_reset_dev(struct hci_dev *hdev);
+int __hci_reset_dev(struct hci_dev *hdev, u8 hw_err_code);
+
+static inline int hci_reset_dev(struct hci_dev *hdev)
+{
+	return __hci_reset_dev(hdev, 0);
+}
+
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
 __printf(2, 3) void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
 
 static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 {
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d5adf882509..509c820a693d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2847,34 +2847,34 @@ int hci_resume_dev(struct hci_dev *hdev)
 		      hdev->wake_addr_type);
 
 	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
 	return ret;
 }
 EXPORT_SYMBOL(hci_resume_dev);
 
 /* Reset HCI device */
-int hci_reset_dev(struct hci_dev *hdev)
+int __hci_reset_dev(struct hci_dev *hdev, u8 hw_err_code)
 {
-	static const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
+	const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, hw_err_code };
 	struct sk_buff *skb;
 
 	skb = bt_skb_alloc(3, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
 	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 	skb_put_data(skb, hw_err, 3);
 
 	bt_dev_err(hdev, "Injecting HCI hardware error event");
 
 	/* Send Hardware Error to upper stack */
 	return hci_recv_frame(hdev, skb);
 }
-EXPORT_SYMBOL(hci_reset_dev);
+EXPORT_SYMBOL(__hci_reset_dev);
 
 static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	if (hdev->classify_pkt_type)
 		return hdev->classify_pkt_type(hdev, skb);
 
 	return hci_skb_pkt_type(skb);
 }

-- 
2.34.1

