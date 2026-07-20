Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE173911CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577516; cv=pass; b=H/I5XNmPkDWr0OMz2Cm5p3ZDySxhBJWPUPlIbBo5DnXMWwCVi3sSm8mNMV61Sw1QYtoteSTfjybMzeYPtJmpuZHSXBE+q3b6gXnGy6Y6E+9/zlSTsSjNetLbgaPIbJdI0yLdkZg3yVSx9SLj86Ajg6HABkCdEZPbq0KkKgdp20U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577516; c=relaxed/simple;
	bh=e8K8qnCQMQCq7N/GCNIIdQb00fKuyW33qvPofgyhMmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLjEK1mDIVQzQmYXnHrSUSE0TKQQoKP3rfcpzlpTiTtUDNMD+k5DnLq58vlHtTBBW/v8VjVrSagWLhk1Zfy5Y85DJFL/Yt54ciIQ6v1VPPJ2Rl2oQbvPd3iWgRDc4AqE+Am2yvcyZewPHfnv09df+PdmhfPlSiT3kEqr3qUHE1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpoFpK2C; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpoFpK2C"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e8fa1b8d6so106619787b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577514; cv=none;
        d=google.com; s=arc-20260327;
        b=B2pocyHe3b1roxBGhBgQPtqoKKIZ99IdBMYKg3vIaDQeYZ4syfcqsvVGAKb++F5W0o
         W2i4SOLr0+/XXCaUl+oVb9fpOOQVNjOGRwnjgJMpSqhqIk9CkQn+wM0q9865+JEFSfBT
         pk56FIdZsftGFdWn8rfV54GrjvR4APcFXge9N5ymwpGYImz2m0I7N/2BtE3u+wHI+p/o
         xti3S/2uCEpUa3G447DO+Fzb7hm03rl1e2+0F9lRN1vH1dz3AiTzF9NtbwyWj/AxvnKN
         sT8CClPdWOtFOgEuamwxhGOVqyOY+EZrI0TuPktHWvlbNm/w+BBUzfPQVD6i5tq4jReJ
         rm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        fh=UyY1sibDNqnkD5K5gCb4pKmMoqbjfYMHpptKhsTUXnQ=;
        b=qlBPsxjgnC0BwGaxD8XiQ9tPabIfjaDZ6ideYye3WZDvqxwNixPxdlT8JzICd21g2/
         h1y+w6h3hPhzDmL769J01yhQcWbvn8WtjRlw76OUjYC1NFEp7UNCMQsK0IUvUO206fHV
         kgbP5WEfDBmB4/a2l7DF3l7kXgBI7z63iiWg1tiiqh4GW8hhWkRZiJnCoC+9i621O1zG
         Qe7vtvFZAZkrSjbuOh04DZqhcjpLVkdwQjFhWb/ueVKZM137bz6jQMqBVZnA1s68UEzc
         a/qF3o+HSMLCz0QFsJWbPbokAwu0yj3YmiHD0gf1nm7klhaAm7Op2KaKciXZGuucZCHm
         KvWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577514; x=1785182314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        b=LpoFpK2CG5v8+5KVTzWksUlbim32tC2EPMIkdpckXajSpfoljRnDloWbqYR0SLgkje
         aRWWXAAmtLUZcukVVVkmIc9TxOU6xVSz22XPHhFuuSc/pbKwA8uW/BO4BzeMEefa7Izx
         qwzZfuZjDYOZTGNFoixPAoXDuuFGk2es8xrTApYPq9zd7ouXDPKnooavgwWMrGitIw9o
         G83IZF0IAz2Pl7r46rQpRXUhD06ZCPXSZwZ1nh/NqHnhiI57CCpf1AYW9RXx1ZYHIlpI
         5AdcXIkCOopeyMj7gDlRGzbqS51Z6WyoXfhnc6RW9MrrAsJwpZ6AXMpR5k3yx6y8w0XA
         QlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577514; x=1785182314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        b=BrRXwi1+/CpvAOYiEyMM1SClwfUq9Sf1D2ZKMxmlHAE95mZUIk5rPjCQB2aqTGSHIJ
         4t7CdSyVzjn79qT7d6km3EDuQ06/N9SO6rkLMVldDAlxmq3jmWjf/SWSKFLPEzgSZIeb
         6XoWK9msE3NE+XxAhe7nHy+eggD8huH3SAOV/crmGG1MsUMxrkWg4vJ8GqYBBnyHyKvI
         VzNG3Me4l0hrONgG1kGR+MeqccEQYpkC3EPtQIM9mooIpAFxGB+nsyPq5IQyASYv6k0W
         cJFDlYyaC5H9JHMwiG2td9VBrM66isbpu0JRzElhSJpoIeCKZlpIEb9XuPeyxrMYEDot
         Gafg==
X-Forwarded-Encrypted: i=1; AHgh+RqvQh92JnHhXY43l54u8xfcdAkUnnSP4755pbbtBcIethADAajggXWFSd/7iHamd6MmndnRvc7mBNKVeguxa3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtsnLGv6VY68p6xV9i2biVT3TM7fMoOx5eMFQEnr9CvkGRW/4
	Yrl4nCswHxj4xaaXJWvFzxBSAMSAhvSoCa3QCDKQQpW+HHGycFNg6HIVdXWShE6JFmOYXSCyL1r
	liQXNIb/zlkTd7RKNtQTpY1+FIbjgyME=
X-Gm-Gg: AR+sD11hNv8qnx9zS4M3I/OtPhnnf7uRGC4UDcgRFcSw9w6sSqh2i4uI0UhJ43OuHIU
	KVD8RRJXUPCrD8LITSYPet2mkDgrIKmXnGZO5dlrA1NdbqekGcD7aUae4ibEufpOuoUnwvtzzVU
	hS6EA0BDf57D6UCTHfgUgCRfiHccJYY3N0hLEAOnUjb9MbSPPQ+UxyM9nt4EYyMsUPPFDB2pqJN
	EXKHHA7dPKArLb4TfwBMXVYj3psmNzdM2WjeIrwERIyGxXkszCy5/YwsYmoAxpa6xD6M6k4hkFU
	ZlzsgAeMfqdey+k6haYVHOzBp6nIRMJXQF1G9zCpzpoR0Y7j
X-Received: by 2002:a05:690c:3344:b0:81e:79f0:4898 with SMTP id
 00721157ae682-81ef26cd1a0mr42024967b3.15.1784577513969; Mon, 20 Jul 2026
 12:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720191322.14432-1-doruk@0sec.ai>
In-Reply-To: <20260720191322.14432-1-doruk@0sec.ai>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:58:22 -0400
X-Gm-Features: AUfX_mx6T-muarEkjZNXWuZXNO-Iwx5kWJ56Oe7o3dTKk0KPjblNm-Vbd1VRM5U
Message-ID: <CABBYNZLaFuoektaPQkzr4ioiz9_pUpbun1oow0kwgSOhbHM11g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read
 in nxp_recv_fw_req_v1()
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Marcel Holtmann <marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doruk,

On Mon, Jul 20, 2026 at 3:13=E2=80=AFPM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset bu=
t
> left an unbounded read in the v1 handler.
>
> nxp_recv_fw_req_v1() advances a device-driven download offset
> (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> bookkeeping runs even when the payload write is skipped, so the offset ca=
n
> walk past nxpdev->fw->size. When the controller then requests a header
> (len =3D=3D HDR_LEN), the driver reads the 16-byte bootloader header at
>
>   nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
>
> with no bound on the offset, reading past the end of the firmware image.
> A malicious or malfunctioning NXP UART controller can drive this to read
> out-of-bounds kernel memory during firmware download.
>
> Bound the offset before the header read, and convert the payload write
> guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
> u32, so fw_dnld_v1_offset + len can wrap). Log the offset, expected lengt=
h
> and firmware size at the reject site to aid debugging of a real device.
>
> This was found by 0sec automated security-research tooling
> (https://0sec.ai).
>
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Blueto=
oth chipsets")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2: log offset/expected_len/fw size at the reject site (requested by
>     Neeraj Kale and Paul Menzel).  No functional change to the bound
>     itself vs v1.
>
> v1: https://lore.kernel.org/linux-bluetooth/20260705115650.81724-1-doruk@=
0sec.ai/
>  drivers/bluetooth/btnxpuart.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 0bb300eef157..6d62d07a542b 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1041,11 +1041,19 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hde=
v, struct sk_buff *skb)
>                  * and we need to re-send the previous header again.
>                  */
>                 if (len =3D=3D nxpdev->fw_v1_expected_len) {
> -                       if (len =3D=3D HDR_LEN)
> +                       if (len =3D=3D HDR_LEN) {
> +                               if (nxpdev->fw_dnld_v1_offset >=3D nxpdev=
->fw->size ||
> +                                   nxpdev->fw->size - nxpdev->fw_dnld_v1=
_offset < HDR_LEN) {
> +                                       bt_dev_err(hdev, "FW request out =
of bounds: offset %u, expected_len %u, fw size %zu",

We still have the 80 columns limit in Bluetooth.

> +                                                  nxpdev->fw_dnld_v1_off=
set, len,
> +                                                  nxpdev->fw->size);
> +                                       goto free_skb;
> +                               }
>                                 nxpdev->fw_v1_expected_len =3D nxp_get_da=
ta_len(nxpdev->fw->data +
>                                                                         n=
xpdev->fw_dnld_v1_offset);
> -                       else
> +                       } else {
>                                 nxpdev->fw_v1_expected_len =3D HDR_LEN;
> +                       }
>                 } else if (len =3D=3D HDR_LEN) {
>                         /* FW download out of sync. Send previous chunk a=
gain */
>                         nxpdev->fw_dnld_v1_offset -=3D nxpdev->fw_v1_sent=
_bytes;
> @@ -1053,7 +1061,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,=
 struct sk_buff *skb)
>                 }
>         }
>
> -       if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
> +       if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> +           len <=3D nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
>                 serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data =
+
>                                         nxpdev->fw_dnld_v1_offset, len);
>         nxpdev->fw_v1_sent_bytes =3D len;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
