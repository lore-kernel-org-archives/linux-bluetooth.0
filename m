Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA873D666A
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943719; cv=none; b=P/RLCNWzxVLsKEmiZuOKEGd2z1NkJ6SoJ3Ydd09Gcls2+xxYOUmp/o1OctKhSnSrO/4AHAadshk09KkDFNXxz/kAcBf/YuZOLKMjH/Chtmk3g0ls2ruUb+9fp3UQedB7ToFlC3Gz8RKIRywW+lD8kqZx5+svn+y9NwcJ64By48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943719; c=relaxed/simple;
	bh=bfENr2Ga1hRaN0a0ouKuR0lDxkpzobWYOnT0p2/YsIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhMlXFX5mors8B1Cp5jDxT7NnU7TWpX/Jj/mrLRZO+YGznaDl1rTPsXGPxaHdOnhy6Qh5XfBnmRg2sY+qBEfG5deWFsng9CT7wtfAG9jRZ08lJk/Knah1m349NGOtd7ZdYOoGFhNBagB9SPWyHyzryW5wnfEuk5aqVSf/Vev2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGzR7lBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foP/aPAE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGzR7lBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foP/aPAE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V2V8nh4013537
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=; b=MGzR7lBx1mzi7Ss9
	yuDUm9ra9bdvpSxHeBBynCFY6poaNaYv8U0I71JGO94QOGCwXODFPQzdsJ12B71d
	nCd2AUXEy0qBH6zz9epBApG1hobev+3XzPDA6FBRz/piz9wlQMHkDlFvFxVh/w4b
	Ahg0JgZeZ293hdKTeRNVBDnF19uPw9L5dtXqSovsBzi111NzRU17ad9Oc/hSf5g6
	OVZxst64/Nyb2QUVbXN48XS1a4j8Aj+rQj28K+7BsGX4Gl3A+jLA9xOno+bvwCBL
	Ix51xCpU3JzPKjpCp/q5DH2EUxty4zKGg5Qlu93eAS7LXo/6/kcEeVPpOc3+jdec
	jEN5yA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regv5fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:55:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b44f7b7bbso172644261cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774943716; x=1775548516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=;
        b=foP/aPAEU08fvqJ38UwRxnsgQwUmrVGwCteXtVPgGglqUDKEko2hiKzrPK5aoxgJsb
         5LhEF6kt/DL9PeBwp+uYsFFx/AzeYGNUW4uq77xo2A2zXh6IlNfKbej+4YbXxd7ys0Ca
         AxOdWZKprFRhsCgTdE08iiMJJphi5OhrQEkcOieHkM3ZZzAQBhR8cbY+0OaFtZoTA4f4
         Rw4ATQoPaEcK5TGNaqUv4f44pvB876cp/feS5eLO//ZMkrD9YPyl1zQ/xFXxK7CeneNj
         bZzulv/aJ9HlOmMTABR+hIFbf/F5hypNHgMFhf2oniS9OusUNspuRwHnroXQR+D3sv1j
         npQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943716; x=1775548516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=;
        b=VZ4UG/JvK3/1KhQ7+rGS0JSwHMP3wQQ0n7jTbulPEBT/nKInjC/W9WB2kGAa/D4lxV
         DDOai0zaOpHiP1Gm8UNahgOtdD/+BFFryysYMHsCNFZSX9St7APNbfdc+MrPmNKQ4QIH
         tMJq2QazPfLmoIrMry0gI5L34OGGPf3ELQ4wh3wqp35xtBFz4we/UYEIqXKraNSjEIVi
         ba7RgiK11id4wI/knJIdfxnxJ+sGFe0xKmocBBX6g+XxRtd50j4fUPMBSO+7YnS2maWH
         /xeUgYsXOPM+ajb962tKvSczdgE44jVsILGpC1l4etFzqMaK+cT2K0ISOUweSAsNKuyD
         JUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8XX3dR3ryLc34xbIW8mzC7j+6kT0WekU5S6jk9/JyCu7+5mjvDyQgN+3h9YYAvpylTL4vTZqsixEXAI9FJcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzh9AAR5Fd1CjPwUN8kRsIeNLkHVuPhlijDCpbvwFW8lLO/uEG
	fhGuCclD4agTzmGtnjk0Sk8Ox+WbJdio7y9barQTZkbQIRGf0Ig+yn2RIZnAfjZMA+5szeVW39O
	S5YBNsNqV8Z09/c0q3z1MKR5PrKplhHvdXOfJkMSNXvnEz011G12EyKZMuu+XJrE9mpSKUuA=
X-Gm-Gg: ATEYQzxsZD6Xkt+HZtGI73Q/+TaomufNI8Lsrr16yLM+evUdURzhSSAwd7eGKjlTMsi
	sVQJEjgljjgM/HZNZb9OC9dNBT9wfzZrmGPdLDFoLuDJjpJVu+RphlHSbY5UcEdx2C6A/ObN8OJ
	KKCvA3XoPEsqBK8mu/Vll0PuMqzZ7ewFVkMZvm4zRr5sogClMq7B2BYLJXT0NoMzwxw7UuVb89X
	Z03QAzL53ri52/W2nhGvOfamfxDVAIIMgL3Y8bfk9NosUI+My/0KEZxB+BX2NMibF2C0TFITPtg
	pAWp99DCytBlBq1OwgDtW9vshvwn7CYifyOZKf/dWsejKz6kIctV1iabZDKlcUYxid34Nwx/uBu
	BvR3HVIG7+AtTbgtQb48tSaaJSR6HjYKuzdExSDbeRDKjMKOIzg==
X-Received: by 2002:a05:622a:5917:b0:50b:460b:650e with SMTP id d75a77b69052e-50ba38e7652mr188112201cf.49.1774943716572;
        Tue, 31 Mar 2026 00:55:16 -0700 (PDT)
X-Received: by 2002:a05:622a:5917:b0:50b:460b:650e with SMTP id d75a77b69052e-50ba38e7652mr188111811cf.49.1774943716067;
        Tue, 31 Mar 2026 00:55:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:29fb:516:a90f:8dda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8a546esm12724395e9.5.2026.03.31.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:55:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors in devicetree
Date: Tue, 31 Mar 2026 09:55:12 +0200
Message-ID: <177494370819.4807.18152210084249335606.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69cb7de5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nTh72EtQ-9J6yJQhtbMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NCBTYWx0ZWRfX8O+ZhHP8FyeH
 q+efj+YJW1qbMnTsvlcE6Uq3l5OLQFXqxJKnP12NthbnfrJ7Aoi+qx3I16ImEhlJr0GUPDtp/gD
 ebEcHNJ6uCqsdulaCNB62ruhybFikZh1/YgymD9V2VhMQk89nE8WPxC1HtDnVL16EGHbjN5uvLt
 /QppzBv1x53KVMGCSC3HlOrf4wPlHHl6ZsqBPgQ3CaUinzaLvAaD1ea419G28cN0w0jeDafhnM1
 PCwMtyGw3t6/lNVt6pjQ4pJ5Vt6rlwwB+6hA6LiSmSMhyDo5o8afm31pBG6ihqNgGj9w+yYE9Ra
 Jognb5AqYHK5CghDFh/nysdVJN50et97mv1lYNByz65ggEQBqj8AW1tHN8sDMU9+ixi90oPBB46
 6FZXOBa4zu2pjIk0cTEaZ3bno8MmHWqUc6JmRhRVfMXJAgycYdvqlYqErtGDukmXROQ4581JWIM
 52lU6ZRKaGG50azIlDQ==
X-Proofpoint-ORIG-GUID: kr4bMSqtkWMPOSrWTn9gN9YCXMz1f3cy
X-Proofpoint-GUID: kr4bMSqtkWMPOSrWTn9gN9YCXMz1f3cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310074


On Thu, 26 Mar 2026 13:36:28 +0530, Manivannan Sadhasivam wrote:
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.
> 
> [...]

Applied, thanks!

[1/8] serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      https://git.kernel.org/brgl/c/e7fef85039ccdba67d97b2a09f313aceeb6691c8
[2/8] serdev: Add an API to find the serdev controller associated with the devicetree node
      https://git.kernel.org/brgl/c/a2b4814190af5944b276c5fd708d95ea146106b3
[3/8] serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      https://git.kernel.org/brgl/c/92fa16ecad07dddc5703f7e2ff342441b04c45af
[4/8] dt-bindings: serial: Document the graph port
      https://git.kernel.org/brgl/c/1785c7bc1495e4e22377edffaf0ff8c3c697647d
[5/8] dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      https://git.kernel.org/brgl/c/5970c1dafb8adbeab5f6d9a22a4ad5b1c0067888
[7/8] power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      https://git.kernel.org/brgl/c/0d38285a12a283e12cd589ad5bb46c6f4a8cc647
[8/8] power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth
      https://git.kernel.org/brgl/c/3f736aecbdc8e4faf2ed82c981812a6bfc76ea98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
