Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579432;
	b=Ul5TtdGTr3JEbWc8nhKwkuzKLAr9CK9i44Jmhdw+qY5JE/j62ndxbsg7Nv5t8cFNDQuE
	 hRVdCCBQJ7yFR5WQ5gWZ1bI2FvZe9+1m6BQpD575z2trteFdxj13Pvvfu3SP9wEEmfB/a
	 OLOeE3pQF7hY0YXLFjso/qlbrh2jF2DtFavuTERssZalQtfU+gXk6/ZfvrS0pkTJEK/L8
	 X19lnv1gAnqwFcRtQaEuPOSt6FsYxbbhjSRYnVHySLmWfN2s7MSRDGvlkOpPPkWbSnQb9
	 TRPVHtAa1qVRU7GAOXEWeNhdcuPCm3mXOzTloZRzMxDqe9E0b49k6NUVYhNJEEWwKsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=07lsw6k/o9C9vuoGzhsarzJ+yesIMLdoxkhztMc6Uik=;
	b=wJqGJrS855DWs3djGmwst+6vvaubp3Dvbmgd1eRy03rz+sRfhPmcPQSEuHkA2wKfN40W
	 P4NK3QqHuC55N2ooHd91eHYBf25z3n6ozM+v4I5Byon6yy/4WvyQm9pX/wXUOlUSWtPqJ
	 ZwVwzYGCoBlPnZyWaZA8t9sFpe/e177G4ZjjRvt41hARmJlY7pkiQIqH52vFCL6ivXpcI
	 7EJX2BCQNIDa+5SXvKl42kt5Rp8Q4niaFG5cSxdfHqg5GfDlv+5f9ggLM7IzL/BO9aGm3
	 /QgE2hYx7bwbQf2zH0ahbAzsuWLVuaSpmV82h5ZbzepBeWGRyn7hO/NnxeNX2cEulVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFkZKEC2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CD606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 14:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F7CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HFkZKEC2
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67921b515a7so974985d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 06:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794579430; cv=none;
        d=google.com; s=arc-20260327;
        b=Ir6lTbBH4oDUdS10kS8Xvv2KyT6GJ57ThVCCgieLXBM6QIM3Cu5OXlI5WFfgApFHrz
         96RP0t6qOxSWzU0obpYW1yRhcjAA/amEMFDaHZ4Q2b1/TgPtHSEk5uXylM4vtBvFnA0N
         rtFeF943uW3ZxMPyGoEs/jlfy0yVbyO9s5ge05vJMHnxIErV7bD45gJAnyZ5BajXrHkN
         82cx5HGnAsi5d3uZVuZVggHWCXzcXZ5oI5qE4Zcrv5CvfaU/FE4BjBW5gmfphkbC3jXB
         XLLXv9rENECfRK/thy9o4zsgWlMdcDiAsxVvh7NgEWO2NwZGZ2HImEkmyJhtpr+oR297
         65hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=07lsw6k/o9C9vuoGzhsarzJ+yesIMLdoxkhztMc6Uik=;
        fh=JqfdGqO4cx3tBLNo8JkhzSGwKJw37F2A9w0E+Ytm1No=;
        b=ZyrHinvPy4N8LXIT9vZ+/v+8tYpYtlXgZ+YzDBnNBKZWsKNgt99WY8JtHdq+9Kr5nM
         Nv3+4gVHakttbA2bjB0vIbfBaVhdCHsJdRJrxzFwQoXBjSk6tgHJCn4DCYZSFbzRiPG0
         lhTW5vnPpIF8O1sU6sYwmRB0xNjKaHmLXql2Y/qd7Ch7GFjv3Ykgd+jf2Pr85eaffGTz
         FP2v8B2oZTMxLoK5zO1mL8m/Gt9P0rCKuf45KxWqCaFPv3WQtWf7ugg2/zSgwLxOk49K
         otPmGH0i3I2SPYwf4xmWRQFSkmBMPBvdgQ4uXfsvXQ1OlqUr7sAiw+otEEXaxAAzDKqZ
         FN9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794579430; x=1795184230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=07lsw6k/o9C9vuoGzhsarzJ+yesIMLdoxkhztMc6Uik=;
        b=HFkZKEC2B/lJyP8Hbqdw1MxjVdObaMn7RAmAoIDMnLEv0He9VHUPJ/MwDr4RqhqUBw
         NItEHahzzW8FuLmo1ockoWBlKyv6KIDGO145AV8vtr1IJu0TNzaRkBGSHrRZ87buPOsw
         JX0OpV1bcE4vkPYrOHFKFiyO6uaRFRjDFUxkFdh/MEEIvZBVCjlxQAeep3YRqvjSWELh
         vmoTlXHnU4jk3Vx4F+OrAfdbtE03BKXJEUWcU+CI2LwTI3f1lJ4olf3NIlp7M1ACw0Su
         esk3Eic92bBIi2ppgGuY5INyNlO1rqeYIzn5t0a7JN1tEjgwdnQkGZb6O9BeoY8DniK/
         wnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794579430; x=1795184230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07lsw6k/o9C9vuoGzhsarzJ+yesIMLdoxkhztMc6Uik=;
        b=UDl9ftQrBGrWeGJtqeZK0OeYrdR2lANMAKs1W3omR77jNNv26F9bDcEa99AGrMs4hf
         QpUcF9+2hxkVK77+0LSVgspc+WHfz/HA6kWKomm3JyvlBPCkK35/RKpM82aakyfXeYTT
         F+h92CHg4+YZEtvDKjAsWqBX0d8iP+TyHjVfqTZXGixytM+gR20aX+0UwBCESLj5dvER
         U1mAsJxvFrhtEXShIMs6fIX3w+F7XXdgpx+hdAEPXxbArDgCDmqmcJYLc53qdgVI1ln1
         /8CcmOCSshC3IS5xLNVnph3x7fRr5bqZVoRXKHZS3ysxellaLVhkFqm8cejgumhPeEuE
         texg==
X-Gm-Message-State: APuU4Z+XkStWEvrHlbEzr0G0IQnVoFGbC3wdoY5USGdlW6V1R/gtrDZq
	m7cacziNsyv9i7NV2uIl49CsML+Ku0U48eBFLYi3+joZiIKHpdrBk84elmpYTv8nIzjBoCTWFsw
	/9SF515rW6pnUpWgAwowbCpzu6dezdG8=
X-Gm-Gg: AYBFou3fS3iP0oPok6h2o/lN8N1wrxxpTzmx4FPXWWvNmBROr7ynUWHW8kuSh1MdnaG
	RLMpvTvHGTve4ImNrxGXV1oJXg1QxTVEdjBManG57kaPXpZ58MhTMTEMk/zHnoJPg5XUJAR6Qu+
	tiqHNhTrP/qDz4hJiwy/GpUqPuBqih4k4rT246HrMND+9Xk6OHvkcH1FneD0C+PFxJJRuiGezRp
	yMLVupctuXWXKp8x+PN5F5oSfiWGOISLzoxGPUvYHKEAQODg4l8CQ3ZZkC9YAfXVtSNqblSDmXE
	J9deORRcXMY8eYk7kxkRLYoMNbhIqytkEZYsXbLeZcI92Xnccg4AmZ3OqbRUcMw3WFrhSVv19q6
	wKM7rtEddFBRaD1gzFgxPjm2lBBG15alScVQRhHT1mqM13zS4Z2QHrZhbyA/NXhYel6wYHgCZht
	6QY1nXfVt6YxxaFxawuzQP+KCvKPlx74WyS7yHjcH06uXJLOGkm9h90San17I=
X-Received: by 2002:a05:690e:4511:20b0:67b:f2b5:4082 with SMTP id
 956f58d0204a3-67d895d192bmr1133975d50.23.1794579429687; Fri, 13 Nov 2026
 06:17:09 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com> <20261113052538.3030771-2-chandrashekar.devegowda@intel.com>
In-Reply-To: <20261113052538.3030771-2-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2026 09:16:58 -0500
X-Gm-Features: AclHuK87YNJ-FymovWO7YBVp4jKuy1m7SqoT2zo58caUikD4FdVTKu6bTKQhn-Y
Message-ID: <CABBYNZLrpDE7WgS5VF3SeTe5TZAp1PzKHT32Fr1+NrdVTR53Xw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Bluetooth: btintel_pcie: Add TOP silent reset support
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com, 
	kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandrashekar,

On Fri, Nov 13, 2026 at 12:53=E2=80=AFAM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> Add TOP silent reset as a lighter alternative to PLDR for HW >=3D SCP2
> on subsystem PEP. After the FLR reprobe, send the Intel soft reset
> with the cached boot_addr, wait for the GP1 mailbox event and boot
> stage 0, then request a final FLR. Any failure falls back to PLDR.
>
> A WiFi-initiated request makes BT follow with PLDR.
>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
> Changes in v6:
> - Rebase on the latest bluetooth-next master; no code changes.

There are still 2 medium problems though:

https://sashiko.dev/#/patchset/20261113052538.3030771-1-chandrashekar.deveg=
owda%40intel.com

> Changes in v5:
> - Publish data->hdev from setup() before use; skip setup() while a
>   reset is in progress so it cannot consume the reprobed device's
>   TOP reset request.
> - On setup failure, open a dedicated gate before re-checking for a
>   pending WiFi PLDR request, so the next setup() still retries the
>   firmware download; do the same if do_top_reset() fails to queue.
> - Retry the FLR or PLDR for a bounded time when the device lock is
>   briefly busy, and order the WiFi request handoff with full barriers.
> - Escalate every reset request to PLDR after a TOP reset or PLDR retry,
>   including hw_error and resume.
> - Drop a stale TOP reset request when the reprobe fails, the device is
>   left unbound after it, or the device is removed.
> - Let a repeated hardware error right after a TOP reset fall back to
>   PLDR instead of being dropped by the retry limit.
> - Fall back to PLDR on an undefined TOP reset mailbox value.
>
> Changes in v4:
> - Fix a pci_dev leak and stale TOP reset request when remove() cancels
>   a queued reset_work.
> - Allow a PLDR retry after the post-TOP-reset FLR fails with -EAGAIN.
> - Keep a pending WiFi PLDR request across setup and failed resets;
>   trylock the BT device around the ACPI WiFi detach.
>
> Changes in v3:
> - Harden WiFi-coordinated reset handling (role switch, NACK, PLDR
>   replay, reset-type races) and exclude BZRIW.
> - Check ACPI _PRR and use a non-blocking PCI lock before detaching WiFi.
>
> Changes in v2:
> - Use a published, role-switch-extendable timeout; fall back to PLDR on
>   any failure and replay a pending WiFi PLDR request across reprobe.
>
> v5: https://lore.kernel.org/linux-bluetooth/20261111193103.2992252-1-chan=
drashekar.devegowda@intel.com/
> v4: https://lore.kernel.org/linux-bluetooth/20261027151930.386971-1-chand=
rashekar.devegowda@intel.com/
> v3: https://lore.kernel.org/linux-bluetooth/20261027054408.318002-1-chand=
rashekar.devegowda@intel.com/
> v2: https://lore.kernel.org/linux-bluetooth/20261023094033.212251-1-chand=
rashekar.devegowda@intel.com/
> v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chand=
rashekar.devegowda@intel.com/
>
>  drivers/bluetooth/btintel_pcie.c | 694 ++++++++++++++++++++++++++++---
>  drivers/bluetooth/btintel_pcie.h |  39 +-
>  2 files changed, 664 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 382e02851758..43915aeef99d 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>
>  struct btintel_pcie_dev_recovery {
>         struct list_head list;
> +       unsigned long flags;
>         u8 count;
>         time64_t last_error;
>         char name[];
> @@ -96,6 +97,11 @@ struct btintel_pcie_dev_recovery {
>
>  #define BTINTEL_PCIE_RESET_WINDOW_SECS         5
>  #define BTINTEL_PCIE_FLR_MAX_RETRY     1
> +#define BTINTEL_PCIE_TOP_RESET_INTERVAL_MS     250
> +#define BTINTEL_PCIE_RESET_BUSY_RETRIES        25
> +#define BTINTEL_PCIE_RESET_BUSY_DELAY_MS       20
> +#define BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS  5000
> +#define BTINTEL_PCIE_TOP_RESET_FALLBACK_MS     250
>
>  /* Alive interrupt context */
>  enum {
> @@ -658,6 +664,15 @@ static inline void btintel_pcie_dump_debug_registers=
(struct hci_dev *hdev)
>  }
>
>  static inline bool btintel_pcie_in_d3(struct btintel_pcie_data *data);
> +static void btintel_pcie_reset_ia(struct btintel_pcie_data *data);
> +static int btintel_pcie_start_rx(struct btintel_pcie_data *data);
> +static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data=
);
> +static struct btintel_pcie_dev_recovery *
> +btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev);
> +static bool btintel_pcie_queue_reset(struct btintel_pcie_data *data,
> +                                    enum btintel_pcie_reset_type type);
> +static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
> +                                      enum btintel_pcie_reset_type type)=
;
>
>  static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
>                                   struct sk_buff *skb, u32 pkt_type, u16 =
opcode)
> @@ -666,6 +681,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie=
_data *data,
>         u16 tfd_index;
>         u32 old_ctxt;
>         bool wait_on_alive =3D false;
> +       bool top_rom =3D false;
>         struct hci_dev *hdev =3D data->hdev;
>
>         struct txq *txq =3D &data->txq;
> @@ -687,7 +703,20 @@ static int btintel_pcie_send_sync(struct btintel_pci=
e_data *data,
>         wait_on_alive =3D (pkt_type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
>                 (opcode =3D=3D BTINTEL_HCI_OP_RESET || opcode =3D=3D HCI_=
OP_RESET));
>
> -       if (wait_on_alive) {
> +       /* After TOP reset the controller is in ROM; no alive interrupt f=
ollows */
> +       if (wait_on_alive && test_bit(BTINTEL_PCIE_TOP_RESET, &data->flag=
s)) {
> +               u32 stage =3D btintel_pcie_rd_reg32(data,
> +                                                 BTINTEL_PCIE_CSR_BOOT_S=
TAGE_REG);
> +
> +               top_rom =3D (stage & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM) &&
> +                         !(stage & (BTINTEL_PCIE_CSR_BOOT_STAGE_IML |
> +                                    BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW));
> +       }
> +
> +       if (top_rom) {
> +               /* Set before the doorbell so GP0 never sees a transient =
context */
> +               data->alive_intr_ctxt =3D BTINTEL_PCIE_FW_DL;
> +       } else if (wait_on_alive) {
>                 data->gp0_received =3D false;
>                 old_ctxt =3D data->alive_intr_ctxt;
>                 data->alive_intr_ctxt =3D
> @@ -728,6 +757,14 @@ static int btintel_pcie_send_sync(struct btintel_pci=
e_data *data,
>                 return -ETIME;
>         }
>
> +       if (top_rom) {
> +               /* Let the TX completion handler finish updating the IA *=
/
> +               btintel_pcie_synchronize_irqs(data);
> +               btintel_pcie_reset_ia(data);
> +               btintel_pcie_start_rx(data);
> +               return 0;
> +       }
> +
>         if (wait_on_alive) {
>                 ret =3D wait_event_timeout(data->gp0_wait_q,
>                                          data->gp0_received,
> @@ -2261,11 +2298,18 @@ static int btintel_parse_mbox_tlv(struct btintel_=
pcie_data *data)
>
>  static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data=
)
>  {
> +       ktime_t calltime, delta, rettime;
> +       unsigned long long duration;
> +       bool top_reset_mbox =3D false;
>         bool target_access =3D false;
> +       bool mbox2_status;
>         u32 addr =3D 0, size =3D 0;
>
> +       calltime =3D ktime_get();
> +
>         /* Read the Mail box status and registers */
>         data->mbox.mbox_status =3D btintel_pcie_rd_reg32(data, BTINTEL_PC=
IE_CSR_MBOX_STATUS_REG);
> +       mbox2_status =3D data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_S=
TATUS_MBOX2;
>         if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) =
{
>                 data->mbox.mbox1 =3D btintel_pcie_rd_reg32(data, BTINTEL_=
PCIE_CSR_MBOX_1_REG);
>                 if (data->mbox.mbox1 =3D=3D
> @@ -2273,14 +2317,29 @@ static void btintel_pcie_msix_gp1_handler(struct =
btintel_pcie_data *data)
>                         if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
>                                 bt_dev_info(data->hdev,
>                                             "mailbox for target access");
> +                       clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
> +                                 &data->flags);
>                         target_access =3D true;
> +               } else if (data->mbox.mbox1 =3D=3D BTINTEL_PCIE_TOP_SILEN=
T_RESET) {
> +                       if (mbox2_status)
> +                               top_reset_mbox =3D true;
> +                       else
> +                               set_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PEND=
ING,
> +                                       &data->flags);
> +               } else {
> +                       clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
> +                                 &data->flags);
>                 }
>         }
>
> -       if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) =
{
> -               data->mbox.mbox2 =3D btintel_pcie_rd_reg32(data, BTINTEL_=
PCIE_CSR_MBOX_2_REG);
> +       if (mbox2_status) {
> +               data->mbox.mbox2 =3D btintel_pcie_rd_reg32(data,
> +                                                        BTINTEL_PCIE_CSR=
_MBOX_2_REG);
>                 if (target_access)
>                         addr =3D data->mbox.mbox2;
> +               if (test_and_clear_bit(BTINTEL_PCIE_TOP_RESET_MBOX1_PENDI=
NG,
> +                                      &data->flags))
> +                       top_reset_mbox =3D true;
>         }
>
>         if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) =
{
> @@ -2321,10 +2380,105 @@ static void btintel_pcie_msix_gp1_handler(struct=
 btintel_pcie_data *data)
>                 }
>         }
>
> +       /* Handle SCU state change inline, just log it */
> +       if ((data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1)=
 &&
> +           data->mbox.mbox1 =3D=3D BTINTEL_PCIE_CNVI_SCU_REG_MAIN_FSM_ST=
ICKY &&
> +           mbox2_status) {
> +               if (data->mbox.mbox2 =3D=3D BTINTEL_PCIE_SCU_CORE_IDLE_SE=
T)
> +                       bt_dev_dbg(data->hdev, "TOP reset SCU CORE IDLE s=
et");
> +               if (data->mbox.mbox2 =3D=3D BTINTEL_PCIE_SCU_CORE_IDLE_RE=
SET)
> +                       bt_dev_dbg(data->hdev, "TOP reset SCU CORE IDLE r=
eset");
> +       }
> +
> +       /* Handle TOP silent reset mbox notification inline */
> +       if (top_reset_mbox) {
> +               u32 expires =3D BTINTEL_PCIE_TOP_RESET_INTERVAL_MS;
> +               struct hci_dev *hdev =3D READ_ONCE(data->hdev);
> +               struct btintel_pcie_dev_recovery *rec;
> +               u32 reg;
> +
> +               rec =3D btintel_pcie_get_recovery(data->pdev,
> +                                               hdev ? &hdev->dev : NULL)=
;
> +               if (!rec) {
> +                       bt_dev_err(hdev,
> +                                  "TOP reset: failed to get recovery dat=
a");
> +                       goto skip_top_reset;
> +               }
> +
> +               switch (data->mbox.mbox2) {
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_REQUEST:
> +                       bt_dev_info(hdev,
> +                                   "TOP reset request from WiFi, trigger=
ing PLDR");
> +                       set_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
> +                               &rec->flags);
> +                       /* Order against the TOP_RESET and SETUP_DONE tes=
ts */
> +                       smp_mb__after_atomic();
> +                       if (!test_bit(BTINTEL_PCIE_TOP_RESET, &data->flag=
s)) {
> +                               bt_dev_info(hdev,
> +                                           "BT is follower, triggering P=
LDR");
> +                               if (btintel_pcie_request_reset(data,
> +                                                              BTINTEL_PC=
IE_IOSF_PRR_PLDR))
> +                                       set_bit(BTINTEL_PCIE_CORE_HALTED,
> +                                               &data->flags);
> +                               goto skip_top_reset;
> +                       }
> +                       set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
> +                               &rec->flags);
> +                       break;
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_ACK:
> +                       bt_dev_info(hdev, "TOP reset ack from WiFi");
> +                       break;
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_NACK:
> +                       bt_dev_info(hdev, "TOP reset NACK from WiFi");
> +                       set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec-=
>flags);
> +                       break;
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_REQ_ROLE_SWITCH:
> +                       bt_dev_info(hdev,
> +                                   "TOP reset WIFI_REQ_ROLE_SWITCH");
> +                       expires =3D BTINTEL_PCIE_TOP_RESET_ROLE_SWITCH_MS=
;
> +                       reg =3D btintel_pcie_rd_reg32(data,
> +                                                   BTINTEL_PCIE_CSR_RESE=
T_DEBUG_AD);
> +                       if (reg =3D=3D BTINTEL_PCIE_TOP_RESET_DBG_RESET_R=
EG)
> +                               bt_dev_dbg(hdev,
> +                                          "TOP reset initiated by WiFi")=
;
> +                       break;
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_NO_RESPONSE:
> +                       bt_dev_err(hdev, "TOP reset WIFI_NO_RESPONSE");
> +                       set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec-=
>flags);
> +                       break;
> +               case BTINTEL_PCIE_TOP_RESET_WIFI_RESPONSE_INVALID:
> +                       bt_dev_err(hdev,
> +                                  "TOP reset WIFI_RESPONSE_INVALID");
> +                       set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec-=
>flags);
> +                       break;
> +               default:
> +                       bt_dev_err(hdev,
> +                                  "TOP reset with undefined MBOX2 0x%8.8=
x",
> +                                  data->mbox.mbox2);
> +                       set_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec-=
>flags);
> +                       break;
> +               }
> +
> +               /* A later event must not shorten an earlier role switch =
timeout */
> +               expires =3D max(expires, READ_ONCE(data->top_reset_expire=
s));
> +               WRITE_ONCE(data->top_reset_expires, expires);
> +               smp_mb__before_atomic(); /* Publish expires before the fl=
ag */
> +               set_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
> +               bt_dev_info(hdev,
> +                           "TOP reset timer expires in %u ms", expires);
> +               wake_up(&data->gp0_wait_q);
> +       }
> +
> +skip_top_reset:
>         /* Mailbox is read, ack to FW */
>         btintel_pcie_set_reg_bits(data,
>                                   BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG,
>                                   BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CON=
FIRM);
> +
> +       rettime =3D ktime_get();
> +       delta =3D ktime_sub(rettime, calltime);
> +       duration =3D ktime_to_us(delta);
> +       bt_dev_dbg(data->hdev, "Mailbox acked in %llu usecs", duration);
>  }
>
>  /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
> @@ -2381,9 +2535,9 @@ static void btintel_pcie_msix_gp0_handler(struct bt=
intel_pcie_data *data)
>                 signal_waitq =3D true;
>                 break;
>         case BTINTEL_PCIE_FW_DL:
> -               /* Error case is already handled. Ideally control shall n=
ot
> -                * reach here
> -                */
> +               /* Wake the TOP reset boot-stage wait */
> +               if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags))
> +                       signal_waitq =3D true;
>                 break;
>         case BTINTEL_PCIE_INTEL_HCI_RESET1:
>                 if (btintel_pcie_in_op(data)) {
> @@ -3504,6 +3658,7 @@ static struct btintel_pcie_causes_list causes_list[=
] =3D {
>         { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x00 },
>         { BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,    BTINTEL_PCIE_CSR_MSIX_FH_=
INT_MASK,      0x01 },
>         { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,  BTINTEL_PCIE_CSR_MSIX_HW_=
INT_MASK,      0x20 },
> +       { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1,  BTINTEL_PCIE_CSR_MSIX_HW_=
INT_MASK,      0x21 },
>         { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,  BTINTEL_PCIE_CSR_MSIX_HW_=
INT_MASK,      0x22 },
>         { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW=
_INT_MASK,     0x23 },
>         { BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_H=
W_INT_MASK,    0x25 },
> @@ -4310,17 +4465,158 @@ static int btintel_pcie_setup_internal(struct hc=
i_dev *hdev,
>         return err;
>  }
>
> +static bool btintel_pcie_top_reset_done(struct btintel_pcie_data *data,
> +                                       struct btintel_pcie_dev_recovery =
*rec)
> +{
> +       return !btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_R=
EG) ||
> +              test_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
> +}
> +
> +static int btintel_pcie_do_top_reset(struct btintel_pcie_data *data,
> +                                    struct hci_dev *hdev)
> +{
> +       struct btintel_data *intel_data =3D hci_get_priv(hdev);
> +       enum btintel_pcie_reset_type reset_type;
> +       struct btintel_pcie_dev_recovery *rec;
> +       u32 expires, latest;
> +       long ret;
> +       bool failed;
> +       u32 reg;
> +       int err;
> +
> +       rec =3D btintel_pcie_get_recovery(data->pdev, &hdev->dev);
> +       if (!rec)
> +               return -ENOMEM;
> +
> +       /* Set scratch register to indicate TOP silent reset to FW */
> +       btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR=
,
> +                                 BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILEN=
T_RESET);
> +
> +       /* Clear mbox flag before sending reset to avoid race with ISR */
> +       clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
> +       clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED, &rec->flags);
> +
> +       if (test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags)) {
> +               bt_dev_info(hdev, "TOP reset: WiFi PLDR pending; doing PL=
DR");
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +               goto done;
> +       }
> +
> +       if (!intel_data->boot_addr) {
> +               bt_dev_err(hdev, "TOP reset: no boot address; doing PLDR"=
);
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +               goto done;
> +       }
> +
> +       err =3D btintel_send_intel_reset(hdev, intel_data->boot_addr);
> +       if (err) {
> +               bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +               goto done;
> +       }
> +
> +       /* First wait: wait for initial mbox event from FW */
> +       ret =3D wait_event_timeout(data->gp0_wait_q,
> +                                test_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &r=
ec->flags),
> +                                msecs_to_jiffies(BTINTEL_PCIE_TOP_RESET_=
FALLBACK_MS));
> +
> +       if (!ret) {
> +               bt_dev_warn(hdev,
> +                           "TOP reset: no mbox received within %u ms; do=
ing PLDR",
> +                           BTINTEL_PCIE_TOP_RESET_FALLBACK_MS);
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +               goto done;
> +       }
> +
> +       /* Second wait: mbox received, wait for boot_stage =3D=3D 0 using=
 the
> +        * timeout determined by the GP1 handler based on mbox2.
> +        */
> +       smp_rmb(); /* Pairs with smp_mb__before_atomic() in the GP1 handl=
er */
> +       expires =3D READ_ONCE(data->top_reset_expires);
> +       ret =3D wait_event_timeout(data->gp0_wait_q,
> +                                btintel_pcie_top_reset_done(data, rec),
> +                                msecs_to_jiffies(expires));
> +       latest =3D READ_ONCE(data->top_reset_expires);
> +       if (!ret && latest > expires)
> +               ret =3D wait_event_timeout(data->gp0_wait_q,
> +                                        btintel_pcie_top_reset_done(data=
, rec),
> +                                        msecs_to_jiffies(latest - expire=
s));
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_R=
EG);
> +       bt_dev_info(hdev, "After side band reset boot-stage: 0x%8.8x", re=
g);
> +
> +       failed =3D test_and_clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
> +                                   &rec->flags) ||
> +                test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags=
);
> +       if ((!ret && reg !=3D 0) || failed) {
> +               bt_dev_warn(hdev,
> +                           "TOP reset failed (boot_stage:0x%08x), trigge=
ring PLDR",
> +                           reg);
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +       } else {
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_FLR;
> +       }
> +
> +done:
> +       clear_bit(BTINTEL_PCIE_MBOX_TOP_RESET, &rec->flags);
> +       btintel_clear_flag(hdev, INTEL_TOP_RESET);
> +       btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR=
,
> +                                 BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILEN=
T_RESET);
> +
> +       if (test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->flags))
> +               reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +
> +       if (!btintel_pcie_queue_reset(data, reset_type)) {
> +               /* No reprobe will follow; let a PLDR request through. Op=
en the
> +                * gate before dropping TOP_RESET so that a GP1 request c=
annot
> +                * see both clear.
> +                */
> +               set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
> +               smp_mb__after_atomic(); /* Pairs with GP1 handler */
> +               clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +               return -EIO;
> +       }
> +
> +       /* Fail the open; reset_work reprobes the device */
> +       return -ECANCELED;
> +}
> +
>  static int btintel_pcie_setup(struct hci_dev *hdev)
>  {
> -       int err, fw_dl_retry =3D 0;
>         struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> -       bool fips_crc_failed;
> +       struct btintel_pcie_dev_recovery *rec;
> +       int err, fw_dl_retry =3D 0;
> +       bool pldr_retry, fips_crc_failed;
> +
> +       /* power_on can run before probe publishes hdev */
> +       WRITE_ONCE(data->hdev, hdev);
> +
> +       /* A queued reset reprobes the device and consumes the TOP reset =
intent
> +        * kept in rec->flags, so leave it for the reprobed instance.
> +        */
> +       if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
> +               return -ECANCELED;
> +
> +       /* Prevent async callers from scheduling reset_work during setup =
*/
> +       clear_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags);
> +       pldr_retry =3D test_and_clear_bit(BTINTEL_PCIE_PLDR_RETRY, &data-=
>flags);
> +
> +       /* Restore TOP reset intent saved across device_reprobe() */
> +       rec =3D btintel_pcie_get_recovery(data->pdev, &hdev->dev);
> +       if (rec && test_and_clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
> +                                     &rec->flags)) {
> +               set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +               btintel_set_flag(hdev, INTEL_TOP_RESET);
> +       }
>
>         btintel_pcie_fatal_err_load(data);
>
>         while ((err =3D btintel_pcie_setup_internal(hdev, &fips_crc_faile=
d)) &&
>                fw_dl_retry++ < 1) {
> -               if (fips_crc_failed)
> +               if (err =3D=3D -ENODEV || fips_crc_failed || pldr_retry |=
|
> +                   test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
> +                   (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
> +                                    &rec->flags)))
>                         break;
>
>                 bt_dev_err(hdev, "Firmware download retry count: %d",
> @@ -4345,6 +4641,44 @@ static int btintel_pcie_setup(struct hci_dev *hdev=
)
>                 btintel_pcie_start_rx(data);
>         }
>
> +       if (err =3D=3D -ECANCELED && test_bit(BTINTEL_PCIE_TOP_RESET, &da=
ta->flags))
> +               return btintel_pcie_do_top_reset(data, hdev);
> +
> +       if (err) {
> +               /* Open the PLDR gate before testing the WiFi request so =
that
> +                * either this path or the GP1 handler queues the PLDR. U=
se
> +                * SETUP_FAILED rather than PLDR_RETRY, which the next se=
tup()
> +                * would take as a failed PLDR and skip its firmware retr=
y.
> +                */
> +               set_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags);
> +               smp_mb__after_atomic(); /* Pairs with GP1 handler */
> +               /* The first lookup can fail; look again after the gate o=
pens */
> +               if (!rec)
> +                       rec =3D btintel_pcie_get_recovery(data->pdev, &hd=
ev->dev);
> +               if (pldr_retry ||
> +                   test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
> +                   (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
> +                                    &rec->flags))) {
> +                       bt_dev_err(hdev,
> +                                  "TOP silent reset setup failed (%d), d=
oing PLDR",
> +                                  err);
> +                       if (btintel_pcie_queue_reset(data,
> +                                                    BTINTEL_PCIE_IOSF_PR=
R_PLDR)) {
> +                               if (rec &&
> +                                   test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_P=
ENDING,
> +                                            &rec->flags))
> +                                       set_bit(BTINTEL_PCIE_CORE_HALTED,
> +                                               &data->flags);
> +                               return -ECANCELED;
> +                       }
> +
> +                       /* No reprobe will follow; a later reset must be =
PLDR */
> +                       set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
> +                       clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +                       btintel_clear_flag(hdev, INTEL_TOP_RESET);
> +               }
> +       }
> +
>         if (!err) {
>                 /* Fatal error test mode: arm the post-setup injection be=
fore
>                  * SETUP_DONE so the rfkill work cannot inject a fault ah=
ead of
> @@ -4352,7 +4686,23 @@ static int btintel_pcie_setup(struct hci_dev *hdev=
)
>                  */
>                 if (btintel_pcie_fatal_err_testmode_active(data))
>                         set_bit(BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING=
, &data->flags);
> +               clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +               btintel_clear_flag(hdev, INTEL_TOP_RESET);
>                 set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
> +               smp_mb__after_atomic(); /* Pairs with GP1 handler */
> +               if (!rec)
> +                       rec =3D btintel_pcie_get_recovery(data->pdev, &hd=
ev->dev);
> +               if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
> +                                   &rec->flags)) {
> +                       clear_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
> +                       if (btintel_pcie_queue_reset(data,
> +                                                    BTINTEL_PCIE_IOSF_PR=
R_PLDR) ||
> +                           test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
> +                                    &data->flags))
> +                               set_bit(BTINTEL_PCIE_CORE_HALTED, &data->=
flags);
> +                       return -ECANCELED;
> +               }
> +
>                 set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags)=
;
>                 btintel_pcie_unmask_hw_rfkill(data);
>                 btintel_delayed_hw_rfkill(data, true);
> @@ -4367,19 +4717,21 @@ static int btintel_pcie_setup(struct hci_dev *hde=
v)
>  static struct btintel_pcie_dev_recovery *
>  btintel_pcie_get_recovery(struct pci_dev *pdev, struct device *dev)
>  {
> +       struct hci_dev *hdev =3D dev ? to_hci_dev(dev) : NULL;
>         struct btintel_pcie_dev_recovery *tmp, *data =3D NULL;
>         const char *name =3D pci_name(pdev);
>         const size_t name_len =3D strlen(name) + 1;
> -       struct hci_dev *hdev =3D to_hci_dev(dev);
> +       unsigned long flags;
>
> -       spin_lock(&btintel_pcie_recovery_lock);
> +       /* Also called from the GP1 irq thread */
> +       spin_lock_irqsave(&btintel_pcie_recovery_lock, flags);
>         list_for_each_entry(tmp, &btintel_pcie_recovery_list, list) {
>                 if (strcmp(tmp->name, name))
>                         continue;
>                 data =3D tmp;
>                 break;
>         }
> -       spin_unlock(&btintel_pcie_recovery_lock);
> +       spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags);
>
>         if (data) {
>                 bt_dev_dbg(hdev, "Found restart data for BDF: %s", data->=
name);
> @@ -4391,9 +4743,17 @@ btintel_pcie_get_recovery(struct pci_dev *pdev, st=
ruct device *dev)
>                 return NULL;
>
>         strscpy(data->name, name, name_len);
> -       spin_lock(&btintel_pcie_recovery_lock);
> +       spin_lock_irqsave(&btintel_pcie_recovery_lock, flags);
> +       /* Recheck: another caller may have added this BDF meanwhile */
> +       list_for_each_entry(tmp, &btintel_pcie_recovery_list, list) {
> +               if (strcmp(tmp->name, name))
> +                       continue;
> +               spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags=
);
> +               kfree(data);
> +               return tmp;
> +       }
>         list_add_tail(&data->list, &btintel_pcie_recovery_list);
> -       spin_unlock(&btintel_pcie_recovery_lock);
> +       spin_unlock_irqrestore(&btintel_pcie_recovery_lock, flags);
>
>         return data;
>  }
> @@ -4433,7 +4793,8 @@ static void btintel_pcie_inc_recovery_count(struct =
pci_dev *pdev,
>  }
>
>  #ifdef CONFIG_ACPI
> -static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
)
> +static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
,
> +                                         struct pci_dev *wifi)
>  {
>         union acpi_object *obj, argv4;
>         acpi_handle handle;
> @@ -4464,6 +4825,21 @@ static int btintel_pcie_acpi_reset_method(struct b=
tintel_pcie_data *data)
>                 return -ENODEV;
>         }
>
> +       /* Unbind may hold the device lock while waiting for reset_work. =
*/
> +       if (!pci_dev_trylock(data->pdev))
> +               return -EAGAIN;
> +
> +       if (wifi) {
> +               pci_dev_unlock(data->pdev);
> +               device_release_driver(&wifi->dev);
> +               if (!pci_dev_trylock(data->pdev)) {
> +                       if (device_reprobe(&wifi->dev))
> +                               BT_ERR("WiFi reprobe failed for BDF:%s",
> +                                      pci_name(wifi));
> +                       return -EAGAIN;
> +               }
> +       }
> +
>         argv4.buffer.type =3D ACPI_TYPE_BUFFER;
>         argv4.buffer.length =3D sizeof(mode);
>         argv4.buffer.pointer =3D (void *)&mode;
> @@ -4472,29 +4848,33 @@ static int btintel_pcie_acpi_reset_method(struct =
btintel_pcie_data *data)
>                                 BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
>         if (!obj) {
>                 bt_dev_err(data->hdev, "Failed to call dsm to set reset m=
ethod");
> -               return -EIO;
> +               ret =3D -EIO;
> +               goto out_unlock;
>         }
>         ACPI_FREE(obj);
>
> -       pci_dev_lock(data->pdev);
>         pci_save_state(data->pdev);
>         ret =3D btintel_acpi_reset_method(hdev);
>         if (ret)
>                 bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d), PLDR=
 incomplete",
>                            ret);
>         pci_restore_state(data->pdev);
> +out_unlock:
>         pci_dev_unlock(data->pdev);
> +       if (wifi && device_reprobe(&wifi->dev))
> +               BT_ERR("WiFi reprobe failed for BDF:%s", pci_name(wifi));
>         return ret;
>  }
>  #else
> -static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
)
> +static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
,
> +                                         struct pci_dev *wifi)
>  {
>         bt_dev_err(data->hdev, "No support for ACPI, cold boot");
>         return -EOPNOTSUPP;
>  }
>  #endif
>
> -static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
> +static int btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
>  {
>         struct pci_dev *pdev =3D data->pdev;
>         struct pci_dev *wifi =3D NULL;
> @@ -4515,7 +4895,7 @@ static void btintel_pcie_perform_pldr(struct btinte=
l_pcie_data *data)
>
>         bus =3D pdev->bus;
>         if (!bus)
> -               return;
> +               return -ENODEV;
>
>         list_for_each_entry(tmp, &bus->devices, bus_list) {
>                 if (pci_match_id(wifi_device_ids, tmp)) {
> @@ -4524,9 +4904,6 @@ static void btintel_pcie_perform_pldr(struct btinte=
l_pcie_data *data)
>                 }
>         }
>
> -       if (wifi)
> -               device_release_driver(&wifi->dev);
> -
>         /* Wi-Fi is fully unbound before the reset and fully reprobed aft=
er
>          * the normal PCI probe path handles all state setup from scratch=
.
>          * BT needs pci_save_state()/pci_restore_state() because the BT d=
river
> @@ -4534,18 +4911,25 @@ static void btintel_pcie_perform_pldr(struct btin=
tel_pcie_data *data)
>          * The PCI device needs to remain minimally functional so that
>          * device_reprobe(&pdev->dev) can work afterward
>          */
> -       ret =3D btintel_pcie_acpi_reset_method(data);
> +       ret =3D btintel_pcie_acpi_reset_method(data, wifi);
>
> -       if (wifi) {
> -               if (device_reprobe(&wifi->dev))
> -                       BT_ERR("WiFi reprobe failed for BDF:%s", pci_name=
(wifi));
> +       if (wifi)
>                 pci_dev_put(wifi);
> -       }
>
>         if (!ret) {
> +               struct btintel_pcie_dev_recovery *rec;
> +
> +               /* This PLDR also reset WiFi; do not replay its request *=
/
> +               rec =3D btintel_pcie_get_recovery(pdev, &data->hdev->dev)=
;
> +               if (rec)
> +                       clear_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
> +                                 &rec->flags);
> +
>                 if (device_reprobe(&pdev->dev))
>                         BT_ERR("BT reprobe failed for BDF:%s", pci_name(p=
dev));
>         }
> +
> +       return ret;
>  }
>
>  /*
> @@ -4558,7 +4942,7 @@ static void btintel_pcie_perform_pldr(struct btinte=
l_pcie_data *data)
>  static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
>  {
>         struct pci_dev *pdev =3D data->pdev;
> -       int err;
> +       int err, reprobe_err;
>
>         /* pci_try_reset_function() avoids the device_lock ABBA against
>          * btintel_pcie_remove(): .remove() runs with device_lock held an=
d
> @@ -4573,20 +4957,86 @@ static int btintel_pcie_perform_flr(struct btinte=
l_pcie_data *data)
>         }
>
>         /* device_reprobe() always detaches the driver first (running
> -        * .remove(), which frees 'data'); any re-probe failure leaves th=
e
> -        * device unbound but 'data' is already gone, so just log it.
> +        * .remove(), which frees 'data'). A failed probe leaves the devi=
ce
> +        * unbound without necessarily making device_reprobe() fail, so c=
heck
> +        * the binding as well. 'data' is already gone, so just log it.
>          */
> -       if (device_reprobe(&pdev->dev))
> -               BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
> +       reprobe_err =3D device_reprobe(&pdev->dev);
> +       if (reprobe_err || !device_is_bound(&pdev->dev)) {
> +               struct btintel_pcie_dev_recovery *rec;
> +
> +               BT_ERR("BT reprobe failed for BDF:%s (%d)", pci_name(pdev=
),
> +                      reprobe_err);
> +
> +               /* No setup() will consume the TOP reset intent */
> +               rec =3D btintel_pcie_get_recovery(pdev, NULL);
> +               if (rec)
> +                       clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
> +                                 &rec->flags);
> +       }
>
>         return 0;
>  }
>
> +/* No reprobe will follow a failed reset; undo the reset state */
> +static void btintel_pcie_reset_failed(struct btintel_pcie_data *data)
> +{
> +       struct btintel_pcie_dev_recovery *rec;
> +       bool top_reset;
> +
> +       rec =3D btintel_pcie_get_recovery(data->pdev, &data->hdev->dev);
> +       top_reset =3D test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +
> +       /* SETUP_DONE is not set during a TOP reset reprobe; allow a PLDR=
 retry
> +        * so that later reset requests are not rejected.
> +        */
> +       if (data->reset_type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR || top_res=
et)
> +               set_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags);
> +       if (rec)
> +               clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags=
);
> +       clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +       btintel_clear_flag(data->hdev, INTEL_TOP_RESET);
> +       enable_work(&data->coredump_work);
> +       enable_work(&data->hwexp_work);
> +       enable_work(&data->fwtrigger_work);
> +       enable_work(&data->mbox_work);
> +       enable_delayed_work(&data->user_dump_work);
> +       enable_delayed_work(&data->hw_rfkill_work);
> +       btintel_pcie_enable_interrupts(data);
> +       if (test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> +               btintel_pcie_unmask_hw_rfkill(data);
> +       clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
> +       smp_mb__after_atomic(); /* Pairs with GP1 handler */
> +
> +       if (data->reset_type !=3D BTINTEL_PCIE_IOSF_PRR_PLDR &&
> +           rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->fla=
gs) &&
> +           btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR))
> +               set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
> +}
> +
> +/* The reset helpers only trylock the device to stay clear of remove(), =
so
> + * ride out brief PM or probe contention instead of giving up. On succes=
s the
> + * device is reprobed and 'data' is gone, so only the result is used.
> + */
> +static int btintel_pcie_reset_retry_busy(struct btintel_pcie_data *data,
> +                                        int (*reset)(struct btintel_pcie=
_data *))
> +{
> +       int err, i =3D 0;
> +
> +       while ((err =3D reset(data)) =3D=3D -EAGAIN &&
> +              i++ < BTINTEL_PCIE_RESET_BUSY_RETRIES)
> +               msleep(BTINTEL_PCIE_RESET_BUSY_DELAY_MS);
> +
> +       return err;
> +}
> +
>  static void btintel_pcie_reset_work(struct work_struct *wk)
>  {
>         struct btintel_pcie_data *data =3D
>                 container_of(wk, struct btintel_pcie_data, reset_work);
> +       struct btintel_pcie_dev_recovery *rec;
>         struct pci_dev *pdev =3D data->pdev;
> +       int err;
>
>         pci_lock_rescan_remove();
>
> @@ -4614,10 +5064,17 @@ static void btintel_pcie_reset_work(struct work_s=
truct *wk)
>         clear_bit(BTINTEL_PCIE_USER_TRIGGERED_DUMP, &data->flags);
>         bt_dev_dbg(data->hdev, "Release bluetooth interface");
>
> +       rec =3D btintel_pcie_get_recovery(pdev,
> +                                       data->hdev ? &data->hdev->dev : N=
ULL);
> +       if (rec && test_bit(BTINTEL_PCIE_REC_WIFI_PLDR_PENDING, &rec->fla=
gs)) {
> +               clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags=
);
> +               data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +       }
> +
>         /* Both reset paths follow the same contract: on success they
>          * destroy 'data' via device_reprobe() (a fresh probe re-INIT_WOR=
Ks
>          * the dump workers with disable count 0), so enable_work() must
> -        * NOT be called on the success path. Only the FLR path can fail
> +        * NOT be called on the success path. Either reset can fail
>          * with 'data' still alive, in which case we balance the
>          * disable_work_sync() calls above so a later successful reset is
>          * not permanently blocked.
> @@ -4627,17 +5084,27 @@ static void btintel_pcie_reset_work(struct work_s=
truct *wk)
>          * or removed from the bus list while this code runs.
>          */
>         if (data->reset_type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR) {
> -               btintel_pcie_perform_pldr(data);
> +               if (btintel_pcie_reset_retry_busy(data, btintel_pcie_perf=
orm_pldr))
> +                       btintel_pcie_reset_failed(data);
>                 goto out;
>         }
>
> -       if (btintel_pcie_perform_flr(data)) {
> -               enable_work(&data->coredump_work);
> -               enable_work(&data->hwexp_work);
> -               enable_work(&data->fwtrigger_work);
> -               enable_work(&data->mbox_work);
> -               enable_delayed_work(&data->user_dump_work);
> -               enable_delayed_work(&data->hw_rfkill_work);
> +       err =3D btintel_pcie_reset_retry_busy(data, btintel_pcie_perform_=
flr);
> +       if (err) {
> +               if (err !=3D -EAGAIN &&
> +                   test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags)) {
> +                       bt_dev_warn(data->hdev,
> +                                   "FLR failure after TOP silent reset, =
falling back to PLDR");
> +                       data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +                       if (rec)
> +                               clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PEND=
ING,
> +                                         &rec->flags);
> +                       if (!btintel_pcie_reset_retry_busy(data,
> +                                                          btintel_pcie_p=
erform_pldr))
> +                               goto out;
> +               }
> +
> +               btintel_pcie_reset_failed(data);
>         }
>
>  out:
> @@ -4662,24 +5129,64 @@ static void btintel_pcie_reset_work(struct work_s=
truct *wk)
>   *     in-flight one (whose recovery will reinitialize the device
>   *     regardless of the dropped trigger's variant).
>   *
> - * The bit is cleared only by .remove() / re-probe via fresh devm
> - * allocation, which is the intended one-shot semantics: a reset
> - * tears down and re-probes 'data', so there is no "in-flight"
> - * reset to follow up after device_reprobe() succeeds.
> + * Successful resets tear down and re-probe 'data'. On failure,
> + * reset_failed() releases the bit after restoring the recovery state.
>   */
> -static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
> -                                      enum btintel_pcie_reset_type type)
> +static bool btintel_pcie_queue_reset(struct btintel_pcie_data *data,
> +                                    enum btintel_pcie_reset_type type)
>  {
> -       if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> -               return;
> +       struct btintel_pcie_dev_recovery *rec =3D NULL;
>
>         if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->fl=
ags))
> -               return;
> +               return false;
> +
> +       if (type =3D=3D BTINTEL_PCIE_IOSF_TOP_RESET) {
> +               rec =3D btintel_pcie_get_recovery(data->pdev, &data->hdev=
->dev);
> +               if (!rec) {
> +                       clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
> +                                 &data->flags);
> +                       return false;
> +               }
> +
> +               set_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +               set_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING, &rec->flags);
> +       }
>
>         data->reset_type =3D type;
>
>         pci_dev_get(data->pdev);
> -       schedule_work(&data->reset_work);
> +       if (!schedule_work(&data->reset_work)) {
> +               pci_dev_put(data->pdev);
> +               if (type =3D=3D BTINTEL_PCIE_IOSF_TOP_RESET) {
> +                       clear_bit(BTINTEL_PCIE_TOP_RESET, &data->flags);
> +                       clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
> +                                 &rec->flags);
> +               }
> +               clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags=
);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool btintel_pcie_request_reset(struct btintel_pcie_data *data,
> +                                      enum btintel_pcie_reset_type type)
> +{
> +       /* Any failure during or after a TOP silent reset falls back to P=
LDR */
> +       if (test_bit(BTINTEL_PCIE_TOP_RESET, &data->flags) ||
> +           test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags))
> +               type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +
> +       /* Allow resets after setup completes, retries of a failed PLDR, =
or a
> +        * PLDR after a failed setup.
> +        */
> +       if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags) &&
> +           !(type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR &&
> +             (test_bit(BTINTEL_PCIE_PLDR_RETRY, &data->flags) ||
> +              test_bit(BTINTEL_PCIE_SETUP_FAILED, &data->flags))))
> +               return false;
> +
> +       return btintel_pcie_queue_reset(data, type);
>  }
>
>  static void btintel_pcie_hci_reset(struct hci_dev *hdev)
> @@ -4726,13 +5233,47 @@ static struct attribute *btintel_pcie_attrs[] =3D=
 {
>
>  ATTRIBUTE_GROUPS(btintel_pcie);
>
> +static const char *btintel_pcie_resettype_to_str(u8 reset_type)
> +{
> +       switch (reset_type) {
> +       case BTINTEL_PCIE_IOSF_PRR_FLR:
> +               return "FLR";
> +       case BTINTEL_PCIE_IOSF_PRR_PLDR:
> +               return "PLDR";
> +       case BTINTEL_PCIE_IOSF_TOP_RESET:
> +               return "TOP_RESET";
> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
> +static bool btintel_pcie_top_reset_supported(struct btintel_pcie_data *d=
ata)
> +{
> +       struct btintel_data *cnvi_data =3D hci_get_priv(data->hdev);
> +       u8 hw_variant =3D INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
> +
> +       if (hw_variant >=3D BTINTEL_HWID_SCP2 &&
> +           hw_variant !=3D BTINTEL_HWID_BZRIW &&
> +           data->pdev->subsystem_device =3D=3D BTINTEL_PCIE_SUBSYSTEM_ID=
_PEP) {
> +               bt_dev_info(data->hdev, "HW variant 0x%02x supports top-r=
eset",
> +                           hw_variant);
> +               return true;
> +       }
> +
> +       bt_dev_dbg(data->hdev,
> +                  "HW variant 0x%02x does not support top-reset", hw_var=
iant);
> +       return false;
> +}
> +
>  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
>  {
> -       struct btintel_pcie_dev_recovery *rec;
>         struct btintel_pcie_data *dev_data =3D hci_get_drvdata(hdev);
> +       struct btintel_pcie_dev_recovery *rec;
>         struct pci_dev *pdev =3D dev_data->pdev;
>         enum btintel_pcie_reset_type type;
>         time64_t retry_window;
> +       bool top_reset;
> +       int max_retry =3D BTINTEL_PCIE_FLR_MAX_RETRY;
>
>         if (test_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &dev_data->flags)=
)
>                 return;
> @@ -4743,25 +5284,37 @@ static void btintel_pcie_hw_error(struct hci_dev =
*hdev, u8 code)
>         if (!rec)
>                 return;
>
> -       type =3D (code =3D=3D 0x13) ? BTINTEL_PCIE_IOSF_PRR_PLDR
> -                             : BTINTEL_PCIE_IOSF_PRR_FLR;
> +       top_reset =3D code =3D=3D 0x13 && btintel_pcie_top_reset_supporte=
d(dev_data);
> +       retry_window =3D ktime_get_boottime_seconds() - rec->last_error;
> +
> +       if (code !=3D 0x13) {
> +               type =3D BTINTEL_PCIE_IOSF_PRR_FLR;
> +       } else if (top_reset && !(retry_window < BTINTEL_PCIE_RESET_WINDO=
W_SECS &&
> +                                 rec->count)) {
> +               type =3D BTINTEL_PCIE_IOSF_TOP_RESET;
> +       } else {
> +               type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
> +               /* A repeated error right after a TOP reset gets one PLDR=
 */
> +               if (top_reset)
> +                       max_retry++;
> +       }
>
>         bt_dev_err(hdev, "Encountered exception err:0x%x triggering: %s",=
 code,
> -                  type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR=
");
> -       retry_window =3D ktime_get_boottime_seconds() - rec->last_error;
> +                  btintel_pcie_resettype_to_str(type));
>
>         if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
> -           rec->count >=3D BTINTEL_PCIE_FLR_MAX_RETRY) {
> +           rec->count >=3D max_retry) {
>                 bt_dev_err(hdev, "Exhausted maximum: %d recovery attempts=
: %d",
> -                          BTINTEL_PCIE_FLR_MAX_RETRY, rec->count);
> +                          max_retry, rec->count);
>                 bt_dev_dbg(hdev, "Boot time: %lld seconds",
>                            ktime_get_boottime_seconds());
>                 bt_dev_dbg(hdev, "last error at: %lld seconds",
>                            rec->last_error);
>                 return;
>         }
> -       btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
> -       btintel_pcie_request_reset(dev_data, type);
> +
> +       if (btintel_pcie_request_reset(dev_data, type))
> +               btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
>  }
>
>  static bool btintel_pcie_wakeup(struct hci_dev *hdev)
> @@ -4890,7 +5443,7 @@ static int btintel_pcie_setup_hdev(struct btintel_p=
cie_data *data)
>          * worker bails on !data->hdev, so it never observes a half-set-u=
p
>          * device.
>          */
> -       data->hdev =3D hdev;
> +       WRITE_ONCE(data->hdev, hdev);
>         data->dmp_hdr.driver_name =3D KBUILD_MODNAME;
>         return 0;
>  }
> @@ -5026,6 +5579,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>
>  static void btintel_pcie_remove(struct pci_dev *pdev)
>  {
> +       struct btintel_pcie_dev_recovery *rec;
>         struct btintel_pcie_data *data;
>
>         data =3D pci_get_drvdata(pdev);
> @@ -5049,9 +5603,21 @@ static void btintel_pcie_remove(struct pci_dev *pd=
ev)
>          * within the reset work itself (PLDR device_reprobe path) to avo=
id
>          * deadlock. current_work() returns the work_struct of the caller=
 if
>          * we are in a workqueue context.
> +        *
> +        * If a queued reset_work is cancelled before it runs, release th=
e
> +        * pci_dev reference that it owned. The TOP reset intent is dropp=
ed
> +        * either way, as no setup() will run to consume it.
>          */
> -       if (current_work() !=3D &data->reset_work)
> -               disable_work_sync(&data->reset_work);
> +       if (current_work() !=3D &data->reset_work) {
> +               if (disable_work_sync(&data->reset_work))
> +                       pci_dev_put(pdev);
> +
> +               rec =3D btintel_pcie_get_recovery(pdev,
> +                                               data->hdev ? &data->hdev-=
>dev : NULL);
> +               if (rec)
> +                       clear_bit(BTINTEL_PCIE_REC_TOP_RESET_PENDING,
> +                                 &rec->flags);
> +       }
>
>         btintel_pcie_mask_hw_rfkill(data);
>         btintel_pcie_synchronize_irqs(data);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index b60e24ca558d..738cd3d4826a 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -12,6 +12,7 @@
>  #define BTINTEL_PCIE_CSR_BASE                  (0x000)
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG         (BTINTEL_PCIE_CSR_BASE + =
0x024)
>  #define BTINTEL_PCIE_CSR_HW_REV_REG            (BTINTEL_PCIE_CSR_BASE + =
0x028)
> +#define BTINTEL_PCIE_CSR_FUNC_SCRATCH_CSR      (BTINTEL_PCIE_CSR_BASE + =
0x02C)
>  #define BTINTEL_PCIE_CSR_RF_ID_REG             (BTINTEL_PCIE_CSR_BASE + =
0x09C)
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG                (BTINTEL_PCIE_CSR=
_BASE + 0x108)
>  #define BTINTEL_PCIE_CSR_IPC_CONTROL_REG       (BTINTEL_PCIE_CSR_BASE + =
0x10C)
> @@ -26,6 +27,7 @@
>  #define BTINTEL_PCIE_CSR_MBOX_3_REG            (BTINTEL_PCIE_CSR_BASE + =
0x178)
>  #define BTINTEL_PCIE_CSR_MBOX_4_REG            (BTINTEL_PCIE_CSR_BASE + =
0x17C)
>  #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG       (BTINTEL_PCIE_CSR_BASE + =
0x180)
> +#define BTINTEL_PCIE_CSR_RESET_DEBUG_AD        (BTINTEL_PCIE_CSR_BASE + =
0x220)
>  #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG         (BTINTEL_PCIE_CSR_BASE + =
0x440)
>  #define BTINTEL_PCIE_PRPH_DEV_WR_REG           (BTINTEL_PCIE_CSR_BASE + =
0x454)
>  #define BTINTEL_PCIE_PRPH_DEV_RD_REG           (BTINTEL_PCIE_CSR_BASE + =
0x458)
> @@ -137,6 +139,13 @@
>  #define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2     0xD346
>  #define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2                0xE476
>
> +#define BTINTEL_PCIE_SUBSYSTEM_ID_PEP  0x0012
> +
> +#define BTINTEL_PCIE_TOP_RESET_DBG_RESET_REG           0x0AAAFFFF
> +#define BTINTEL_PCIE_CSR_FUNC_SCRATCH_TOP_SILENT_RESET BIT(9)
> +#define BTINTEL_PCIE_SCU_CORE_IDLE_SET                 0x0000000F
> +#define BTINTEL_PCIE_SCU_CORE_IDLE_RESET               0x0000000E
> +
>  /* Causes for the FH register interrupts */
>  enum msix_fh_int_causes {
>         BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0       =3D BIT(0),       /* caus=
e 0 */
> @@ -177,6 +186,14 @@ enum {
>         BTINTEL_PCIE_MBOX_PARSE_PENDING,
>         BTINTEL_PCIE_MBOX_PARSE_READY,
>         BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING,
> +       BTINTEL_PCIE_TOP_RESET,
> +       BTINTEL_PCIE_PLDR_RETRY,
> +       BTINTEL_PCIE_SETUP_FAILED,
> +       BTINTEL_PCIE_MBOX_TOP_RESET,
> +       BTINTEL_PCIE_MBOX_TOP_RESET_FAILED,
> +       BTINTEL_PCIE_TOP_RESET_MBOX1_PENDING,
> +       BTINTEL_PCIE_REC_TOP_RESET_PENDING,
> +       BTINTEL_PCIE_REC_WIFI_PLDR_PENDING,
>  };
>
>  enum btintel_pcie_tlv_type {
> @@ -206,14 +223,25 @@ enum msix_mbox_int_causes {
>  enum btintel_pcie_reset_type {
>         BTINTEL_PCIE_IOSF_PRR_FLR =3D 0,
>         BTINTEL_PCIE_IOSF_PRR_PLDR =3D 1,
> +       BTINTEL_PCIE_IOSF_TOP_RESET =3D 2,
>  };
>
> -enum btintel_pcie_mbox_msg {
> +enum btintel_pcie_mbox1_msg {
>         BTINTEL_PCIE_NO_USE =3D 0,
> -       BTINTEL_PCIE_TOP_SILENT_RESET,
> -       BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT,
> -       BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING,
> -       BTINTEL_PCIE_LAST_MESSAGE =3D 4095
> +       BTINTEL_PCIE_TOP_SILENT_RESET =3D 1,
> +       BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT =3D 2,
> +       BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING =3D 3,
> +       BTINTEL_PCIE_CNVI_SCU_REG_MAIN_FSM_STICKY =3D 0xC08,
> +       BTINTEL_PCIE_LAST_MESSAGE =3D 0xFFF,
> +};
> +
> +enum btintel_pcie_mbox2_msg {
> +       BTINTEL_PCIE_TOP_RESET_WIFI_REQUEST =3D 257, /* 0x101 */
> +       BTINTEL_PCIE_TOP_RESET_WIFI_ACK =3D 513, /* 0x201 */
> +       BTINTEL_PCIE_TOP_RESET_WIFI_NACK =3D 514, /* 0x202 */
> +       BTINTEL_PCIE_TOP_RESET_WIFI_REQ_ROLE_SWITCH =3D 515, /* 0x203 */
> +       BTINTEL_PCIE_TOP_RESET_WIFI_NO_RESPONSE =3D 771, /* 0x303 */
> +       BTINTEL_PCIE_TOP_RESET_WIFI_RESPONSE_INVALID =3D 4095, /* 0xFFF *=
/
>  };
>
>  #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
> @@ -846,6 +874,7 @@ struct btintel_pcie_data {
>         /* Timestamp captured in GP1 handler when mbox interrupt is recei=
ved */
>         ktime_t mbox_intr_ts;
>         bool            pcie_alloc_init;
> +       u32                     top_reset_expires;
>  };
>
>  static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
