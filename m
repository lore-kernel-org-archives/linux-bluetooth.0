Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA5239E98
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568773; cv=none; b=aFZvPo5RxayFKlq1ewI9xzVsI3e1pGAJYf8hPjJy0Ouh0wU4dWrZizDzElfm90t8he1g1SnxBJQJR+WaqS25I9AT/I82BEMC1ODeizJzg1niaeAL095tIJcWYGCPkNgz7BVJfhqNMnjOxWROXDIhja/HwwF5Tep5U5juWI4KON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568773; c=relaxed/simple;
	bh=SXnxX5TdCy4BN7o3A+xHNfurVr3yjarQ7EiECnI9mT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkuJlk6XQOL17o+gblY2dFAn7WMdaDXFEDIw+zEsbSE9U1T7h9VtV0kq+b5q1YHzn5DTutXu6dVfhHbzrn47kZEeWNTALEcnJQQPqx2aZsAWozUwO0kMpcDzgQwvzqlJ9jpuvw211bgtqMHjx2nHfEtNdUMtRmeecRb4Amoxrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI3GU1/H; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI3GU1/H"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32925727810so47169871fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568769; x=1750173569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUgzKHZw0fTHP/LEhI0YDqJa4fWPjC04tRc1fYpJ/ho=;
        b=WI3GU1/H2UHqObSa6xAlJyOYS3z2x/2GyItizvlFvPb6VFYGodZ4Y8bRz0BTLztB4m
         86VjEnX3RTfqbIILNN9ZUDu4AhjoiuXL3xlivLB24fTooRvUlCVXPX4SEySpEgbd6KP/
         5t7t4eCMiWn5lqs0401+p0l3g+/evytAvKYJ5jUlwISB6FxSYXwAWxtXFjiv4e8/us7E
         wz6TTto/RejU4/i6g2VtiSUo9BCluQVDgWuE2T9ZpY7a95YDASRab4rLOtPnh9/wP4PY
         jMK6CaTjgzcnQMRCT99WMMYZqZbaYWlEgP3BM4kuG+rEc4d2KKQ9gfOzGombV5cPTwja
         dKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568769; x=1750173569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUgzKHZw0fTHP/LEhI0YDqJa4fWPjC04tRc1fYpJ/ho=;
        b=pnT9nga9ui9uR9V4pfcm3ukuJx6t1oOadVCTYU5kT34CiuYVIpdXoFxM6MjU2m2GBW
         5GaE8I7Y7X+ASGnd3j1YdVR5SE3VXkPU0hn8yBqonBEKQKUKRPLtIRcisB0HLza7vRlJ
         k08kK1hElhf85mwvXvN90QMZrA+o8uD07Dy4m2rLvuhINgqtCfINm6nlBeulYfOidGQD
         WoTZ9yWUB2iD9xhXGRp1pLplJasIXIcjARxF2bqCEG9P/qAYuQhfcHGD7u8iDbNYQI9t
         DVrIGDyjHWvN1uN7+RcyfsU1ZcbjQjPMi/GNMJupzc1P4FKkn0Q0kE7H0RQLz+6jySkB
         K/og==
X-Forwarded-Encrypted: i=1; AJvYcCUrYUlk9Q/ofdhD/YiFyHl44X8mZ52GluqNSa+sEJAs/5PAAHpZfAQdmg9jMcKuFeNZpZ/kVc61Ocl8UeWiIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCITIovgtS8cGLBgf/zYj9HNT4uVuU4qBsiuQTNCkwbaLzeP1
	7HWt0pJ52agQFWS6S79043MEc7uH0P7tbn72VDt/Ua8G7szEkguWHkflli1ZXN6ceF88wUrzula
	p39POT0JI5iY80XRZz9MjOQ4TfhF2jI/Ssw==
X-Gm-Gg: ASbGnct+T/kr6TOsRJqxIeV1pMTGJPQknOcOZ3ydMZOgfiqewTJ3wPyCpPUygirNUYx
	n+AIti5yKi6bo/QwH3yoRHH0Yr6NvmJoKqES0Et96MbumMnijeMHSfxWFVQrlL4atPTplVoM5NU
	1Vh15OvcNJ6XVqw1XdttydwTsLcBOlx4MEesNbOgCwVA==
X-Google-Smtp-Source: AGHT+IEgdsxPtMW4m0YrFP89TlIwTdR+MtvQdc81iuJNJwqUyQUbZzwMZQecegZE9eQuHlMf8nFTICUVLqBZqkiZWrI=
X-Received: by 2002:a2e:95cc:0:b0:30c:c8d:ba3c with SMTP id
 38308e7fff4ca-32b2026fffbmr516031fa.17.1749568768882; Tue, 10 Jun 2025
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610140038.696091-1-kiran.k@intel.com> <20250610140038.696091-2-kiran.k@intel.com>
 <6b48977c-5b3a-4977-b1b0-a04f416a1511@molgen.mpg.de>
In-Reply-To: <6b48977c-5b3a-4977-b1b0-a04f416a1511@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Jun 2025 11:19:15 -0400
X-Gm-Features: AX0GCFvKURLS_2XXyx__fbj9qzmTigqxODCHiCRcx1AQ0llIGd3cPkS3sdxc928
Message-ID: <CABBYNZJF+djdG168EDbXdEgA2VR7eh6cAyAm_EjwyTW=BC7fWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btintel_pcie: Support Function level reset
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kiran K <kiran.k@intel.com>, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	aluvala.sai.teja@intel.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Jun 10, 2025 at 11:08=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Chandrashekar, dear Kiran,
>
>
> Thank you for the improved version. Sorry, but I still have a few minor
> comments.
>
> Am 10.06.25 um 16:00 schrieb Kiran K:
> > From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> >
> > The driver supports Function Level Reset (FLR) to recover the controlle=
r
> > upon hardware exceptions or hci command timeouts. FLR is triggered only
> > when no prior reset has occurred within the retry window, with a maximu=
m
> > of one FLR allowed within this window.
>
> Why only one FLR?

FLR is used for recovery, if it can't recover on the first try then it
probably can't be recovered with FLR alone.

> > This patch is tested by,
> > echo 1 >  /sys/class/bluetooth/hciX/reset
> >
> > Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.c=
om>
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > ---
> > changes in v3:
> > - Fix typos, indentation issues
> > - Update commit message to include test command
> > - Keep the flr max retry to 1
> >
> >   drivers/bluetooth/btintel_pcie.c | 226 ++++++++++++++++++++++++++++++=
-
> >   drivers/bluetooth/btintel_pcie.h |   4 +-
> >   2 files changed, 227 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index e1c688dd2d45..87e4b3546c7a 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -41,6 +41,13 @@ static const struct pci_device_id btintel_pcie_table=
[] =3D {
> >   };
> >   MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> >
> > +struct btintel_pcie_dev_restart_data {
> > +     struct list_head list;
> > +     u8 restart_count;
> > +     time64_t last_error;
> > +     char name[];
> > +};
> > +
> >   /* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI t=
ype */
> >   #define BTINTEL_PCIE_HCI_TYPE_LEN   4
> >   #define BTINTEL_PCIE_HCI_CMD_PKT    0x00000001
> > @@ -62,6 +69,9 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> >   #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER    0x17A2
> >   #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT               0x1E61
> >
> > +#define BTINTEL_PCIE_RESET_WINDOW_SECS               5
> > +#define BTINTEL_PCIE_FLR_MAX_RETRY   1
> > +
> >   /* Alive interrupt context */
> >   enum {
> >       BTINTEL_PCIE_ROM,
> > @@ -99,6 +109,14 @@ struct btintel_pcie_dbgc_ctxt {
> >       struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_C=
OUNT];
> >   };
> >
> > +struct btintel_pcie_removal {
> > +     struct pci_dev *pdev;
> > +     struct work_struct work;
> > +};
> > +
> > +static LIST_HEAD(btintel_pcie_restart_data_list);
> > +static DEFINE_SPINLOCK(btintel_pcie_restart_data_lock);
> > +
> >   /* This function initializes the memory for DBGC buffers and formats =
the
> >    * DBGC fragment which consists header info and DBGC buffer's LSB, MS=
B and
> >    * size as the payload
> > @@ -1932,6 +1950,9 @@ static int btintel_pcie_send_frame(struct hci_dev=
 *hdev,
> >       u32 type;
> >       u32 old_ctxt;
> >
> > +     if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
> > +             return -ENODEV;
> > +
> >       /* Due to the fw limitation, the type header of the packet should=
 be
> >        * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
> >        * the first byte to get the packet type and redirect the rest of=
 data
> > @@ -2192,9 +2213,196 @@ static int btintel_pcie_setup(struct hci_dev *h=
dev)
> >               }
> >               btintel_pcie_start_rx(data);
> >       }
> > +
> > +     if (!err)
> > +             set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
> >       return err;
> >   }
> >
> > +static struct btintel_pcie_dev_restart_data *btintel_pcie_get_restart_=
data(struct pci_dev *pdev,
> > +                                                                      =
  struct device *dev)
> > +{
> > +     struct btintel_pcie_dev_restart_data *tmp, *data =3D NULL;
> > +     const char *name =3D pci_name(pdev);
> > +     struct hci_dev *hdev =3D to_hci_dev(dev);
> > +
> > +     spin_lock(&btintel_pcie_restart_data_lock);
> > +     list_for_each_entry(tmp, &btintel_pcie_restart_data_list, list) {
> > +             if (strcmp(tmp->name, name))
> > +                     continue;
> > +             data =3D tmp;
> > +             break;
> > +     }
> > +     spin_unlock(&btintel_pcie_restart_data_lock);
> > +
> > +     if (data) {
> > +             bt_dev_dbg(hdev, "Found restart data for BDF: %s", data->=
name);
> > +             return data;
> > +     }
> > +
> > +     data =3D kzalloc(struct_size(data, name, strlen(name) + 1), GFP_A=
TOMIC);
> > +     if (!data)
> > +             return NULL;
> > +
> > +     strscpy_pad(data->name, name, strlen(name) + 1);
> > +     spin_lock(&btintel_pcie_restart_data_lock);
> > +     list_add_tail(&data->list, &btintel_pcie_restart_data_list);
> > +     spin_unlock(&btintel_pcie_restart_data_lock);
> > +
> > +     return data;
> > +}
> > +
> > +static void btintel_pcie_free_restart_list(void)
> > +{
> > +     struct btintel_pcie_dev_restart_data *tmp;
> > +
> > +     while ((tmp =3D list_first_entry_or_null(&btintel_pcie_restart_da=
ta_list,
> > +                                            typeof(*tmp), list))) {
> > +             list_del(&tmp->list);
> > +             kfree(tmp);
> > +     }
> > +}
> > +
> > +static void btintel_pcie_inc_restart_count(struct pci_dev *pdev,
> > +                                        struct device *dev)
> > +{
> > +     struct btintel_pcie_dev_restart_data *data;
> > +     struct hci_dev *hdev =3D to_hci_dev(dev);
> > +     time64_t retry_window;
> > +
> > +     data =3D btintel_pcie_get_restart_data(pdev, dev);
> > +     if (!data)
> > +             return;
> > +
> > +     retry_window =3D ktime_get_boottime_seconds() - data->last_error;
> > +     if (data->restart_count =3D=3D 0) {
> > +             data->last_error =3D ktime_get_boottime_seconds();
> > +             data->restart_count++;
> > +             bt_dev_dbg(hdev, "First iteration initialise. last_error:=
 %lld seconds restart_count: %d",
> > +                        data->last_error, data->restart_count);
> > +     } else if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
> > +                data->restart_count <=3D BTINTEL_PCIE_FLR_MAX_RETRY) {
> > +             data->restart_count++;
> > +             bt_dev_dbg(hdev, "Flr triggered within the max retry time=
 so increment the restart_count: %d",
>
> Spell it FLR?

This is maybe misleading since the idea now is that the FLR is only
triggered once, we could probably remove restart_count altogether and
just a flag to indicate FLR has been triggered.

> > +                        data->restart_count);
> > +     } else if (retry_window > BTINTEL_PCIE_RESET_WINDOW_SECS) {
> > +             data->last_error =3D 0;
> > +             data->restart_count =3D 0;
> > +             bt_dev_dbg(hdev, "Flr triggered out of the retry window, =
so reset counters");
>
> Ditto.
>
> > +     }
> > +}
> > +
> > +static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
> > +
> > +static void btintel_pcie_removal_work(struct work_struct *wk)
> > +{
> > +     struct btintel_pcie_removal *removal =3D
> > +             container_of(wk, struct btintel_pcie_removal, work);
> > +     struct pci_dev *pdev =3D removal->pdev;
> > +     struct btintel_pcie_data *data;
> > +     int err;
> > +
> > +     pci_lock_rescan_remove();
> > +
> > +     if (!pdev->bus)
> > +             goto error;
> > +
> > +     data =3D pci_get_drvdata(pdev);
> > +
> > +     btintel_pcie_disable_interrupts(data);
> > +     btintel_pcie_synchronize_irqs(data);
> > +
> > +     flush_work(&data->rx_work);
> > +     flush_work(&data->hdev->dump.dump_rx);
> > +
> > +     bt_dev_dbg(data->hdev, "Release bluetooth interface");
> > +     btintel_pcie_release_hdev(data);
> > +
> > +     err =3D pci_reset_function(pdev);
> > +     if (err) {
> > +             BT_ERR("Failed resetting the pcie device (%d)", err);
> > +             goto error;
> > +     }
> > +
> > +     btintel_pcie_enable_interrupts(data);
> > +     btintel_pcie_config_msix(data);
> > +
> > +     err =3D btintel_pcie_enable_bt(data);
> > +     if (err) {
> > +             BT_ERR("Failed to enable bluetooth hardware after reset (=
%d)",
> > +                    err);
> > +             goto error;
> > +     }
> > +
> > +     btintel_pcie_reset_ia(data);
> > +     btintel_pcie_start_rx(data);
> > +     data->flags =3D 0;
> > +
> > +     err =3D btintel_pcie_setup_hdev(data);
> > +     if (err) {
> > +             BT_ERR("Failed registering hdev (%d)", err);
> > +             goto error;
> > +     }
> > +error:
> > +     pci_dev_put(pdev);
> > +     pci_unlock_rescan_remove();
> > +     kfree(removal);
> > +}
> > +
> > +static void btintel_pcie_reset(struct hci_dev *hdev)
> > +{
> > +     struct btintel_pcie_removal *removal;
> > +     struct btintel_pcie_data *data;
> > +
> > +     data =3D hci_get_drvdata(hdev);
> > +
> > +     if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> > +             return;
> > +
> > +     if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->fl=
ags))
> > +             return;
> > +
> > +     removal =3D kzalloc(sizeof(*removal), GFP_ATOMIC);
> > +     if (!removal)
> > +             return;
> > +
> > +     removal->pdev =3D data->pdev;
> > +     INIT_WORK(&removal->work, btintel_pcie_removal_work);
> > +     pci_dev_get(removal->pdev);
> > +     schedule_work(&removal->work);
> > +}
> > +
> > +static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
> > +{
> > +     struct  btintel_pcie_dev_restart_data *data;
>
> Exactly one space after struct?
>
> > +     struct btintel_pcie_data *dev_data =3D hci_get_drvdata(hdev);
> > +     struct pci_dev *pdev =3D dev_data->pdev;
> > +     time64_t retry_window;
> > +
> > +     if (code =3D=3D 0x13) {
> > +             bt_dev_err(hdev, "Encountered top exception");
> > +             return;
> > +     }
> > +
> > +     data =3D btintel_pcie_get_restart_data(pdev, &hdev->dev);
> > +     if (!data)
> > +             return;
> > +
> > +     retry_window =3D ktime_get_boottime_seconds() - data->last_error;
> > +
> > +     if (retry_window < BTINTEL_PCIE_RESET_WINDOW_SECS &&
> > +         data->restart_count >=3D BTINTEL_PCIE_FLR_MAX_RETRY) {
> > +             bt_dev_err(hdev, "Exhausted maximum: %d recovery attempts=
: %d",
> > +                        BTINTEL_PCIE_FLR_MAX_RETRY, data->restart_coun=
t);
> > +             bt_dev_dbg(hdev, "Boot time: %lld seconds first_flr at: %=
lld seconds restart_count: %d",
> > +                        ktime_get_boottime_seconds(), data->last_error=
,
> > +                        data->restart_count);
> > +             return;
> > +     }
> > +     btintel_pcie_inc_restart_count(pdev, &hdev->dev);
> > +     btintel_pcie_reset(hdev);
> > +}
> > +
> >   static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
> >   {
> >       int err;
> > @@ -2216,9 +2424,10 @@ static int btintel_pcie_setup_hdev(struct btinte=
l_pcie_data *data)
> >       hdev->send =3D btintel_pcie_send_frame;
> >       hdev->setup =3D btintel_pcie_setup;
> >       hdev->shutdown =3D btintel_shutdown_combined;
> > -     hdev->hw_error =3D btintel_hw_error;
> > +     hdev->hw_error =3D btintel_pcie_hw_error;
> >       hdev->set_diag =3D btintel_set_diag;
> >       hdev->set_bdaddr =3D btintel_set_bdaddr;
> > +     hdev->reset =3D btintel_pcie_reset;
> >
> >       err =3D hci_register_dev(hdev);
> >       if (err < 0) {
> > @@ -2366,7 +2575,20 @@ static struct pci_driver btintel_pcie_driver =3D=
 {
> >       .driver.coredump =3D btintel_pcie_coredump
> >   #endif
> >   };
> > -module_pci_driver(btintel_pcie_driver);
> > +
> > +static int __init btintel_pcie_init(void)
> > +{
> > +     return pci_register_driver(&btintel_pcie_driver);
> > +}
> > +
> > +static void __exit btintel_pcie_exit(void)
> > +{
> > +     pci_unregister_driver(&btintel_pcie_driver);
> > +     btintel_pcie_free_restart_list();
> > +}
> > +
> > +module_init(btintel_pcie_init);
> > +module_exit(btintel_pcie_exit);
> >
> >   MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
> >   MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSI=
ON);
> > diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btint=
el_pcie.h
> > index 7dad4523236c..0fa876c5b954 100644
> > --- a/drivers/bluetooth/btintel_pcie.h
> > +++ b/drivers/bluetooth/btintel_pcie.h
> > @@ -117,7 +117,9 @@ enum {
> >   enum {
> >       BTINTEL_PCIE_CORE_HALTED,
> >       BTINTEL_PCIE_HWEXP_INPROGRESS,
> > -     BTINTEL_PCIE_COREDUMP_INPROGRESS
> > +     BTINTEL_PCIE_COREDUMP_INPROGRESS,
> > +     BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
> > +     BTINTEL_PCIE_SETUP_DONE
> >   };
> >
> >   enum btintel_pcie_tlv_type {
>
>
> Kind regards,
>
> Paul
>


--=20
Luiz Augusto von Dentz
