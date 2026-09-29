Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1708225403
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676212; cv=pass; b=KbGbhZBVORE+47VtjfrfBSNtfMw8TanNloBJBYEotxpN0UuLSE7nH6O+fYKEPcRd8m/GHoslsLTpj4IHoV07+RYDQxeBllIEmVR3Zq0UZRoiONb9/H4rIkGkhTh4XJclMIJ7j2lEDd0QnuDkPYbKOgJGrlwZZsfCx9w7bmhqYq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676212; c=relaxed/simple;
	bh=428tXCbvtfrk+2zlh0uwJkqz4i0sMFragXvVb9rwGLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyaYX9XFnDZ2Q0GzA9orPKZPntZUQwgGRQXI4L/eABjRhbQAjkOAg7vNjrVum0/wBMwf7FVZZvNxEHm+T6H2l+TCEU/iCoFB+jgtG0BA+no+QkvjnbVj7i3DZe7ejI6g6UxYIyMtQytijb9zd1GLH34wOG1ezsvgCvfbyd07CHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRRIX5+w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XXIQ3xzp; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRRIX5+w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXIQ3xzp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TncW2570904
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NmhBYMIxyetX32o034YORWUFSNbgOUrruLgW7i9+vds=; b=WRRIX5+wX7JM4mWz
	/tShCvtr9UJWqMeykDUccHF6LMsQpbqWmaVY12gZj/uEzZtP2j0opy2dRARb7xGA
	Fo0ktIRt7YSHn/D6MjrZon8SnLkUJ/AstmOal1R+1+OeTNTCCi39evHFEkl9CbK2
	4RdnU9cMBMhmjqNzUbe6n+yIpNLNhSJI3W0kRAxxbRH+iz2r6nI3Dcv0g0yodmZl
	inAmX/2fOHsCv27Y6V99QtXHabEaF3WKabjsWsDpn9N8OwfTOjudVGJkjsTN3uU5
	uiRikW+Z07x6qwiRk7WFxz9pCZujAdfqgjMWkvpwaWloN5YdoVVAIT6cR/1rVYyO
	uFXdBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mna353-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:03:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so846620485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 03:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790676205; cv=none;
        d=google.com; s=arc-20260327;
        b=DceA48PYmN4ab6hN0WzrU/2AhcJIy2bBg54jm9Uuub8sw6BAPWAXQLY/VA+Qb23puV
         bRSh2VBRneOvlK9C9TwC2rylk7+rDifCuVCATII8TxRwtiwGhQn4AAPhW5sOssH6Q+oq
         DLg1JT5ag9u8Ni2aLw53KsovwL65JfZ6v3D6bDATsxbmhjYL+VdLlKDYcGz8hdqyS/GS
         AT+FPqnUW4dNg49zcWH3gzVLkCT6n/tUFBh4/gZcBAQsNo+Q7MOTJC921dMo2o17Km87
         AirVITL3PQXEZDFH3tx0+H/1ElyL3WZfPFEl8qBp0tOtDiRo7nPNlai1syEr4HV1wr0h
         Aj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmhBYMIxyetX32o034YORWUFSNbgOUrruLgW7i9+vds=;
        fh=be7kvf1QRtprg8y6ynxrEzYF8NRxHBFhkSdVT0lISKY=;
        b=OHeUk+Tw8d6noJsT26SVS6O75UPO7shu4Uot37lNkoOtivgmANfCeALXWM2mRHhLDq
         2pDUP/QrtBrX5B8QXicBRPSp5S6kfF50SkOBfFnunsIywcfCQyzI4/BMEQih6tiLugGE
         wK8PMuGx+u1zQwFxrQQItjTN3xp3WKRHoXRuJt9ph0Dn4JKN9o2aOKq82F9L2X874Veu
         RL3auQhPf9P+sB59NycVY4k9/NkvAbbe9hW4icmkoVyc0UVK1IADC+hbEY5aKsSZs2B8
         Yp3NsgOgoeszlGidN+L5qyOXnFv9VILPAAaNkvdhwIIT2hyWrghpaMmBtiL1G9K1UAK8
         ejYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790676205; x=1791281005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmhBYMIxyetX32o034YORWUFSNbgOUrruLgW7i9+vds=;
        b=XXIQ3xzpCLCifScGQY/i4EzKS9Xo0Ff9FyJuZohg0ayu/OjBmSjYA5G4VfM+l73Mkp
         Ufs+X/5p5Y59t711G29B/dnfCa5CFuSJekUtgvaMlZNUQG6LCwwe6V8UUR6gmYY5shaN
         m2TaEX7AR60fi0MbAcNkmuy3VBg+FEbwNKgVJO70MgsoODXYaVG6WjRqS7TpOMAEjYO4
         vkxvxEQjpmcYY53Wht+Kwn8VtdIGofQHLQwN4SlilvazUIKRSFZxU42Rzt9DlcgyvMFv
         gsenduSDHM6m9l2tuv46S6gww+8DWSkLVHx/qluFpsi0ERL+V+VYtquA0R0iAnCFM3Fy
         bALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676205; x=1791281005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmhBYMIxyetX32o034YORWUFSNbgOUrruLgW7i9+vds=;
        b=RWEzfMpSGFg2KTZRFgT4ZnHNu11/YndVTxrM3sye4GBgFxsSfMQ1OzKgU2FSK82FyD
         mvICugfQd0lokp0Ldb3Pnf4ZeRUhYCi/tHAG1In2HfJJQSD10u/yOR1j8DKcUGWzccpY
         biHbs5/oC3yS8YB0wzlA0vzbD3Iy7qfA2ACzQV8/3iRiijXWlJ32zUvzbuauOWGN9eE2
         plZO5qFJJq/SR0+g5xYrVnQfPB33qJwPZKgdjezkID7r01fOplBE3LSF0XTS71iU3WtC
         QPz3LXtl8waiTOKcLKzlBJH6b4T8Pi3vb24LvRsP2+aE9q/WMu0aVg5+83ktfT5P73uv
         T75A==
X-Forwarded-Encrypted: i=1; AKwUvBx/uypGiOMcXrFs08sakc7CPITR7LJ+aIPwmYBl3Xz5MFshbOK1moSC/KlezytGMXekgUUCAW6tBHHF/8SN+Wc=@vger.kernel.org
X-Gm-Message-State: AFuF++ktQcsxaMhnv1M9+cCcWxlqhKDeLKo9vSrpNXBQa0IvCtEPb1cM
	6MJDvQwKy1Y+b30xsN5A9T+nBoipZ1xpT+1cSU8xGxpCPFfvoNJ7VE1EGI+CaYdUgMbBC82fu4v
	4OL4B+MhvB6INdHUXcd59iFD9h09l5MrTuVENTH25A1IGGNWDmnFjpRA6AouSMHQkaJWEgNW0zC
	pAue1ZUxShh3x7ifdIW/pA2pbuf34srK52x2GoH73u92k5tA==
X-Gm-Gg: AYBFou0g3k4bixLJwKTFfAxpYJEG2gdTGZ/IomOTC7O9s0fS9pboTmxa3qbKVYqsz0B
	FaKs9mfwxEXnzCFFTQsxw6tOn3WvUbAoAFG9LZ1iiLep/3TRIUa9opqC4mN10koYy8XjqaL5fcL
	rTgk5IQj++ahrZF6OsboXxznyQ1Os4rnraIOAxw72zvh4JL/O+a8VNaBLQrT7iuwAXye+MJHDF9
	8Y/VXKYwex29DuOeUlguSXh9D9xhzuvlDvMNY9u8BDLHi0AAZ81Lbkjar2zp8WviJ+VjEimJ0rg
X-Received: by 2002:a05:620a:1724:b0:93c:2110:14e1 with SMTP id af79cd13be357-93c43cd61a7mr2588125385a.42.1790676204587;
        Tue, 29 Sep 2026 03:03:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1724:b0:93c:2110:14e1 with SMTP id
 af79cd13be357-93c43cd61a7mr2588119585a.42.1790676204086; Tue, 29 Sep 2026
 03:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-bt-wcn-clk-enable-v1-0-30bee88c4de4@oss.qualcomm.com> <20260925-bt-wcn-clk-enable-v1-1-30bee88c4de4@oss.qualcomm.com>
In-Reply-To: <20260925-bt-wcn-clk-enable-v1-1-30bee88c4de4@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:03:13 +0200
X-Gm-Features: AclHuK8hrus5ifIhd0kBrHEFVRgKNmcLi6GGy2VwQ0rTLUBWrWRbn9i9ZtKBjZc
Message-ID: <CAFEp6-1J_nnD1OY=GBET19p9+j28n9LFmt5CgoiyWr7FVSmOFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_qca: Add WCN clock management for
 pwrseq-based power path
To: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb8ced cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=k-oZKQUuCPdrsXQy0KMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: tZHPWxlbxPT8PEcv8V-3L_R5Y35FJNpb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX/DkBfmE+bc7H
 H6FpFF/ImJmig75ZB9jRy+no1ZsOYWqGLsFFWxyjvMDBaUDNCzaZTv0Tu7lOfvMkxhKuYZ0rjFg
 OZVN5JzOpXWB3xZbUi8M5hfCNSGO1Aw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX4vRVJaDJoyXB
 Yrr1/kcBHk4IcxT1KpoSRFiRdI+dwI/WuEqIyg0Kx2BgykIh2YDKmFmTTF3jXvzaLU/P96g3UgT
 YW0dauuur26cmHU3DojLkSkLZL6BTYqRJ4xsa2Q3tSBZwMXNoenxFXn9qkA85WUUKoMY+CBFQOC
 ik6BatwEkSKXYPjtvnG3V1u2ocBEuIs1IOL7P4btwvX0sewy8fixa4ZxxShm0iyn+51d8RlrTIZ
 jE098wB6QxoaPE01LR3Msj04qehQw+nXPe91CebO7csPJ9v7t766nJOrdUFTa4bQAW0WCbfiHgm
 QkLUbHOdXbGopCAxkcENHaG4PTURhpQXH7uQ2KGwNBomb5IhHPFGKmQwe5KKDvZMEEp36wdnCPm
 CCXcqayPpOcHV7tAPDRIwAy7GkZr6ylZA8I/0tAvRpo90+GgoEHtqa0wbXfbScMUDUp1S8fSMN/
 rOjYyTpqt+7hPbM7pcA==
X-Proofpoint-ORIG-GUID: tZHPWxlbxPT8PEcv8V-3L_R5Y35FJNpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290039

On Fri, Sep 25, 2026 at 8:21=E2=80=AFAM Yepuri Siddu
<yepuri.siddu@oss.qualcomm.com> wrote:
>
> RPMCC previously kept WCN clocks enabled via proxy votes, so the pwrseq
> power path in hci_qca did not need to explicitly manage the clock.
> With proxy vote removal, each consumer must explicitly enable and disable
> its required clocks.
>
> Extend the pwrseq-based power path to acquire and manage an optional
> WCN clock. In qca_serdev_probe(), acquire the clock using
> devm_clk_get_optional(). In qca_regulator_enable(), enable the clock
> after a successful pwrseq_enable() with proper rollback on failure.
> In qca_power_off(), disable the clock before pwrseq_disable().
>
> Targets that do not define a clock in DTS are unaffected since
> devm_clk_get_optional() returns NULL and all clock operations are
> guarded accordingly.
>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7089e9b639b2..489a059e519a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2265,6 +2265,8 @@ static void qca_power_off(struct hci_uart *hu)
>         }
>
>         if (power && power->pwrseq) {
> +               if (qcadev->susclk)
> +                       clk_disable_unprepare(qcadev->susclk);
>                 pwrseq_disable(power->pwrseq);
>                 set_bit(QCA_BT_OFF, &qca->flags);
>                 return;
> @@ -2324,8 +2326,17 @@ static int qca_regulator_enable(struct qca_serdev =
*qcadev)
>         struct qca_power *power =3D qcadev->bt_power;
>         int ret;
>
> -       if (power->pwrseq)
> -               return pwrseq_enable(power->pwrseq);
> +       if (power->pwrseq) {
> +               ret =3D pwrseq_enable(power->pwrseq);
> +               if (ret)
> +                       return ret;
> +               if (qcadev->susclk) {
> +                       ret =3D clk_prepare_enable(qcadev->susclk);

Why is susclk guarded by the pwrseq? They seem unrelated to me.

> +                       if (ret)
> +                               pwrseq_disable(power->pwrseq);
> +               }
> +               return ret;
> +       }
>
>         /* Already enabled */
>         if (power->vregs_on)
> @@ -2472,8 +2483,14 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>                          */
>                         if (IS_ERR(qcadev->bt_power->pwrseq))
>                                 qcadev->bt_power->pwrseq =3D NULL;
> -                       else
> +                       else {
> +                               qcadev->susclk =3D devm_clk_get_optional(=
&serdev->dev, NULL);
> +                               if (IS_ERR(qcadev->susclk)) {
> +                                       dev_err(&serdev->dev, "failed to =
acquire clk\n");
> +                                       return PTR_ERR(qcadev->susclk);
> +                               }
>                                 break;
> +                       }
>                 }
>
>                 qcadev->bt_power->dev =3D &serdev->dev;
>
> --
> 2.34.1
>
>
