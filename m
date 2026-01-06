Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7A18024
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666766; cv=none; b=FvrMatQ4aqY7gc85ihMmmH9XS1EKlrdafdtRViVcXSXdv0W6cRV19AKAeQ/AB/QYh8y1C248b/5dDaAPWMLUHwcHX59+XlJ9kWcP3nzEuRtD3H45UWdWT99LhII3ZO5sABLqjhKaMgrr4SAA4V29ldyHOnSM1RVJUOPaRx9wcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666766; c=relaxed/simple;
	bh=s4HXUfnKrGF3YOBo4t33gEiLCHQphx23M+E7PPgmudU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzwV8Xi0V48X0UUQL/TgNg1haEhiBUuMl9J1+jv2s7FjFiX5zRDDo3FlKdX6l+8aGUgBb5rk8ZUSxFxK6C+OHVBfz/ZX7OlQXTJJI9HDq1thb1vlZuuSC8VHVRtFVr7o+yQSPLyj/uVGKV3bUcdmRGpmpwdr0qlqPDWeyW8BG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzSG4IT9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScPHdq6Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzSG4IT9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScPHdq6Q"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nT2j2726715
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 02:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4HXUfnKrGF3YOBo4t33gEiLCHQphx23M+E7PPgmudU=; b=bzSG4IT9BwiRiTrn
	SBPW4eGCCMjvFe4vyeoe2YXINVCaHozIfsgkveJpT5emfjh5Q2QK8EjQsYYxbGVy
	LwIDe9a/BeiGQwiTFHT7vECIyTH4jpUVRetX5heFd3XG/ElRfDGv+yxs9bLv2rH8
	NsJzpU91kMNbJlrVASKSFdPypE/0aa9ffxl9n/ruIuVcgWyPloFO8xbh9+QbKLLR
	OhFdAr7VF5zql0GtyrT47tn4bjjXGPcupcf2uLGWWsdGabL5wUlW76kzr/55hAHu
	TC2uoATuMpVj8UDSVIJSzTZg0hHqXss5vt4BUAopDxDXEKtdxlb3weHjHTz42IbI
	XuCIFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpn9rdp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:32:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso1271512a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767666763; x=1768271563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4HXUfnKrGF3YOBo4t33gEiLCHQphx23M+E7PPgmudU=;
        b=ScPHdq6QG/uoGGeMDY25Eu+ZoWUX+q7meLUGHUTZlj6h0qVgziPwDDlUcMI4T6QIjr
         P0kz+5G/vTB3StzajrgAJOcMKJhAlHRPdvtmDYBvJ2WYUsb4702FoBXvlk44qCzbdUvS
         Un+c277reYxOAI4/PkOayjVWLQBG1WY6Nk61rLRXbZjtxxnQPyLXmgxQ8uow00Px6/4Y
         L2ll+nTknMHf5PufplumDtgBg9pWE01WpgkiPDm+W9G5sX2m3M+qKD2+NI7oWMAnFnTb
         oaOx9O4H1vWiaqjF9/XJ8GpZsyxVxtTpbFRPeH6q9MkvKvMYB0XIE1udj1KqMBmz+dN5
         C9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767666763; x=1768271563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4HXUfnKrGF3YOBo4t33gEiLCHQphx23M+E7PPgmudU=;
        b=dUJYQDpPveaulOl2DR2YXJjgSdCsO6D/CP9RwFJP99EZWXPJMLEkQJDqN3SD2q9vlA
         zK6t15VLUUkPbMjrdjdI6ozlTIsGgbv2yNnoMp9Kuy99LggIf9J8FuDlrKpIJg4EWt7c
         GD04zVv76IgUjtcrREHZrDCdaaXbpHVQbT0C0uic1QFXpeyXLl0xRWxgYEzj2YyhG/o+
         bvgi+9NkcrEDnQ48Y49L3Ot67ttMckA3EUsgT9mtz9xTTiHxZB6d6Zv0lchb25fRMukT
         ekEmT2ddWVFNgJCbnXhi4/oK/S8D64bj7nLRjVhR/bh0LlqMt48+Og3PCMsj6dsitCgm
         m4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxKonsFjXht/jtG1j64YYxWabmJb2lvA1Ngv5yLZ+Bfyy00a5IkpuH4F/QJNcuAJFALjBvQKoY5gMyD+Bc4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp1X+gfi0D/ARm2I1eTiHHYKUnzIwkz7QRMrJjYgyp+FBxDc/
	XB6al2MZ/LPYHl0ogWYGLEURRdxf2VCVyEl9y584pnQmPCmRQCiZCTJJsL4W1hEr68+SqNNYOF0
	mUK92vH/MF3bQVdTArHboKra1iq8ttkuXzzNDZqFqkethHJXHYXPk9bgcn0QYkFcFH5Eu/sKv4K
	aBYsNdZgzZUaSudBojzP9LImKHMeSmQPNqU3PdvatybDwvSg==
X-Gm-Gg: AY/fxX7EWxQo8TfjFx7NMf8o0g+Tf62KRQSc/dIz0JVrinmmeKHcZyS30JGFmHt9cJl
	J/kBUKyh9wbY3uitLE3cT2FVvlJo/Rw5oT+lxzSnhdVR+xC3SLw9OwnfOIPOiGYfeg3oIctrTXf
	dtHtUDD0LzU36mTExzFhi7YWsiV6ldaL4Gb7VT0d15jMvU38NF1DHwO1Z0oqGpruk=
X-Received: by 2002:a05:6a21:999a:b0:35e:6c3:c8d6 with SMTP id adf61e73a8af0-389823cc871mr1213847637.41.1767666763073;
        Mon, 05 Jan 2026 18:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE822MAVam3mO83RTpLVRchdqJZM8HdniMKKqr3nM7fWL25KjYQMNHpKNlUxiVKAJbA3CvWiz0QNdnA/bA4/dM=
X-Received: by 2002:a05:6a21:999a:b0:35e:6c3:c8d6 with SMTP id
 adf61e73a8af0-389823cc871mr1213821637.41.1767666762506; Mon, 05 Jan 2026
 18:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
 <tfdeucc7opjtjuo723hskens3te3eg5ohm7db6tbhompbtgkkq@vsqgz5qtmbr2> <6d29459c-2cd8-44ed-b64f-6947cf620960@oss.qualcomm.com>
In-Reply-To: <6d29459c-2cd8-44ed-b64f-6947cf620960@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 04:32:31 +0200
X-Gm-Features: AQt7F2qsD_5aiYnuBf2iYsBOnBnMF18rt1i42DaXK9XOw3KfDRAywDzf-EqORBQ
Message-ID: <CAO9ioeVCRF1ADsrXeHzP7hKoudvMQ1f6cZPDx5jt_8C7SLmYZQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/1] Bluetooth: btqca: move WCN7850 WA
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5tZIYT_DNj44XhirUQ5bjIigBtuYCQK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyMCBTYWx0ZWRfXw2PEzvSXT8J0
 2tEIFoKNleoKlg57O/vEm65AerMHQmGcsLhD9n4/uI0OMHjaVbXrJZP8dQ3LwYN8QMHmuvDh8et
 o7YoQpUCX8Hrg2FhFPM55tHgmbgNpV0kyvtBW4Xz51KQbC1Yyz5ZjrBceqAo8Mqt9aAl4MYqHog
 SboMzALCxmCUq34oHOS7ewaT2OyudWicS1Se4QVq+laYBUApCq7OOvWe0NlBYxh5wyCV8/8Z3g3
 irfD8JaYz4OZc36aLKenw4uUGnUFYQy5g6pu8YVoa1OeNOrGEZxv+pJ9/8x/AGwlmHyr6TElMxr
 nVvldAuixmSVCR04ou4HkLNpkSr0ZcqlxCEH6B3PUuasQX7mXXwUIV+oYDBkxleLPQ1TfXLcg5C
 5jqNxmKxudRwlQnMkohcXhTWevA5QWSvTIUhIYTuRIjWVMSnS8YA+FGc7Ko00PV1p43haVqDb2r
 LFNaMG92X6vTXWk8mZw==
X-Proofpoint-GUID: 5tZIYT_DNj44XhirUQ5bjIigBtuYCQK2
X-Authority-Analysis: v=2.4 cv=KfnfcAYD c=1 sm=1 tr=0 ts=695c744c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=XPMivCli0LKV4eIUGI8A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060020

On Tue, 6 Jan 2026 at 04:21, Shuai Zhang <shuai.zhang@oss.qualcomm.com> wro=
te:
>
> Hi Dmitry
>
> On 1/6/2026 10:16 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 06, 2026 at 10:07:37AM +0800, Shuai Zhang wrote:
> >> Move WCN7850 workaround to the caller
> > Why have you lost the second patch?
>
>
> I thought the second one had already been reviewed, so I didn=E2=80=99t n=
eed to
> submit it.
>
> Do I need to submit a new version that includes both patches?

How else would it be merged if it is not submitted in the latest
version of the series?
Have you read Documentation/process/ ? Especially submitting-patches.rst?


--=20
With best wishes
Dmitry
