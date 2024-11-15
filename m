Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1E1D54EE;
	Fri, 15 Nov 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688856; cv=none; b=dhceJw0ZAHF4eZt9WKxRKVtXL3bH+1h/9cje/7Wj681QEK6DXYX+2F66vlpzGjKQWM3EaxIseKPBnVW/PefhtUVZBlQJSaEwnky16hMliaiRHqpC8GqldN0Y84ZFEhhy+D0Zd/mgKLpV32kbdMgtbDMgjJB/qtXA8BGmdCOkY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688856; c=relaxed/simple;
	bh=E5iRXdzyicHiAPnJsHv4IUWYR3Ho3H41AOg7TUPVqXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iecL8EN4zB31cx/ogr2AYQQo5mhJOmSznkGYgPUwNC0Abks/j1MXswonc6EnFt8wSdWSSAvYnnLnHcqEZyyxntfop1VCVCnw3RCIl2yvUyl+mdILri0TyDxsURJeHygdf2eqD1s0CI1eg8RD8nc+H5sAOKIPd67BD0iNhCnUuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1oc5JNk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1oc5JNk"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso7488811fa.1;
        Fri, 15 Nov 2024 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688853; x=1732293653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWM1zhBUaIEICsvvUOeD60alRnVicILRnIGqkspauLA=;
        b=I1oc5JNkYusY7EgB5KkhCj5Jqlse7V7N8yAbKNXr/JwcHgF9f06aXudr5QlsuYsYdn
         GmaJ9y01GV8xMLeWPczq9NMNXBmft7uPqaNb1rHLoDJPf33iXZpyNduF5YavJjaI6kGa
         r/rdgcVrRpv9NKwNZ+AU9H+W6b9roGkVeTfAQIUiYs2Eoi4S8K+9iN9DU+mfo7RQJ0MB
         JJCzN9hX+JNlA3VF62NSuQW0vbbMmb+Rcg+umuXgfjZeZkOGKrw1rcIH8s/3upThWxjQ
         V2KLBYDazmZAZc8dQ4i0FUwqznnYz2/rP16ajODUGmDhA3bh0PI15TIpDWSUOw5oxtDo
         +nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688853; x=1732293653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWM1zhBUaIEICsvvUOeD60alRnVicILRnIGqkspauLA=;
        b=YROBGBi0nY21H6HjtwOFAuIyMj4BbOr4sssyHtF/B2SIs52JUPOPLBHj0J5a+MzgK+
         kw3096S056mYZeSwLutUsKQzveUGEeyvIruAB8oE14D/beVinh5OlfxP3ZYDf33vpixp
         bmzXS/58KkYPcTm9yaowAl8T/Xc0gawsogNm61HFpYTGJG+RMDPaiGcUF2qv6DqXszVO
         /t4R+HA4G/dA6+bshYYUtf4qTrxIvCQVQmBCgaSiEeuFb19FvMLwFlycwpwascedvcIP
         LjK4CRppTnkftMqc87DpqOzC2Rf7G29nS75TcL/76pRlDpfKFnGG+O/mB8m7mN6Q9HAY
         ZiRg==
X-Forwarded-Encrypted: i=1; AJvYcCUDGkjUWqwAYUzqemJqyWYhBm/4O20DPt8ZNNaZQSx0R1Ruv1JkVta2eIECBQT8x5p2ZuZ2wRukljmDCUH+@vger.kernel.org, AJvYcCVUzCEL7bCS3/AwcgVtPT6V0+6noDe2zHkhOoE5OlGRr3deKaS6N6+j9N/obqZKKxshNIfAfj16PcNpU324h94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlc8Nz+56Y1Dc61w87z2fAXZy1a0MU9PZP/gm8SWnW62x0pIgL
	58cEy5nrshFz1pIPgw6OVbu9Gth5mrsIBJ5daCDfHNqVAtc8qCArxCWn9qslYmzUmCyfGCIEJuC
	8Ms3inBxKhiQuZDxAf2TdV/DrmTc=
X-Google-Smtp-Source: AGHT+IEfHFXTrkX4iU2zxXCc93wTO6nasnQ1J9wNeeFUeckOF1/IPATFBdPtOSE1zu0AQdyczMDScHT12VmyJrYxFB4=
X-Received: by 2002:a05:651c:400a:b0:2ff:6298:ecc0 with SMTP id
 38308e7fff4ca-2ff6298ed90mr9510421fa.18.1731688851618; Fri, 15 Nov 2024
 08:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
In-Reply-To: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Nov 2024 11:40:39 -0500
Message-ID: <CABBYNZJQGCnsKtdKaByLJkgV715oOorOQLLK8Z+g1BYz9YovNQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <bjorande@quicinc.com>, "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>, 
	Cheng Jiang <quic_chejiang@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Nov 14, 2024 at 1:27=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Download board id specific NVM instead of default for WCN6855 if board
> id is available, and that is required by Lenovo ThinkPad X13s.
>
> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

How about adding the following:

Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI
Bluetooth chip wcn6855")

Not sure if this would be simple to backport given that there are
things like 691d54d0f7cb ("Bluetooth: qca: use switch case for soc
type behavior") that may have to be backported as well.

> ---
>  drivers/bluetooth/btqca.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac92242a..4f8576cbbab9 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname, =
size_t max_size,
>                 snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, =
variant, bid);
>  }
>
> +static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
> +                                        struct qca_btsoc_version ver,
> +                                        u8 rom_ver, u16 bid)
> +{
> +       const char *variant;
> +
> +       /* hsp gf chip */
> +       if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) =3D=3D QCA_HS=
P_GF_SOC_ID)
> +               variant =3D "g";
> +       else
> +               variant =3D "";
> +
> +       if (bid =3D=3D 0x0)
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.bin",
> +                        rom_ver, variant);
> +       else if (bid & 0xff00)
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.b%x",
> +                        rom_ver, variant, bid);
> +       else
> +               snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%=
s.b%02x",
> +                        rom_ver, variant, bid);
> +}
> +
>  static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
>                                             const char *stem, u8 rom_ver,=
 u16 bid)
>  {
> @@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t bau=
drate,
>         /* Give the controller some time to get ready to receive the NVM =
*/
>         msleep(10);
>
> -       if (soc_type =3D=3D QCA_QCA2066 || soc_type =3D=3D QCA_WCN7850)
> +       switch (soc_type) {
> +       case QCA_QCA2066:
> +       case QCA_WCN6855:
> +       case QCA_WCN7850:
>                 qca_read_fw_board_id(hdev, &boardid);
> +               break;
> +       default:
> +               break;
> +       }
>
>         /* Download NVM configuration */
>         config.type =3D TLV_TYPE_NVM;
> @@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>                                  "qca/msnv%02x.bin", rom_ver);
>                         break;
>                 case QCA_WCN6855:
> -                       snprintf(config.fwname, sizeof(config.fwname),
> -                                "qca/hpnv%02x.bin", rom_ver);
> +                       qca_get_hsp_nvm_name_generic(&config, ver, rom_ve=
r, boardid);
>                         break;
>                 case QCA_WCN7850:
>                         qca_get_nvm_name_generic(&config, "hmt", rom_ver,=
 boardid);
>
> ---
> base-commit: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
> change-id: 20241113-x13s_wcn6855_fix-53c573ff7878
>
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
>


--=20
Luiz Augusto von Dentz
