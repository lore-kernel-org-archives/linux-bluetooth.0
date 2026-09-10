Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4048EC83
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051206; cv=none; b=HMGQFaNguPH69DBVkEebNxYp3opT9YqQxX9Bl/LOuuC/iD6i0lOws8R/nKbdqYIcgF8qBJwkWMO2puja/gDJxx4/pbMO62Bs7urPk08H1/GURtvD6yL7bfiIEAOQ8v2TYfPUGyt/KXiGJ5tKR2XEhHT2vpT38xIVCUY6WZwgjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051206; c=relaxed/simple;
	bh=HOW+Bl2YssPvWFg0IiDPdGdNd9bLdInvIYPJhVjigT4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rOOlTLCUmQ5B0HXcs4bD0XKhS0NrG5QrK7wvWxdUgpqgf1LzZsgNoxbjpvNxfg3k3IfTLiI++L4JxZp2gjwYjyUhNqYFq+SFHTC4cmGPkz3PCLM19cYRDANlknBjitBQZ0HDfyyluiSq5d3SmTDnKsLlGJ12ndIjspnL4tzqaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3nwvo5l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=If2k5WjX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3nwvo5l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="If2k5WjX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC86wI782205
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xWObxD1jMeHBJAyepuPZiT
	v+MCRov09Ka0F1aUtTOEo=; b=Q3nwvo5lQB+I3mBbM70Z7vohkPNqJZa/2ahlU/
	reaU2/855o8bhCkQW++bz/Nh6um/i0OAc9XPKGZue1nWoJ/7BMf0Jx0+0gvr0rsJ
	BmySw45Gm5LVLiWCcEphxxsLv0FkyYV3Wei27vW8aif0Vga/2gnmuEfr9nmceEBR
	wFV1A4GUHpsxsm1aLgAPzD6oejW3Z0K4uCiFvSim4cVCUvl/OBxgTLrdAMBFAoP6
	gYNNsIpMiB65sjkNI6pn6ZomLa2D8eUE4KqXOP//BPaZ+4e7PEH2ePAra3J3exII
	JzSkrtSfTbhOrnBNevfOyCABF24uZ5F6tyvBJXlDiPKuN4rw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrak9spq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:03 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-800d0edbdfeso453561a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789051203; x=1789656003; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xWObxD1jMeHBJAyepuPZiTv+MCRov09Ka0F1aUtTOEo=;
        b=If2k5WjXmzDzjg4UBHIQll7EzJy4KAIQBW9GZiayGgTCfL4dc3flIs3q5nr7cPFIND
         9VQkkOFPocqzxfgiav8rpYUCy6WCHWS9QX7QGoRRrUgQjq05Y6N1p+mZiZzuAxJjKZuw
         e07cYvqRRg2NGnUauBB4cxWsRAlL3WkELUNkVYEfdU0hxT6xmHELkHy/NqT5UrOD19c8
         1izLWsMZ91Cb216pu1Jl0PuJm7leWAg69kXYn0rZFk9jERnIoVZlQddUV96eugm9KgAl
         GfWz2No7/WSgf7rMwRto4Maq5FhBKSpQqjtuikjJIUoK4Zrzt6yKYhpaTbPBGj5HdR/M
         yltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051203; x=1789656003;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xWObxD1jMeHBJAyepuPZiTv+MCRov09Ka0F1aUtTOEo=;
        b=eo8QwjTOD6tt2/Cv7N9mlhENlE5flzz4ATxzRrVaGHum3a+/kNrNkpPSlZLNuIgwh6
         YNibSiIBmr8K7426YprtUD6x0BWFA9Zh3P0sUdl7sDYfiOPQa5qwy6P7yk/wcKOXSMrp
         bVJEHh9SGThcbEXTvH+JV/9BKSdTkCUkxv0pqjrD5T+IA7s7SANZeplba6tk35vSq/A5
         cdI3IQT/9hCdvqDDJrGzDkMfRnSQuamkwMjLC2sf7Gabbwng39/UnxJVwbEAG8/euTkC
         DJ0A61API0PN9P1iPteKYdvqGQHdjvL6D7IDsZF32KkdEwn1dPTXgB+gOVF/yHWMTD3a
         cAow==
X-Forwarded-Encrypted: i=1; AKwUvBx4Pz4eRrT2iPVpAFJHHuxpohyiaZDtm2m5r+7YDxnyslimBiyId6Lrg32YEk50t0s0XMSzWNappin3FWC93sg=@vger.kernel.org
X-Gm-Message-State: AFuF++kHrxsMj0pAEHFYjaXsgX2sg59I0MxpAougVQv+Hb+zIvhWEelG
	F30QrzE6j3LE+PeQ6NjciHHesw+oUmHr6ghvwiaLkcBeDA+GRSM2DvgEbA8o1lwbZnkWJK9yEgZ
	K/TM5lXEK8Gog0fWDncX7v4oRvaGkHeBWK4iIYYaGJkKe8dpKmeTYJVGEhnL6agMfg6NhwA8=
X-Gm-Gg: AYBFou0P3SQHSunR1/bX89LZi5jpbzxVL5ogLum5oUKq50kKtODaZm5E9vPiToDzB35
	VoCiy9SPNfNONV+uf0eK/1F/K8g46LQPqJhUvrbmFdsJmI2qxofvvN9vvb0H2htTB0eozcnTdOg
	65UKBD6cCAiyPoc5AF4KwgomQwchcvxU8Kr5Ea9wiBwcb73RZNf3nfUmePdlKyS/jETCNFJBxzP
	rwaCfrCmI245cyP2AHwOsKmId7Mp5pt8MKCl4dL/DhwqWnG9doNYhkNmYbv7cx4HkGHxUGriYDL
	TX9J8GPljkfdxQuKlbbNMENrJe/bN+GvER/Ki19WqGGAr4Fvh6uops6v/mpvAS/beIp369naIqE
	Ntbd1HK0YrEuRLlOEl67Ddf1eG7yyk62LChLKf+8gUdjgrfc=
X-Received: by 2002:a05:6830:a149:10b0:800:716a:dcbf with SMTP id 46e09a7af769-800716add73mr6074985a34.3.1789051203192;
        Thu, 10 Sep 2026 07:40:03 -0700 (PDT)
X-Received: by 2002:a05:6830:a149:10b0:800:716a:dcbf with SMTP id 46e09a7af769-800716add73mr6074962a34.3.1789051202733;
        Thu, 10 Sep 2026 07:40:02 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa02cddc41sm20740155a34.22.2026.09.10.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:40:02 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 0/3] BlueZ: Support vendor packets
Date: Thu, 10 Sep 2026 07:39:54 -0700
Message-Id: <20260910-vendor_hci-v4-0-b953ce117d12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrBomoC/3XN3wrCIBQG8FcZXufwT87ZVfQYRYSpa8Y2Szcpx
 t49WxcRrJsD3+E7vzOCYLw1AWyyEXgTbbCuS2G9yoCqZXcx0OqUAUGkQBwLGE2nnT/VykJclpV
 iVGguS5AObt5U9jFjB7BrBrMHx886DOerUf0behdrG3rnn/PTiOf6kh8xRFBXRComGcKYb10I+
 X2QjXJtm6cx+5F8hZKiH4EkQQhEeYEE4/L8R6BfIZV/BJoEhJkuiGRcCbwgTNP0AgAz0/BIAQA
 A
X-Change-ID: 20260719-vendor_hci-188fc539d7a8
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfX4/SCPjDcPnO6
 qmcMYH6+gT4l4wtEVlOOoqdBTlPg/yl2Uy58Tm9bpgNqDExmZxqhkJtNtxof8QG3Ed7fU/Np2Fr
 +B4+fQC/4YSVpFT5BgtXeOu9Zp5XoSc=
X-Proofpoint-GUID: l7tVrw0QUvoaMJ4M-1Y5MoVMiseEyHkL
X-Proofpoint-ORIG-GUID: l7tVrw0QUvoaMJ4M-1Y5MoVMiseEyHkL
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa2c143 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=qgPclA31fA7-HnSu8dwA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfX1N9VXbXls//4
 50mgDf8f+ScHal2k6Dn3vm32Nqf426sqLmzEu8qihcKREx8E9WoFvoKr+lQwjv0fFOhV1l7IJOl
 4jZF0svx43nZY2ovGLpPPyWCFjDEWRk8bK5OAYBEcFmtmUCqnAzail0WdYQHUX/bcWnDrIvGW2w
 dsNn0X8hgZZQBpL7VNI70KYpH0jwdTGaK5jKI+mn3ij6RyfDRza2NDVMXKIKewSC9Y/CON9m+Ug
 xp6PhzMrU+hpO/gRX33vcl/BA0dQPSnF9RkiGm/S1y8miPUrCt8EnfjvLtdzOFFqEgTIMdB85wB
 sTl8oo7kAe+scvaNM5QsjNg76glsAG3opUujk4kZm7vmIElPD7gB5B4gmOMrIDVMjwreHf9w8sz
 sel8F2/1XbBU6PVFEKbKpjZ02a+HC/i0c/pxwfG7/KKki/RzErqahBl6sJBAHy19b+Bb5Pb/9vE
 0eK3fv+F1gLJ1S3plVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100177

This series adds userspace support for vendor packets, which use
0xff as their packet type, complementing the kernel change here:

https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com

All commits are straightforward.

---
Changes in v4:
- Drop doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER
- Link to v3: https://patch.msgid.link/20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com

Changes in v3:
- New patch: s/vendor_(evt|event)/\1_vendor/ for monitor
- Improve naming for consistency (no functional change)
- Improve the commit title and message
- Link to v2: https://patch.msgid.link/20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com

Changes in v2:
- Rename BT_RCV_VENDOR_PKT to BT_RECV_VENDOR_PKT
- Improve the commit title and message 
- Link to v1: https://patch.msgid.link/20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com

---
Zijun Hu (3):
      doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example
      monitor: s/vendor_(evt|event)/\1_vendor/
      monitor: Support vendor packets

 doc/btsnoop-protocol.rst |  8 ++++++++
 doc/hci-protocol.rst     |  2 +-
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/broadcom.c       | 10 +++++-----
 monitor/broadcom.h       |  4 ++--
 monitor/intel.c          | 16 ++++++++--------
 monitor/intel.h          |  4 ++--
 monitor/msft.c           |  6 +++---
 monitor/msft.h           |  4 ++--
 monitor/packet.c         | 46 ++++++++++++++++++++++++++++++++++++----------
 monitor/packet.h         |  2 ++
 monitor/vendor.c         |  2 +-
 monitor/vendor.h         |  4 ++--
 src/shared/btsnoop.h     |  2 ++
 14 files changed, 97 insertions(+), 36 deletions(-)
---
base-commit: 19ebd6a2124de54fff5906d84e26cd5370937c54
change-id: 20260719-vendor_hci-188fc539d7a8

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

