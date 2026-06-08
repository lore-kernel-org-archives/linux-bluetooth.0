Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481483876C1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901970; cv=none; b=rq8vR6Ty1b7RJTdubGAfhpWUIAqp0DOyfv/3FEg/0gxt+IM8PG7rfOaCWcIUGWavreXpDq3xlyUYhkbGSLjcwgNRAych4zinOxxGOIwTrWsqJozRvHbOikc8x4vYIxxKcHHKAEOG6T4uBDqWUL1bEUT5ipkGOfoSvnPTBVGkp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901970; c=relaxed/simple;
	bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=djW9HjJ4502g6BeFpCJf+oNtkWjydPKkT6S0CM4Pdq3vBFIdybHUKjLRG4lZXupDvafGe8Uynt12N7jJS3v61oA0SQOGVEFOWhk242H2z4Jv28vKXQoV7GuiyUMIrYSluwKglAhBuwjG714QpOLSuHHbK5ADDiCxG5OufsytQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pd7Z+oYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrl0+v9x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pd7Z+oYL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hrl0+v9x"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PUda2808239
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 06:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DoLbGeNFDGlHR+89QHRczU
	z9SK+zm6OjHb7++b63eUk=; b=Pd7Z+oYLLpo92FhhBgXxctOptCvzfHaK0jKa46
	z6i9ZA+O5LRmjVc+ab0pJYbzXpfeLXJS6p3WLmwOD8fx89qT6TaMtMCyb4e0jvt0
	OquOQG72MPLa3Jm2VhlUx/6R5Vq05nifGYP636KhjWDZMvv8kZCo8sbNJcA7e4KP
	uJuWwbNj+emnIwr7UmHWAqfU8GFLfkhLG0giwcvSA9rJYFukBGdvF6WMquUX/uAV
	C2mOd2utnUs0Ads10bV8h+o1sMAOQDG4XsgzTgCLF8i8Po5kMIL6F/TyQ+n011SG
	IR+g/PFb0F9zlBCqkbeFkkVg78CEMcdPKnhcYoTQ/V8mxkvg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6e58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:59:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59eba8fe530so6493896e0c.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901966; x=1781506766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=Hrl0+v9xAUcy0CULmPh4KiUmxLCYuXPh4mDAo15rThCe/2bup7Lpz6EBYsRBcb3RjT
         x9mglnB5O5Re/1Em1XRJw+qvEtR2gJ9p3orqYrpflZ5H0wM/087hL9tyO4GMcx9EMxFo
         aqIXD7y4Zb7Z9LMTRhCcRcHBMjjO4g2HshV/BtSmDXlXplNoUjxtjMd7+9Olc1IpqtOB
         zVWbfXKK9DCNhmFj42Ih0gWLY4lj/81Qhc/YRvsl3qCW4GGIAKwhS+CDXTW/xA/ERXQ8
         TpBU2hZ2cN+aYq52u/bwgBIOMe7HZ978/TwXYRRY02mO1D1p/33wHfluhR5jAnY0lvm6
         cqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901966; x=1781506766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=mUtOnl/ND2PWQEH4dQlwZcDrnJ6+JCEOVbHgm9icpoZUs+VsfGHCI5ZPRDAv4/ypDy
         XSznTVqpDtJGNvx1YvH1LAfbrpYi2QcVxzo6RrcwWZ4hTiRk3sWthHgt9RLyotxAIUbt
         gRgab/0HIQwXGOA1jF6EO2Zvkz1yoPpVE1iHnPcK2WpKnY8PnV3uQ+IGWGutsVI4DGyk
         /IyWMWAq+3d8w21nAv0CtDnyZJDCh+0Y9ne2Ai9tgPrxj8+hMJKlqDgLdzctPaFrBDr+
         LqIDC9TClm3UlAePmEtRofNUXhup5Br/H0i1jO2k/cj19vREds53k5n2ScOC39ZI5/3i
         jnlg==
X-Forwarded-Encrypted: i=1; AFNElJ9JWlHeIBMHuTHXV2F2EkljLUho25ISGSy3vv5oe6qis6kICoLnaSo5s9/ztdnNSoj24oe2QEer388DKdJzbV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPx1xSc1ZToDRnHSzSwABfI6sWGMR+d/PtlR81723OUCVTAVs
	V8KwUlBCe8FmZiiu1Skj7HQpPHEdQTQiPI5dTAv95Rc3OQ7PblM9EpGPqMViQPKVmKoanEF8+yT
	xDteOU+itO7TY0PAxvxMoeq5GiY7hKi/y3/S1QStL3FZi/8cp/YZL/uxsPBK9sSP6cyLc0lc=
X-Gm-Gg: Acq92OF5bxCXCH/VFzvaI3mu4OLajfCBpAtTs8x4D8ut4rxlUSpfD3qTOs6VODx6Cgo
	uWE4Vh/rkU+A3MkDNo0NIGlHvuB30IFj4L31FEoYLn+oFklTZbFSz1D/UyaGoQ3ZzL+QRVlcxbH
	Ryl/3+FDprTfjn8bXVQn51TtCLsY7L88z90kzGIvY+W6lB6pjI0MoLD6rQnnPu0jhRQCDmUF3Kr
	do0UT7Oi8px+vKpRe5h0yfOJPzJ1MM0CqLdJl5EEOwUQ9THJecMFVm3UJFX7FvucsIB9JpZn4Fd
	uiAgy0CbCcrROm/krEZBzjXsx2yzqOuxgtp3QmNwmFPI2oV714Iwfb1ckuGVVnlzM4Z3rYxc2Y1
	GgS1DxTU7EYYeBOnfZ87rhjJmBLGiwEoGfshbUItGJ4v66P/w6fTv6vTSG9B0o7LHdCuzDLQVGJ
	N3y6KYHky75GsxZcy5YRJUkAMZAlfV1Y7MHdclKBfJeHHqdA==
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670981137.9.1780901966545;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670963137.9.1780901966202;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Date: Mon, 08 Jun 2026 09:59:18 +0300
Message-Id: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZoJmoC/1WNyw6CMBREf4XctSV9CBZX/odhAaXINUK1F1BD+
 u8WWLmZ5CQzZxYg69ESnJMFvJ2R0A0R5CEB01XDzTJsIoPkMueZEox6rTLO3tgiUzXPs6I2Qqs
 K4uLpbYufzXYtd6apvlszroq10SGNzn+3u1msvd2c83/zLBhn8igLcWq05kpcHFH6mqqHcX2fx
 oAyhPADyvkjMb8AAAA=
X-Change-ID: 20260531-sm8350-wifi-3b0659bc183a
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhJ62EPLw2wHCOzmMHkygIyfRi3VNIwoeZ7n
 XMzCJgYxB2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSQAKCRCLPIo+Aiko
 1aWWB/9q9FMl9zHtWaCN27mxlfW4OEuabIPIMZoM2/kXkQzi9TkoXEnIPjkwhXeEMPLRuJ89Vte
 lWl6jykC6bN6e0GDhye7fIZdmt8GIekDsZ/OzX5BxqoSsBgVSRlmlhP6rV6StRnkRhPb3peMVzn
 I9ErCOQyoxPtixjB4mVZAGqs8O/rTE2LAtdLQR2BhOpNnDxLL/S4al+KhAKzpoeLZxU0TteasLW
 gOVd2QDSqGUYmo6xTb5jbHNBMpvyVQKGlMnR6wjwHg5U5ra0vE54cneYutMDigJNxVR/xPlJeg9
 GA4vhuuZTwRz1aJNPRfnxuwDXYtGRAu0BNZP52BVtTj2KOof
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: BdvjbFUMW8qDsUYFRBY2q6Y_tu7lx8NK
X-Proofpoint-GUID: BdvjbFUMW8qDsUYFRBY2q6Y_tu7lx8NK
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a26684f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=6KS0kTMdj-vf8_meW0gA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXw8DhWJbTERk+
 gLt37XeJIdmBOczLZOzvNnYwvH+rYcJokEowOOSwGC6yzPuxTPYVeI0F2v/7SYtiX4Fe2Dq5+a6
 /P96N/GbKWMG633MAKlQbIMGq1/r/R1ccPVlh8wZGNZt41AOOphclqUliYS+QVcMOzp/qoz6xFX
 H2FlnKcPb2ChPy7eqRaYEozlqbiZLubecVcZTKJorLa2Yq8qq3Oaf85frKGYq6Sw/6xPSJvyJvO
 XRgwC33PmK/gkMSzosxdC6n3/2kWnKkjdFU6fvEJPz4heKL6NvN53+z2TeWmFqADAF/y7o458aT
 mej9AOEImHAoPNVpGh088+JxmdWPdx2ZDWRJ2zMwL1NoOSMZlZ8+lBtx5+5mqigbn7uZ1o9Yfew
 AWZwZr2W4EF7sblDcby4PKACdXWqSXc8CxgOlnOvZbkroyS+yTv9QZp9eBaQp0bkNNSFP9mW29H
 th7+jJ9TckYP/rY13WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
time was not supported. Bring up different pieces required to enable
this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Bumped num_vdevs to 4 to follow other similar devices (Jeff)
- Link to v1: https://patch.msgid.link/20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com

---
Dmitry Baryshkov (7):
      PCI: qcom: fix parsing of PERST# in the legacy case
      wifi: ath11k: enable support for WCN6851
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
      dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
      arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
      arm64: dts: qcom: sm8350: modernize PCIe entries
      arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |   8 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 142 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  14 +-
 drivers/net/wireless/ath/ath11k/core.c             |  92 +++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   9 ++
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |  25 ++--
 10 files changed, 275 insertions(+), 32 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260531-sm8350-wifi-3b0659bc183a

Best regards,
--  
With best wishes
Dmitry

