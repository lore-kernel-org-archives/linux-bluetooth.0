Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680437;
	b=RHjLjDoJnjeAySLW6EdHoYwlmalAtmnF69ezdWizRzWA+8XB99p1lZYFVN1oN146bqql
	 PbApF1QW79qOHifGZLTziQ31gIV6rymcvqmCsAENm5TQnQc4sFCZXFKwB8/UbdkgmIa9U
	 PDDjZ6p3OzEGJY4+6AzYMf5iVK6SlAKu5JtIijNKHiDNUL5NW2dQOt3VuF/9vCl39l1Ju
	 Opn/LLcL+eWC3ikEIrThysBhCQpNEilnzfsAqKenxFg5robVOUcfDuynMz3U9enZEGfsM
	 H40NIvYhFuYFaWZCogmtZTwJ2pAo/h+9V7Lt16Yrl4OQzWj1XyOxU7AYh8gRJMI+QAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aUkDNLO/u5puP38JXKFEnWyV5La/0VL8jM+AQyNlURk=;
	b=hVV7K18Wlakt+yAtSfe/HjCcFHo2e9gEOTf19oH3eBVWR2KUKrWFWYI+t9mQSaycxSdp
	 J7oLpB8z9hm1qly+09zPOk9psHwSnvy85sfBAuQcG+//zueCxTnQ1HevvICL1y6/mQfRT
	 X6Y4uHFiSAfDY7XfZ9BvuqQpxWwuYsGePRFRqDRgWwqKloAUXSWC5rOdr66IojTrk6zfU
	 6h9XYExp9xiJzb5PfdtaxmVwLQTYgR/Dh8921auxy6LF3xGxaOjPb+w8k6968dWsvPPow
	 H2g8xVaEoaRChZFiaY6HZ0UL8LJYoUetZUDqmo2pbY3vKMKNAos2LyHXWFKl2+d3PAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="EGvR/5qI";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="gIZ17/I/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D6606A330
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 084D6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EGvR/5qI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIZ17/I/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7j6pH132252
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aUkDNLO/u5p
	uP38JXKFEnWyV5La/0VL8jM+AQyNlURk=; b=EGvR/5qIBwyKON95vHR6DpuzpeF
	xd5QarYKpskzlMDr+0eMJBOsRZOS896GGOK4Lmhj2uvT9Ehf6oId50BbrNpVm1AO
	6b9+MNjxxOrwd3CPzAZ6XavItJhF8qgVe5kDK4Gb4Sxrk5zbFy8R1QZX115WeFKc
	AvYCUfkVNR1OH0MTnclIU/bag114evZTQQBTU6LTRFYeqIzOFFXGfUYNneJSzmfH
	8qM8fisQ9BTHrfW/xWU/W177FkDp9315CGPmBmTDOSdGq9Ug+5jaYM45kB00ZYUd
	MRADJHcZPQXK8MSGL2tJLo5LXpUvfi4O2WzDnR6GD5fc9kUtr8sLrhlftdA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne02kb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:07:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a6f57c066so695165eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795680435; x=1796285235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUkDNLO/u5puP38JXKFEnWyV5La/0VL8jM+AQyNlURk=;
        b=gIZ17/I/FCIJBA0Ie3erBFrgk3QUC+7L8ZzZhXLnyrA5XGB4AAqazK1C+2qSPCRGWg
         FV1m3fxgkBh8HeOpOeaaC64huA4SCJABp+HgglMmznwgNY4x4nDECGxKN7ajd1njgA+o
         F3pLwD4R9azURxef35RraeDb5iusbefmz6/8CwrqUbpflPzkA2dTq+qkjpRitApe1iGN
         /gZpnvE9QSTLeeFrb/nKcG6cjjCv1p5Rc0jp2Z+3HdnFwkLuMlZWPyCdIh7s36vm34mu
         BtyWUxZhpe7Qp5cZyby1pEyg1EUVKPnR1TeQWIlnO7SZXQjUESc1k4VRSQiWO9yojvKY
         txIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680435; x=1796285235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUkDNLO/u5puP38JXKFEnWyV5La/0VL8jM+AQyNlURk=;
        b=pdh90yEZfJWezqWNiYr+Ug6ruQ0e1G914Wb3Yw2dMyoP2oRBd05xkLYWGGiM5qQ4G5
         vWf2lX1ds/8nO6TgGMWXBDu52PLyGDuavbt1pijJHJNkYLb/fqa4lgXxKFDBYTqv6L2e
         NuJDLOWDRODYA2P4mRtUEY9r3KkvvLiUqfEW9U6l+lTVntc5K0y9DjhD5Z1cuttLIsuS
         O2QhDrj08mKB1WgMlIWFu/H3sPuM538wUluGna+FCxO4LReJ8iy9bVbg8uoMwB0Kbety
         6efSr3VHiFvlH1Q4R7hb00qZv2sJS0Ggn0QFp2wXmI6keZgQnUbHeEEUlgq2ADtz7pND
         udBw==
X-Forwarded-Encrypted: i=1; AL+hErFl6gf7nysXN7r6uPaz4lEDewpIEI6SC9K/2QZXNd4pK85kNCcDnLGGXAVb2UsZeSHEMiLt7ZJQBYwgtQwGbgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OgMs7RCBYZ3wIeLmghMai2l8Ji8Si11bqE1YMKXt2TCqRZg9y
	JHi3j5xqV1e/e1618LVTCBLbYnbEcHqsYzfbaZYes7uN5S1ruAEA2O1i7xST6ZhxoJVrC1qDebA
	2be5YX9cyfr1RrdxrZ/eyzO6lxbLHZ3e7ZYFkeA2x2rTvSCdOnfI1Bmn7QRTpAJebF1o6700=
X-Gm-Gg: AZFdTZe7bOJS/vorHqb0+Xt+vpOS2+jLMzPKlv30zwryQoLro2q0gvKC0GkHT6bbi0K
	gOabCE/ZPsYk4OoJgATknjaOG0ZXNtcBuE9tlRRnYBuTjzBWZoVXjZaplBI6C3Hdvyo6Ku3FzTV
	WoIBjYgqwFohdRtQLogDZwxeRwKunwSLxOGUaO+HK2th8oO7mxnN9ZueliQOg0QVIu+FFmVqIdl
	gdlHDcQDNNy6OTfgk7hrKi3DoFA/eT7D4iNPvCNibPYef609QCE7DdDdWIPEqlkTLf0oACS7Oxr
	EGROlT9Rkvv9Py1f/2lL5UUgAE2fZWm+hcj+LXwSu68lshlg+FnixNM9RlpC8deKnxp4K+r8VEj
	TPV5pGLeZHuSVRX80HWLpa8cAJ2/8ZrxGSCWJQTHFrT6aMFk6k69Y40ow9kODDD5A9fTI6epF
X-Received: by 2002:a05:7300:16a3:b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-3856ef457b6mr29495494eec.2.1795680434472;
        Thu, 26 Nov 2026 00:07:14 -0800 (PST)
X-Received: by 2002:a05:7300:16a3:b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-3856ef457b6mr29495462eec.2.1795680433883;
        Thu, 26 Nov 2026 00:07:13 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm59870872eec.23.2026.11.26.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:07:13 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sherry Sun <sherry.sun@oss.nxp.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 0/5] Rework M.2 Bluetooth instantiation using the auxiliary bus
Date: Thu, 26 Nov 2026 13:37:05 +0530
Message-Id: <20261126080705.1966830-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b07e8b3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Unh1toCOKya3YOY-X0AA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfX5q0G8rTjeeWq
 9lHJXIebGTD6ZQFPk8Oht/55OTrSnGvRvdJdyPCUmYBTznnJ8wSt1r+t5ay29tlYkkTA48C6Ssv
 xWc5/w9S+CZRqlpZDq5vJHGmJfixYyKPm0Lbym+s6RkdPZnsJzItSLVb8XeeLungiYp/a+J4Et6
 awYObIURpFz8+s3HxjD12iy2RCEzCZ8oQXGtQzJrbYhioY8Gc5FbYCOzBiPCmYRKE1AvUZkuwtI
 mzrQrQiQshoBdUqvk7pLGi5hIl05Xgw+M5wC8pX7szcVAh+zwdNxf0VNRf/Zk1Ihy0YxrU1Zwj9
 9stABi5pMNEonXP6yQofh0KHavB8ghW05uao5ktAHzt9GKRtRYEOaj7p1IlUTtXPufiiNK45XT6
 bLXqVNa2Gw/nVIXrty2oytrDLfYTuXmHhWMlHXcl2T/x9tJdTZAAeInrYKFIe8Y18ItnZogtvrZ
 RVO9VqfHumUf0hPI5Zg==
X-Proofpoint-GUID: HZmCQv-XxrN6tl_zXsqR6vNVrj3CBi3E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMSBTYWx0ZWRfX/GHIwHIKULRg
 eP2zAssK2/DegevQrHcLE+6u5KAz3TFBegY00NpdgJMocgQlJ6GWiMAH82Pe8mAVzZEMNqd5al9
 Fq4lVoUIZkSH7BAA2LuGNSIEb5OHwRs=
X-Proofpoint-ORIG-GUID: HZmCQv-XxrN6tl_zXsqR6vNVrj3CBi3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260031

Hi Mani,

On Tue, 15 Sep 2026 16:24:01 +0200, Manivannan Sadhasivam wrote:
> Hi,
>
> This series reworks the PCIe M.2 Bluetooth instantiation using the auxiliary
> bus.
>
> The Bluetooth interface of the QCA2066, WCN6855, WCN7850 and NXP 88W8987
> M.2 modules is accessed over UART, but the modules show up at runtime over
> PCIe and are not described in firmware like devicetree. To make the serdev
> bus match the Bluetooth driver, the power sequencing driver was creating a
> devicetree node at runtime using an of_changeset. But, creating a node just for
> driver matching is not recommended as per Krzysztof [1].
>
> So this series reworks the instantiation to use the auxiliary bus instead. The
> power sequencing driver still allocates the UART serdev, but now hands it over
> through an auxiliary device along with the power sequencing target. So this
> series adds auxiliary driver support to hci_qca and btnxpuart drivers binding to
> this device and brings up the controller over the existing UART transport.
> Finally, it drops the serdev based M.2 code from both BT drivers.
>
> Dependency
> ==========
>
> This series depends on Monza series from Loic [2] and reuses its
> pwrseq_is_controllable() API.
>
> [1] https://lore.kernel.org/linux-pci/768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org
> [2] https://lore.kernel.org/all/20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (5):
>       Bluetooth: hci_qca: Add auxiliary driver for PCIe M.2 modules
>       Bluetooth: btnxpuart: Add auxiliary driver for PCIe M.2 modules
>       power: sequencing: pcie-m2: Create auxiliary device for the M.2 BT interface
>       Bluetooth: hci_qca: Drop serdev based M.2 power sequencing code
>       Bluetooth: btnxpuart: Drop serdev based M.2 power sequencing code
>
>  MAINTAINERS                               |   1 +
>  drivers/bluetooth/Kconfig                 |   2 +
>  drivers/bluetooth/btnxpuart.c             | 193 +++++++++++++++++++-----------
>  drivers/bluetooth/hci_qca.c               | 138 +++++++++++++++------
>  drivers/power/sequencing/Kconfig          |   2 +-
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 137 +++++++++++----------
>  include/linux/pwrseq/pcie-m2-bt.h         |  38 ++++++
>  7 files changed, 343 insertions(+), 168 deletions(-)
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260806-pci-m2-bt-rework-78dc2c926f00
> prerequisite-message-id: 20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com
> prerequisite-patch-id: c4e777757ca9358cc4dd35e23738cd7dc1ead1a0
> prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
> prerequisite-patch-id: afe88432c4d459e9094c0e6dd31ebeab6c9f2f08
> prerequisite-patch-id: 60fd7b13447ccad7546fa8e5b5609d8f133f788f
> prerequisite-patch-id: 61dcbe55fdb6f33a3229c197f16a678785aa16d8
> prerequisite-patch-id: 14099e5c573d7c41b899c3f9bb9126aa23f1553e
> prerequisite-patch-id: 647ee15b77671054b4bb012afa9ba8694b6c86c5
> prerequisite-patch-id: c3a774cae81a6fad287731a38f1b76c7e8babc4c
> prerequisite-patch-id: 18b0fa62060a1a2c96e76051944d692699035572
> prerequisite-patch-id: df02ab167976ac1f0d5a38c78e559a7372b16c1f
> prerequisite-patch-id: 3f2dddd108677252a539cdb1eb661912836289ca
>
> Best regards,

I tested this series with Bluetooth over UART, based on your patches with
two local additions: the QCC2072 PCI ID and its auxiliary device ID, and a
check of the pwrseq_enable() return value in the always-on path of
qca_bt_aux_probe(). The patches were only adjusted for context differences
with the tree used for testing.

Both cases were tested with a QCC2072 M.2 Key E module: pwrseq_is_controllable()
returning true (W_DISABLE2# wired) and returning false (W_DISABLE2# not
wired). Bluetooth works in both cases, including powering hci0 off and on.

Tested-by: Wei Deng <wei.deng@oss.qualcomm.com> # QCC2072 over UART, pwrseq_is_controllable() true and false, patches 1/5, 3/5 and 4/5

I did not test the NXP side (patches 2/5 and 5/5).

I plan to send the QCC2072 enablement on top of this series. It needs no
devicetree binding since the module is instantiated as an auxiliary device.

-- 
Best Regards,
Wei Deng
