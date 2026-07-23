Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADB388E44
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825791; cv=pass; b=lEzWwXhZC78mOcoqpxapyOkdu44GsUdqBAFI8CEpnM1C01G4atcmgb5mOQBCl5VyCWTdaYjYEO+e1Etk/K9w34Fyp5Yff05iEZv3kgEbLW0SuKdz47NgWjKgV/f7PXrE5Moqvg6Qznud68tQJEvX2Ugidu//IFE3Ii6IptmBbos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825791; c=relaxed/simple;
	bh=3JZVRo71ipF62WfK9PzwYpsqWMtGqB6xrKSjIBISyh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it/VxXdLxbAk4yzyTU5hB7WJkRs1xuBkQHDgriDgNMYYAyhR1WmnLDhiZpUi8szxp7IiwQp5gIZwtHnk/cfbAy87croscHgf/F1IR4FaOLOydnGQiun+Zeqw4/HPWdxdhGWysY7dn//6O9Q66KRkjWm5S0pl35ggzXFMIuUXIEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnpAWhfI; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnpAWhfI"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6688a2dceb8so628394d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784825789; cv=none;
        d=google.com; s=arc-20260327;
        b=R2dOxpYZt9fN0qpMXtGFNQxCNQJ2HbkjOH4qjSWBNsFpXUyUmPyztZVcQB9i6jkfN+
         7+EsI/wz6L7eIY848Bd69kWuQksXXaJcrPzkimSU37CYXj3B4eYH/AVNAC0UKQh4BhhI
         FXu2nAkfSaFvhzfN436C0HHTUvkQ/chJvdlskqYmMg7swfmxEcODbxfJ8CeJGomm7pfp
         R+GBMrGHrITu7FN36viDJPlEVLKEU5+oMfwN8IOw6kKvioj0UX42wCr75dUZT190otOe
         B7cCAa0b4Vkxr06+H6XdVgKkjHq6xCRbFKG6Dj1mHmINTTLUUmuQpH2L1yVLNq64Edo/
         L77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3SBfkU+Tt86ZZ3mMtAHDXcrnGGGD/U4cjv5DUOLC/Tk=;
        fh=Fq3pyB0l7X0tZ+xuy/HYnvPAIbr3E6psExEiZ1/NYVo=;
        b=CBK36zca6BhMZMlpONNHzvHjnVIcN1qhMrsJJaaA0Zbtb0JtljSiPTs+hAtfhrOOoh
         aPj22F/q99TDXb7x7enWj6LfpiNeWueaJy4B+i3FMG0bB1ClNtYmtApZ+2mRH5aaEGnw
         9AT52ZNUMiHmpBCho8qoLNIVgSOtuf87fZvGkK/Lbf+S9i/33wdiEZvcQbZnou4qdt67
         +fyxiPfsyScuMz3w9AxaA9WT0uLxAUngxPAZSjDZCo1hQGoU04qlPAI9bGSx7mRnpgNO
         l9A2u7/L4nbJ8mUlr1Sv+bpDj9NzpN8FycxcNfzDRyXmK2ZcjKf8QaztpqmE13uKcGNt
         15+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825789; x=1785430589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SBfkU+Tt86ZZ3mMtAHDXcrnGGGD/U4cjv5DUOLC/Tk=;
        b=gnpAWhfIdZoIdD/7xI8uVFNDE4t2n/moMgO19eAJ87yMHjMZeDaNqOcZwqUk9ukL53
         /T4k+BJpd9lBotfdWadMilwK64XG+v6ssQQWyYt0MRxErOHXf57QtWTRQPYZwywhrZXz
         u/SC1DAfGCc4vyqkzb4aSmdHzEZ8Fvh54wt/P36Ool0MSvveaaoCao38S0QmuEP4FsDG
         2FtNfqZWcENPiMyGHh1/c6ciAQGEbsPoBMQMkB5wfJH/PSH3wdPMfZ8I0zkZ9rJWviXn
         Jasn/Kq/9QZbDZkcrLOhEbn7wzEkY57wEiPuIG5nxUfE0FixZfboEH9UEAknsBB/ai8d
         +8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825789; x=1785430589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SBfkU+Tt86ZZ3mMtAHDXcrnGGGD/U4cjv5DUOLC/Tk=;
        b=Wd7PcxwMeuGyhxUlehQAefkvm8rfIa1xaw+x7RUHJSYQL1owoSdB/6SewUuMv2BLQV
         dKYnqbQLW0lW1CNVgeNP/dLoCX/D5d4q/5H2UZKYIaSlJYcJ1fokSHzDu+IxvVuFrfNt
         CKvhb9VSqW7Uma1vtxF6r36iGvASFAbm0ZDbH/F2D3huXvTpl1Vi/6wbdJT1xptbkxcH
         /+4o67ukL48sTZRjjcqPH+4i5ggkQ233tfD7RvNNK9CP+wrl97AkjEu/RxrTFU5wQVRu
         Sh9m9tHYlmqHdXaFr70rYd5eXwFdiSEZAA553/Zwgp0nE1QfQwdcHB6WBut59n+hEopB
         1+/A==
X-Forwarded-Encrypted: i=1; AHgh+RoBwnnrzQE7ydw6A8AJO17vnkTVI3DfuGIZD5UiW4pqUzO4ZvHSIB467NhrW1igFWB8njSs9EKzmoyx4PseIBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPYMcs4qRzQalBq+Ck5FZFb/FuDRDZkZQHYy/D1Q6+MUhMOVy
	38W1hBD1g7ZCbQOF9OifziNRWNNK6hFDs4WlPVfsr3N7NhfYmBBBV1r61Zwexsnbv8KiITU6WeL
	M75tWyy5r7DyhsFPshIFUvhFmLnFXPsE=
X-Gm-Gg: AR+sD105TDSNwPzSbeT7gfs9MP+Qd5NHkppXaYxKlGeMZBmDxKfZ/4SaecyTqdUPp+L
	sP/WM0BgalYOQHKudvTe22Uzuo7bDCmsySPBuzqb9diRoJtsWnl5/Mux8ARZ22FU+BEIQo2TpGq
	Z1b8dP7qCzCV9WrurwG43ZJrtuTq7cZP2EJF+2Voj6ptg0ogbEBvFpBvsX59nbUDE7Yriv804Dy
	kd7TnP0KqCFtBioeOBvvkO64MtvYFqt/YuTvtoFHZwpAeg4mCaRq0DCc3bkjTPgxQOI9qD2dhi/
	vVM+vh6Xu9FBPqOcllYDvEgntDAkFWKA0ThwoR4ZAEo+E4qRZg==
X-Received: by 2002:a05:690e:1406:b0:664:cf03:cf5 with SMTP id
 956f58d0204a3-668a4cbce27mr1215083d50.48.1784825788974; Thu, 23 Jul 2026
 09:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723095616.1543159-1-zhangchen200426@163.com>
In-Reply-To: <20260723095616.1543159-1-zhangchen200426@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Jul 2026 12:56:17 -0400
X-Gm-Features: AUfX_mxChPh2TyTIYw8GRzvg4DdPjbuK6JuB_zwQmV3cXqCfI3vXwpv8X0bgRRw
Message-ID: <CABBYNZ+gCiULFp_oO0kFg=0euovCAHeW_Me-h4cBw8bZLi_W0Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout
 command/event structures
To: zhangchen200426@163.com
Cc: luiz.von.dentz@intel.com, yang.li@amlogic.com, tim.bird@sony.com, 
	naga.akella@oss.qualcomm.com, gustavoars@kernel.org, pav@iki.fi, 
	zhangchen01@kylinos.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 23, 2026 at 6:05=E2=80=AFAM <zhangchen200426@163.com> wrote:
>
> From: Chen Zhang <zhangchen01@kylinos.cn>
>
> Define HCI_Write_Link_Supervision_Timeout command, event structure, and
> corresponding event handler function.
>
> Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
> ---
>  include/net/bluetooth/hci.h      | 10 ++++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_event.c        | 40 ++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 50f0eef71fb1..18a5a17eb218 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1239,6 +1239,16 @@ struct hci_cp_host_buffer_size {
>         __le16   sco_max_pkt;
>  } __packed;
>
> +#define HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT  0x0c37
> +struct hci_cp_write_link_supervision_timeout {
> +       __le16   handle;
> +       __le16   timeout;
> +} __packed;
> +struct hci_rp_write_link_supervision_timeout {
> +       __u8     status;
> +       __le16   handle;
> +} __packed;
> +
>  #define HCI_OP_READ_NUM_SUPPORTED_IAC  0x0c38
>  struct hci_rp_read_num_supported_iac {
>         __u8    status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e7133ff87fbf..866903a9b5c8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -702,6 +702,7 @@ struct hci_conn {
>         __u8            le_features[248];
>         __u16           pkt_type;
>         __u16           link_policy;
> +       __u16           link_supervision_timeout;
>         __u8            key_type;
>         __u8            auth_type;
>         __u8            sec_level;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..3b1f4cf922c3 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -606,6 +606,44 @@ static u8 hci_cc_write_voice_setting(struct hci_dev =
*hdev, void *data,
>         return rp->status;
>  }
>
> +static u8 hci_cc_write_link_supervision_timeout(struct hci_dev *hdev, vo=
id *data,
> +                                               struct sk_buff *skb)
> +{
> +       struct hci_ev_status *rp =3D data;
> +       struct hci_cp_write_link_supervision_timeout *sent;
> +       struct hci_conn *conn;
> +       u16 handle;
> +       u8 status =3D rp->status;
> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", status);
> +
> +       sent =3D hci_sent_cmd_data(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TI=
MEOUT);
> +       if (!sent)
> +               return status;
> +
> +       handle =3D le16_to_cpu(sent->handle);
> +
> +       hci_dev_lock(hdev);
> +
> +       conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> +       if (!conn) {
> +               status =3D 0xFF;
> +               goto done;
> +       }
> +
> +       if (!status) {
> +               conn->link_supervision_timeout =3D __le16_to_cpu(sent->ti=
meout);
> +               bt_dev_dbg(hdev, "handle 0x%4.4x timeout set to 0x%4.4x (=
%u ms)",
> +                          handle, conn->link_supervision_timeout,
> +                          conn->link_supervision_timeout * 5 / 8);
> +       }
> +
> +done:
> +       hci_dev_unlock(hdev);
> +
> +       return status;
> +}
> +
>  static u8 hci_cc_read_num_supported_iac(struct hci_dev *hdev, void *data=
,
>                                         struct sk_buff *skb)
>  {
> @@ -4097,6 +4135,8 @@ static const struct hci_cc {
>         HCI_CC_STATUS(HCI_OP_WRITE_CLASS_OF_DEV, hci_cc_write_class_of_de=
v),
>         HCI_CC(HCI_OP_READ_VOICE_SETTING, hci_cc_read_voice_setting,
>                sizeof(struct hci_rp_read_voice_setting)),
> +       HCI_CC(HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT, hci_cc_write_link_s=
upervision_timeout,
> +              sizeof(struct hci_rp_write_link_supervision_timeout)),

Ok, but I don't see use sending the
HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT command, so what is this for,
handling some custom entity that does perform this sort of operation
behind bluetoothd back is not an acceptable excuse.

>         HCI_CC_STATUS(HCI_OP_WRITE_VOICE_SETTING, hci_cc_write_voice_sett=
ing),
>         HCI_CC(HCI_OP_READ_NUM_SUPPORTED_IAC, hci_cc_read_num_supported_i=
ac,
>                sizeof(struct hci_rp_read_num_supported_iac)),
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
