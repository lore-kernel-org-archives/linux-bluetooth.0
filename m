Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE672E7380
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216767; cv=pass; b=EBdmz0ifkYKR9upELJkVudMcOon51XbhJM4Z+pOmDvgdqVxVgRd4qa7hK1Es756lagn8afgewSGdClkC7lkoG0Dz8sjU490UqOY58ZtncfRfdfBjRt4DW76yJDkISoUVCgSLUWodFOLc+Bnd5BhxV43oyh3ZZya8l7V2FrY3mT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216767; c=relaxed/simple;
	bh=OZGEF2emtiuHK15ItQmuCRN8wNze8eKQC2CdaVRwh64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdsddoTNqZ/NWf5TRjtTej1WSG9BXAok6gbRFq2J3E3j3XsjFVv46gfs5T/TDExAKDsD8rMHziKSA5CPiTMhzqFbOEMsvL72ozYf72RBSZAyiJvp7UH7RsIGd7ZirKqQDUKjAZoB1ayLkWU/g7MYdWKPTr/G1XeS9a7UBnbocMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUIZhSGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRvQ2WxC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUIZhSGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRvQ2WxC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKPSO2960024
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=; b=FUIZhSGNkDxiCWaM
	EJ4RUB+hfB3tOgb+1kGgQVAJciKke+hEDM0FAnLlSi604B7ccKMnjFzupW5BCQab
	kstEbZHlMgNve9ly7m0kJnB4BpvgGOM4/sy12A/WqD0p10vinVPTIKFpY0vIOTC2
	NNdR+61+OvOMn3+QBoT+H9BINQVb0XamqAC34pdHE3AFahRMBiFirPNEkorHQTV5
	gxev50CWP3yN6TgIe9P7K8TSx/UQJtxxmRNsTnsUN2LDvbAwck4pMrCVQ39uouUs
	HdKktWI4LE4c//gRH1ZfLunyhw5hJoIsfomNKXLpqjXRddb4OgTOjnMxMdiRCv2s
	CnENJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym18trq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:46:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bec738909so58313951cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216764; cv=none;
        d=google.com; s=arc-20260327;
        b=SRKqtiw5UjupSvjjBlbub6aW4WxFebNRhXJFlSVQVnN7XYAIbGoWI65HsA10briDaC
         oFUFAwTRh3m7Xl2nPPYlAV2HnnrPt2vG4y0+dPt+fgsiATL+DRa4PzArCYB5JxdZr3Mz
         mph9Tk3uw/6vq16GcmzQBtmnKdDMJJkbo9kP6SKeJkcaYapIb0O3k3Un4Ql10xRk2gkI
         iRvc4+KkkWBkeMHJKDDEbbAOc+McTwoNENBd+495zKn+1GQDVFV7tw6Ad89H+5KoPCcT
         R6xYoUnpIkDdjfGiizKaYBZ29wEMisga9qxxLTFrniJdVEeAbfvdUGJOTWviqgrmrrVU
         U/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        fh=61OeLD3Sx6TAHpN5t9LChRk0TTA5yjT+PggN1j1GVxw=;
        b=YvKMnjn1yhw2yHkRrDO8b+JqIuoVx0iMBHHdW+xfveY9ilDb6OZIvlglJeoqkE+ndG
         UAF+xQPvk1J+MvqhWnF1/Y8ajbbaH4fLp39JUoz3GoN7oX/LHXlsmNllOFBoRDYnVxpD
         E417p2gR/LF04nuWUEjXwbo5jk+eph8013y5wHpslwltrzziCbXeFF4LjZ1M9U8JE6a0
         zcekTj5lN1tcbaw7lXCjhabNr+beO6cts3kfWcVqiVUG28j9FwCl/dhgINYsxL5TlDVj
         9AlMOdfqEzM4Rxv0Y4YZGoSIrqvufgOVVsbVGdn+D3UbSzKalXPbE80bVFdjBk4P7lKR
         StlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784216764; x=1784821564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        b=WRvQ2WxCnJYcQTKl8IUdBrcKrMQZ03DOrh2vYolxHatvLVU82Ww/qqfsBRjVD0CLr2
         hu7MU5mwPEHU6/iky/XU282otJ3zC5wIIbWll4hzNTlTWo4mC/D2zPsooRboADRww04S
         WutMdqy1RaAgZRqj2QxPLWtBL990ZCGcvi3PzY7Q0BGR/sYEt2MRudvoKndKIJa2KsEs
         Q5841MTw/ctwiyxUb+Gd5drUA6qmfr+Yfhc/vfRYwjnYx21Mcw3uZbEuX1FVzcFF9K6x
         koQ/V7PGt0N5UvRrl8IVUWGKCmWB5olS37avSyZ3dS2D8siUSXN3zkwwcQMV6gdJQ+FV
         uyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216764; x=1784821564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        b=bepQ7aOQcs4Us2yrpr6mXvBhWWor9w6DdbflQxNEEuS0hzNO/FlnfDbNP/zMKYZ1I/
         94EoMKQYHdXbfXDZ4kAlqG5RKPlPEFJ9NGO17h0HhOOLHIdYk0Sx/oBZ6AzkscX9RiN+
         HrHHjKx2OHxz+5Nx7bcg5jH2SqXNxTOlpYTm9kIOBFba2pNwyViRIyHtGhyXhoWy0a0+
         aKJTSWbevRj6pg/S1vLq2U3XsnYSJR/y+TW5Nv7Sz+QFvkrueMEuQHqigUdpGbZPKt1r
         R55z4lbyExOt+wKJL91BNs6TldvD3nWgPmOwtDpA4VvF5cjd0Tch+Y3h0lPY+SGbInuR
         PnoA==
X-Forwarded-Encrypted: i=1; AHgh+RqxO5QGJTS56eREd2dSbhht27p3240WrVnvy92omA/A+LN8j1ucJIOuNmYSv3ZD2FqW1vpF2JPyCC/OOvmXuB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYYC3pucarefhy+zCH4elvxLeLG9bmhJhClgFT7j7bYBGRv8t
	q0zG//Gi55YrTlDwCJk7++E5sWTPbGeLfJ9BONKJ4C1fuOztyyhsoFzAvQbirx3TBQcysDVJ/VN
	FyPgiLhp0CM/2nESdsNFb3OWZr433zDg6N3WAPxsBaSK0V8E+2R6oeN1QMSJ+nIJa05dX9uETeZ
	6jWc4Wd3GBzYs54Cqah8TPX0I+koFsq2v+t/oAAC1yzNs1Ug==
X-Gm-Gg: AfdE7cmE/X32CeyJ3E/1FAMvmvfsq2zcjht5SIhdH+9UDCgEdnd3gVi/cnbIEm1cxVn
	RPY4X8PREyFqLdJmWFY2oRdtjTTsjb20RQS42eBcfEviLRIwwFGoE3GFUJ2OKQD1E2U/SyYA1wc
	Q+fiTcLADsY5LMKWqEeKWGjaK9UVMFMf91DvxNSvj/65Mvh7HNQoU5x4/OiVKmu8u+eYCJJuTbb
	zud16Zwlyn1QEBx5C1EqvUaUvMkFMiV4/X4Og2eefG2PXzXOVm4NmC7yZR+xTeQiexxkUBWXWUT
X-Received: by 2002:ac8:574c:0:b0:51b:f549:c706 with SMTP id d75a77b69052e-51e423528d7mr115570941cf.16.1784216764068;
        Thu, 16 Jul 2026 08:46:04 -0700 (PDT)
X-Received: by 2002:ac8:574c:0:b0:51b:f549:c706 with SMTP id
 d75a77b69052e-51e423528d7mr115570511cf.16.1784216763565; Thu, 16 Jul 2026
 08:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-4-46253587af64@oss.qualcomm.com> <txl2wo47ftsaqwh32x63kmhqwqjx5xpszoazccyeqdqmjzh2rv@ocev6u7vzdiq>
In-Reply-To: <txl2wo47ftsaqwh32x63kmhqwqjx5xpszoazccyeqdqmjzh2rv@ocev6u7vzdiq>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:45:51 +0200
X-Gm-Features: AUfX_mz-fKvzynmtc1c_-d4E51SyY4cnAP-WK134FPMEMzbs42O_5YCHtKpJhKI
Message-ID: <CAFEp6-02kqoDvvGSYy+2uM-gzvhrH3OTUGaxu32pEfj=kOVHPg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] power: sequencing: pcie-m2: Report power controllability
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a58fcbc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4upAz5BH4U1jwP5PTYsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX+v0dMDIeJzt3
 lyKd90EO+LklFGoHbodismOyH43xG+HmmXxCZlHvlrGK8XjVSVtJe36BrJefUGnqKTvHMK5MekW
 ODvnkaKZ5tWYj2X95fDmT8RKdUhAjDGzmxGRf6Rll4P9iu1IuHkFXj/4EcUpBINamCyb1/YwUbW
 LiqAHp7H5IrWk/FECWO1NWEPTvZNUArXdWFagdA4LNTrv6Oyu7JiLPJOWswQF89TSXPGxEh4Gcx
 hP5rh6RznOHIWU2MAasfzeJ6PvAS1Xg7sL23JFU49CrWYk5d40rHk+07asZKblx24c+y19FyWTj
 /S4g41p4vxVW8StKKURJ4PpB2aLOOP6cwZQuOl1a0h85Q1AUWSwi4JgYwDkZ0m7Y02mdBsKN6tz
 U0npcyTfhtRbbL/0dy0EtSpZXxD+JWukOqCqm7UitNjIb6zPczVvfXA51FGEtZo0XmvW3/5syzn
 InYFS1+HOLbq98dfmJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX0j55MCWExn0O
 62t4ib/xkapAPKwm3lmQ/0LsfeHzhHgdCbSkOeKSdv1XOYyVF0mxnAvmLld6r6KCoHhal4+CaJK
 Jb+8XtPO+kbd0EiF2e6Xkkx0e72Kr4E=
X-Proofpoint-GUID: aPJryss4zTGLQX5Ts6CRKPhE355ezZOJ
X-Proofpoint-ORIG-GUID: aPJryss4zTGLQX5Ts6CRKPhE355ezZOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160161

On Thu, Jul 16, 2026 at 4:27=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 11:57:30AM +0200, Loic Poulain wrote:
> > The M.2 Key E connector gates its functions through the W_DISABLE1#
> > (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals. When a signal is not
> > routed to a host GPIO, the corresponding enable/disable callbacks are
> > no-ops, so the host cannot gate that function's power on its own.
> >
>
> I think it is misleading to say that if W_DISABLE{1/2}# signals are not
> available then we cannot control the function's power. Power to the funct=
ion
> only comes from the core 3.3v regulator, and these signals only enable/di=
sable
> the radio (WLAN/BT) as per the spec.

Yes, though in reality vendors often use it as a reset/power-enable
for the functions, not only for their RF part, effectively powering
off the Bluetooth or WiFi subsystem (and the spec says that when the
Bluetooth radio is disabled it may reset the Bluetooth feature). I
guess that is why it's part of pwrseq in the first place. But right,
here the control isn't fine-grained enough to gate the Bluetooth and
WiFi functions independently, but power/3v3 can still be powered-off
as a whole when controllable.

Also, in pwrseq the targets are named 'pcie' and 'uart', but per spec
I think they should really be 'wifi' and 'bluetooth', especially as
Bluetooth can also be connected over USB while still controlled via
the same W_DISABLE2# pin, though we don't handle that case yet. But
that's another story.

Regards,
Loic



>
> - Mani
>
> > Implement the per-unit .is_controllable() callback on the "uart-enable"
> > and "pcie-enable" units so that consumers can query this per instance
> > (based on the runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) vi=
a
> > pwrseq_power_is_controllable().
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 26 +++++++++++++++++++++++=
+++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/=
sequencing/pwrseq-pcie-m2.c
> > index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..4bcd5078609da1be966ab30=
c73cffae5e578934f 100644
> > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -84,11 +84,24 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrs=
eq_device *pwrseq)
> >       return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
> >  }
> >
> > +static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device =
*pwrseq)
> > +{
> > +     struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> > +
> > +     /*
> > +      * The UART enable is driven through the W_DISABLE2# line. When i=
t is not
> > +      * wired up on this connector the enable/disable callbacks are no=
-ops, so
> > +      * the host cannot gate the Bluetooth function on its own.
> > +      */
> > +     return !!ctx->w_disable2_gpio;
> > +}
> > +
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data =
=3D {
> >       .name =3D "uart-enable",
> >       .deps =3D pwrseq_pcie_m2_unit_deps,
> >       .enable =3D pwrseq_pci_m2_e_uart_enable,
> >       .disable =3D pwrseq_pci_m2_e_uart_disable,
> > +     .is_controllable =3D pwrseq_pci_m2_e_uart_is_controllable,
> >  };
> >
> >  static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
> > @@ -105,11 +118,24 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pw=
rseq_device *pwrseq)
> >       return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
> >  }
> >
> > +static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device =
*pwrseq)
> > +{
> > +     struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> > +
> > +     /*
> > +      * The PCIe/WiFi enable is driven through the W_DISABLE1# line. W=
hen it
> > +      * is not wired up on this connector the enable/disable callbacks=
 are
> > +      * no-ops, so the host cannot gate the PCIe/WiFi function on its =
own.
> > +      */
> > +     return !!ctx->w_disable1_gpio;
> > +}
> > +
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data =
=3D {
> >       .name =3D "pcie-enable",
> >       .deps =3D pwrseq_pcie_m2_unit_deps,
> >       .enable =3D pwrseq_pci_m2_e_pcie_enable,
> >       .disable =3D pwrseq_pci_m2_e_pcie_disable,
> > +     .is_controllable =3D pwrseq_pci_m2_e_pcie_is_controllable,
> >  };
> >
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data =
=3D {
> >
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
