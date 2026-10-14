Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB5513544
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982991; cv=none; b=UAUDv+wnVv4ahF4G6Ib7SarreBzC3wclA5I/TJr3EcTbF3PB8imyjpMKEUmRfEjeWgo4bi6Cc2J/saazDuVxK/i+ZMcswGcO3tFfxa6+FX0iirgSsHIg66es0NVW8QJVrmu9zzKCZBS1RK60+1r6Mfr9XhjCls+hpRPhH+gi4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982991; c=relaxed/simple;
	bh=M65grMqA0pbQdU4QyJoVu4Bgle4ZA4GTDxdFGfP4iCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vj7FRMEsk7GqA8BkQCjBK7R0KIOSNFdgNQGoylZQLyvn4vpaIlFt0m/xGcKh0Jlu6b4sclzu2JKnhAudb1hwEB9X67zBCYEggUr4dHCdrvbq/J3FJxkNzr5CjchpjsK0OAPPHpPoXkLrBHXTF2MFpgtgwxc15jh7sY8xQNgz32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EsuVTKBa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a+2gM4dL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EsuVTKBa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+2gM4dL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ECJQRM2088171
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q3z0cAL5rFgQt78BTP0aQrx2ojCO9AhS7BBpn8BW/14=; b=EsuVTKBa+BPJWbGJ
	C6iV8zppThQzhk42jtzuOM242Lex5uB97yEBabka0Q/Xf0W42WHvDhq82FUaQAc4
	MpyH/jqWMUMn7vN33TZ7ZUJZR3GqcPBLgokQFHA0fYBhH+bHF2/C6WBJATq+RNue
	LyHNpTLiFwGo8KrlVYDb46G8NlgnIppAHU9MfSmax+e21cag1CgPvCIb2YiIIYoC
	nTAUoT6lQDXky6r+EL/4lQBbMt3PXA9AGA/6NvsKV6Ix6GfJap6HnHjS77aB25Qq
	Dn1CT+wBQERBdVy/5X/Lj+KLGPdZ0uj945rH+akIumPj6pZHcNxdRNUvOWEbnBBL
	eLa9ig==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49jxsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e94989d97aso1065487e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791982987; x=1792587787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3z0cAL5rFgQt78BTP0aQrx2ojCO9AhS7BBpn8BW/14=;
        b=a+2gM4dL96/IjLq9Dmhvu5xmupifLvTsUEWgE4Bw6WCkJY9qrK0u6BCVXCCvgbCTuR
         zMypm1kBk8Zji+TrBB94v3pL/dmaobiVTH9ph8sdQA0Sxd1QoXqrDmr4P8gDmq4ngajt
         1lHsQS8hBnla7yfoBCIj7PbyMRmJ4SBCl2vzwh5qGzdljusVb2sYbZG9SQTZEHxl1T/F
         StAAegvXcvi00p5co4xZPpnAjgSHQmFJUx70t8fuEP7BIqDyaLfBPoJS59k8HaksJheX
         upEyPlhOOY7V46Zk1WJTpzZ6hTszYv9q0cje1kfAzcK1vwOyM9jfKjaYiUqgnMG51pBW
         AZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982987; x=1792587787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3z0cAL5rFgQt78BTP0aQrx2ojCO9AhS7BBpn8BW/14=;
        b=rV7Vw/aBvBdvJIfl0BTID4hq8CF3akwZQhoegyozpxWKiyEsylRbK9l4JHvx6e7VbD
         sC3GEWXyc/ebbbyl1TQmsWa68HuG2kuX+JVrTHyvAaSddyFgLS8dY9eqD11NCf1cYxVy
         GX9EH/o5b0sPAKhrOCHDK1/OpPU59qvmJEtIgKOUqJyazSANfHvWzfongMkR2WApF/Zq
         aR62Sn0mT0CCcw/WI1pb4ZMvSLh5EgSwGclB6IxJHX/Lwh0CvhGgtgvsTW+85pWcb2kw
         OkLFyAOrkB/yMYMpryRwRjpoi+YNKuA49bdBvSM4JvKn91h1RJkaO65t+eMf8mmyJq7Q
         ULyA==
X-Forwarded-Encrypted: i=1; AKwUvBwMJHz+I5gnGn01ltGgTBm8ggCCIiXT9VeKdgA96aJXTumTrbI4TbN9qHB5kx3B8r9zxp/jPqsfF7RvC5spqR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEFmMCaKkA5pSK9jNBHTnK/JjTJjtyRrpMMmTL5bbyJjEMRmPd
	oeq7xED8fHJlw7x3sxzK98jq4s5J9/Y7Ejx4A5RZ7QYe7BkF59aDf9zx01exnK0tDIokM3OnHgK
	VA6+dIpq4dgjMwSpam/XN5BYe3jEZWs6Z3UrcjPZ2g+Ltfp+NAn6vX/SRV9jMugRWVAClfzM=
X-Gm-Gg: AYBFou2waG0h/oSbK5R31bXu+BCsItxGIR2fgQxvAIw6C4S5y9wqHU/UBMmhbY/T59i
	bgOzOT2LOgogmcbDQfYznjyR7wcWAi52xsXn2u38631MleFbisXo4d9QEF6R8sVvfsJ6eLqOPXJ
	p0tKHxHECYB+xp9xHZvkDSFV/tbgzZid7vQgqsx1nhDfI02uHEQ6XA5EcxqNw48i4w+6fhKyJqQ
	c+Cus7lY6tZNo2zxBC7MENAt0LH78MNrnHQHW26lIJyBNknlcOt21fopaP3jz0LH7y8HhzrCgAK
	B3+S7YmZGxQ5Nqy/vUL5oGMyfkAKpRqh2peaxjaQhxKIraPuMj0FrQDXF0jnk8UfC5/2fbjzMBw
	r6NueUTC5/A==
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr4660003e0c.5.1791982986692;
        Wed, 14 Oct 2026 06:03:06 -0700 (PDT)
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr4659950e0c.5.1791982985578;
        Wed, 14 Oct 2026 06:03:05 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcece106sm567795e9.9.2026.10.14.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:03:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:02:41 +0300
Subject: [PATCH RFC 3/5] Bluetooth: hci_qca: Support BD address from an
 nvmem cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-nvmem-efivar-v1-3-187c85f65018@oss.qualcomm.com>
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
In-Reply-To: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=M65grMqA0pbQdU4QyJoVu4Bgle4ZA4GTDxdFGfP4iCw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqz317IP/RgPiFebMABWgpRQA4kfAxNpiWKdFo5
 nyL124My0aJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCas99ewAKCRAbX0TJAJUV
 ViGxD/4n6SfiXmZfYHLfCeUDnUW3mv0CjuulX8LDaae1+UfNKgq2D94MKSPHAq908uFKy8M3ACS
 8DfA+SIbA95s/9QIamiIEZJhTyg8TpeZbzHTi3lj107xrKggAI85FudtTGjV9P4SaWUJNxR5IrQ
 XuCckMQWmRZesiLQaLZyZDrlUZEXVSi7kFEfw8aQV0bUwFFxe03NuxkfCONUipyohb14bMOz7+D
 tgTn6EO7LKZosyaY+4bnhyi2iueZEteOgPN7JC5dd5heheXIyhbhpR7m/gXQ/i20Nr0Mzr+IXSR
 QZmzceVn4hdEW/37uzJLcXdKtboeq2ONnycBsL2mwY8iMdH5ke7urm0DHXSktdl32F5bxHvsT8F
 orvrvmk6GSTuZWdKMr2YAfyo5Gyo1nRfRrr2dDUle4fJTJmFb3kiKhTh5UvunPj2UpVeqmXuJcJ
 d07Q2lNWp+wH87irkbyd7cKFJQ/WkwTvmacXxpdXe8wIqvriDLwsGG+bYzZUyPLbF73JtHDlXB3
 lJVm4uST7oRbRxr53+f9xCWnbICzwnmQmE6967SUaK+TL2gJEEf5zdhL3XTmc35je/Jxhq+FT+W
 EurMZI+mGnTYvwNTdprUK2sW4/ORcB6j+wzmndEhnrwi55cgs2wbJKsi4tlLroyV4YOkxJSFvap
 EaYk+c/iAwqdZLw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf7d8b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=e97J7Y3cOKKqNyIg4ksA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfXwnk2mpK2UbV5
 frf73OH05W/2/JAeMfKkhHXdl9FXwYt0/08bmr+ATx2cwphCBI2s95TSmW3ZZpLirh7nu4Hs9xN
 9OQLZSHnRt/IhAPDHKzqR8Rrm9WTIfNQJfZ+8O/tRdVLlOIRdKCYe7D3XAjI1u/SFRIjB5Gr4tF
 643EmytGBIHx9nBkROD1A8cObR06+kR4CXI4mCVdotYbZ4Goz7vnRqfG1RpwjODfwr4vFfOSpP7
 ESireR1csXrPiMONoR4IVynfVG4G3DPbhqyvl6VYzMrY6NMI73VjrCLIHKKquuQvYjiKALfsPAM
 gCwbPBJWmJUMYhuai3paBhatgAFHB+J91V9iG+OOk9+gotjS8Fg0zGHHA/CfXv/KgG+yM0WWPpu
 Z6I4J8XVQKTyWG5hVmerRh5tIAm57I5Y2b4mdnCUQWRhJyJgWBpMf3HM/wPALln7CuIRhTQnGbj
 zfael1nZXhbaYrlYTUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX8p0ozmECt0cF
 uyZEGslqVuaLS4jsPk7PzVJhznx6Ehu6bhIxktlrRpyHQNi4iDSH8xjeY4W7Fi5zF3vFl+HXVB9
 U1OSxEVHA8wu6JSbzij2bavr/0BuTLg=
X-Proofpoint-GUID: I3UD0Mjr0Ix11mLvqD8ns_3hQ4Xb3AV3
X-Proofpoint-ORIG-GUID: I3UD0Mjr0Ix11mLvqD8ns_3hQ4Xb3AV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140051

Read an optional Bluetooth device address from an nvmem cell named
"bd-address" (as already supported by hci_ll), and program it into the
controller during setup. This lets QCA controllers source their BD_ADDR
from firmware-provisioned storage such as a UEFI variable exposed via
nvmem. An all-zero value is ignored, so unprovisioned storage leaves
the controller default address untouched.

Assisted-by: LLM
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b639b2..b704f4c3e1a4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,6 +25,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -230,6 +231,8 @@ struct qca_serdev {
 	bool bdaddr_property_broken;
 	bool support_hfp_hw_offload;
 	const char *firmware_name[2];
+	bdaddr_t bdaddr;
+	bool bdaddr_valid;
 };
 
 static int qca_regulator_enable(struct qca_serdev *qcadev);
@@ -2079,6 +2082,16 @@ static int qca_setup(struct hci_uart *hu)
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
 
+	/* Program a BD address sourced from an nvmem cell, if provided. */
+	if (qcadev && qcadev->bdaddr_valid) {
+		int berr = hu->hdev->set_bdaddr(hdev, &qcadev->bdaddr);
+
+		if (berr)
+			bt_dev_warn(hdev, "Failed to set nvmem bd-address: %d", berr);
+		else
+			bt_dev_info(hdev, "Set bd-address %pMR from nvmem", &qcadev->bdaddr);
+	}
+
 	if (qcadev && qcadev->support_hfp_hw_offload)
 		qca_configure_hfp_offload(hdev);
 
@@ -2420,6 +2433,41 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	qcadev->bdaddr_property_broken = device_property_read_bool(&serdev->dev,
 			"qcom,local-bd-address-broken");
 
+	/* Optional BD address from an nvmem cell (e.g. a UEFI variable). */
+	{
+		struct nvmem_cell *cell;
+
+		cell = nvmem_cell_get(&serdev->dev, "bd-address");
+		if (IS_ERR(cell)) {
+			err = PTR_ERR(cell);
+			if (err == -EPROBE_DEFER)
+				return err;
+			/* -ENOENT/-ENOSYS: no cell configured, ignore. */
+		} else {
+			size_t clen;
+			void *cdata = nvmem_cell_read(cell, &clen);
+
+			nvmem_cell_put(cell);
+			if (!IS_ERR(cdata)) {
+				/*
+				 * Ignore an all-zero address: the backing
+				 * storage has not been provisioned.
+				 */
+				if (clen == sizeof(bdaddr_t) &&
+				    bacmp(cdata, BDADDR_ANY)) {
+					/*
+					 * Per the device tree bindings the nvmem
+					 * value is MSB first, while bdaddr_t is
+					 * LSB first.
+					 */
+					baswap(&qcadev->bdaddr, cdata);
+					qcadev->bdaddr_valid = true;
+				}
+				kfree(cdata);
+			}
+		}
+	}
+
 	if (data)
 		qcadev->btsoc_type = data->soc_type;
 	else

-- 
2.54.0

