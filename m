Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248E216E3B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741391; cv=none; b=PFqUjwOAczpa26PiWU+oA1JxXyPV9LF7/ZLqV9hoCm3t7m0xMaweemS0683eGGF+lGX3DKRn3QuDempCfRB6BcI1GxxcatVrnWnptpm1HzVdO2MFcYDnFISEoCFWJ5HhZUJ3uoM6XTYDud5/3nO+ZUmIpmJZX3xdacCJakEa42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741391; c=relaxed/simple;
	bh=srFLrkw6jWw8U1KYljcQ/ha11DRb2uVFGA7k5nqSryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URbxx2k+s3bBjqTobwIuRwwer6b93ea4lSD/XyO8hj71J8R8yWCb2i+LShNA4xJ6z1BfR7+Qx5gF5UFsA5praidbH9UWk6njyalRkP/mJBcbm+kLzPgEJwwilElMO8iSvg5acbn2tMEr09k0KH4STiJeitKqtaPGvbqnHdCkR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxUSnF2n; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxUSnF2n"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso3102787e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741386; x=1734346186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlAR+VD/cgDE86krqRBoQlxOV64Ir3F8wLDCK/Cp2hc=;
        b=hxUSnF2nEt2j5yPUQq8KOR6+B9SwjqGSvnr574z7d9il7O0Bcupoq/YpQjCU1tXLPv
         9FzmLZ0gEYYEPMDbEnKsPOxuO4pKmNHjIsdCJD6ruShroipn+rhC5U0S8enATOv3CxCm
         ErABQSFQ6jkDwHNSlRSfyPnHCvW2Y+wSw7E0txznsiyKTtBOVAPrh0+ELyUzi7WUMNSv
         qiRPletb0AfHfUbmKvRYgmEDkMPloL2MDe/Klw+yK4a3sJD7mZBfd9XUk7m+Dphi/KOI
         KUENUp06NUCwl7xIJx2YcFlLx4FwJnVCaaqWfwaAD+niEJwqjjqKyL9AwgOmPJZi22yk
         9jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741386; x=1734346186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlAR+VD/cgDE86krqRBoQlxOV64Ir3F8wLDCK/Cp2hc=;
        b=eQ1e2NTEkzwhu5PSvg3t2QTCxypsoZ/D74tFIISv39/I41VkiZo7kH7L/ic7y7Riml
         Nj3EXIwGM1EqwPEB+R0GQl20y3sD18OiQb0lctnr21RV86EFiKKl74l9jY67fnVbF1yz
         vQzWeRYNG+q8CtUrDcUptAoL8pK4rAgmEto7rUrARbzh7fj7ehkiyFlkyiN8B+NL0sYw
         /GUNwYBOKGQGarH2i5/Sg/13hT51yOiOQh1m+PlBdbzP0KAmYEK0ubcDLQ8rBX2dacat
         DkvFsNn2Gdj2D8Icmdqnl1PY8QT0+8nmGb8Gu7QeKQO1sRWYCD10KYGrNxDqRyJM2tOa
         qHow==
X-Forwarded-Encrypted: i=1; AJvYcCVdafgIfZEos6Pto7zqlzf1HrejMkNJ8YARv8XAcOFwusgzhM4hdmAgZQYLi4s7wbqo8awS2AYlBoEu9EWHP3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pqmiyA15TFOx/uCF0STyZ3EaFouVRNRebEOKreh6t9GAdpun
	K4irgR9hRGRHyM0exoX7+l+w23ZU9fzrHrbcgIeHBC6O07x7WizXnSDRcMQH200=
X-Gm-Gg: ASbGncvMLq9GjZ0LLZErFuMSlnDs5T7ZHmLSXesEkDLxl7eRzl2+qS0CM74+GJLHmui
	9bi0j1oxMfQBTYk/zBZ1cEJpXW0KI0WI2aEsLqEcu12BiJHtTDMK1izdVVECyhV4f9XfDpbnvDn
	RQyJO3ycOQh7UVDH3kH2KdoSvvCvgEjUTx2DFwBkU18dtUAUzGMD3kRf1heM7NF5iE4WRoxi2kD
	1lH+3EkrHUhkU1GMpUqX05SzUinBM5BN2lpyAc7B2+lyfOjx34BKMK4MG5gan9dngoW75KrwmjJ
	jjBzvARBexrfqA9CeGgzkNtWT+zgsw==
X-Google-Smtp-Source: AGHT+IECfPAzk2JyaDBNwZT4PQUxdFHYoRvfIKPXjo0cQ4d96bucs5bZ0Vp1b7iAABw7vC+b45S1ug==
X-Received: by 2002:a05:6512:68c:b0:540:2257:22a0 with SMTP id 2adb3069b0e04-540225723d3mr600061e87.21.1733741386060;
        Mon, 09 Dec 2024 02:49:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f22efe4c3sm669661e87.24.2024.12.09.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:49:44 -0800 (PST)
Date: Mon, 9 Dec 2024 12:49:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, 
	quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: Re: [PATCH v3 2/3] Bluetooth: qca: Expand firmware-name to load
 specific nvm and rampatch
Message-ID: <fb7exdibh4f5r3io6m34i7lqqe7qo2kk357bfdzcdbie6cppui@mqwwq5w4c57j>
References: <20241205102213.1281865-1-quic_chejiang@quicinc.com>
 <20241205102213.1281865-3-quic_chejiang@quicinc.com>
 <w7r4itwyrh3jva3rx3kmsm4kqtawqkgkneqrlin4hpjkqb3deo@2qmjd3ijzqn3>
 <541a5682-5b99-4793-84ee-a7c9168cb9a0@quicinc.com>
 <CAA8EJppmTSovZKTPb+syrc0Vvfu8U=HoP18tW072OEZ5nYyOgg@mail.gmail.com>
 <4ef61f91-f1ae-4593-9522-2229680a9707@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef61f91-f1ae-4593-9522-2229680a9707@quicinc.com>

On Mon, Dec 09, 2024 at 05:03:55PM +0800, Cheng Jiang (IOE) wrote:
> Hi Dmitry,
> 
> On 12/6/2024 4:34 PM, Dmitry Baryshkov wrote:
> > On Fri, 6 Dec 2024 at 05:05, Cheng Jiang (IOE)
> > <quic_chejiang@quicinc.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 12/5/2024 8:00 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Dec 05, 2024 at 06:22:12PM +0800, Cheng Jiang wrote:
> >>>> The firmware-name property has been expanded to specify the names of NVM
> >>>> and rampatch firmware for certain chips, such as the QCA6698 Bluetooth
> >>>> chip. Although it shares the same IP core as the WCN6855, the QCA6698
> >>>> has different RF components and RAM sizes, necessitating new firmware
> >>>> files. This change allows for the configuration of NVM and rampatch in
> >>>> DT.
> >>>>
> >>>> Different connectivity boards may be attached to the same platform. For
> >>>> example, QCA6698-based boards can support either a two-antenna or
> >>>> three-antenna solution, both of which work on the sa8775p-ride platform.
> >>>> Due to differences in connectivity boards and variations in RF
> >>>> performance from different foundries, different NVM configurations are
> >>>> used based on the board ID.
> >>>
> >>> Two separate commits, one for NVM, another one for RAM patch.
> >>>
> >> Ack.
> >>>>
> >>>> Therefore, in the firmware-name property, if the NVM file has an
> >>>> extension, the NVM file will be used. Otherwise, the system will first
> >>>> try the .bNN (board ID) file, and if that fails, it will fall back to
> >>>> the .bin file.
> >>>>
> >>>> Possible configurations:
> >>>> firmware-name = "QCA6698/hpnv21.bin", "QCA6698/hpbtfw21.tlv";
> >>>> firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
> >>>> firmware-name = "QCA6698/hpnv21.bin";
> >>>>
> >>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >>>> ---
> >>>>  drivers/bluetooth/btqca.c   | 154 ++++++++++++++++++++++++++----------
> >>>>  drivers/bluetooth/btqca.h   |   5 +-
> >>>>  drivers/bluetooth/hci_qca.c |  21 ++++-
> >>>>  3 files changed, 134 insertions(+), 46 deletions(-)
> >>>>
> >>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> >>>> index dfbbac922..e8b89b8cc 100644
> >>>> --- a/drivers/bluetooth/btqca.c
> >>>> +++ b/drivers/bluetooth/btqca.c
> >>>> @@ -272,6 +272,31 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
> >>>>
> >>>> +static int qca_get_alt_nvm_path(char *path, size_t max_size)
> >>>
> >>> int is usually for errors, the code suggests bool return type.
> >>>
> >> Ack.
> >>>> +{
> >>>> +    char fwname[64];
> >>>> +    const char *suffix;
> >>>> +
> >>>> +    suffix = strrchr(path, '.');
> >>>> +
> >>>> +    if (!suffix)
> >>>> +            return 0;
> >>>> +
> >>>> +    strscpy(fwname, path, strlen(path));
> >>>
> >>> 64 bytes ought to be enough for anybody, correct?
> >>>
> >> Yes, in current driver, the max f/w path length is 64.
> >>
> >>>> +    fwname[suffix - path] = 0;
> >>>
> >>> with path = "qcom/sc7180/Oh.My.Device/name" this is broken.
> >>>
> >> Let me test this and fix in next patch.
> >>>> +
> >>>> +    snprintf(fwname, sizeof(fwname), "%s.bin", fwname);
> >>>> +
> >>>> +    /* If nvm file is already the default one, return false to
> >>>> +     * skip the retry.
> >>>> +     */
> >>>> +    if (strcmp(fwname, path) == 0)
> >>>> +            return 0;
> >>>> +
> >>>> +    snprintf(path, max_size, "%s", fwname);
> >>>> +    return 1;
> >>>> +}
> >>>> +
> >>>>  static int qca_tlv_check_data(struct hci_dev *hdev,
> >>>>                             struct qca_fw_config *config,
> >>>>                             u8 *fw_data, size_t fw_size,
> >>>> @@ -564,6 +589,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
> >>>>                                         config->fwname, ret);
> >>>>                              return ret;
> >>>>                      }
> >>>> +            }
> >>>> +            /* For nvm, if desired nvm file is not present and it's not the
> >>>> +             * default nvm file(ends with .bin), try to load the default nvm.
> >>>> +             */
> >>>> +            else if (config->type == TLV_TYPE_NVM &&
> >>>> +                     qca_get_alt_nvm_path(config->fwname, sizeof(config->fwname))) {
> >>>
> >>> Please, don't rewrite the config. The file may be not present now, but
> >>> it will reappear later (e.g. when rootfs gets mounted).
> >>>
> >> This tries to load a default NVM file if the board-specific NVM is not found.
> >> It is called when request_firmware fails. It's safe to rewrite the config->fwname
> >> here since we have already tried to load the board-specific NVM. The config
> >> is a local variable in qca_uart_setup and will return after downloading the NVM.
> > 
> > Please read my question before answering it.
> > 
> Sorry, I'm not clear about your question. Could you please explain it in more detail? 
> I'm not quite sure how the situation you mentioned affects this code flow if you mean
> not downloading another NVM file.
> 
> The board-specific NVM and the default NVM should be in the same folder and should
> appear simultaneously.
> 
> From the Bluetooth firmware load flow perspective, the firmware is loaded either 
> when the kernel module is inserted (insmod) or when Bluetooth is turned off and 
> then on again via a user-space command. If the firmware is not found at this time, 
> the ROM code is used instead. It does not attempt to load the firmware automatically,
> even if the firmware appears later.

I was thinking about the following scenario:

- BT firmware is attempted to load during driver probe, /lib/firmware is
  not fully populated, so the config is rewritten to use the default
- rootfs is fully mounted and populated with the board-specific file
- BT interface is being turned on. It is expected that the
  board-specific file will be loaded, however because the config was
  changed in one of the previous steps, the driver still loads the
  default one.

That said, the driver should perform the fallback, etc, but the config
should stay intact even in the fallback case.

> 
> >>>> +                    bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> >>>> +                    ret = request_firmware(&fw, config->fwname, &hdev->dev);
> >>>> +                    if (ret) {
> >>>> +                            bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> >>>> +                                       config->fwname, ret);
> >>>> +                            return ret;
> >>>> +                    }
> >>>>              } else {
> >>>>                      bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> >>>>                                 config->fwname, ret);
> >>>> @@ -730,15 +768,38 @@ static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
> >>>>                       "qca/%snv%02x.b%02x", stem, rom_ver, bid);
> >>>>  }
> >>>>
> >>>> +static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
> >>>> +            const char *firmware_name, struct qca_btsoc_version ver,
> >>>> +            enum qca_btsoc_type soc_type, u16 bid)
> >>>> +{
> >>>> +    const char *variant;
> >>>> +
> >>>> +    /* Set the variant to empty by default */
> >>>> +    variant = "";
> >>>> +    /* hsp gf chip */
> >>>> +    if (soc_type == QCA_WCN6855) {
> >>>> +            if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> >>>> +                    variant = "g";
> >>>
> >>> Didn't you get the 'set but unused' here?
> >>>
> >> Yes, miss this part. Thank you!
> >>>> +    }
> >>>> +
> >>>> +    if (bid == 0x0)
> >>>
> >>> 0x0 or 0xff?
> >> board is set to 0 by default, 0x0 means read board id fails, then we should use
> >> the default one.
> > 
> > What is the 'unprogrammed' board_id? On the WiFi side it's usually 0xff.
> > 
> Yes, the 'unprogrammed' board_id should be 0xffff. Then 0 and 0xffff should use the
> default nvm.  

Good. I think it's safe to safe board_id to 0xffff by default, then you
don't have to handle '0' specially.

> >>>
> >>>> +            snprintf(fwname, max_size, "qca/%s.bin", firmware_name);
> >>>> +    else if (bid & 0xff00)
> >>>> +            snprintf(fwname, max_size, "qca/%s.b%x", firmware_name, bid);
> >>>
> >>> Doesn't ".b%02x" work in this case too?
> >>>
> >> No, board id are two bytes, it coudl be 0x0206, then we need .b206. Or it is
> >> 0x000a, then we need .b0a.
> > 
> > What will ".b%02x" write in those two cases?
> > 
> Yes, it works for both cases. Thanks! 

:-)

> >>>> +    else
> >>>> +            snprintf(fwname, max_size, "qca/%s.b%02x", firmware_name, bid);
> >>>> +}
> >>>> +
> > 
> > 
> 

-- 
With best wishes
Dmitry
