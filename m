Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322B1A08A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793186; cv=none; b=VsesZbBs3sayIhL6TALRfjXLwjfAlnHyNI/p+dbYvThtIxqzz6t3z8q0nXPU1Ky8zwGs+G25z9R1SiBllXT1w9i3bw+UHcjbEMHoM300HZnwMWir74CQpOlsqC0kqEbSaUvr14ZOTel8nnNWFfmR3jQpWFob6/tN8CDSano4mjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793186; c=relaxed/simple;
	bh=1E7PJH3+/ESibs1smQOWoKAsQucPPJMAJGFo7QjRYdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsChCW5bjSlxdm/3bQP6NWjjT2avt2MN0aTfDsJnD2KA9wtK9Z6v6u7v/lmRMLpBTjOTljBXOxuuzH9ibqmxw+QPpx4MVOsprZV8pflpV0Cmoo6Be+QtbwTCw1vnvx9QSNLK659dt8NjvjtCotAGHt3weOhyQnua9/+JIYPdx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8kCjdEX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8kCjdEX"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so64434971fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727793182; x=1728397982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgIXCfBAoddBnDT1lbPHeFeNO0wvCpJ/cIXx/4wiVeg=;
        b=j8kCjdEXjAPW6uPzxq7D1rgEqo9Er9i+6iqjfToL2xvd/NwY3TsgM/FV5QthJXA7p8
         1Ot/XXCVa1VsfTgZL5e/l7W8bqGy5vJkkeuEY7vvP1y9fuVVI8FjFAWj+lctvzJiXJfd
         7/+RTrMJRU3OdYj1V4aEr5yIlTxcg7/AMp4HINlMcG2aScpr1j+ufL/m1pbgcedfMg0z
         PdKLNpF0Cycpen4fDs9G7QpFYkBJ7pIO+URgrzMTqgmfXMtKTj0jfYe2Zsstdn1hHoe0
         vCfsUOTY2tPNo0fbWuQ8ui0+rIW0VdW9Qc2nl0aSiPqy858RUSpMHixiHJBR0/naGulM
         dcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793182; x=1728397982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgIXCfBAoddBnDT1lbPHeFeNO0wvCpJ/cIXx/4wiVeg=;
        b=ijSZ5h/7UhceMvJ3Ua8qtOR4HBPHymphYqyDU//vkMOHK3dajCpK4sHmTVBtlRk2jm
         fzUzqK4GEG6mWTGOiefzt/H4LW4A5FJAEXY1LZzF5Hv/xNS+DZhmfC9m/CcTIhGsbINM
         4LJGQXS0YUFlgYCsKdLbeSMQ/JxffgZgIsWap0QZm4l1ZB2V7Lgkaybn8CvUwlYBzBld
         VwfD++p9sXXUVDXfyBZV59KDTgZnW7sTwzEhksxbG6rZe5MD/FNbFdD2TtWzRxzUjzEQ
         RuJf/4/sOcNFQ0S21hphKHec035B3XjjFVBGb92iHHnCRsU1YncybJhuC9ln8vp1tvZj
         6nIA==
X-Gm-Message-State: AOJu0YzIxIOUzE0KeIQSGRYfY9vNxlq2r2Y7Wvkw+cgX/3GHgrrhb+Kk
	I4hdLxpx07na9m8PrK5zq4fkV82GO4XsB+VVLzNjNJLF+lXjIH39pc5iwdSnfxK1BYcS7diqDBI
	TRriURhqTIo7pZU8q9P1G+9AdK6SKow==
X-Google-Smtp-Source: AGHT+IHgI0Y0w0Wrub+pBJTQSkAeCr5vfG6jflqTMLSTI3RirHwklZuttqlj7PpDFmcTCR6eVEAhN4Bu4C1cJSjx/Ds=
X-Received: by 2002:a2e:a99c:0:b0:2fa:d978:a6cf with SMTP id
 38308e7fff4ca-2fad978a992mr21065791fa.6.1727793181533; Tue, 01 Oct 2024
 07:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001104451.626964-1-kiran.k@intel.com>
In-Reply-To: <20241001104451.626964-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 10:32:47 -0400
Message-ID: <CABBYNZJRQV+bgYcVDCST1+_+KOMZWDSdAWMLUkVYy-Kni2WdnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Oct 1, 2024 at 6:29=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> The following handshake mechanism needs be followed after firmware
> download is completed to bring the firmware to running state.
>
> After firmware fragments of Operational image are downloaded and
> secure sends result of the image succeeds,
>
> 1. Driver sends HCI Intel reset with boot option #1 to switch FW image.
> 2. FW sends Alive GP[0] MSIx
> 3. Driver enables data path (doorbell 0x460 for RBDs, etc...)
> 4. Driver gets Bootup event from firmware
> 5. Driver performs D0 entry to device (WRITE to IPC_Sleep_Control =3D0x0)
> 6. FW sends Alive GP[0] MSIx
> 7. Device host interface is fully set for BT protocol stack operation.
> 8. Driver may optionally get debug event with ID 0x97 which can be droppe=
d

We should probably start versioning the boot sequence from the very
beginning, I also wonder if we should promote the use usage of
something like the hci_init_stage_sync for such use cases so one can
clearly define each step separately as a function which makes it very
simple to reuse them in different init stage (operational vs
intermediate).

> For Intermediate loadger image, all the above steps are applicable
> expcept #5 and #6.
>
> On HCI_OP_RESET, firmware raises alive interrupt. Driver needs to wait
> for it before passing control over to bluetooth stack.
>
> Co-developed-by: Devegowda Chandrashekar <chandrashekar.devegowda@intel.c=
om>
> Signed-off-by: Devegowda Chandrashekar <chandrashekar.devegowda@intel.com=
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      |  56 ++++++-
>  drivers/bluetooth/btintel.h      |   7 +
>  drivers/bluetooth/btintel_pcie.c | 262 ++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel_pcie.h |  16 +-
>  4 files changed, 329 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 1ccbb5157515..fed1a939aad6 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1841,6 +1841,37 @@ static int btintel_boot_wait(struct hci_dev *hdev,=
 ktime_t calltime, int msec)
>         return 0;
>  }
>
> +static int btintel_boot_wait_d0(struct hci_dev *hdev, ktime_t calltime,
> +                               int msec)
> +{
> +       ktime_t delta, rettime;
> +       unsigned long long duration;
> +       int err;
> +
> +       bt_dev_info(hdev, "Waiting for device transition to d0");
> +
> +       err =3D btintel_wait_on_flag_timeout(hdev, INTEL_WAIT_FOR_D0,
> +                                          TASK_INTERRUPTIBLE,
> +                                          msecs_to_jiffies(msec));
> +       if (err =3D=3D -EINTR) {
> +               bt_dev_err(hdev, "Device d0 move interrupted");
> +               return -EINTR;
> +       }
> +
> +       if (err) {
> +               bt_dev_err(hdev, "Device d0 move timeout");
> +               return -ETIMEDOUT;
> +       }
> +
> +       rettime =3D ktime_get();
> +       delta =3D ktime_sub(rettime, calltime);
> +       duration =3D (unsigned long long)ktime_to_ns(delta) >> 10;
> +
> +       bt_dev_info(hdev, "Device moved to D0 in %llu usecs", duration);
> +
> +       return 0;
> +}
> +
>  static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
>  {
>         ktime_t calltime;
> @@ -1849,6 +1880,7 @@ static int btintel_boot(struct hci_dev *hdev, u32 b=
oot_addr)
>         calltime =3D ktime_get();
>
>         btintel_set_flag(hdev, INTEL_BOOTING);
> +       btintel_set_flag(hdev, INTEL_WAIT_FOR_D0);
>
>         err =3D btintel_send_intel_reset(hdev, boot_addr);
>         if (err) {
> @@ -1861,13 +1893,28 @@ static int btintel_boot(struct hci_dev *hdev, u32=
 boot_addr)
>          * is done by the operational firmware sending bootup notificatio=
n.
>          *
>          * Booting into operational firmware should not take longer than
> -        * 1 second. However if that happens, then just fail the setup
> +        * 5 second. However if that happens, then just fail the setup
>          * since something went wrong.
>          */
> -       err =3D btintel_boot_wait(hdev, calltime, 1000);
> -       if (err =3D=3D -ETIMEDOUT)
> +       err =3D btintel_boot_wait(hdev, calltime, 5000);
> +       if (err =3D=3D -ETIMEDOUT) {
>                 btintel_reset_to_bootloader(hdev);
> +               goto exit_error;
> +       }
>
> +       if (hdev->bus =3D=3D HCI_PCI) {
> +               /* In case of PCIe, after receiving bootup event, driver =
performs
> +                * D0 entry by writing 0 to sleep control register (check
> +                * btintel_pcie_recv_event())
> +                * Firmware acks with alive interrupt indicating host is =
full ready to
> +                * perform BT operation. Lets wait here till INTEL_WAIT_F=
OR_D0
> +                * bit is cleared.
> +                */
> +               calltime =3D ktime_get();
> +               err =3D btintel_boot_wait_d0(hdev, calltime, 2000);
> +       }
> +
> +exit_error:
>         return err;
>  }
>
> @@ -3273,7 +3320,7 @@ int btintel_configure_setup(struct hci_dev *hdev, c=
onst char *driver_name)
>  }
>  EXPORT_SYMBOL_GPL(btintel_configure_setup);
>
> -static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb=
)
> +int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct intel_tlv *tlv =3D (void *)&skb->data[5];
>
> @@ -3302,6 +3349,7 @@ static int btintel_diagnostics(struct hci_dev *hdev=
, struct sk_buff *skb)
>  recv_frame:
>         return hci_recv_frame(hdev, skb);
>  }
> +EXPORT_SYMBOL_GPL(btintel_diagnostics);
>
>  int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index aa70e4c27416..b448c67e8ed9 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -178,6 +178,7 @@ enum {
>         INTEL_ROM_LEGACY,
>         INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
>         INTEL_ACPI_RESET_ACTIVE,
> +       INTEL_WAIT_FOR_D0,
>
>         __INTEL_NUM_FLAGS,
>  };
> @@ -249,6 +250,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev=
,
>  int btintel_shutdown_combined(struct hci_dev *hdev);
>  void btintel_hw_error(struct hci_dev *hdev, u8 code);
>  void btintel_print_fseq_info(struct hci_dev *hdev);
> +int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb);
>  #else
>
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -382,4 +384,9 @@ static inline void btintel_hw_error(struct hci_dev *h=
dev, u8 code)
>  static inline void btintel_print_fseq_info(struct hci_dev *hdev)
>  {
>  }
> +
> +static inline int btintel_diagnostics(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index fda47948c35d..cff3e7afdff9 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -48,6 +48,17 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>  #define BTINTEL_PCIE_HCI_EVT_PKT       0x00000004
>  #define BTINTEL_PCIE_HCI_ISO_PKT       0x00000005
>
> +/* Alive interrupt context */
> +enum {
> +       BTINTEL_PCIE_ROM,
> +       BTINTEL_PCIE_FW_DL,
> +       BTINTEL_PCIE_HCI_RESET,
> +       BTINTEL_PCIE_INTEL_HCI_RESET1,
> +       BTINTEL_PCIE_INTEL_HCI_RESET2,
> +       BTINTEL_PCIE_D0,
> +       BTINTEL_PCIE_D3
> +};
> +
>  static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia=
,
>                                      u16 queue_num)
>  {
> @@ -290,8 +301,9 @@ static int btintel_pcie_enable_bt(struct btintel_pcie=
_data *data)
>         /* wait for interrupt from the device after booting up to primary
>          * bootloader.
>          */
> +       data->alive_intr_ctxt =3D BTINTEL_PCIE_ROM;
>         err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> -                                msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT));
> +                                msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT_MS));
>         if (!err)
>                 return -ETIME;
>
> @@ -302,12 +314,78 @@ static int btintel_pcie_enable_bt(struct btintel_pc=
ie_data *data)
>         return 0;
>  }
>
> +/* BIT(0) - ROM, BIT(1) - IML and BIT(3) - OP
> + * Sometimes during firmware image switching from ROM to IML or IML to O=
P image,
> + * the previous image bit is not cleared by firmware when alive interrup=
t is
> + * received. Driver needs to take care of these sticky bits when decidin=
g the
> + * current image running on controller.
> + * Ex: 0x10 and 0x11 - both represents that controller is running IML
> + */
> +static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
> +{
> +       return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM &=
&
> +               !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IM=
L) &&
> +               !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OP=
FW);
> +}
> +
> +static inline bool btintel_pcie_in_op(struct btintel_pcie_data *data)
> +{
> +       return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW;
> +}
> +
> +static inline bool btintel_pcie_in_iml(struct btintel_pcie_data *data)
> +{
> +       return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML &=
&
> +               !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OP=
FW);
> +}
> +
> +static inline bool btintel_pcie_in_d3(struct btintel_pcie_data *data)
> +{
> +       return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_ST=
ATE_READY;
> +}
> +
> +static inline bool btintel_pcie_in_d0(struct btintel_pcie_data *data)
> +{
> +       return !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_=
STATE_READY);
> +}
> +
> +static void btintel_pcie_wr_sleep_cntrl(struct btintel_pcie_data *data,
> +                                       u32 dxstate)
> +{
> +       bt_dev_dbg(data->hdev, "writing sleep_ctl_reg: 0x%8.8x", dxstate)=
;
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG, d=
xstate);
> +}
> +
> +static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt=
)
> +{
> +       switch (alive_intr_ctxt) {
> +       case BTINTEL_PCIE_ROM:
> +               return "rom";
> +       case BTINTEL_PCIE_FW_DL:
> +               return "fw_dl";
> +       case BTINTEL_PCIE_D0:
> +               return "d0";
> +       case BTINTEL_PCIE_D3:
> +               return "d3";
> +       case BTINTEL_PCIE_HCI_RESET:
> +               return "hci_reset";
> +       case BTINTEL_PCIE_INTEL_HCI_RESET1:
> +               return "intel_reset1";
> +       case BTINTEL_PCIE_INTEL_HCI_RESET2:
> +               return "intel_reset2";
> +       default:
> +               return "unknown";
> +       }
> +       return "null";
> +}
> +
>  /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>   * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and=
 image response.
>   */
>  static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data=
)
>  {
> -       u32 reg;
> +       bool submit_rx, signal_waitq;
> +       u32 reg, old_ctxt;
>
>         /* This interrupt is for three different causes and it is not eas=
y to
>          * know what causes the interrupt. So, it compares each register =
value
> @@ -317,20 +395,87 @@ static void btintel_pcie_msix_gp0_handler(struct bt=
intel_pcie_data *data)
>         if (reg !=3D data->boot_stage_cache)
>                 data->boot_stage_cache =3D reg;
>
> +       bt_dev_dbg(data->hdev, "Alive context: %s old_boot_stage: 0x%8.8x=
 new_boot_stage: 0x%8.8x",
> +                  btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt=
),
> +                  data->boot_stage_cache, reg);
>         reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IMG_RESPONSE=
_REG);
>         if (reg !=3D data->img_resp_cache)
>                 data->img_resp_cache =3D reg;
>
>         data->gp0_received =3D true;
>
> -       /* If the boot stage is OP or IML, reset IA and start RX again */
> -       if (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW ||
> -           data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML) {
> +       old_ctxt =3D data->alive_intr_ctxt;
> +       submit_rx =3D false;
> +       signal_waitq =3D false;
> +
> +       switch (data->alive_intr_ctxt) {
> +       case BTINTEL_PCIE_ROM:
> +               data->alive_intr_ctxt =3D BTINTEL_PCIE_FW_DL;
> +               signal_waitq =3D true;
> +               break;
> +       case BTINTEL_PCIE_FW_DL:
> +               /* Error case is already handled. Ideally control shall n=
ot
> +                * reach here
> +                */
> +               break;
> +       case BTINTEL_PCIE_INTEL_HCI_RESET1:
> +               if (btintel_pcie_in_op(data)) {
> +                       submit_rx =3D true;
> +                       break;
> +               }
> +
> +               if (btintel_pcie_in_iml(data)) {
> +                       submit_rx =3D true;
> +                       data->alive_intr_ctxt =3D BTINTEL_PCIE_FW_DL;
> +                       break;
> +               }
> +               break;
> +       case BTINTEL_PCIE_INTEL_HCI_RESET2:
> +               if (btintel_test_and_clear_flag(data->hdev, INTEL_WAIT_FO=
R_D0)) {
> +                       btintel_wake_up_flag(data->hdev, INTEL_WAIT_FOR_D=
0);
> +                       data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
> +               }
> +               break;
> +       case BTINTEL_PCIE_D0:
> +               if (btintel_pcie_in_d3(data)) {
> +                       data->alive_intr_ctxt =3D BTINTEL_PCIE_D3;
> +                       signal_waitq =3D true;
> +                       break;
> +               }
> +               break;
> +       case BTINTEL_PCIE_D3:
> +               if (btintel_pcie_in_d0(data)) {
> +                       data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
> +                       submit_rx =3D true;
> +                       signal_waitq =3D true;
> +                       break;
> +               }
> +               break;
> +       case BTINTEL_PCIE_HCI_RESET:
> +               data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
> +               submit_rx =3D true;
> +               signal_waitq =3D true;
> +               break;
> +       default:
> +               bt_dev_err(data->hdev, "Unknown state: 0x%2.2x",
> +                          data->alive_intr_ctxt);
> +               break;
> +       }
> +
> +       if (submit_rx) {
>                 btintel_pcie_reset_ia(data);
>                 btintel_pcie_start_rx(data);
>         }
>
> -       wake_up(&data->gp0_wait_q);
> +       if (signal_waitq) {
> +               bt_dev_dbg(data->hdev, "wake up gp0 wait_q");
> +               wake_up(&data->gp0_wait_q);
> +       }
> +
> +       if (old_ctxt !=3D data->alive_intr_ctxt)
> +               bt_dev_dbg(data->hdev, "alive context changed: %s  ->  %s=
",
> +                          btintel_pcie_alivectxt_state2str(old_ctxt),
> +                          btintel_pcie_alivectxt_state2str(data->alive_i=
ntr_ctxt));
>  }
>
>  /* This function handles the MSX-X interrupt for rx queue 0 which is for=
 TX
> @@ -364,6 +509,80 @@ static void btintel_pcie_msix_tx_handle(struct btint=
el_pcie_data *data)
>         }
>  }
>
> +static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *)skb->data;
> +       const char diagnostics_hdr[] =3D { 0x87, 0x80, 0x03 };
> +       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +
> +       if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff &&
> +           hdr->plen > 0) {
> +               const void *ptr =3D skb->data + HCI_EVENT_HDR_SIZE + 1;
> +               unsigned int len =3D skb->len - HCI_EVENT_HDR_SIZE - 1;
> +
> +               if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> +                       switch (skb->data[2]) {
> +                       case 0x02:
> +                               /* When switching to the operational firm=
ware
> +                                * the device sends a vendor specific eve=
nt
> +                                * indicating that the bootup completed.
> +                                */
> +                               btintel_bootup(hdev, ptr, len);
> +
> +                               /* If bootup event is from operational im=
age,
> +                                * driver needs to write sleep control re=
gister to
> +                                * move into D0 state
> +                                */
> +                               if (btintel_pcie_in_op(data)) {
> +                                       btintel_pcie_wr_sleep_cntrl(data,=
 BTINTEL_PCIE_STATE_D0);
> +                                       data->alive_intr_ctxt =3D BTINTEL=
_PCIE_INTEL_HCI_RESET2;
> +                                       break;
> +                               }
> +
> +                               if (btintel_pcie_in_iml(data)) {
> +                                       /* In case of IML, there is no co=
ncept
> +                                        * of D0 transition. Just mimic a=
s if
> +                                        * IML moved to D0 by clearing IN=
TEL_WAIT_FOR_D0
> +                                        * bit and waking up the task wai=
ting on
> +                                        * INTEL_WAIT_FOR_D0. This is req=
uired
> +                                        * as intel_boot() is common func=
tion for
> +                                        * both IML and OP image loading.
> +                                        */
> +                                       if (btintel_test_and_clear_flag(d=
ata->hdev,
> +                                                                       I=
NTEL_WAIT_FOR_D0))
> +                                               btintel_wake_up_flag(data=
->hdev,
> +                                                                    INTE=
L_WAIT_FOR_D0);
> +                               }
> +                               break;
> +                       case 0x06:
> +                               /* When the firmware loading completes th=
e
> +                                * device sends out a vendor specific eve=
nt
> +                                * indicating the result of the firmware
> +                                * loading.
> +                                */
> +                               btintel_secure_send_result(hdev, ptr, len=
);
> +                               break;
> +                       }
> +               }
> +
> +               /* Handle all diagnostics events separately. May still ca=
ll
> +                * hci_recv_frame.
> +                */
> +               if (len >=3D sizeof(diagnostics_hdr) &&
> +                   memcmp(&skb->data[2], diagnostics_hdr,
> +                          sizeof(diagnostics_hdr)) =3D=3D 0) {
> +                       return btintel_diagnostics(hdev, skb);
> +               }
> +
> +               /* This is a debug event that comes from IML and OP image=
 when it
> +                * starts execution. There is no need pass this event to =
stack.
> +                */
> +               if (skb->data[2] =3D=3D 0x97)
> +                       return 0;
> +       }
> +
> +       return hci_recv_frame(hdev, skb);
> +}
>  /* Process the received rx data
>   * It check the frame header to identify the data type and create skb
>   * and calling HCI API
> @@ -465,7 +684,7 @@ static int btintel_pcie_recv_frame(struct btintel_pci=
e_data *data,
>         hdev->stat.byte_rx +=3D plen;
>
>         if (pcie_pkt_type =3D=3D BTINTEL_PCIE_HCI_EVT_PKT)
> -               ret =3D btintel_recv_event(hdev, new_skb);
> +               ret =3D btintel_pcie_recv_event(hdev, new_skb);
>         else
>                 ret =3D hci_recv_frame(hdev, new_skb);
>
> @@ -1053,8 +1272,11 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>                                        struct sk_buff *skb)
>  {
>         struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +       struct hci_command_hdr *cmd;
> +       __u16 opcode =3D ~0;
>         int ret;
>         u32 type;
> +       u32 old_ctxt;
>
>         /* Due to the fw limitation, the type header of the packet should=
 be
>          * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
> @@ -1073,6 +1295,8 @@ static int btintel_pcie_send_frame(struct hci_dev *=
hdev,
>         switch (hci_skb_pkt_type(skb)) {
>         case HCI_COMMAND_PKT:
>                 type =3D BTINTEL_PCIE_HCI_CMD_PKT;
> +               cmd =3D (void *)skb->data;
> +               opcode =3D le16_to_cpu(cmd->opcode);
>                 if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
>                         struct hci_command_hdr *cmd =3D (void *)skb->data=
;
>                         __u16 opcode =3D le16_to_cpu(cmd->opcode);
> @@ -1111,6 +1335,30 @@ static int btintel_pcie_send_frame(struct hci_dev =
*hdev,
>                 bt_dev_err(hdev, "Failed to send frame (%d)", ret);
>                 goto exit_error;
>         }
> +
> +       if (type =3D=3D BTINTEL_PCIE_HCI_CMD_PKT &&
> +           (opcode =3D=3D HCI_OP_RESET || opcode =3D=3D 0xfc01)) {
> +               old_ctxt =3D data->alive_intr_ctxt;
> +               data->alive_intr_ctxt =3D
> +                       (opcode =3D=3D 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RE=
SET1 :
> +                               BTINTEL_PCIE_HCI_RESET);
> +               bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context c=
hanged: %s  ->  %s",
> +                          opcode, btintel_pcie_alivectxt_state2str(old_c=
txt),
> +                          btintel_pcie_alivectxt_state2str(data->alive_i=
ntr_ctxt));
> +               if (opcode =3D=3D HCI_OP_RESET) {
> +                       data->gp0_received =3D false;
> +                       ret =3D wait_event_timeout(data->gp0_wait_q,
> +                                                data->gp0_received,
> +                                                msecs_to_jiffies(BTINTEL=
_DEFAULT_INTR_TIMEOUT_MS));
> +                       if (!ret) {
> +                               hdev->stat.err_tx++;
> +                               bt_dev_err(hdev, "No alive interrupt rece=
ived for %s",
> +                                          btintel_pcie_alivectxt_state2s=
tr(data->alive_intr_ctxt));
> +                               ret =3D -ETIME;
> +                               goto exit_error;
> +                       }
> +               }
> +       }
>         hdev->stat.byte_tx +=3D skb->len;
>         kfree_skb(skb);
>
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index baaff70420f5..8b7824ad005a 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -12,6 +12,7 @@
>  #define BTINTEL_PCIE_CSR_HW_REV_REG            (BTINTEL_PCIE_CSR_BASE + =
0x028)
>  #define BTINTEL_PCIE_CSR_RF_ID_REG             (BTINTEL_PCIE_CSR_BASE + =
0x09C)
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG                (BTINTEL_PCIE_CSR=
_BASE + 0x108)
> +#define BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG     (BTINTEL_PCIE_CSR_BASE + =
0x114)
>  #define BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x118)
>  #define BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG       (BTINTEL_PCIE_CSR_BASE + =
0x11C)
>  #define BTINTEL_PCIE_CSR_IMG_RESPONSE_REG      (BTINTEL_PCIE_CSR_BASE + =
0x12C)
> @@ -32,6 +33,7 @@
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN       (BIT(11))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON      (BIT(16))
>  #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE              (BIT(23))
> +#define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY     (BIT(24))
>
>  /* Registers for MSI-X */
>  #define BTINTEL_PCIE_CSR_MSIX_BASE             (0x2000)
> @@ -55,6 +57,16 @@ enum msix_hw_int_causes {
>         BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0     =3D BIT(0),       /* caus=
e 32 */
>  };
>
> +/* PCIe device states
> + * Host-Device interface is active
> + * Host-Device interface is inactive(as reflected by IPC_SLEEP_CONTROL_C=
SR_AD)
> + * Host-Device interface is inactive(as reflected by IPC_SLEEP_CONTROL_C=
SR_AD)
> + */
> +enum {
> +       BTINTEL_PCIE_STATE_D0 =3D 0,
> +       BTINTEL_PCIE_STATE_D3_HOT =3D 2,
> +       BTINTEL_PCIE_STATE_D3_COLD =3D 3,
> +};
>  #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE BIT(7)
>
>  /* Minimum and Maximum number of MSI-X Vector
> @@ -67,7 +79,7 @@ enum msix_hw_int_causes {
>  #define BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US  200000
>
>  /* Default interrupt timeout in msec */
> -#define BTINTEL_DEFAULT_INTR_TIMEOUT   3000
> +#define BTINTEL_DEFAULT_INTR_TIMEOUT_MS        3000
>
>  /* The number of descriptors in TX/RX queues */
>  #define BTINTEL_DESCS_COUNT    16
> @@ -343,6 +355,7 @@ struct rxq {
>   * @ia: Index Array struct
>   * @txq: TX Queue struct
>   * @rxq: RX Queue struct
> + * @alive_intr_ctxt: Alive interrupt context
>   */
>  struct btintel_pcie_data {
>         struct pci_dev  *pdev;
> @@ -389,6 +402,7 @@ struct btintel_pcie_data {
>         struct ia       ia;
>         struct txq      txq;
>         struct rxq      rxq;
> +       u32     alive_intr_ctxt;
>  };
>
>  static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
