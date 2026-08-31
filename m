Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6993282F06
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154794; cv=none; b=ZumgrgBCED/bO6mX3jW0aDLTqV1p0B2e4lyb7m182VRIAS6YDMc+CNblQOQIsvL3i1lPCgMUEICZqCw1oLXHr8hTdRzjQO3/jkarTE2clUGJlGqwTMyeTrSEw91ef60pDdibEciaki2Dd7xnhpxTMo+wIePkd3Da5jYB5BOz+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154794; c=relaxed/simple;
	bh=Je2tIn/gnHb5U7sEOil0/WF0V+o+ap03/OTkCDS2aAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rsyf9sNYrQ6Gh4NKCatKb58oD39D6h3450aIEIPmiOUiSBzLticj30eepQT3BmrTPRUpKb8JjXDddK6TNaM2w7ngFkHXxVVDg133l+UTz3MnIYpgrMHfPZ8Xrbp26y4sRIbIAY0VorjxmBpZOYt+HYZFPXT1hElJLJ4fhwodKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kcr34kA0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQLnLvQV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kcr34kA0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQLnLvQV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52gpm2522571
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Rlhljhadj0jGXuwOy4Kie3
	Gfp9d5nbuIesZjcAGyc7k=; b=Kcr34kA0M9auF5GuZAgeuciiDFs8gO+91HLPs5
	OfQVVfsFgX7qzZ8EDzaO81KwFVVvAKZw68jv/9vdDrXFNGLpwdhoQQoH2iT5DIon
	XPvbwFBpO4LP1cm0aLcHUMS2XeEvlgDB8tdfuoxDFffdKPOMsxrJ99nTMouiEZLx
	RGlikfVI59lLcNRJfCgx6mn5/MeaojldsityBP5Wr4mRJZBm5mdTubtU575KFXoU
	WjpgAT2/nLOcaIqThHvwLQafvFaf371FqFVGYH4/4W5Y8Z6o/mQXgLDnnBLXTceT
	OhMnboatr7D/+SQ2YB6rMNWNfoT7VEQo30w+HQEl89Q3ohyg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w90em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3966d158a76so1041487a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788154791; x=1788759591; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rlhljhadj0jGXuwOy4Kie3Gfp9d5nbuIesZjcAGyc7k=;
        b=KQLnLvQV3OXYzck1XZ44X569Y33blau8UOppPC1kjKhXq+8+o7hDO8ugMxMDdBbcp1
         /rulGBxGx0IvEu6uiilbnspoFiiy9NUlYT5rjVQVFSqdNRyuYbGMzaB98LuppFayiFLi
         1P3GpTPYXGi2zSVsJupSreyigDUuvsnpdhu1fqOexvRxsebPrd44aj4myV6GebU46I6x
         uftqhAPbMt2DFQrTD/EMwxjH651t/mjoXPVWy/jeAmCB4S13/iTqyShY/bDKf6uMfVw2
         LxZe6d24eeUH1K9S3lNnTcuYx9aEeeXtaYvF5mg9Nh2D4tjZoK6mlsft/Kar8U9nfuku
         uSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154791; x=1788759591;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rlhljhadj0jGXuwOy4Kie3Gfp9d5nbuIesZjcAGyc7k=;
        b=ffkEuP+FvRO5yo1W1bKWlRl9NPc4S4lcLFRr1h3lk2rMbgeHvTUNa3Q3vYqc8g1leh
         FyuTOusvPwd4rZku1gt4BuPbaISGoS9HNz9yTgZENUhSVg2gwU82YUJ4oG1k38KLEXOs
         Q+ZLXDV2Fa6VNGgXiATh9GFE5Jd7IEj2cnCxzEHKJsmUyjouguV643pIfQE2hdTSomJn
         sq9GRLDW+DR+i1MfcQmkWBIDq1IOQ6ZsTmhyURZhMdyg6j40bpg9hkxKzDvqgwNFTIB9
         Fif0yUzTo6kStTPMyHHk7exMnFkSxxmiEgIZbT8ZHZoLE7G8swaw4RdHBN5xC3zVcu1P
         CMog==
X-Forwarded-Encrypted: i=1; AKwUvBwY/xSXsi7Cxeas0+y2rTNlbZ8uA8FWtOzdsADAre+to1u+xkseBw8kRqbZN60JwB/0Ok6Rbt7K5kHerxo4Yw0=@vger.kernel.org
X-Gm-Message-State: AFuF++ngEWdleGSHzefbH6YA3rkIBo56HYTbi8m3nLgOWJ5njrxJwiok
	s0IUuijlOwU19PXGg9P41a67Nl7inmkZ0RbpkshAYy2q07uLVxbG03hLwCA+D29i+mNbws5D/Aa
	BFNYbRCEXMTAHK+lpDmRtU3+HC/oJL9F62w3Zlx+2pZEswAqcGMRXPGphiH+RXvT8wpyYXrI=
X-Gm-Gg: AYBFou1A2ZyhN2ARVnPpBh+JCMU6wUnEMasVHnuOOiKvIADsGrKK4pO57SeQ5n4nSck
	YqkZHdmjpIN19tz0tmp+EulVj/WiHh2QXWUE4RST1gT4vg6oGUbF6+6a/H/qtHWaVXOfgWJZjSN
	0HtQgpt8G76FP6U2GvOs5iEMCgxKiSTZnZf4/A+c1DK73IMh7Qfsj2rdBbl2xm3VRpi+s9GBnsd
	YmEILJZGqJT4enY3rfmM4xwX9lF80BBOLuWVpV2LD67wSoo5slbR5anDfyXzyv1z1aF6UoERD8h
	/YjP9C054xpdxjiBXiOQctJW87deg+JW7tsxEl6I1SLovl5D2z8KUDPPCmaJZVXKfw0dOThKeBR
	6iezwn4BXoStxiL/TBOMpDHwTzpjzIZF60gMniJzGs9tBg8M=
X-Received: by 2002:a17:90b:2fcf:b0:395:4df3:8800 with SMTP id 98e67ed59e1d1-398ba71b467mr10285892a91.0.1788154790739;
        Sun, 30 Aug 2026 22:39:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2fcf:b0:395:4df3:8800 with SMTP id 98e67ed59e1d1-398ba71b467mr10285866a91.0.1788154790291;
        Sun, 30 Aug 2026 22:39:50 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm25566085c88.6.2026.08.30.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:39:49 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/3] BlueZ: Support vendor HCI packets
Date: Sun, 30 Aug 2026 22:39:28 -0700
Message-Id: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJATlWoC/22NQQ6CMBREr0L+2pK2BgFXxGNoiKntR74Bqi00G
 sLdLbh1M8lMZt7M4NERejgmMzgM5MkO0chdArpVwx0ZmehBcnnguShZwMFYd201MVEUjc72pcl
 VAXHwdNjQe4Nd4NRNeIb6F/vp9kA9rqC12JIfrftsp0Fs9X/8IBhnppFKZyrjQuSV9T59TarTt
 u/TKFAvy/IFxFIZ+MQAAAA=
X-Change-ID: 20260719-vendor_hci-188fc539d7a8
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9513a7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=yX20uc9k16gVdxbA_YYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX3BoTiBo1yAj0
 WpW1KKgi+Q/kh8vVkyt9POeFVAInG95S/ZsKcLlMxAZQgA9xFkgoUnLPr2LxrDo3vVQlMinBNCm
 vlvQ3TiVthcpDbbOQWQnGSTYcfMXer0=
X-Proofpoint-ORIG-GUID: Zj0bkuL5RIn9gmKF4M6jKmrJSkDQ9U_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX8YCycqOPSrZW
 0KwLt6E7NCCJmYb11bsrNZyL6AURHpK/6ZyEdosXD6ywoNwU91ma+U6aCyPiJ1HSzU34z/2pr2I
 hj8Lkv+t9PV0RQPn1aZEaB2XJSePTVzsFcZHJ5ePSHM72NWZSxYdKsODX3fvQHhgNWU+tsxMRDW
 C+6+x+hDOrDxwOVVSmXFNQLBlLWbxGgnjEhh2gMnjffmXNSz1LNLylLWXOdGi+wTCQ3mbWZDIdG
 xhWfHngRk3IE3OjY49dKabq1Bw8p2FmAE6ZSh1JQZ+5sh7u8atrnfnInhHoToR8c0crtbEUus7/
 +tfFJhbOh8FECAjygQI11w282Imf21lZNuQHsGOnIYWzi0x/jWoss5CBoZ8LsaTwXSQOJW/KxDv
 oIJTYF/N6LMpQ8mxxafSw4DMp7V3kfiWnv5GXycanEynkrXfdFDPCuIq6GqJnZUVxXGGOn1R14+
 eNNwoeTBurJDIYb2DVQ==
X-Proofpoint-GUID: Zj0bkuL5RIn9gmKF4M6jKmrJSkDQ9U_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310046

This series adds userspace support for vendor HCI packets, which use
0xff as their packet type, complementing the kernel change here:

https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com

All commits are straightforward.

---
Changes in v2:
- Rename BT_RCV_VENDOR_PKT to BT_RECV_VENDOR_PKT
- Improve the commit title and message 
- Link to v1: https://patch.msgid.link/20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com

---
Zijun Hu (3):
      doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example
      doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER
      monitor: Support vendor HCI packets

 doc/btsnoop-protocol.rst |  8 ++++++++
 doc/hci-protocol.rst     | 20 +++++++++++++++++++-
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/packet.c         | 26 ++++++++++++++++++++++++++
 monitor/packet.h         |  2 ++
 src/shared/btsnoop.h     |  2 ++
 6 files changed, 80 insertions(+), 1 deletion(-)
---
base-commit: e8141342284be2a52e16565b96b513ebe1297d84
change-id: 20260719-vendor_hci-188fc539d7a8

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

