Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0aKFJaT"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CAC90
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 08:02:19 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso28162911fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700236938; x=1700841738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2SN9v6ygW2GedDXRXak0weNAqvI8+I/yNpqchw+QQ8=;
        b=a0aKFJaTZzLwm7yfUXtfrQeW6Il9VGK6l+L1c7xNXycphjjQ2ZDdsrLqtEVbV56I4m
         3PDGOD8KpebuoOXuV9iZIxwC7rvu0OVpu5u5gcNK7Vpr1enUg1Oz/3o8UTVEE05vGoQL
         5CTfclmOMx3SudkZ4X0oFUHzCsyQ0Bk7fVphYHOyub1+IEoc8w9V1cz/1lRU7btdAHt1
         A6zR8srg0yg0t+jlWs20MIuoQXoj0PbACEozJk+RNjgyjyii5AZSzSAK9WXW60dcOHL5
         GLaLbQsyZn1whpx4SiMyupqoVc9ibeN9FvbrJaYQdTNyH4SuPOGi0f7y1jlIWzybXBYh
         jFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236938; x=1700841738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2SN9v6ygW2GedDXRXak0weNAqvI8+I/yNpqchw+QQ8=;
        b=XhuJtMehncXaSRr8Jn8XJkP6gtZsOYvq3hgmSVLJa+3jhtADgHtQJuHWv4Ego70YTo
         r4s17idjT/sptgaFu3ufg40fI+AtU0LQdlRT/STqsxKKuwDGYKRYeH3AR1NUtCDTIJuF
         W7EViRaaJtLpP7q89TLqamy7UnzVmDcRf/IqmArxo8TWjFyYLGX2/EYBHJ3870/8V15s
         fp0kyHa/FwK55RwtUDmxSoDB7mwSShSYzpdhDXhY7yhsU6MywWjk4E0V53Gtidhn2280
         A+Jq2qrblE2i3YROjW4dPLURSVS/s9QtXLMRXQ4+no1CVXvREdtPffu9N3ghHbUrOTbJ
         Q7cQ==
X-Gm-Message-State: AOJu0YyGqmWdKL2bGEGcAtrRgOY9i6b4gU/CkIbigigqVugGeC8yGiq8
	MQpQ8RzNUukrjlaULJZNuBVnrxJk14pit/vvLdU=
X-Google-Smtp-Source: AGHT+IH+PzwwKlBEVWmMHfY10ier+Vu7wkTOA3FMh5XDM59Q1cCeEusUEGw0XFmqlkqHsqJ3/Bbw6uuFj6HzE1SN2/4=
X-Received: by 2002:a2e:8042:0:b0:2c6:ef8d:b49d with SMTP id
 p2-20020a2e8042000000b002c6ef8db49dmr15865ljg.24.1700236937713; Fri, 17 Nov
 2023 08:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZK6UNm9SWhmJtvp-bzObTk-UR7GhK2U16ffFEe-bdpOoA@mail.gmail.com> <b767f792-912d-0386-c891-4f571217e846@quicinc.com>
In-Reply-To: <b767f792-912d-0386-c891-4f571217e846@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Nov 2023 11:02:05 -0500
Message-ID: <CABBYNZLrdX5pxWNL86NcE7DvSzvLN0xMTaMvJ265=CvKYmMMcw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Bluetooth: Support SCO offload for QCA2066
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 6, 2023 at 9:47=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicinc.com=
> wrote:
>
> On 11/7/2023 12:16 AM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Mon, Nov 6, 2023 at 1:19=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.co=
m> wrote:
> >>
> >> This patch series are to support SCO offload for QCA2066, ALL BTHOST
> >> needs to do is specifying both Input_Data_Path and Output_Data_Path
> >> as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
> >> to configure data path by HCI_Configure_Data_Path at all.
> >
> > This part it doesn't need to use HCI_Configure_Data_Path seems to be
> > non-standard, if so it needs to be handled by the driver, also it is
> > probably a good idea to explain how it works, what are the commands
> > used and the result traffic using btmon to collect the HCI trace.
> >
> My change does NOT touch current BT core driver logic at all. i just assi=
gn NULL to
> hdev->get_codec_config_data within QCA device driver. so it follows curre=
nt kernel
> offload design.
>
> BTW, Core spec also does not specify standard procedures for SCO offload =
since it is
> vendor specific.

We should probably document the expectation so it is clearer to the
driver what to expect, also the offload must be selected by the
application via socket interface as the HCI routing is the default, so
if the controller defaults to offload that needs fixing.

As for this change in specific, the configure data path function can
check if the driver does implement it, so we don't have to check it
before calling avoiding duplicate code.

> >> Zijun Hu (2):
> >>   Bluetooth: hci_conn: Check non NULL before calling
> >>     hdev->get_codec_config_data()
> >>   Bluetooth: qca: Support SCO offload for QCA2066
> >>
> >>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
> >>  net/bluetooth/hci_conn.c    |  2 +-
> >>  2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> --
> >> The Qualcomm Innovation Center
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
