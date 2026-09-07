Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389884B8DF2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785462; cv=pass; b=b0oK0WD41qOCM0CqZOO9YX+bzg2nFfUOZqQf/vCEHV47mKqoYzvR335BPz+HQa0+YXyke8P+xSi9i7bpP/M+SvE09g/fmLwE2ZmDHT/HF7nY3HlBrCo5D44iZBVD6TDC7iy5t+0V0IbzDxdb8zUB4tj2OwWGhE2T/WUhfN9HUKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785462; c=relaxed/simple;
	bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLaZtmoxr+9gMywHxMkB7Sz7E3xDWOFqnATadTrNRIXSQ2KVa6wGoLAreXDBZDAtSlklr3DUrmX3uvQwV1EoQRq+hY2SkBpeoI+JZjpVRA0Tn9OYhlvFd9v4BZjhDN+Fz+KKTr+Wf+HCPRIAiG83C0x2lb48Igo5enFnAWhjSxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U04jKatk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7S/LEd5; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U04jKatk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7S/LEd5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnAU64064255
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 12:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=; b=U04jKatkX5/Of0Lk
	NmSq95IrJaz5jcdpR2S3y2CdjZZrtZ5yoWV23Nl9G6UoLVXFr5aJFDMsoJi9WX0I
	nscIDNxtlNflYhFNPAXMWADWfbhGH4jyE+UTB9K4qxcPXD49SSYVfWcrjguxeEIT
	5YxVZHRqY0IiHKiufD+oEu3sQ692rdNZR0iwB2iLAudyyGRUXah+yzW/eGC/j5GV
	OpNpHAZsAMwSdDV1TDRFnU/WVuXH2wSDuQRWd50xY5EagiCkjIaZj703b4cFmVsP
	v0sXaSQuO7cUCRLl/3/CJmTrcuN6JvGiwTM4bqVg0Ec4ccJogB1oAkJj0fPshJKx
	ZHO2kA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86s8bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 12:50:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so90002246d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788785458; cv=none;
        d=google.com; s=arc-20260327;
        b=mTkR/cDe2iML2chOQrRBQDNizhAQnSx2HmMFPSh7mnsWVM6YWtYPCobtR8ySYXYa+C
         HAjBvasIZZQnhpsXkbb1Nnowz4XV6I/yy7hEuMcCHIexpP3ZrRUg5kF1gaTSoXJd/ZAV
         2V+wMadnks3/FFMYL/mAugVqGEZNDR+2bXEUCFoohLQarfSeHMnFINEdVSS7lXkgsbZo
         ZiEA6ubH3AaYJI4V0dhjvhU4os3So7/4Y7G2H92Hua/Elaq23zPvxJzNjSgIZ0/zahNT
         vBVaqJyzM+Rsu7798GcGW/VDttT8uPYMCeJgfWmGlZRLksqQyXXvrYlnIEv/Yh/fe+RW
         F2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        fh=3/tjUkttApzlqEuy+uPkbFidGP2T7SWrzX6KDYnQm0s=;
        b=ozPWdQLwfxShjNrAY0PV5qFjAihQZU1OkH3AI8LHBy4CS8vz5nRGZM/rPiKyHz0Div
         kmMWR6hAiM06KJ5mNPdY1hg6K69XWuDc06qD2p9J6GRr6UAsFFGGiPgwv2QZO2xwIX8a
         bEzId3aLGuhpPKdmfToax3G6F2z2LLNVC+uE+2OGYx6v5vEerJJhlY+pRpBFPj0JbKIR
         9j6m6HMKIg6bhSwjP/ESXhR0dPSuwUqgTpl75wEf8ZK2u2f3J5qqG89QxYll7v4JOxug
         xK9bndlxGuxvqqDJ53MunoH6ybfAV8T2WttlzBknzxKG0a1mSjqjhnSTIiSDlT6KBzcO
         Ba5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788785458; x=1789390258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=D7S/LEd5tfmtAEoVBVUlbGFPQU6VKZUF6Je2YKaHzboMgG4c99XlJi2XdYmYUTlbFV
         2jcTK3II3F5K7p3rCXJWuLbI23ZM/zO4YMK1gF9S98VsFnH9njBf9UL3qWHYCDrC/iQ1
         P8KcfZ2fjjnCiuRCybfFhjBvFTifik1vvY70WK7D4A0dSmotItmcUZ2jaIxZTkqcH+cI
         ry4v9QNHbBpTXQGV1d6qic2TEaPCOCzgTIgVv1e80EnheXyqK2M+eegseltrbo8kVYvN
         yVWdPTTYKtR1xBSXGe0YDdvv6hpftT+suysydKLOpr0WFpUIcKyWHWH19noPraGnXB8j
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785458; x=1789390258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gT+Bt5eURaG5QY5OQe8D6BhKgHr/3HEhc0BcnyDPJsc=;
        b=U8CSo1SVO+TK+vKMx7YdOBhGniK/iMQ6HGTi5VNyfOO0wmXQ1wf+ALsrfpteLQGcAX
         2fZW7z2buxQlmTXh8wQ20i9BAad0cCspQN0fgh8r7s7iUpPuZH4LtSMxeKRIyAp2jyYx
         nEnTypuTOJBOHVNNQ+sPu8g/uFEXBeeQGQmivKtI3Zgo6nWnFWjwtiL1NYv8uPRZrp67
         M4TGYS6T18b1G4A6x6J8dE6t/+CDw1ZmPqLpR57OWIcwmwBisWOnWrztRwkwcc5UsvAI
         dwdtwrrWQsOkUgOneJXHW8V3zfEpfNJq6ft8ebp+hQUmGEH0D5n3ZT1QoGhX9gtrzXPZ
         5jQg==
X-Forwarded-Encrypted: i=1; AKwUvBwsB8W5zDZOrDNYA0e30BhRGKFa3p2g2sDxb1fI68Au3XypEmVIkLMGzFhsoSl8zXr40FgVm6m0S+q3Het+hx4=@vger.kernel.org
X-Gm-Message-State: AFuF++lkZjxWRp8hDhOy5g+AtVEWx/YO/Fnbox9jIkncEdCIzxxsnfyn
	0/oSd/wFeILc5G9OLl8Xv0spuWUHaNXJn/5Xc/r6o8rTGGLlWNk7wwTFf3c2fnj1w1XN5Z9IqFT
	+P/+Z/g/2sg/flDOKZz1PONCxWiEs7dQRiUc4P2oFITCF9Zi4vwPv+a4hL0C8ZYbOG84zMlHRr1
	DHJXzBarY7vkoM9L+uuX/2iNI3p2/DHALFz9gaxVujjeyfrw==
X-Gm-Gg: AYBFou36XQzj5p7mjPAlmazm51ju9x4nlPh8wLQrcHdQykyXI+526uICigi3secNHCV
	ureOqa6ZM/IEOwu4ESciBxkf7ozqqgSARJNgk90yeeZSoOVk0vLvxG+upPgzCL6v2vqhtcIQPmR
	DT64VXAsmgbl2ha+QJdyijdJoS7KIZbpuCxWY2nsv9D8w+oholQgIWjGjPSnRexKdtBi/fZhO3+
	0hPcjCwEwjiMeW3CZlupJhNbjnzZBx0MLWQiZQrFB8Xalmu8NA5cCL9MVoBdt0VcLTxoR29Kns=
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id 6a1803df08f44-9103efbc676mr253793526d6.16.1788785458367;
        Mon, 07 Sep 2026 05:50:58 -0700 (PDT)
X-Received: by 2002:ad4:5d67:0:b0:90e:84e1:8b93 with SMTP id
 6a1803df08f44-9103efbc676mr253793026d6.16.1788785457864; Mon, 07 Sep 2026
 05:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com> <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
In-Reply-To: <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:50:45 +0200
X-Gm-Features: AcwNN1Uy8Dv_z6eHdNiSSHvTLy1MMXc0Rh3LRZ3dI-XaUt9s5OrddNB4Kn5BgT8
Message-ID: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Uqkc8ApuvQ94hAi3n3_HLfm7scNtYQ5E
X-Proofpoint-ORIG-GUID: Uqkc8ApuvQ94hAi3n3_HLfm7scNtYQ5E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfX+l0Dr/For0G3
 bAZcurNNBY0FIa+ybRomV/wJJ2ppsUZA1vrMeWAAmJcMOmMbPawJ/0+WzH9W025l94d5kG9KC/a
 S/qiO3sKjjkPVPlP+HyDMDk7J1yDlnw=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9eb332 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YKo8iWYt6ehE2M1v1KUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MiBTYWx0ZWRfXwtwcrus90xML
 ghgkp9jGoydD7kwzsYDKPjhYrVp2IccFXHnBD56+zFL+EwYXmSpeHCqgFRh3tEj8yeGlXWTu2Yo
 wfevLdNPkmtalheYaKv+7DBPPoGyuHu2wDK/AQrbDqbe3zVOZ6XfayBKzowGkgXKGePykp+To1J
 vX9X6FTw2Ew/GRnaipAt1xn7e6wxNF43YxRiR5ETmj37E/WMe5rtL8o+pEybscypVr3mBl5wnFW
 x/+mibVu/slQeiJPgDttheeoSo1xVuOdRRP9oiYhhBzlY3tps11rKN99x3wbV/WfuEQYDPy15C8
 6F0nGQfkD7NY8lDIP1rDk0qoAG+j6rqbSXPh1cQK4vgfAg+THxNMrCzigwysb4pQ9TmpO9TaZog
 eZSbd0s7DCuEyIcKFUupcdhYleDDFbTjqX90yytUrFk+QcSO0A3zVctqVZVNjtnzbnVNi7IyvUw
 vILZ+fa/XExwVb155kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070142

Hi Bartosz,

On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > This series describes support for the onboard WiFi/Bluetooth module
> > present on the Arduino VENTUNO Q (monaco) platform.
> >
> > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > these pads are populated with an NFA725B module featuring the
> > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > the design is functionally compatible with the M.2 Key E.
> >
> > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > signals, as defined by the M.2 specification and handled here via
> > the pcie-m2 power sequencer.
> >
> > This series models the hardware using the existing pwrseq framework
> > and connector bindings, allowing coordinated PCIe and UART bring-up.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> What is the merge strategy? Do the pwrseq changes depend on first two blu=
etooth
> patches (I don't think so)? Can they go onto an immutable branch shared w=
ith
> the BT tree?

The pwrseq changes are only a dependency for the Bluetooth changes,
not the other way around. So yes, they can potentially go separately.

Regards,
Loic
