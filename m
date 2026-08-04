Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C03E3160
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862721; cv=pass; b=rw/Lqg75bHq3hkbzu9B4oVYY2tVDJVsvvO3IcdxbrtYdyjYNw+b+P6HTP28prG1x+7NSolffemMoKM46b3hijuzeUC8YIIQoRhBgJAuHyS7r0uYtL59mrEC1WSFuMo1fcwwP5Up+0c07mxSud9H/nNGGZxistEvT+/N+zK9eets=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862721; c=relaxed/simple;
	bh=5fKokd55GRF/CW493YwElkndMnpnt/Eho5qDakmBBds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgXn6w7I4yCjKX0LKxRrhiFNGbey6nwjHXH0GEUOj6aXhuaUH8valfZe2zFnPAQieIugzlVhZiAq1K7sQ8uwHQn4HaI9MAnJCX/nno3wM3U81wqCr1ucOWbtBuJKGbMKgai8V3Ypj5YIDAuAZuVIM7XV3f4nYVY+CZSvqZaydac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMoRwkqM; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMoRwkqM"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664a09bc459so6228424d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 09:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862702; cv=none;
        d=google.com; s=arc-20260327;
        b=FGS3apAKSs1Tu8qBTYtBByMCUiBIPOPVbXFKJnCSD+9zHlrneqWIkTIn8gNDSNilkB
         8lM/NMdrv58getXceJtsAZVr83tLf5KatLKesfKXgk3c3Zm90GB+TPdDYBMoRv0pa5uT
         KsCh6CPDFUIQ6MwmLe2XkFZ72Km5NHJEGpSCqjh77ZwzDXNTmAA7kXyPu7kqcPLDdw8o
         oy769dqp2/skPTvOy+Q2/VtkxmfHsU6esCMbIaElHzFZ3dxdkwVYF9XP4On+qUzgf7sD
         CyIYlXbaNVjuK8w6+CDpl2BhcfoMfHpNBiNR92VzY4qWU6gLffEMRkOV+Nb1AfcSiBGv
         nyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rt4xu8H0V4WbUJEHkA/Mj29VBlAURPVngKvdLSnvISU=;
        fh=u/DsVw8wgQNm3WO/Pwk7qL5tf51U7Vyfx7IGyYadzP8=;
        b=Xg88/cdN6Sq2fRun12OUdAXlBXmAd07v+2PgCWSlUU+9tzvKaAOFogjYfywT8uzZxk
         upHjbYM+z8MRz9SLy8WbxzLDffUHzultNVZix9//0idKCyduuq6iwInm1TZELWte3bdQ
         2M5ae0Fjp1ohLMCtykPFYnAAD01H5ODLp5X6N/mnA3+bdOv3eJdvW057zGnbifBT4q7X
         68uFGbUHvU7HO9oZZjeGJ0lm9y+XtpZCj+XbJ54AjtfJjPyyXBaAMJcohL+fogwXEv0J
         jvd6QjQN8TtWLnvJ9zBmxHgy7r2fhiAW4OuoQbMX/5pGVeQhxMTZ157uf9S25l+gE8Uv
         8QZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862702; x=1786467502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rt4xu8H0V4WbUJEHkA/Mj29VBlAURPVngKvdLSnvISU=;
        b=EMoRwkqM4jTXxSruNjupNs2jgktUwRKLzc2lD0o7QuwRruCj8539v8EzlxdMede8Of
         1pHVx7QbWB8Cl5i/AmUnN3wQVj5Ekd5hupxzbf9LcDdYBin0ZDMdf/y9eRJsO0K9P87S
         NvqEKqQPZd3QFPz5nQQ4lrJ6Se65GEU7giTVqC8Z0jeS4wQC3+g+qFF0wejhDzzLnuzg
         NQiuPUygo+XFDJ8BK6lAN8TqAiV4N4LXy5jOxZXbaJ09+lM1tBuZAR+xqKvcI6xIeZge
         uFs2CcaNAZmHQ2vfPGWK+aJh9w48KkLrQV57w2IvzZi4bus9Wqm2TfLD6po/rLhhuDeS
         iBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862702; x=1786467502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rt4xu8H0V4WbUJEHkA/Mj29VBlAURPVngKvdLSnvISU=;
        b=V60B87m4s6VI340vRj7GWdFCZun4FywV6jPiMM28sOdmQFk5elcfEcTSIBr598kJq2
         z8Gyk7wI9ewrUNlEJiKi5W0vB6LqVbSeYNV3df6aMBXMS5kgnaGPMg1bUQEFsTOFIXag
         R/Ar2wk3YhLbc8iMbzSLg2kAJwO1DWX8TwesPEG8LT3OHItxoN58jXpM3XBXHAOryjaE
         mgaWUqpPCzEdJrB3+GbiE6+ooK/PxxWMTOfYxF5QAOsA2RxmhklRlftE5mfRhfPjdd52
         sQCLW/fswBklp4cI+5qR3kB0i8K3ychjHElA17dpsTqBqx8SzU9ktiJAapmcYiu0pwia
         XvkQ==
X-Gm-Message-State: AOJu0YwOTJGHHRTiVXMN+MyhErO02zcWxjm/sWMRQGGvl6NyPwJEY1Gx
	QFTU3kBh0/4b0Wpj0atFMUg0GOjjW7QuUUsPLBhXNthZWwH3vOnZwv+BzbkDXcPm9kM6oYMxlYz
	yEwSsj3mO3NH49zuxBgyMHwQNx78HUtg=
X-Gm-Gg: AR+sD1035D9hxVSgs3h0SwY+LEQO3X5vrmBhknAtpfGn+V598s5KtJAksdrc0ClJC/k
	bSbCdsUqaGp0mYHwIuRAfw54p6IGtplNKAZWRqqhbw4zdUzQInIi55xEUb6+1hlAlBfk1NnWarl
	S63ieLmFAPVKusXU3N/XSb7HTcOnn0B5T88gxnwjHZxEb1ZKypq7rjB5uSQLKgJ820QjHywcLuU
	xUIXMLuphWBZFr1LV+CxMyL23jqlMaufFwBhwlNHXt4nBAn4yReeasB8kKLkiemQtD6X/j0ewTR
	NiJmiwpz45q5Q/xcK8vVywAtGYGFLuVDtuwHo/+TxIe0izHoxjuECIgG+Yor87Az5dCr9ea02Mo
	MSNQIDStDfR/CFu8pJkbk96d3Wr8EUMC/OeEhDCXZ1bPD/g==
X-Received: by 2002:a05:690e:284:b0:667:e441:bc0d with SMTP id
 956f58d0204a3-6699aa3e7b2mr123545d50.33.1785862701926; Tue, 04 Aug 2026
 09:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
In-Reply-To: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Aug 2026 12:58:10 -0400
X-Gm-Features: AUfX_myXPvr1-skYkKgO5OjMjhPcc-xM3H2L2sqU_aopqsgPpoBsus4Vv_R9ufo
Message-ID: <CABBYNZLua5QmQav7U3qjOBDQeSjEm5+X9ejJcBP9sVhS5JPPdQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Tue, Aug 4, 2026 at 6:13=E2=80=AFAM Sean Rhodes <sean@starlabs.systems> =
wrote:
>
> Commit 6953217d9f44 ("usb: core: allow ACPI-managed hard-wired
> ports to power off") allows internal USB devices on ACPI-managed
> hard-wired ports to use the existing runtime power-off path. For Intel
> combined USB Bluetooth controllers, btusb still keeps runtime remote wake
> enabled for as long as the adapter is open, which prevents the USB PM
> core from dropping the last child reference and powering the port off
> while idle.
>
> Only keep runtime remote wake enabled while the controller is expected to
> signal activity on its own: initialization, outstanding HCI commands,
> established links, discovery, LE scan, LE advertising, BR/EDR page or
> inquiry scan, diagnostic modes, DUT mode, quality reports, or Intel
> devcoredump collection. When those are idle, clear needs_remote_wakeup so
> autosuspend can power-manage the port and a later host-initiated command
> can resume the device again.

This looks way too big to be considered in a single change, beside I
don't think I understand the whole idea here, are we trying to
determine if the hdev is suspendable or something like that?

> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/bluetooth/btusb.c         | 917 +++++++++++++++++++++++++++++-
>  include/net/bluetooth/bluetooth.h |   1 +
>  include/net/bluetooth/hci.h       |   4 +
>  net/bluetooth/hci_debugfs.c       |  20 +-
>  net/bluetooth/hci_sock.c          |   5 +
>  net/bluetooth/hci_sync.c          |   2 +
>  net/bluetooth/mgmt.c              |  15 +-
>  7 files changed, 940 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8f7ed469cac6..a69f63c87b27 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -957,6 +957,18 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS 15
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>  #define BTUSB_HW_SSR_ACTIVE    17
> +#define BTUSB_REMOTE_WAKEUP_ACTIVE     18
> +#define BTUSB_REMOTE_WAKEUP_COREDUMP   19
> +
> +#define BTUSB_REMOTE_WAKEUP_RETRY      msecs_to_jiffies(100)
> +
> +struct btusb_raw_vendor_cmd {
> +       struct list_head list;
> +       struct sk_buff *skb;
> +       unsigned long expires;
> +       u16 opcode;
> +       bool submitted;
> +};
>
>  struct btusb_data {
>         struct hci_dev       *hdev;
> @@ -969,9 +981,25 @@ struct btusb_data {
>         unsigned long flags;
>
>         bool poll_sync;
> +       bool intel_idle_power_manageable;
> +       int (*setup)(struct hci_dev *hdev);
> +       int (*set_diag)(struct hci_dev *hdev, bool enable);
> +       int (*set_quality_report)(struct hci_dev *hdev, bool enable);
> +       void (*coredump)(struct hci_dev *hdev);
> +       void (*coredump_notify)(struct hci_dev *hdev, int state);
>         int intr_interval;
>         struct work_struct  work;
>         struct work_struct  waker;
> +       struct delayed_work remote_wakeup;
> +       struct delayed_work remote_wakeup_retry;
> +       struct delayed_work coredump_remote_wakeup;
> +       struct delayed_work raw_vendor_cmd_timeout;
> +       unsigned long coredump_remote_wakeup_expires;
> +       struct list_head raw_vendor_cmds;
> +       unsigned int raw_vendor_cmd_count;
> +       unsigned int raw_vendor_cmd_submitted;
> +       /* Protects remote wake update scheduling against close/remove. *=
/
> +       spinlock_t remote_wakeup_lock;
>         struct delayed_work rx_work;
>
>         struct sk_buff_head acl_q;
> @@ -1026,6 +1054,16 @@ struct btusb_data {
>         struct qca_dump_info qca_dump;
>  };
>
> +static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data);
> +static bool btusb_raw_vendor_cmd_pending(struct btusb_data *data);
> +static void btusb_raw_vendor_cmd_done(struct btusb_data *data, u16 opcod=
e);
> +static bool btusb_event_completes_raw_vendor_cmd(struct sk_buff *skb,
> +                                                u16 *opcode);
> +static void btusb_raw_vendor_cmd_free_list(struct list_head *cmds);
> +static void btusb_remote_wakeup_set_active(struct btusb_data *data,
> +                                          bool active);
> +static void btusb_queue_remote_wakeup_update(struct btusb_data *data);
> +
>  static void btusb_reset(struct hci_dev *hdev)
>  {
>         struct btusb_data *data;
> @@ -1237,12 +1275,26 @@ static inline void btusb_free_frags(struct btusb_=
data *data)
>
>  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
>  {
> +       bool raw_vendor_cmd_done;
> +       u16 raw_vendor_opcode;
> +       int err;
> +
>         if (data->intr_interval) {
>                 /* Trigger dequeue immediately if an event is received */
>                 schedule_delayed_work(&data->rx_work, 0);
>         }
>
> -       return data->recv_event(data->hdev, skb);
> +       raw_vendor_cmd_done =3D btusb_event_completes_raw_vendor_cmd(skb,
> +                                                                  &raw_v=
endor_opcode);
> +
> +       err =3D data->recv_event(data->hdev, skb);
> +       if (!err) {
> +               if (raw_vendor_cmd_done)
> +                       btusb_raw_vendor_cmd_done(data, raw_vendor_opcode=
);
> +               btusb_queue_remote_wakeup_update(data);
> +       }
> +
> +       return err;
>  }
>
>  static int btusb_recv_intr(struct btusb_data *data, void *buffer, int co=
unt)
> @@ -2010,7 +2062,10 @@ static int btusb_open(struct hci_dev *hdev)
>                         goto setup_fail;
>         }
>
> -       data->intf->needs_remote_wakeup =3D 1;
> +       data->intf->needs_remote_wakeup =3D
> +               btusb_needs_runtime_remote_wakeup(data);
> +       if (data->intel_idle_power_manageable)
> +               btusb_remote_wakeup_set_active(data, true);
>
>         if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
>                 goto done;
> @@ -2039,6 +2094,7 @@ static int btusb_open(struct hci_dev *hdev)
>
>  failed:
>         clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> +       btusb_remote_wakeup_set_active(data, false);
>  setup_fail:
>         usb_autopm_put_interface(data->intf);
>         return err;
> @@ -2053,6 +2109,657 @@ static void btusb_stop_traffic(struct btusb_data =
*data)
>         usb_kill_anchored_urbs(&data->ctrl_anchor);
>  }
>
> +static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data)
> +{
> +       struct hci_dev *hdev =3D data->hdev;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return true;
> +
> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
> +               return true;
> +
> +       /*
> +        * HCI_CMD_PENDING only covers synchronous requests. cmd_cnt reac=
hes
> +        * zero while any accepted HCI command is awaiting Command Comple=
te or
> +        * Command Status.
> +        */
> +       if (!atomic_read(&hdev->cmd_cnt) ||
> +           hci_dev_test_flag(hdev, HCI_CMD_PENDING) ||
> +           test_bit(HCI_INIT, &hdev->flags) ||
> +           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ||
> +           hci_dev_test_flag(hdev, HCI_QUALITY_REPORT) ||
> +           hci_dev_test_flag(hdev, HCI_DUT_MODE))
> +               return true;
> +
> +       if (test_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags))
> +               return true;
> +
> +       if (btusb_raw_vendor_cmd_pending(data))
> +               return true;
> +
> +       if (hci_conn_count(hdev))
> +               return true;
> +
> +       if (hdev->discovery.state =3D=3D DISCOVERY_FINDING ||
> +           hdev->discovery.state =3D=3D DISCOVERY_RESOLVING)
> +               return true;
> +
> +       if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +           hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +           hci_dev_test_flag(hdev, HCI_LE_PER_ADV) ||
> +           hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
> +           test_bit(HCI_PSCAN, &hdev->flags) ||
> +           test_bit(HCI_ISCAN, &hdev->flags) ||
> +           test_bit(HCI_INQUIRY, &hdev->flags) ||
> +           hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
> +               return true;
> +
> +       return false;
> +}
> +
> +static void btusb_remote_wakeup_set_active(struct btusb_data *data, bool=
 active)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       if (active)
> +               set_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags);
> +       else
> +               clear_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +}
> +
> +static bool btusb_remote_wakeup_active(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +       bool active;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       active =3D test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
> +                !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return active;
> +}
> +
> +static bool btusb_queue_remote_wakeup_work(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +       bool active;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       active =3D test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
> +                !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
> +       if (active)
> +               mod_delayed_work(data->hdev->workqueue, &data->remote_wak=
eup, 0);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return active;
> +}
> +
> +static bool btusb_queue_remote_wakeup_retry(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +       bool active;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       active =3D test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
> +                !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
> +       if (active)
> +               mod_delayed_work(system_freezable_wq, &data->remote_wakeu=
p_retry,
> +                                BTUSB_REMOTE_WAKEUP_RETRY);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return active;
> +}
> +
> +static bool btusb_remote_wakeup_pm_retryable(int err)
> +{
> +       return err =3D=3D -EACCES || err =3D=3D -EAGAIN || err =3D=3D -EB=
USY;
> +}
> +
> +static void btusb_remote_wakeup_work(struct work_struct *work)
> +{
> +       struct btusb_data *data =3D container_of(work, struct btusb_data,
> +                                              remote_wakeup.work);
> +       int err;
> +
> +       if (!btusb_remote_wakeup_active(data))
> +               return;
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0) {
> +               if (btusb_remote_wakeup_pm_retryable(err))
> +                       btusb_queue_remote_wakeup_retry(data);
> +               return;
> +       }
> +
> +       if (btusb_remote_wakeup_active(data))
> +               data->intf->needs_remote_wakeup =3D
> +                       btusb_needs_runtime_remote_wakeup(data);
> +
> +       usb_autopm_put_interface(data->intf);
> +}
> +
> +static void btusb_remote_wakeup_retry_work(struct work_struct *work)
> +{
> +       struct btusb_data *data =3D container_of(work, struct btusb_data,
> +                                              remote_wakeup_retry.work);
> +
> +       btusb_queue_remote_wakeup_work(data);
> +}
> +
> +static void btusb_queue_remote_wakeup_update(struct btusb_data *data)
> +{
> +       btusb_queue_remote_wakeup_work(data);
> +}
> +
> +static bool btusb_raw_vendor_cmd_pending(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +       bool pending;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       pending =3D data->raw_vendor_cmd_submitted;
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return pending;
> +}
> +
> +static bool btusb_skb_raw_vendor_cmd_opcode(struct sk_buff *skb, u16 *op=
code)
> +{
> +       struct hci_command_hdr *cmd;
> +       u16 cmd_opcode;
> +
> +       if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT ||
> +           !(bt_cb(skb)->hci.req_flags & HCI_REQ_RAW) ||
> +           skb->len < HCI_COMMAND_HDR_SIZE)
> +               return false;
> +
> +       cmd =3D (void *)skb->data;
> +       cmd_opcode =3D le16_to_cpu(cmd->opcode);
> +
> +       if (hci_opcode_ogf(cmd_opcode) !=3D 0x3f)
> +               return false;
> +
> +       *opcode =3D cmd_opcode;
> +
> +       return true;
> +}
> +
> +static void btusb_raw_vendor_cmd_add(struct btusb_data *data,
> +                                    struct btusb_raw_vendor_cmd *cmd)
> +{
> +       unsigned long flags;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_add_tail(&cmd->list, &data->raw_vendor_cmds);
> +       data->raw_vendor_cmd_count++;
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +}
> +
> +static void btusb_raw_vendor_cmd_schedule_locked(struct btusb_data *data=
)
> +{
> +       struct btusb_raw_vendor_cmd *cmd;
> +       unsigned long expires =3D 0;
> +
> +       if (!data->raw_vendor_cmd_submitted)
> +               return;
> +
> +       list_for_each_entry(cmd, &data->raw_vendor_cmds, list) {
> +               if (!cmd->submitted)
> +                       continue;
> +
> +               if (!expires || time_before(cmd->expires, expires))
> +                       expires =3D cmd->expires;
> +       }
> +
> +       if (expires)
> +               mod_delayed_work(system_wq, &data->raw_vendor_cmd_timeout=
,
> +                                time_after(expires, jiffies) ?
> +                                expires - jiffies : 0);
> +}
> +
> +static void btusb_raw_vendor_cmd_remove_locked(struct btusb_data *data,
> +                                              struct btusb_raw_vendor_cm=
d *cmd,
> +                                              struct list_head *cmds,
> +                                              bool *queue)
> +{
> +       list_move_tail(&cmd->list, cmds);
> +       data->raw_vendor_cmd_count--;
> +
> +       if (!cmd->submitted)
> +               return;
> +
> +       data->raw_vendor_cmd_submitted--;
> +       *queue =3D true;
> +}
> +
> +static bool btusb_raw_vendor_cmd_submitted(struct btusb_data *data,
> +                                          struct btusb_raw_vendor_cmd *c=
md)
> +{
> +       struct btusb_raw_vendor_cmd *iter;
> +       unsigned long flags;
> +       bool arm =3D false;
> +
> +       if (!data->intel_idle_power_manageable || !cmd)
> +               return false;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry(iter, &data->raw_vendor_cmds, list) {
> +               if (iter !=3D cmd || iter->submitted)
> +                       continue;
> +
> +               iter->submitted =3D true;
> +               iter->expires =3D jiffies + HCI_CMD_TIMEOUT;
> +               data->raw_vendor_cmd_submitted++;
> +               arm =3D true;
> +               break;
> +       }
> +
> +       if (arm)
> +               btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return arm;
> +}
> +
> +static struct btusb_raw_vendor_cmd *
> +btusb_raw_vendor_cmd_submitted_by_skb(struct btusb_data *data,
> +                                     struct sk_buff *skb)
> +{
> +       struct btusb_raw_vendor_cmd *cmd, *submitted =3D NULL;
> +       unsigned long flags;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return NULL;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry(cmd, &data->raw_vendor_cmds, list) {
> +               if (cmd->skb !=3D skb || cmd->submitted)
> +                       continue;
> +
> +               cmd->submitted =3D true;
> +               cmd->expires =3D jiffies + HCI_CMD_TIMEOUT;
> +               data->raw_vendor_cmd_submitted++;
> +               submitted =3D cmd;
> +               break;
> +       }
> +
> +       if (submitted)
> +               btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       return submitted;
> +}
> +
> +static void btusb_raw_vendor_cmd_cancel(struct btusb_data *data,
> +                                       struct btusb_raw_vendor_cmd *cmd)
> +{
> +       LIST_HEAD(cmds);
> +       struct btusb_raw_vendor_cmd *iter, *tmp;
> +       unsigned long flags;
> +       bool queue =3D false;
> +
> +       if (!data->intel_idle_power_manageable || !cmd)
> +               return;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry_safe(iter, tmp, &data->raw_vendor_cmds, list)=
 {
> +               if (iter !=3D cmd)
> +                       continue;
> +
> +               btusb_raw_vendor_cmd_remove_locked(data, iter, &cmds, &qu=
eue);
> +               break;
> +       }
> +       btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       btusb_raw_vendor_cmd_free_list(&cmds);
> +
> +       if (queue)
> +               btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static void btusb_raw_vendor_cmd_cancel_unsubmitted(struct btusb_data *d=
ata,
> +                                                   struct sk_buff *skb)
> +{
> +       struct btusb_raw_vendor_cmd *cmd, *tmp;
> +       LIST_HEAD(cmds);
> +       unsigned long flags;
> +       bool queue =3D false;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) =
{
> +               if (cmd->skb !=3D skb || cmd->submitted)
> +                       continue;
> +
> +               btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &que=
ue);
> +               break;
> +       }
> +       btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       btusb_raw_vendor_cmd_free_list(&cmds);
> +
> +       if (queue)
> +               btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static void btusb_raw_vendor_cmd_free_list(struct list_head *cmds)
> +{
> +       struct btusb_raw_vendor_cmd *cmd, *tmp;
> +
> +       list_for_each_entry_safe(cmd, tmp, cmds, list) {
> +               list_del(&cmd->list);
> +               kfree(cmd);
> +       }
> +}
> +
> +static void btusb_raw_vendor_cmd_done(struct btusb_data *data, u16 opcod=
e)
> +{
> +       struct btusb_raw_vendor_cmd *cmd, *tmp;
> +       LIST_HEAD(cmds);
> +       unsigned long flags;
> +       bool queue =3D false;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) =
{
> +               if (!cmd->submitted || cmd->opcode !=3D opcode)
> +                       continue;
> +
> +               btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &que=
ue);
> +               break;
> +       }
> +       btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       btusb_raw_vendor_cmd_free_list(&cmds);
> +
> +       if (queue)
> +               btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static void btusb_raw_vendor_cmd_clear(struct btusb_data *data)
> +{
> +       LIST_HEAD(cmds);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_splice_init(&data->raw_vendor_cmds, &cmds);
> +       data->raw_vendor_cmd_count =3D 0;
> +       data->raw_vendor_cmd_submitted =3D 0;
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       btusb_raw_vendor_cmd_free_list(&cmds);
> +}
> +
> +static void btusb_raw_vendor_cmd_timeout_work(struct work_struct *work)
> +{
> +       struct btusb_data *data =3D container_of(work, struct btusb_data,
> +                                              raw_vendor_cmd_timeout.wor=
k);
> +       LIST_HEAD(cmds);
> +       struct btusb_raw_vendor_cmd *cmd, *tmp;
> +       unsigned long flags;
> +       bool queue =3D false;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) =
{
> +               if (!cmd->submitted || time_before(jiffies, cmd->expires)=
)
> +                       continue;
> +
> +               btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &que=
ue);
> +       }
> +       btusb_raw_vendor_cmd_schedule_locked(data);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       btusb_raw_vendor_cmd_free_list(&cmds);
> +
> +       if (queue)
> +               btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static bool btusb_event_completes_raw_vendor_cmd(struct sk_buff *skb,
> +                                                u16 *opcode)
> +{
> +       struct hci_event_hdr *hdr;
> +       u16 event_opcode;
> +
> +       if (skb->len < HCI_EVENT_HDR_SIZE)
> +               return false;
> +
> +       hdr =3D (void *)skb->data;
> +       if (hdr->evt =3D=3D HCI_EV_CMD_COMPLETE) {
> +               struct hci_ev_cmd_complete *ev;
> +
> +               if (skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ev))
> +                       return false;
> +
> +               ev =3D (void *)(skb->data + HCI_EVENT_HDR_SIZE);
> +               event_opcode =3D le16_to_cpu(ev->opcode);
> +       } else if (hdr->evt =3D=3D HCI_EV_CMD_STATUS) {
> +               struct hci_ev_cmd_status *ev;
> +
> +               if (skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ev))
> +                       return false;
> +
> +               ev =3D (void *)(skb->data + HCI_EVENT_HDR_SIZE);
> +               event_opcode =3D le16_to_cpu(ev->opcode);
> +               if (!ev->status)
> +                       return false;
> +       } else {
> +               return false;
> +       }
> +
> +       if (hci_opcode_ogf(event_opcode) !=3D 0x3f)
> +               return false;
> +
> +       *opcode =3D event_opcode;
> +
> +       return true;
> +}
> +
> +static int btusb_hold_remote_wakeup(struct btusb_data *data)
> +{
> +       int err;
> +
> +       if (!data->intel_idle_power_manageable)
> +               return 0;
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return err;
> +
> +       data->intf->needs_remote_wakeup =3D true;
> +
> +       return 0;
> +}
> +
> +static void btusb_put_remote_wakeup(struct btusb_data *data)
> +{
> +       if (data->intel_idle_power_manageable)
> +               usb_autopm_put_interface(data->intf);
> +}
> +
> +static void btusb_free_tx_urb(struct urb *urb)
> +{
> +       kfree(urb->setup_packet);
> +       usb_free_urb(urb);
> +}
> +
> +static void btusb_coredump_remote_wakeup_clear(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       data->coredump_remote_wakeup_expires =3D 0;
> +       clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +}
> +
> +static void btusb_coredump_remote_wakeup_work(struct work_struct *work)
> +{
> +       struct btusb_data *data =3D container_of(work, struct btusb_data,
> +                                              coredump_remote_wakeup.wor=
k);
> +       unsigned long flags;
> +       bool queue =3D false;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       if (time_after_eq(jiffies, data->coredump_remote_wakeup_expires))=
 {
> +               data->coredump_remote_wakeup_expires =3D 0;
> +               clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
> +               queue =3D true;
> +       }
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       if (queue)
> +               btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static void btusb_coredump_remote_wakeup_set(struct btusb_data *data,
> +                                            bool active)
> +{
> +       unsigned long flags;
> +       int err;
> +       bool queue =3D false;
> +
> +       spin_lock_irqsave(&data->remote_wakeup_lock, flags);
> +       if (active && test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) =
&&
> +           !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
> +               data->coredump_remote_wakeup_expires =3D
> +                       jiffies + DEVCOREDUMP_TIMEOUT;
> +               set_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
> +               mod_delayed_work(system_wq, &data->coredump_remote_wakeup=
,
> +                                DEVCOREDUMP_TIMEOUT);
> +               queue =3D true;
> +       } else {
> +               data->coredump_remote_wakeup_expires =3D 0;
> +               clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
> +       }
> +       spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
> +
> +       if (queue) {
> +               err =3D btusb_hold_remote_wakeup(data);
> +               if (!err)
> +                       btusb_put_remote_wakeup(data);
> +       }
> +
> +       btusb_queue_remote_wakeup_update(data);
> +}
> +
> +static void btusb_intel_coredump_notify(struct hci_dev *hdev, int state)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +
> +       if (data->coredump_notify)
> +               data->coredump_notify(hdev, state);
> +
> +       if (state =3D=3D HCI_DEVCOREDUMP_ACTIVE)
> +               btusb_coredump_remote_wakeup_set(data, true);
> +       else
> +               btusb_coredump_remote_wakeup_set(data, false);
> +}
> +
> +static void btusb_intel_coredump(struct hci_dev *hdev)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +
> +       btusb_coredump_remote_wakeup_set(data, true);
> +
> +       if (data->coredump)
> +               data->coredump(hdev);
> +}
> +
> +static int btusb_intel_set_diag(struct hci_dev *hdev, bool enable)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       int err;
> +
> +       if (enable) {
> +               hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
> +               btusb_queue_remote_wakeup_update(data);
> +       }
> +
> +       err =3D data->set_diag(hdev, enable);
> +       if (err) {
> +               if (enable) {
> +                       hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
> +                       btusb_queue_remote_wakeup_update(data);
> +               }
> +               return err;
> +       }
> +
> +       if (!enable) {
> +               hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
> +               btusb_queue_remote_wakeup_update(data);
> +       }
> +
> +       return 0;
> +}
> +
> +static int btusb_intel_set_quality_report(struct hci_dev *hdev, bool ena=
ble)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       int err;
> +
> +       if (enable) {
> +               hci_dev_set_flag(hdev, HCI_QUALITY_REPORT);
> +               btusb_queue_remote_wakeup_update(data);
> +       }
> +
> +       err =3D data->set_quality_report(hdev, enable);
> +       if (err) {
> +               if (enable) {
> +                       hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
> +                       btusb_queue_remote_wakeup_update(data);
> +               }
> +               return err;
> +       }
> +
> +       if (!enable) {
> +               hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
> +               btusb_queue_remote_wakeup_update(data);
> +       }
> +
> +       return 0;
> +}
> +
> +static int btusb_intel_setup(struct hci_dev *hdev)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       int err;
> +
> +       err =3D data->setup(hdev);
> +       if (err)
> +               return err;
> +
> +       if (hdev->set_quality_report &&
> +           hdev->set_quality_report !=3D btusb_intel_set_quality_report)=
 {
> +               data->set_quality_report =3D hdev->set_quality_report;
> +               hdev->set_quality_report =3D btusb_intel_set_quality_repo=
rt;
> +       }
> +
> +       if (hdev->dump.coredump &&
> +           hdev->dump.coredump !=3D btusb_intel_coredump) {
> +               data->coredump =3D hdev->dump.coredump;
> +               data->coredump_notify =3D hdev->dump.notify_change;
> +               hdev->dump.coredump =3D btusb_intel_coredump;
> +               hdev->dump.notify_change =3D btusb_intel_coredump_notify;
> +       }
> +
> +       return 0;
> +}
> +
>  static int btusb_close(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -2063,6 +2770,13 @@ static int btusb_close(struct hci_dev *hdev)
>         cancel_delayed_work(&data->rx_work);
>         cancel_work_sync(&data->work);
>         cancel_work_sync(&data->waker);
> +       btusb_remote_wakeup_set_active(data, false);
> +       cancel_delayed_work_sync(&data->coredump_remote_wakeup);
> +       btusb_coredump_remote_wakeup_clear(data);
> +       cancel_delayed_work_sync(&data->raw_vendor_cmd_timeout);
> +       btusb_raw_vendor_cmd_clear(data);
> +       cancel_delayed_work_sync(&data->remote_wakeup_retry);
> +       cancel_delayed_work_sync(&data->remote_wakeup);
>
>         skb_queue_purge(&data->acl_q);
>
> @@ -2218,7 +2932,16 @@ static int submit_tx_urb(struct hci_dev *hdev, str=
uct urb *urb)
>         return err;
>  }
>
> -static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
> +static void btusb_defer_tx_urb(struct btusb_data *data, struct urb *urb)
> +{
> +       usb_anchor_urb(urb, &data->deferred);
> +       schedule_work(&data->waker);
> +
> +       usb_free_urb(urb);
> +}
> +
> +static bool btusb_defer_tx_urb_if_suspending(struct hci_dev *hdev,
> +                                            struct urb *urb)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         unsigned long flags;
> @@ -2226,20 +2949,121 @@ static int submit_or_queue_tx_urb(struct hci_dev=
 *hdev, struct urb *urb)
>
>         spin_lock_irqsave(&data->txlock, flags);
>         suspending =3D test_bit(BTUSB_SUSPENDING, &data->flags);
> +       spin_unlock_irqrestore(&data->txlock, flags);
> +
>         if (!suspending)
> +               return false;
> +
> +       btusb_defer_tx_urb(data, urb);
> +
> +       return true;
> +}
> +
> +static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->txlock, flags);
> +       if (!test_bit(BTUSB_SUSPENDING, &data->flags)) {
>                 data->tx_in_flight++;
> +               spin_unlock_irqrestore(&data->txlock, flags);
> +
> +               return submit_tx_urb(hdev, urb);
> +       }
>         spin_unlock_irqrestore(&data->txlock, flags);
>
> -       if (!suspending)
> +       btusb_defer_tx_urb(data, urb);
> +
> +       return 0;
> +}
> +
> +static int btusb_raw_vendor_cmd_prepare(struct btusb_data *data,
> +                                       struct sk_buff *skb,
> +                                       struct btusb_raw_vendor_cmd **cmd=
)
> +{
> +       u16 opcode;
> +
> +       *cmd =3D NULL;
> +
> +       if (!data->intel_idle_power_manageable ||
> +           !btusb_skb_raw_vendor_cmd_opcode(skb, &opcode))
> +               return 0;
> +
> +       *cmd =3D kzalloc(sizeof(**cmd), GFP_KERNEL);
> +       if (!*cmd)
> +               return -ENOMEM;
> +
> +       (*cmd)->skb =3D skb;
> +       (*cmd)->opcode =3D opcode;
> +       btusb_raw_vendor_cmd_add(data, *cmd);
> +
> +       return 0;
> +}
> +
> +static int submit_or_queue_cmd_urb(struct hci_dev *hdev, struct urb *urb=
,
> +                                  struct btusb_raw_vendor_cmd *raw_vendo=
r_cmd)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->txlock, flags);
> +       if (!test_bit(BTUSB_SUSPENDING, &data->flags)) {
> +               data->tx_in_flight++;
> +               btusb_raw_vendor_cmd_submitted(data, raw_vendor_cmd);
> +               spin_unlock_irqrestore(&data->txlock, flags);
> +
>                 return submit_tx_urb(hdev, urb);
> +       }
> +       spin_unlock_irqrestore(&data->txlock, flags);
>
> -       usb_anchor_urb(urb, &data->deferred);
> -       schedule_work(&data->waker);
> +       btusb_defer_tx_urb(data, urb);
>
> -       usb_free_urb(urb);
>         return 0;
>  }
>
> +static int btusb_submit_cmd_urb(struct hci_dev *hdev, struct urb *urb,
> +                               struct sk_buff *skb)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btusb_raw_vendor_cmd *raw_vendor_cmd;
> +       int err;
> +
> +       err =3D btusb_raw_vendor_cmd_prepare(data, skb, &raw_vendor_cmd);
> +       if (err < 0) {
> +               btusb_free_tx_urb(urb);
> +               return err;
> +       }
> +
> +       hdev->stat.cmd_tx++;
> +       if (btusb_defer_tx_urb_if_suspending(hdev, urb)) {
> +               btusb_queue_remote_wakeup_update(data);
> +               return 0;
> +       }
> +
> +       err =3D btusb_hold_remote_wakeup(data);
> +       if (err < 0) {
> +               if (err =3D=3D -EACCES &&
> +                   btusb_defer_tx_urb_if_suspending(hdev, urb)) {
> +                       btusb_queue_remote_wakeup_update(data);
> +                       return 0;
> +               }
> +
> +               if (raw_vendor_cmd)
> +                       btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd)=
;
> +               btusb_free_tx_urb(urb);
> +               return err;
> +       }
> +
> +       err =3D submit_or_queue_cmd_urb(hdev, urb, raw_vendor_cmd);
> +       btusb_put_remote_wakeup(data);
> +       if (err < 0 && raw_vendor_cmd)
> +               btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd);
> +       btusb_queue_remote_wakeup_update(data);
> +
> +       return err;
> +}
> +
>  static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct urb *urb;
> @@ -2252,8 +3076,7 @@ static int btusb_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>                 if (IS_ERR(urb))
>                         return PTR_ERR(urb);
>
> -               hdev->stat.cmd_tx++;
> -               return submit_or_queue_tx_urb(hdev, urb);
> +               return btusb_submit_cmd_urb(hdev, urb, skb);
>
>         case HCI_ACLDATA_PKT:
>                 urb =3D alloc_bulk_urb(hdev, skb);
> @@ -2286,13 +3109,26 @@ static int btusb_send_frame(struct hci_dev *hdev,=
 struct sk_buff *skb)
>         return -EILSEQ;
>  }
>
> +static bool btusb_notify_is_sco(unsigned int evt)
> +{
> +       return evt =3D=3D HCI_NOTIFY_ENABLE_SCO_CVSD ||
> +              evt =3D=3D HCI_NOTIFY_ENABLE_SCO_TRANSP ||
> +              evt =3D=3D HCI_NOTIFY_DISABLE_SCO;
> +}
> +
>  static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>
>         BT_DBG("%s evt %d", hdev->name, evt);
>
> -       if (hci_conn_num(hdev, SCO_LINK) !=3D data->sco_num) {
> +       if (evt =3D=3D HCI_NOTIFY_CONN_ADD || evt =3D=3D HCI_NOTIFY_CONN_=
DEL ||
> +           evt =3D=3D HCI_NOTIFY_DUT_MODE || evt =3D=3D HCI_NOTIFY_INIT_=
DONE ||
> +           evt =3D=3D HCI_NOTIFY_ADV_STATE || evt =3D=3D HCI_NOTIFY_USER=
_CHANNEL)
> +               btusb_queue_remote_wakeup_update(data);
> +
> +       if (btusb_notify_is_sco(evt) &&
> +           hci_conn_num(hdev, SCO_LINK) !=3D data->sco_num) {
>                 data->sco_num =3D hci_conn_num(hdev, SCO_LINK);
>                 data->air_mode =3D evt;
>                 schedule_work(&data->work);
> @@ -2727,16 +3563,15 @@ static int btusb_send_frame_intel(struct hci_dev =
*hdev, struct sk_buff *skb)
>                          */
>                         if (opcode =3D=3D BTINTEL_HCI_OP_RESET)
>                                 inject_cmd_complete(hdev, opcode);
> -               } else {
> -                       urb =3D alloc_ctrl_urb(hdev, skb);
> -               }
> -               if (IS_ERR(urb))
> -                       return PTR_ERR(urb);
> +                       } else {
> +                               urb =3D alloc_ctrl_urb(hdev, skb);
> +                       }
> +                       if (IS_ERR(urb))
> +                               return PTR_ERR(urb);
>
> -               hdev->stat.cmd_tx++;
> -               return submit_or_queue_tx_urb(hdev, urb);
> +                       return btusb_submit_cmd_urb(hdev, urb, skb);
>
> -       case HCI_ACLDATA_PKT:
> +               case HCI_ACLDATA_PKT:
>                 urb =3D alloc_bulk_urb(hdev, skb);
>                 if (IS_ERR(urb))
>                         return PTR_ERR(urb);
> @@ -4137,6 +4972,15 @@ static int btusb_probe(struct usb_interface *intf,
>
>         INIT_WORK(&data->work, btusb_work);
>         INIT_WORK(&data->waker, btusb_waker);
> +       INIT_DELAYED_WORK(&data->remote_wakeup, btusb_remote_wakeup_work)=
;
> +       INIT_DELAYED_WORK(&data->remote_wakeup_retry,
> +                         btusb_remote_wakeup_retry_work);
> +       INIT_DELAYED_WORK(&data->coredump_remote_wakeup,
> +                         btusb_coredump_remote_wakeup_work);
> +       INIT_DELAYED_WORK(&data->raw_vendor_cmd_timeout,
> +                         btusb_raw_vendor_cmd_timeout_work);
> +       INIT_LIST_HEAD(&data->raw_vendor_cmds);
> +       spin_lock_init(&data->remote_wakeup_lock);
>         INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
>
>         skb_queue_head_init(&data->acl_q);
> @@ -4158,6 +5002,12 @@ static int btusb_probe(struct usb_interface *intf,
>         data->recv_bulk =3D btusb_recv_bulk;
>
>         if (id->driver_info & BTUSB_INTEL_COMBINED) {
> +               data->intel_idle_power_manageable =3D
> +                       IS_ENABLED(CONFIG_ACPI) &&
> +                       data->udev->parent && data->udev->portnum &&
> +                       usb_acpi_power_manageable(data->udev->parent,
> +                                                 data->udev->portnum - 1=
);
> +
>                 /* Allocate extra space for Intel device */
>                 priv_size +=3D sizeof(struct btintel_data);
>
> @@ -4253,6 +5103,11 @@ static int btusb_probe(struct usb_interface *intf,
>                 if (err)
>                         goto err_kill_tx_urbs;
>
> +               data->set_diag =3D hdev->set_diag;
> +               hdev->set_diag =3D btusb_intel_set_diag;
> +               data->setup =3D hdev->setup;
> +               hdev->setup =3D btusb_intel_setup;
> +
>                 /* Transport specific configuration */
>                 hdev->send =3D btusb_send_frame_intel;
>                 hdev->reset =3D btusb_intel_reset;
> @@ -4499,7 +5354,14 @@ static void btusb_disconnect(struct usb_interface =
*intf)
>         if (data->disconnect)
>                 data->disconnect(hdev);
>
> +       btusb_remote_wakeup_set_active(data, false);
> +       cancel_delayed_work_sync(&data->remote_wakeup_retry);
> +       cancel_delayed_work_sync(&data->remote_wakeup);
>         hci_unregister_dev(hdev);
> +       cancel_delayed_work_sync(&data->coredump_remote_wakeup);
> +       btusb_coredump_remote_wakeup_clear(data);
> +       cancel_delayed_work_sync(&data->raw_vendor_cmd_timeout);
> +       btusb_raw_vendor_cmd_clear(data);
>
>         if (data->oob_wake_irq) {
>                 device_init_wakeup(&data->udev->dev, false);
> @@ -4587,19 +5449,27 @@ static int btusb_suspend(struct usb_interface *in=
tf, pm_message_t message)
>         return 0;
>  }
>
> -static void play_deferred(struct btusb_data *data)
> +static bool play_deferred(struct btusb_data *data)
>  {
> +       struct btusb_raw_vendor_cmd *raw_vendor_cmd;
>         struct urb *urb;
> +       bool queue =3D false;
>         int err;
>
>         while ((urb =3D usb_get_from_anchor(&data->deferred))) {
> +               struct sk_buff *skb =3D urb->context;
> +
>                 usb_anchor_urb(urb, &data->tx_anchor);
> +               raw_vendor_cmd =3D btusb_raw_vendor_cmd_submitted_by_skb(=
data, skb);
> +               if (hci_skb_pkt_type(skb) =3D=3D HCI_COMMAND_PKT)
> +                       queue =3D true;
>
>                 err =3D usb_submit_urb(urb, GFP_ATOMIC);
>                 if (err < 0) {
>                         if (err !=3D -EPERM && err !=3D -ENODEV)
>                                 BT_ERR("%s urb %p submission failed (%d)"=
,
>                                        data->hdev->name, urb, -err);
> +                       btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd)=
;
>                         kfree(urb->setup_packet);
>                         usb_unanchor_urb(urb);
>                         usb_free_urb(urb);
> @@ -4612,15 +5482,19 @@ static void play_deferred(struct btusb_data *data=
)
>
>         /* Cleanup the rest deferred urbs. */
>         while ((urb =3D usb_get_from_anchor(&data->deferred))) {
> +               btusb_raw_vendor_cmd_cancel_unsubmitted(data, urb->contex=
t);
>                 kfree(urb->setup_packet);
>                 usb_free_urb(urb);
>         }
> +
> +       return queue;
>  }
>
>  static int btusb_resume(struct usb_interface *intf)
>  {
>         struct btusb_data *data =3D usb_get_intfdata(intf);
>         struct hci_dev *hdev =3D data->hdev;
> +       bool queue_remote_wakeup;
>         int err =3D 0;
>
>         BT_DBG("intf %p", intf);
> @@ -4666,14 +5540,17 @@ static int btusb_resume(struct usb_interface *int=
f)
>                 data->resume(hdev);
>
>         spin_lock_irq(&data->txlock);
> -       play_deferred(data);
> +       queue_remote_wakeup =3D play_deferred(data);
>         clear_bit(BTUSB_SUSPENDING, &data->flags);
>         spin_unlock_irq(&data->txlock);
> +       if (queue_remote_wakeup)
> +               btusb_queue_remote_wakeup_update(data);
>         schedule_work(&data->work);
>
>         return 0;
>
>  failed:
> +       btusb_raw_vendor_cmd_clear(data);
>         usb_scuttle_anchored_urbs(&data->deferred);
>  done:
>         spin_lock_irq(&data->txlock);
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index b624da5026f5..166e49c11f73 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -469,6 +469,7 @@ int hci_ethtool_ts_info(unsigned int index, int sk_pr=
oto,
>
>  #define HCI_REQ_START  BIT(0)
>  #define HCI_REQ_SKB    BIT(1)
> +#define HCI_REQ_RAW    BIT(2)
>
>  struct hci_ctrl {
>         struct sock *sk;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 50f0eef71fb1..b1a2b8bc301a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -52,6 +52,10 @@
>  #define HCI_NOTIFY_ENABLE_SCO_CVSD     4
>  #define HCI_NOTIFY_ENABLE_SCO_TRANSP   5
>  #define HCI_NOTIFY_DISABLE_SCO         6
> +#define HCI_NOTIFY_DUT_MODE            7
> +#define HCI_NOTIFY_INIT_DONE           8
> +#define HCI_NOTIFY_ADV_STATE           9
> +#define HCI_NOTIFY_USER_CHANNEL                10
>
>  /* HCI bus types */
>  #define HCI_VIRTUAL    0
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 0635e4641db4..c8d8b173097b 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -1299,6 +1299,12 @@ static ssize_t dut_mode_write(struct file *file, c=
onst char __user *user_buf,
>         if (enable =3D=3D hci_dev_test_flag(hdev, HCI_DUT_MODE))
>                 return -EALREADY;
>
> +       if (enable) {
> +               hci_dev_set_flag(hdev, HCI_DUT_MODE);
> +               if (hdev->notify)
> +                       hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
> +       }
> +
>         hci_req_sync_lock(hdev);
>         if (enable)
>                 skb =3D __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, N=
ULL,
> @@ -1308,12 +1314,22 @@ static ssize_t dut_mode_write(struct file *file, =
const char __user *user_buf,
>                                      HCI_CMD_TIMEOUT);
>         hci_req_sync_unlock(hdev);
>
> -       if (IS_ERR(skb))
> +       if (IS_ERR(skb)) {
> +               if (enable) {
> +                       hci_dev_clear_flag(hdev, HCI_DUT_MODE);
> +                       if (hdev->notify)
> +                               hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
> +               }
>                 return PTR_ERR(skb);
> +       }
>
>         kfree_skb(skb);
>
> -       hci_dev_change_flag(hdev, HCI_DUT_MODE);
> +       if (!enable) {
> +               hci_dev_clear_flag(hdev, HCI_DUT_MODE);
> +               if (hdev->notify)
> +                       hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
> +       }
>
>         return count;
>  }
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 070ca388f9ac..03b4676869e6 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1190,6 +1190,7 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>         struct sock *sk =3D sock->sk;
>         struct hci_dev *hdev =3D NULL;
>         struct sk_buff *skb;
> +       bool notify_user_channel =3D false;
>         int len, err =3D 0;
>
>         BT_DBG("sock %p sk %p", sock, sk);
> @@ -1324,6 +1325,7 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                                  * is still active.
>                                  */
>                                 err =3D 0;
> +                               notify_user_channel =3D true;
>                         } else {
>                                 hci_dev_clear_flag(hdev, HCI_USER_CHANNEL=
);
>                                 mgmt_index_added(hdev);
> @@ -1364,6 +1366,8 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                 }
>
>                 atomic_inc(&hdev->promisc);
> +               if (notify_user_channel && hdev->notify)
> +                       hdev->notify(hdev, HCI_NOTIFY_USER_CHANNEL);
>                 break;
>
>         case HCI_CHANNEL_MONITOR:
> @@ -1894,6 +1898,7 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                 hci_skb_opcode(skb) =3D opcode;
>
>                 if (ogf =3D=3D 0x3f) {
> +                       bt_cb(skb)->hci.req_flags |=3D HCI_REQ_RAW;
>                         skb_queue_tail(&hdev->raw_q, skb);
>                         queue_work(hdev->workqueue, &hdev->tx_work);
>                 } else {
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c0b1fc293b49..87199342621b 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5212,6 +5212,8 @@ static int hci_dev_init_sync(struct hci_dev *hdev)
>         }
>
>         clear_bit(HCI_INIT, &hdev->flags);
> +       if (hdev->notify)
> +               hdev->notify(hdev, HCI_NOTIFY_INIT_DONE);
>
>         return ret;
>  }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1db10e0f617f..5b652998e60e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2579,6 +2579,7 @@ static int set_le(struct sock *sk, struct hci_dev *=
hdev, void *data, u16 len)
>         enabled =3D lmp_host_le_capable(hdev);
>
>         if (!hdev_is_powered(hdev) || val =3D=3D enabled) {
> +               bool advertising_changed =3D false;
>                 bool changed =3D false;
>
>                 if (val !=3D hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> @@ -2588,6 +2589,7 @@ static int set_le(struct sock *sk, struct hci_dev *=
hdev, void *data, u16 len)
>
>                 if (!val && hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
>                         hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> +                       advertising_changed =3D true;
>                         changed =3D true;
>                 }
>
> @@ -2595,8 +2597,11 @@ static int set_le(struct sock *sk, struct hci_dev =
*hdev, void *data, u16 len)
>                 if (err < 0)
>                         goto unlock;
>
> -               if (changed)
> +               if (changed) {
> +                       if (advertising_changed && hdev->notify)
> +                               hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
>                         err =3D new_settings(hdev, sk);
> +               }
>
>                 goto unlock;
>         }
> @@ -6459,6 +6464,9 @@ static void set_advertising_complete(struct hci_dev=
 *hdev, void *data, int err)
>         else
>                 hci_dev_clear_flag(hdev, HCI_ADVERTISING);
>
> +       if (hdev->notify)
> +               hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
> +
>         settings_rsp(cmd, &match);
>         mgmt_pending_free(cmd);
>
> @@ -6593,8 +6601,11 @@ static int set_advertising(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>                 if (err < 0)
>                         goto unlock;
>
> -               if (changed)
> +               if (changed) {
> +                       if (hdev->notify)
> +                               hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
>                         err =3D new_settings(hdev, sk);
> +               }
>
>                 goto unlock;
>         }



--=20
Luiz Augusto von Dentz
