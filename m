Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688932;
	b=DF3lxb6TKCriuuT5NJXrJTQANxq4k8DJuFWPYM+OVm/aJS4LNNzQPzGs75PQaxSGgBys
	 jfeLg6BmwIeON7HYSIKZsR7BGneN5ekkE8924RR+YP3y4xoYkCzkwOTPknWef7qWwN4BQ
	 XF339a2RaA08E5lxAApKCyKWmUI2Z15T7UEGuOPMSKgHfUoSCHvr168yPMa1+/dDK4Ifx
	 xQ3UseHltW9njNwkHSFQsiqRh2b7y8Yqvqi4wGkqgSZhFKve+6rKKzkbk57H7uasRKj4R
	 J20zl4xbcEf8QbEKFeSrUFVQtk+JrpJlbBK3IqJU8KYtnADwaU2Z/ozylJBbVidTDiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688932;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=u3h1/X3+r8JGIu4ype+pHKZpociXhTpLMqQc+auwIMs=;
	b=feMD5dwqRZRPWMf7lVWJu/OeAz0g2lx5AiitbtvRhf/NWEnIN8wt/PXSdqQ2UbeYzJSw
	 bmPY4kmAiFR+ED73i2IpvKBhk+AujlCQCXdcQzWfR7T/4qNXB+NJe4myW5HzsTa6trFDk
	 6VB+y5mdsb/TBlPs9HoyKvIBueYlC2Tern/AYZS9OUUf7au/Jmae/+po95msRtquubFvx
	 V4WiDZXl/TUFFmzTSXLyGSqOQ3bh3BIX1ARJ9R1hnB6YFyNuUDWu1DV/UzB47TPXADa9A
	 VaZEJjR75pho43teFo5V84QdUiYN9Ylpp+LT55XTXfyzg+wdIBtufv1wP5lThWXbUNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cNqnkf3s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7oMpQxo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1153606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 06:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1153606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cNqnkf3s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7oMpQxo
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eo2b4002807
	for <linux-bluetooth@vger.kernel.org>; Tue, 3 Nov 2026 06:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u3h1/X3+r8JGIu4ype+pHK
	ZpociXhTpLMqQc+auwIMs=; b=cNqnkf3saiq9E+SxtnmOxnu7Vj+sf+oeug6lg2
	7Kg1diOPs1x4DvAhFRS7dTTKoCRnQFQkvtUaS7kKVOwjBXOu+v3T03KzbjyrAvOA
	gvnD4qJxLKxds6sOZVNXDLZmJd7PcE/ZVXDAIzIHNLL5zOOUjRBDDErDKPrrx5bT
	y9P9nhzZUtonEi2ybWTz/S0hrGT/ulhwXFXPvWkdK+S6+6n0w3WznJvJg3Yq7Q5V
	Ibmn4I/eNETAbmtZJebvb4fWThVIq802STpR5bPnZU8AEYV3Gk6k1bRhndjiQm3/
	yEA8YZKEYaOYM9Pk/hbK8lC2NYtUblLq/UfN6aoNXDTdrQKg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07ejcns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 06:55:30 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-540e2737afaso1273044b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793688930; x=1794293730; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3h1/X3+r8JGIu4ype+pHKZpociXhTpLMqQc+auwIMs=;
        b=f7oMpQxoDoTnc1yQzIiNfLG089InWguVfl+vZUJg0V25Zr7z+li1DGaUEIfnXnRlob
         A7Ywdj0+Px2zAyfgCTka/96WSl1WGZXiP0bfviP5VR3x6w7z7/7Py/jDerh8PGtr0xJX
         gHvMwHUT5V9KT+Va69vWeh+4aGdhnvH+TiA3c9DXLFmgR8d9cVGSYyCgCsAR6ZMyxVlu
         DQSWzmDALqOmEr6PNRDCDzWSwumA6rTUUjYFw+9ZfYsHJv/J4tifYralJZQuEq6C9DX8
         yOUdhKW3qCdhK5GA6vAOPwDKhnER9OnmSJ/AcOTyeN6yhvPsFPaDhhPjZwHAmkAsHobe
         8woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793688930; x=1794293730;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u3h1/X3+r8JGIu4ype+pHKZpociXhTpLMqQc+auwIMs=;
        b=I0Nna6vaclCG3pt6yjsfeXs+spjN7MtulRxgiP/q6PIEH2HLfe15x6JV8MzU0+5YAZ
         QMue75B7kwCadFJXqJt1WYlzpFHIhmmlqqc3alkgFVztQ6V57w/6GHaJ3biqfWV3ypu2
         G8bVBX3+WDtTxtUdeCqy3UvYBbbGQgguPqKadDqx2nfNm1FcTKK1O+76qGQ4k3i17e2H
         dk6LR3HXVvSq5hSHyacgMy8yhxNtiuLhweCgI7XlDyitTMsKD8onPg3ALV/4U9nb0QpJ
         13dRwNek6ugPcsdaT9P82E0ngz/0u2xzen/RTloIEKcG6ToEaoHlrJ0F4K2JOTKp/fcZ
         y5vA==
X-Forwarded-Encrypted: i=1; AKwUvBx4mKpYNGK0hHqvch1p7ME5BatnePWAnO9e/K5bALrJbDsyNKWcsUqa2PqgE5nhrIoXuLGS5hlUiwSReaU6tuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuFHG8um76ppFwgKKfZO8NV70Iv7T9ifAlRShSNK6t6L4ywhtd
	FTe6abLiILHBteVcTjXDfVYos0sE9IwaOYnb+n6vLg/V0tGbKLN/pBMrrmABUpftek7TcwK/Bs5
	lwXDYhR7+trlsTBM5xzB+il9Uc4+OXebRC8c2y7MXmtYrQR2McZ/bEBrG96skeMd/sKw/GGI=
X-Gm-Gg: AYBFou03vRVN2+vxSJQyBO7PWf76y44LHwmMuPOywkC29U/jB5Sxczpnr7KwvdY28HT
	m0jX4EpmeXk0dL/Nc0KBboQRn2mNXUwWa+GdepMbzcv7dFO86dGC2Du2gw66uEnBYWkY3G4Olos
	5THTO0Qhv5omN+UozXw9njns7m7eE67mKG6w6PeFEevNrj3TU5Ig8SICEGFox/aqAr+y4UiAq2C
	YvCeEOBPFa5zGwrFWPFVxKdKkjWAh5edlETdq9h448p4A5+C8LfFHR6c9zB/D4XSd0RTMtqZ0tf
	Km1KE/RDW7Ckq9ssKH/IuLrLBLbz75xJg3nXQLLrx7SsPCRWOZLggG9K66oQiLnx2dVXG/cG9um
	2ZFaGeJBIMLyx/l34OJE891uyr6fxzTYL/DQx6wAUVj/FedBTuoT4JCYJ5ASA46fsi08W/LK6Gl
	qO/pkGRBdpxLzhjO5INc0=
X-Received: by 2002:a05:6808:308d:b0:4c0:c8ee:adb0 with SMTP id 5614622812f47-5640d654132mr14322797b6e.0.1793688929958;
        Mon, 02 Nov 2026 22:55:29 -0800 (PST)
X-Received: by 2002:a05:6808:308d:b0:4c0:c8ee:adb0 with SMTP id 5614622812f47-5640d654132mr14322789b6e.0.1793688929539;
        Mon, 02 Nov 2026 22:55:29 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe423fasm10305974b6e.16.2026.11.02.22.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:55:28 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Bluetooth: Fix Transport_Unit_Size and remove
 redundant NVMEM dependency
Date: Mon, 02 Nov 2026 22:55:19 -0800
Message-Id: <20261102-fix_kconf-v2-0-b4bd28de37b5@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFeF6WoC/22NQQ6CMBBFr0JmbQmtBAZX3MMQA2WQqlDtANGQ3
 t2CWzeTvPyXNyswOUMMp2gFR4thY8cA6hCB7uvxSsK0gUElKpOJQtGZ9+Wu7diJtEXCPMWmKTo
 I/tNRGPfWufoxz82N9LQFNqM3PFn32Z8tcvP+dRcppMhUmiMWSh4zLC1z/Jrrh7bDEIcDlff+C
 wr5DiS7AAAA
X-Change-ID: 20261028-fix_kconf-4d8e8748bb9f
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        Kiran K <kiran.k@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfXxjZufBj2P78x
 f37ghGcWwRpcdDKx8DPse3yn0XR6DWt/yDc6l2REih+vqeFFTtOHvGc4bKNDKmwINE4JeNw43eh
 Iu6SZ8cUtVckUc1F7pP3qkBItL5+xWM+ktFYPOAGEHL6gzLjlYpje1shKwg/F2nqXRuldMak4Hq
 pAimqdqa1mD6mhSTQOGCAe/Emeouiy3uoUiagmCYSgyTiEspHrb0xLq/U6C25/3ewHtnvLDXzpr
 Mz1oDpANbMxMC+79JVynj1bf9ii38ODPiL8aI49XQwQmdSTjfT6FeKaRdQtTjrfzMWEW5eA/yEn
 ud7w8Ue5BJ75j/K0690gOcaHDTAgreROZ4Wlwtd9Pd6mmlLxPQ77WtM95Vb6CvZUrBavrrDxuxg
 5QipGZ2B5zBRTeiv9unGjrBmI+ahDpKd3U51vXZqybboxrM4jRNhTTlUI0Bokh6OjKC6MVKPXDS
 tGDZc0D5deWTJiAxcsg==
X-Proofpoint-ORIG-GUID: w8QRq5fPefEmWFikl-v_GJm9DZjsMSmr
X-Proofpoint-GUID: w8QRq5fPefEmWFikl-v_GJm9DZjsMSmr
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae98562 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1nq5aM8V5XYSDQTivPwA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfX3k1vexbgGomo
 AZkkGsPDEeKSOiAsvXeHIv5jElfnQAiJamC/s8XEqhgX44m2DJ5tPqG78aaSAQpYb0ChDJL6mAn
 Lji7LOMxJMYIrmYJZw5tQUiewrAUqeQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030027

This series contains a very simple bug fix and a trivial cleanup.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Add patch 1 to fix Transport_Unit_Size for HCI data path
- Patch 2: Reword commit message
- Link to v1: https://patch.msgid.link/20261028-fix_kconf-v1-1-624788921368@oss.qualcomm.com

---
Zijun Hu (2):
      Bluetooth: hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path
      Bluetooth: hci_uart: Remove redundant NVMEM dependency

 drivers/bluetooth/Kconfig |  1 -
 net/bluetooth/hci_conn.c  | 18 ++++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)
---
base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
change-id: 20261028-fix_kconf-4d8e8748bb9f

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

