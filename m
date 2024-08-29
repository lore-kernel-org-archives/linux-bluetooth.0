Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B718A924
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946621; cv=none; b=jU9dwSLdAoTInIm8XodJfIDlewbyHzZKDIshb+EncUa43d3T/vK8nq5h2E1St35KoVpU9e4xQjIrwPa1q2QDlvSjeZgPiVGOEPC5qD/R2OEE9RELbG3pYB+LbKxh1AIreLCQjMkrJ7w0zgRWf0DOXF0hhBe6G1Xpb3NZJFeF4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946621; c=relaxed/simple;
	bh=Eg6d8uXuIcOrKo7pNAN+Lgu3bABR9vKLpeQ7faiu0Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpdi7CgzSraPMsGiWn0Dj6wcVMFK0OxwwRDY/MNWbEBLv+o9ckqWeHFe0pa01Cuz540QgOvX93tP05av5200sTc5VyVxYX41Ocpml3s78gtCggdt8sE4lnRXnfCI0kzSQfg4NKOFkKFe8K5XDn3V66cy6oCp9gXdhTbj+Q3tWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMCftldg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMCftldg"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f409c87b07so9744671fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946617; x=1725551417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkCYkjTVtNrK1DEvOB1OzxFnzMWBPekHeLuaAszShGg=;
        b=KMCftldgVgrqtHZ4RIRjrDBtTmm0UwjO1Pk5c7OiCkzLCkGK0ig0zWGrVSgLS9MmWS
         5NUozV+zpWyItMtGhH+ZiGMfFeip9Jn7gvz3V6HqIF0djfno8E08wimYehWkruAnbe+8
         +RNCjf7x9lt0MSlDBRoQeyZiGipQEdA24/gJqqNrrhJHTJ9ldpyGoebFTPwCQzt9CQQW
         +MC2LPf28ECemjNiscLxKj+w8sN4MXWxaR5b/Q3kcC1nVB1H5FjJaPP/Bq/YKy0/7heq
         gRdxcRbta1L08Zp3dRHM9fPLN5ZcZUeZe1pxiwDfU3s82o05010bmNhwwVmOAAWS76+/
         O1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946617; x=1725551417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkCYkjTVtNrK1DEvOB1OzxFnzMWBPekHeLuaAszShGg=;
        b=FNHdW9YF65jzbudUatKY1IO3nXRk0B+C42xL6HNvdh6ya15Kqosvfi/MkfjjqjtM+d
         67C3SRR/vS8oX8/CDvnRSjG0+mkE5dOHWIP7pJcaVknQ9/8hoaN8gQwE7cKlohYbcYR1
         ZfiQBz/mGkiy9go2n+PwyqYMtsy0E+zPYaufSfiHmqmTj58Ab9tdm4ZkS0jQ4QozffPJ
         vGboT5O8smYP+xvrFo4dHDu32PzqVkHD+fsVCyAebUMDmXtOOW26CKoF2aPzmUxNUtQe
         vrsiqekGjXUMG2p7PiMNeCTTtjpsAJjnNRtZVA4Q1j5CMhua7Z3ZO/MWsWgSB9IR4+v3
         Sl7g==
X-Gm-Message-State: AOJu0YzzbGUusENok2U8kbusPUIDOgwtwL8OVGQ9vHQXLCeFDNH+r4cm
	7vuA9FvnxOnurvOx9vg8OKPyaWIuch1CAkETaSfl62Ew9Yt6xCPs8S2+V1hzbc8chw0vq7c7WOy
	SDoy7aJCJLRN57vsN9Vpv9HnE7SWMYHEE
X-Google-Smtp-Source: AGHT+IHhsecLnLENVwNTSI9Ar/3DMpx9RqQTG4wucuRHLhUsxmJHkjBityMoAEPRdNS0/SH0AVOJJQiMDh2uc6NkbRc=
X-Received: by 2002:a2e:71a:0:b0:2f3:cbc3:b093 with SMTP id
 38308e7fff4ca-2f6105559dfmr21080901fa.43.1724946616458; Thu, 29 Aug 2024
 08:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829132507.4545-1-iulia.tanasescu@nxp.com> <20240829132507.4545-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20240829132507.4545-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Aug 2024 11:50:04 -0400
Message-ID: <CABBYNZKi1A0iWxVqJDUfoy45BO7ZD8wQcm7JrSz67kO0+R-+EQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client/assistant: Enter Broadcast Code as string
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Aug 29, 2024 at 9:25=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Currently, the user sets the Broadcast Code as an array of bytes
> when prompted from the assistant submenu. However, the Bluetooth
> Core Specification requires that, on the UI level, the Broadcast
> Code shall be represented as a string (Vol 3, Part C, 3.2.6).

Interesting, but we could go one step further can hash the string
using bt_crypto_AES-CMAC since that would always generate a 16 bits
hash, we actually have done something similar for SIRK on main.conf:

https://github.com/bluez/bluez/blob/master/src/main.conf#L268

> This commit makes the Broadcast Code be parsed as a string from
> the assistant prompt. The bluetoothctl log below shows a Broadcast
> Assistant pushing an encrypted stream to a peer:
>
> client/bluetoothctl
> [bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
> [bluetooth]# AdvertisementMonitor path registered
> [bluetooth]# scan on
> [bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
> [bluetooth]# connect 00:60:37:31:7E:3F
> Attempting to connect to 00:60:37:31:7E:3F
> [CHG] Device 00:60:37:31:7E:3F Connected: yes
> [00-60-37-31-7E-3F]# Connection successful
> [00-60-37-31-7E-3F]# [NEW] Device 19:9A:7A:71:E5:8B 19-9A-7A-71-E5-8B
> [00-60-37-31-7E-3F]# [NEW] Assistant
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> [00-60-37-31-7E-3F]# assistant.push
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
> [Assistant] Enter Metadata (auto/value): a
> [Assistant] Enter Broadcast Code (auto/value): Borne House
> [00-60-37-31-7E-3F]# [CHG] Assistant
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
>     State: pending
> [00-60-37-31-7E-3F]# Assistant
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
>     pushed
> [00-60-37-31-7E-3F]# [CHG] Assistant
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
>     State: requesting
> [00-60-37-31-7E-3F]# [CHG] Assistant
>     /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
>     State: active
>
> The btmon log below shows the way the Broadcast Code string is converted
> into a byte array and sent to the peer via GATT:
>
> bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 28
>       ATT: Write Command (0x52) len 23
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data[21]: 02018be5717a9a1900db5e3a02ffff010100000000
>             Opcode: Add Source (0x02)
>             Source_Address_Type: 1
>             Source_Address: 19:9A:7A:71:E5:8B
>             Source_Adv_SID: 0
>             Broadcast_ID: 0x3a5edb
>             PA_Sync_State: Synchronize to PA - PAST not available
>             PA_Interval: 0xffff
>             Num_Subgroups: 1
>             Subgroup #0:
>               BIS_Sync State: 0x00000001
> > ACL Data RX: Handle 0 flags 0x01 dlen 2
>       ATT: Handle Multiple Value Notification (0x23) len 24
>         Length: 0x0014
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>           Data[20]: 01018be5717a9a1900db5e3a0201010000000000
>           Source_ID: 1
>           Source_Address_Type: 1
>           Source_Address: 19:9A:7A:71:E5:8B
>           Source_Adv_SID: 0
>           Broadcast_ID: 0x3a5edb
>           PA_Sync_State: Synchronized to PA
>           BIG_Encryption: Broadcast_Code required
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000000
> bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 25
>       ATT: Write Command (0x52) len 20
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data[18]: 040142c3b8726e6520486f75736500000000
>             Opcode: Set Broadcast_Code (0x04)
>             Source_ID: 1
>             Broadcast_Code[16]: 426f726e6520486f7573650000000000
> > ACL Data RX: Handle 0 flags 0x01 dlen 2
>       ATT: Handle Multiple Value Notification (0x23) len 24
>         Length: 0x0014
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>           Data[20]: 01018be5717a9a1900db5e3a0202010100000000
>           Source_ID: 1
>           Source_Address_Type: 1
>           Source_Address: 19:9A:7A:71:E5:8B
>           Source_Adv_SID: 0
>           Broadcast_ID: 0x3a5edb
>           PA_Sync_State: Synchronized to PA
>           BIG_Encryption: Decrypting
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000001
> ---
>  client/assistant.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/client/assistant.c b/client/assistant.c
> index 77fb78329..16e94664a 100644
> --- a/client/assistant.c
> +++ b/client/assistant.c
> @@ -255,28 +255,32 @@ static void push_reply(DBusMessage *message, void *=
user_data)
>  static void assistant_set_bcode_cfg(const char *input, void *user_data)
>  {
>         struct assistant_config *cfg =3D user_data;
> -       char *endptr;
> -       uint8_t *bcode =3D cfg->qos.bcast.bcode;
>
>         if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
> -               memset(bcode, 0, BCODE_LEN);
> +               memset(cfg->qos.bcast.bcode, 0, BCODE_LEN);
>         } else {
> -               bcode[0] =3D strtol(input, &endptr, 16);
> +               if (strlen(input) > BCODE_LEN) {
> +                       bt_shell_printf("Input string too long %s\n", inp=
ut);
> +                       goto fail;
> +               }
>
> -               for (uint8_t i =3D 1; i < BCODE_LEN; i++)
> -                       bcode[i] =3D strtol(endptr, &endptr, 16);
> +               memcpy(cfg->qos.bcast.bcode, input, strlen(input));
>         }
>
>         if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
>                                         push_setup, push_reply,
>                                         cfg, NULL)) {
>                 bt_shell_printf("Failed to push assistant\n");
> +               goto fail;
> +       }
>
> -               free(cfg->meta);
> -               g_free(cfg);
> +       return;
>
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -       }
> +fail:
> +       free(cfg->meta);
> +       g_free(cfg);
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
>  static void assistant_set_metadata_cfg(const char *input, void *user_dat=
a)
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
