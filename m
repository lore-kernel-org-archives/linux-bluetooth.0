Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B33E7BA8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991598; cv=none; b=qwZAYQEj69SjbIzi309GRoRjiGuhoP598bHk8Zd5WP0gsoh3702RC8rR6I+Nzl/eDHXrsRq9iCMpGfe1v3W4PKl5bL9DStYHdWDylbVJBAftA4Tt5HSvLaQxi8HB8ol0KherI/OAywRR74Nw2P6vJJqrrledn6daU9R5zkkoH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991598; c=relaxed/simple;
	bh=53MOC5eqOHfTcv+JZmgCH0zadWL/SAMKYW9OpqKopEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bEl221xaHCs0A16J/H5Gfwy862aozPMJIhMHzMwRbtmrFCjtIILB2ohyIf7pW3VcRXit212dNRP46TRPxh6bmiITj9i80MJ+eABj2mvkIvRxiuY/9KnOIebNZ8cVaVFurgFFoCW+VuKGly7R4xBoscrFq1piMD5XV5UQY8G/M7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WR2QPOXw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baW9WMIH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR2QPOXw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="baW9WMIH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597fOMf1491029
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 07:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bc3f7a+PYfloRmVgEBrBcp
	B0oTfwi5E+mma25qPWbOk=; b=WR2QPOXwAlDHo4kjWwPXq3+xqjQzqWZz/pOcCn
	u1uCdF685AbfbOlFdnPrcH/j6V7rO8USss5dSXfwz89jmNigTZUeMK3NonHngtfK
	G/8yYKsOkYlsr4g3ARnOMmaF5EHU5PzGgc8apKsYdw1r7iq4ZIsWfK54nJGNKH9k
	8vxKIh55tLswEYjd1yGZVHvYGYYJWlji4dYKCdbjd9z8DR8G7Ws0zLD8v4d2/Tnj
	/WxErNGnw/JruqCd1kh1DdW3HZMMiwE5IlWw2ltxTM4Sg+dzaIbRstne4GFjzOAZ
	9owjpFeQyLPNhq/p2duVdx940wVJp6iLnCh6O4NCeXflyThg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr81dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:53:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5176d949c58so134604501cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991594; x=1781596394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc3f7a+PYfloRmVgEBrBcpB0oTfwi5E+mma25qPWbOk=;
        b=baW9WMIHSUnREDgNc+MVXeEfoL40sOQjk4QsFU6UcdoIFjOnz7eAk0eh97KXbnmYnL
         ohvmj7I5427qqJROSPGI+/+Q47djQZeVYHux5Ey7JGY8UN0kgr5DsY3/pYT+YvYTmSNB
         yqgCu+0ocWOO9w6tr0Oz7OdydOdUEhlUig0j0xN5lTsoKBbNR3TXJgpv+2Yv1EJORz9v
         2Ab2+CV8xfvtQa327ZTZKn9J/avfsZD+0Bb2IQIqGfnmVW6SUwTIV8xmzITM8zIhm4o7
         5eQ5fT4h62q5IRlH6hiASLRnjipXlwNrl6fz9T1RP3YjLsVJCHQe2x7XpEvUPsay6gUG
         KNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991594; x=1781596394;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc3f7a+PYfloRmVgEBrBcpB0oTfwi5E+mma25qPWbOk=;
        b=LqU7G9EBZjCguefckLktQ5Il2+PB/zYENObZapfXl1gcPcbm0QcwHuh6uag4GRtSAF
         Tp0E3VMTtEyaixlBuEC5zTp3fx7IxToaG13N/cJCAXTOJftLyiPbQEWV/qogXUCQMyZp
         aopUtbY5JYlMzFVimCLIre/eg41FfJt25EQvCuzbQgIkC5T9/SEvM9MPJq47KDU/Ebji
         jzCu4DweOW+/R51RfCD+2v8ZsET088RS2Lf9jEGI8Ov/TYbHgCmPCtGHsyzfznCdiz4l
         1g0LAtoA7jNuIzz+pnPA1UjZNFQcV2XNpyjFYPEW7EAVgSHDlZ1WoLBJNkvq5kK/YMjb
         rJHw==
X-Forwarded-Encrypted: i=1; AFNElJ8pgXu/RmCp8TMxqW1xhq3AcltG3BvFDHYDT5XVnTWw1fepqKGHnJYhVSDggdD20TjmUuT+0zIy78ADtOBH0eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLziZErdGWw6U+AdawFuIx9ttW3dxMOYEBx7O/wZPO+0SSSBc
	D6v80D3xXs/hAi/6k99ESQWA8svtaBwLhTZPhhsLPKgokOPNqvhvCzJZ+UOIkixR2M4otQm+b2z
	lbxj63/s2OCNAu4Qu6zZFhggo76oeGnxjRNZuVK1w6cXJBCAEfCrpUt0lXrmQaOZXHWP57lukkq
	ClRN0WQg==
X-Gm-Gg: Acq92OERv9htzSmabAUGzjAD2jVHdpw+DKiLao9R4w/DRW7GSXFbQUoOXe0ENoqcVDV
	AJH9N2+aDlE+sHbrkqaubQnXTW2sducX8wRFwLtvg6XEA4IlFTJNZ46+bJvKsNmNTQEVIaA3ZF9
	/f/kNSbAzHZfiiTYP1NyvFpAIB04kF5dQvNrkrOxTBupIjHLJEPul2FP8dE973GOhUNjqai0px5
	fRxRTbYBKkiEWWYLmbY0KZVUUAhJpjdG7XigiLZ0QsUUVBITzTY9O3xzS5doZsi2Zqg1vh06GF0
	7JBcIt63JCmSuryl01N+7cFqsAgi/Ysj7xQg8yG1RtQ3KzU4YLSIHE7mUidkmJO+bi5b2sV6vy/
	Rnd3Tk7BWZ+vPqSlIdDtOAONI+BPFiWtutGX7O7Jm19n3aruZK0KKcC0aUATlQgqrC06Abx1501
	fsx9oR2q0TDMLGYyiayrClYq/vZpe4J1voHu+V8j9vzpNnwkJ8aOmemV00dXsX9D99OWA40u/QY
	Lc9Jhvmxr2s
X-Received: by 2002:a05:622a:120b:b0:516:d73d:2a34 with SMTP id d75a77b69052e-517959d300emr266975581cf.5.1780991593753;
        Tue, 09 Jun 2026 00:53:13 -0700 (PDT)
X-Received: by 2002:a05:622a:120b:b0:516:d73d:2a34 with SMTP id d75a77b69052e-517959d300emr266975221cf.5.1780991593301;
        Tue, 09 Jun 2026 00:53:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v4 0/8] Support for block device NVMEM providers
Date: Tue, 09 Jun 2026 09:52:25 +0200
Message-Id: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnGJ2oC/3XOSw6CMBCA4auYri3pg0Jx5T2Mi4EO0ghUqTYaw
 t0tbFggm0n+SebLjMTjYNGT02EkAwbrretjpMcDqRrob0itiU0EExlLhaZl66o7BU/70GFH01I
 yjbo0UACJR48Ba/tZwMs1dmP9yw3fxQ983u5SgVNGMzBCYq54weDsvE+eb2gr13VJHGQWg1gVx
 fKNIqJS1jxHYxSXKe4oclUytv1FRkWLTPNaMQCp/ijTNP0AkmAc1D8BAAA=
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: jxg2feafRBpG1G07Mi5Smv-DzV6IUAcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX+rymXtqtZZ+k
 2sPA7JkaXmFpk8E0k0jbV1KrbJw8D8KKuKBdoW/g4XPPVdAnPvBznY13VqHjR2+zNkiCkuXARWv
 QSPzvxN5GGn3Jv2q1rzUo6vqNRk6EmyKMQDAzS3MDjYq+mNgFVG9z53wVouy7H3hQsWXTcQPzhe
 +v2UkET9keJSUcHY5pZKKfoaqPLLVErDDxpe8t2xG5XLVMdQdcA9MoEurBtQk+ThYBtFPUhw9IZ
 PpL6j2SXd5okGvV5XL0xrutHvrSHypznEPnJIMMIJ0aZ4JHrE3Z5xV6WYFk2fMuapZ41pxQLtCC
 qLBg0QQUrLEJSlITB0vD9UhDgAX+D0S9v8kaw7SXes6xU+ot0ESfOWxlM3BANFXU0dockQcx7m9
 pSr9OMC6IcZVjZ7mU/H4JEzZAha3uao7SO12QUel4ZBM2JR1WRx0eld9+zXSc0GrkT8K+oI2uhp
 tSOnhc9gs2iO4As0SLg==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27c66a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=4dfaE-bLb2wR0_rHmkcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: jxg2feafRBpG1G07Mi5Smv-DzV6IUAcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (7):
      dt-bindings: mmc: Document support for nvmem-layout
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  29 ++++++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  39 +++++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 114 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |   5 +-
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  39 ++++++-
 net/core/of_net.c                                  |  49 ++++++---
 12 files changed, 321 insertions(+), 14 deletions(-)
---
base-commit: 47c4835fc0fed583d01d90387b67633950eba2b2
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

