Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6349690F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921667; cv=none; b=FPvlF+2W/gLhJRIlv38+NLjNs7lveuzUrGFb/bWirA00BxSExHq6iwbvASPxs/M9b2nmV9zFJ3YtHXbXw6tUwf07TByHE3x8MbJ1fDvzdvLrTucGkmsAz7nsdqq31qcfK6Fwo5UC5hzdPdejpQuvDCuzQ26iwRxZQsNoYe843o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921667; c=relaxed/simple;
	bh=NJn2c31lUH7/D4D288VRl32/NWMVhF4Gt9cu63zJMps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmucj8x6fvj5fqdlugewxWDFfAY1LJkp5ocrEccybnOuf8JBZ5pAM7xTtYVVxhfjPV5dD8JLbseU9JQNQB590TNfbj9gFBz5t6ZfqqJVt2bUdeDjvqS2ZdhoZQB6MYDArlpbFeSOniEsI/7cwrewc32VTkfeNhg7QSlYC/dnCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLRgeEjC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=irhSKQkn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLRgeEjC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irhSKQkn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoAT41468610
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h6kqBe/1HqC093rRFcLnOq
	y3nv640MGtvfx3ayZFRYw=; b=eLRgeEjCy31rzy9tZarhmF5RzLaGbFh22koYq8
	lnRDUX7UJO8DMuxeaspcWJObEChEuWWBXlCZmcMHWa3r3L7BnTnVkXbN/+3dcej5
	TOqAFnF5ZayUzTxPDjCspYi1ZFjqCx56CCYyPc4PgZCcwnYhx4VPE7bd8ZmvlV5F
	zX8jYx6CzMWPsLM5JytL7MLbAz0LiIdNcCJ41t3x3d4SU5sNKUe4ISRQuyNjm2o+
	oTgWOf0ItSsdXQeWJClRR+1ANT5kKplRAO48ogqA7kHL8pQqHvclLBjj8V113eJu
	+URP6/d/0sdAvLIq07glcUNxxfYuCzoxayTai3hvkC2AuiBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sn15m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92da6f3cc81so106231785a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921634; x=1783526434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=irhSKQkn44IJTWyqmJMALId/xkaHBZ4FQbwEsa4PptKe+e9ywNmhspmZcI+Om+0EhU
         HrwhGJ52SB0VZW4UgrC+jtziVUrgOae5zLkH9RcATZWAyGnXyB91bjCjApf/KhnGptTG
         Pq6613i0PPkFnUP/OMfQdV60j8qsKYm++ro2pG69phsw+kzKfaS4o3fDTdwGykf8Wpew
         tnXugBjbfJi52Qyp9L4pFTlGQZOtkCiRHzw6p1zUzTDX/KA28MU/ggm4iodh077d5cv2
         n4rmlB4C90QxOt65xB7szpUcPu1mx12a+coEcQstgyuPnc30l5XDymWy70qBi9t9lalK
         fGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921634; x=1783526434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=Hb1PrThI3VXBXJeSc42GViuOvwRUJC92OuRuCYn0gqHTg2X7QKZN9ZIMWrk1ufqKvc
         c/cH2ZdbpA4vKj/nAqL7602avi8YgqgLUzbUEOIXKUTzZKBt9kg9n58CyUtC4Ix1y3Y2
         kFmgioIQ9L5GD9Q5L1i5sqnsj4lkqCNd+OcGzfanDz62jPzaQ0eeWPvGWF30i/ILtZMj
         dkX3mfJHDb3SdhFfPEYVzbfO4BxqNSh/O+36mB0wLMVlU1xFlyaqC84acAAq5uGekqyD
         DYuyjKosHRLCll4eGR4Kp2TVkt4E9AbqBqbdQcN8iFqsI0MCNgOo8GGsmCJFFrZV3eAm
         bnEA==
X-Forwarded-Encrypted: i=1; AFNElJ/XzEiArdIs5yDZbhOSEzdkzalLrQeqHcffHSi5wrbObqZKeQHUV3zbbKs764sHieCaUbVebZVUJhhrlDs8zO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQD3M5NxBMEY6eMhS6RVpwGocYLSlbAnb54ZTU0nWnxcMzyPyC
	zGjTKBvCZ7rCmR9Yu1YiRyTnLsX9Pl2oHTjRuL6wMRiSd2AxP01vNk7fXOl/LmnjOpzPMfYxs5V
	Le1vYYVolkqHabQfvM5m+NRUsFa+TpVzsjUrqCKqeN1SBM0xdjlX0yvc2GzEPYARzCGUvRB0=
X-Gm-Gg: AfdE7cnfXyahvqLtgx/kHV36KZjekFiGMmr1VditnQvyDrVMS76o2TsWT9CIyM57Jgt
	QyIGePEpxHhlMf/weikaiqzAmRLw11ln1rttV4RcpN616Q/m9qkK4vWjis0gvfIVrUTlQmgcpDM
	15s256rR+DvQIafx8NpFd4nAiH0aS8AUkAX5xKOkzCRTbaCUWeEoqQuigsq4felp7G1dTRXUc3P
	9qPVvp3ZrSjRIIak5D530zThznC7kK6sfNg9rzrfKUgXu4fa+xbrzFwemnPZl+Evk5w86A1rRcM
	kgW6YbK8rNUpj+KlfLaPmBPBkIQPbrIQ05X4rbTiSXzfYG6J1dT1Z0NSw6O8iUKnhYUPwjgkh0R
	qqEC8C717GzCRMK2SjwxOo0V3v2VRZwNmUJDnNxsDNd6ncuVY8UZPjsVKXxq+mM/4m4ae+Ka/mq
	H2URkd0eOey9YthUdqGTvC1AfBCgXxEi9OzAo7mzbYoJIZ5swBLrCjIRuk+YhGDqw=
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210575285a.27.1782921632841;
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210536885a.27.1782921630809;
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v7 0/9] Support for block device NVMEM providers
Date: Wed, 01 Jul 2026 18:00:24 +0200
Message-Id: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJg5RWoC/3XQz2rDMAwG8FcpPs9Flv8k6WnvMXawY3k1a5It3
 sJGybtP7aWBzBfBJ9AP8V1FoTlTEafDVcy05JKnkUPzdBD92Y9vJHPkLBDQgcFWhsvUv0tf5Lg
 MNEgTNLTUhug7L/joY6aUf+7gyyvncy5f0/x79xd121apRUmQzkfU1FjVgX+eSjl+fvtLPw3Dk
 Ye4iQs+FAvNTkFWQlINxWiVNlRR9ENxsP9Fs9Kia1Wy4L22FcVslW6nGFaMbRSSC4i9qyh2oyj
 cKZaVzhJw1SmlDiqK2yi4/8WxkgC5k9hH4+I/yrqufw3z5J8RAgAA
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0_h7BZIuMbz1B_M3GR6zSWXOSeF8nlZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX1l84GdtHxI4B
 irG2yJiisKrB9mYKK7YpbUCawEMChH1f1kvpYH1Jn/cXQr0JR7h26lrbSG8cv3s7vMyLpp5N+Ai
 5s8w1p7WkUhqRW0FwOP2K1HdgfDPga4gUo1O4qfdQukvB+vgobvHeSBKGH1F+VAnR8C8hWrSFfH
 A1Wif1nzlBkvRjatH8uROl4XdvVv8L4PSyAWfW3oWGkOV2I6FeL3ffT99lmlJgA86V/BTwZze2U
 1vAmxi1Tzd1xMOwKxSpKyNqepnr/ShMY68qp5rM0fbbS81ToB3/hvpF5V5zErtsNQRYVIfTCst3
 eRmzp14Sp/im4AelOoUOMCbQdEmOHrwNCL0vuZsfSiMp31+t/F4chZ7GG3lWidVRoHaq6gRB9fD
 xggt0gXgjb3ydhnjs/M2o+NnGbbbpecI6Ae1q41+cGVZPEKKWYRHkMxqSPg+KHw2LbvlicNLX54
 FBD9NLr7R8w0fszMRAg==
X-Proofpoint-ORIG-GUID: 0_h7BZIuMbz1B_M3GR6zSWXOSeF8nlZb
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a4539a2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=0GYAYOgpis-UCnD6-MAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX7CaTSdQJ9gyv
 bzY8PnvNIPHIjyRLvESNv4oUBG6HY1/y2Wg+dXFj6r4LFQqwewTBYDzVL5gk7mRBr6UNYVqp3Fq
 IyRh5jwK34H2MBX2tpo1tGXqEOzHXF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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
Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

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

Loic Poulain (8):
      dt-bindings: mmc: Document fixed-layout NVMEM provider support
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      nvmem: layouts: Support fixed-layout as the nvmem device node itself
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 ++++-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 ++++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 109 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/core/of_net.c                                  |  49 ++++++---
 16 files changed, 332 insertions(+), 16 deletions(-)
---
base-commit: c58ba8c7e9ab26b5e8d91f8ca0e0a16c2ae318e9
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

