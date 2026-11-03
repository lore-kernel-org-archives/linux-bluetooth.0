Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688936;
	b=mjoRkfwWJe9nqIDAc9mxLy9P2FhoCtcPzT1bcBJgm+NMeOKNKp6q5ajCT3ibfLa+tRjJ
	 meq1XlIJDdnNO8FUpBVYnV7L8A6xwIi0sZOV5bK//73dvFNRnWqZyGPZWEijyqmBiYop3
	 zKT+ePqIfoSRiEzNFzK6jWIsjLuNNBa0RZgM3SyfJCaYWv/qt7WiCVy2QNOcMatlu91aA
	 EWzqpUdW9PSt5d4+EkQjDt2CoYggkbN9DZv8bFMBjXabMwIiO1uyI1U5yY1vXplCQj48u
	 9uzJhyVX22gvLB2LvUHE5OEiVZxhf52pLvcbibzFYVhQg8jpQbZSdDRSobr89755EsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688936;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5eoKnttr8d0Ojq6L5syAw5jkS+Q5yVG5Q+JQ/FVXY8w=;
	b=ucRlDQYwFVmFIJDOP8AnZOPRn/sQppgj03Kz+ewtaVixD+QdsTqnk3TKiuOCYDo0Hg1p
	 kHCVgHDDG3IPLT9q3FIPyZDWcMjQyEeDT6jayOzOpORSXs6B3BmoqdnK3vZxU6EZzmqN0
	 pUHTEVviGbU1tCO7EHE7GCOAkZ3AWvYcN+MU7lrgMQy60T2fk9zlDFzCdkT9S8A/0FMyM
	 jctkm7ezmjVIv5Yiib+J72R7Z5sDzLOpijI9Q1BFKW7tZ6gn5Sr1xqUHmzw46xtrdGAcj
	 fHqrup191bOwcVu9f18WHGHW6EWkKlF48QzTCvTttbLOr8ZVVRLE4UdltwrdRXvwLxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zq3wF36m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M9uVqPX+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53F606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 06:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B53F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zq3wF36m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M9uVqPX+
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A32Btep2106680
	for <linux-bluetooth@vger.kernel.org>; Tue, 3 Nov 2026 06:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5eoKnttr8d0Ojq6L5syAw5jkS+Q5yVG5Q+JQ/FVXY8w=; b=Zq3wF36m2QiXyVkt
	JayEmq5i5Krz/7n8QhHRoII7D+li/vrRe4ik2vEwMiEoQ/QR4//G8iHgQC+PPUCr
	9aaYHYwbfQx8Zs1fuYQ98dp/ZoFNob5Zbkx+XxTrRrSe+zlfK7JBV+1Dm89eTY3u
	vwvYZfjo1nUK3/q7TeyIyMSuI4Sd6gQ6b6N2rYh2ktvs8DSYvolbquMzsZcTrcf3
	yvEF0wtahSadCaRmbic5QszrWm2rhMqoOrp0f3QfwCJkOIcpkLyOjGWu5Hu0Ou54
	Q0c6Bs3VeiByAjzI7l5FY1MHj3qsn5X/3C3n50GTMaLVzGaNcS1qBFzP7e3Va/L4
	RrYMaw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m98whk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 06:55:35 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-85c1135c288so1089339a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 22:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793688934; x=1794293734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eoKnttr8d0Ojq6L5syAw5jkS+Q5yVG5Q+JQ/FVXY8w=;
        b=M9uVqPX+skgbjtAOmwWu+ol6eCfR9UeMvvMF5h/11bhNv+Fm5Hp73uol+F7GUHjYqX
         Pv7b04r0FDtqdN2z+j9KVmCKgHNpkQdSxCJKvSbTBQ7gouVFsduAIy6X1ImxyvghAEHG
         O1W5lP+cgRgfMKT5a2nRZCWUcnlkJk4qqAyRlBhA0XYG/z57f5QKL/A44smB73xao8En
         2P9RAOoV84zjQ+fKzILOMPLMNQ8sESkmX0Qrq8//69gFTXNFgGR3jJLNhlDJ1a09/G0w
         W7md9WFy13LLAIF/oaoz6pn9yzV0bxsGHsMDLGHhzlmXS++l/dyVKwCN3ZWgG5zOUe8h
         6INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793688934; x=1794293734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5eoKnttr8d0Ojq6L5syAw5jkS+Q5yVG5Q+JQ/FVXY8w=;
        b=aS+M0Bfvir1k92Kr6mVyXS1pkgtqpK6Dygaa2HqQvg1YhCbCukb6S01LY9VFkc5ocs
         bYotDF1ZCTcAIrfIcuqXqJtwrRStC7l+TXjUauI3+cqgbBV+mkDgKbM81oZcBswxaV6X
         tBC78J030+V9KSQwO5IofvmjnbZdSLt+TrKIymhwWjZcfAsZQ4K0pBKrI0zsRvYWHm5h
         Q75HDkHsChYKpQgXxA+0/IqqBpXUAdJqpuseEhc7gy0Zw3OpUENSU0o6WFHzCVVfEHwr
         5ITK5ssWTtIpROjq3V4wucN6bOyPKe2z5ej5ITAiW5JCEr8Exwcq7wnTyHe3SmWmxvxb
         uOQA==
X-Forwarded-Encrypted: i=1; AKwUvBzyZ3ONETYzUnlAv8+48RQZhYMNYwKMT2nhf6/YtCYWvtYdqengeETtPvKHq5KGnkWwij2GrRB3SDGzZDX0UZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuj/gHaPVWTzPjIfo2GIawmMnrm6z7wA2ezJPOiRSA2k1h/wbg
	PgibzSnoKKKvViXBhjlUzy+ak6QbW19TUiSLe9YlzDIvIRkjVguGOnfPF70v8CsPp3GJV3ZZq1R
	K0hvoNU2aNdZI0f9IviQOxuwF9T+5l9oyaAolL09PGYkQ21Vr23pAuMIXfx8InnGr2ZAm+ks=
X-Gm-Gg: AYBFou0dqT2Tz2Yw4AjaKqEhfYkwxWn4hAiESbByTpHh035knw8r7r1dc8pq6kx8Bjh
	BVX44fIG9pYmheDKrsTJO6PnmkHnegdsFam1VV4JYWzDoyZrQHFfkRKK036AYq2X8CUAQuDAkgg
	RstIna+bbCV1ZkXUo1x3v0Dvg3A+mIUpn0LH+a8P7qSbCCiI+6TpJ3O5pWnrKmn4NDrMrSUibMN
	g3uWovik2qtkHgg8fACdeRMF7T0QEK9N5nsVF2AFASvJDFXBRxHXUPfTogxOcz1y5V94hpirnCc
	XxKZVR8c+nSLsUtWKbQGtM89ndfKcWDEcwtOP1eJTLFujyqZoO7m5uB+utuBqDVrNiHGRh0rcSJ
	Sn8yiIZ6NuJPXvFukAlHTC+h+KDf9a7In+cJccVhOTPaVxzk66uRXCVp932ADFwn6kga4KpcBAm
	cmmfN7+zHYpp63Yy6bsKU=
X-Received: by 2002:a05:6808:1209:b0:4e8:9e40:a0dc with SMTP id 5614622812f47-564101873f9mr11041446b6e.1.1793688934321;
        Mon, 02 Nov 2026 22:55:34 -0800 (PST)
X-Received: by 2002:a05:6808:1209:b0:4e8:9e40:a0dc with SMTP id 5614622812f47-564101873f9mr11041424b6e.1.1793688933917;
        Mon, 02 Nov 2026 22:55:33 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe423fasm10305974b6e.16.2026.11.02.22.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:55:33 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 22:55:21 -0800
Subject: [PATCH v2 2/2] Bluetooth: hci_uart: Remove redundant NVMEM
 dependency
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
Message-Id: <20261102-fix_kconf-v2-2-b4bd28de37b5@oss.qualcomm.com>
References: <20261102-fix_kconf-v2-0-b4bd28de37b5@oss.qualcomm.com>
In-Reply-To: <20261102-fix_kconf-v2-0-b4bd28de37b5@oss.qualcomm.com>
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
X-Proofpoint-GUID: RQyRF6x7XzHCVQEMhKS_bvOM_nKUkbuJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfXzvOMxnAtAhyG
 Hq/jNAyLznUGnkwPCmAqd/klR5ycUIH1mZvTclXIQz7ijk4+0UV7o3YAk0vNmPB4z7iNgCYz1lD
 0ZNDYTU4y0zIdg6+Zuu1a9wOxznvFKM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfX2pPt7BPxW5nJ
 wlSIK7pGbEHo200ZU8au79P5EjlFxm7/JlUCYrGy+i1cVjzByZFnELUQORupFs/UOYBM++sm0GM
 5N5zvdnUdO3sdxng/ztWxh7OSrElFZAQxsxcP/9KLuZMhNyF8mPJt/M0ACszFY+8TIDSX64C+AA
 9KdJAF5BDxviqLZyws8Hg8BjKfUHQtrIRNs5Zu0Mmz3422iTNtN/k4MDKFD+6Pmdw739ezzcsOb
 /lDpsbagiAGkN2OVd06KIEbSyyHaG7d5o12eSc18HBqsUKOIiaqIJ1qdNimqRMKUlRhxsUVmE+O
 eZy97G6m6daH/SPivcg4AMul0eyJ5SCQX/Jb66NXNiTm2WANKil/O0RsGNBYCzHve/nDdGHmKQ3
 23IbgzNcNkKxT9WU+4JJMkOIZw7LZQI7dLMQ6Tf9l6VFGGjqhKYg+SF60Nx3KIFrunMaGuGLd/n
 oJnaF6r/u2++wmYhErg==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae98567 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4keN-7vRS7seC8qMJf0A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: RQyRF6x7XzHCVQEMhKS_bvOM_nKUkbuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030027

'depends on NVMEM || !NVMEM' always evaluates to y, so it has no
impact since the following commit changed NVMEM type from tristate
to bool:

Commit 2a37ce25d9f2 ("nvmem: disallow modular CONFIG_NVMEM")

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index b18482b5677f..ad5eabb8eb77 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -112,17 +112,16 @@ config BT_HCIBTSDIO
 	  SDIO interface.
 
 	  Say Y here to compile support for Bluetooth SDIO devices into the
 	  kernel or say M to compile it as module (btsdio).
 
 config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
-	depends on NVMEM || !NVMEM
 	depends on POWER_SEQUENCING || !POWER_SEQUENCING
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
 	  This driver is required if you want to use Bluetooth devices with
 	  serial port interface. You will also need this driver if you have
 	  UART based Bluetooth PCMCIA and CF devices like Xircom Credit Card
 	  adapter and BrainBoxes Bluetooth PC Card.

-- 
2.34.1

