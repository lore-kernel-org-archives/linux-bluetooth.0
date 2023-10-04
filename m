Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2BE7C4EC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 19:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjJDTYW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjJDTYV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 15:24:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB69B90
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 12:24:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so2348151fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Oct 2023 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696447456; x=1697052256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3M5bTiShpT2bVdGixiGJB13BVHemqAOesMVlC41kvg=;
        b=Hx23dAGy8aqtsiniCyjH/pzqESGXEEHqeyyZlzNGawTeN0hYk8uFxJsjSOQCMYeUUt
         pjt9jPOEFASMSbW3P3fNt/0HyO8y5ycDCBKhtEvNu5IJ6gTMNAyv/fLr8RBVPbYlarxA
         zN/rGN2scUlSO9Gr4XupSpLbaf9SKQjWAnyuR4ZReyOUxGtXRUYuuBMBPBaBb6HuJyjl
         KDQW6cHI7T0n7nl6tTw5Ru6QqOeBaN6h/j24Lptjk0sMPrMZQI3XCsrGyXaR1NwcdHUh
         Hynf6uXw5pF2qwhO0UMn/EwdU+kxJ+/KJvi/IZd50I/qNzzYFKAsIxXHN9COsEdiTC7q
         si6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447456; x=1697052256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3M5bTiShpT2bVdGixiGJB13BVHemqAOesMVlC41kvg=;
        b=sTf9uFwTF1jzFHd2llAlNwCmKX2cDJ5VzqW5GGFScQpUklRfaA9IKRW4DxVoF3O2Ex
         Mf+3A8ptcVbojbdWVwCf9RLO70SsyoYE5jSdkjghzI3gpqBr19hMPUBB6mtvTXjMjOfD
         a8grrvcp0f7WYgJ56D39M+6Aeo71Vn09lP8JIDH8aioSJb4y05WFHqa59F9Gc5i4HXOb
         rUc2ijS02lA9/2cI5T392oAea1E0ufWRe62YjB9hQiOooOB6Zm44wuYEbUphy743vZgI
         zJr8yWpMjvIFeeYjldA614S4peg1OdUEQpheDlgYE8x/iyxEGcQbfJD8UhzSXSWdm0QQ
         So1A==
X-Gm-Message-State: AOJu0Yz4K1t22VyhFoGqsOV5yxehiyJl3+7KtrK+cH2hAEbdv8ZPTM1e
        ervKEy4Kew8Tes+701uoo4mOJ0ViImcH3wsCV+k=
X-Google-Smtp-Source: AGHT+IHfTPJly6LYx7KC7PidOtzVhYabZrgrfPpuma7WQEEFA81n42V1tnGkE4ssM65zWkqoQgEPq/XK60q3vQsh0aA=
X-Received: by 2002:a2e:350e:0:b0:2bc:f1a1:29d9 with SMTP id
 z14-20020a2e350e000000b002bcf1a129d9mr2917654ljz.2.1696447455762; Wed, 04 Oct
 2023 12:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b@eucas1p2.samsung.com>
 <20230928134506.130545-1-a.bokowy@samsung.com>
In-Reply-To: <20230928134506.130545-1-a.bokowy@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Oct 2023 12:24:03 -0700
Message-ID: <CABBYNZ+=c_G9wRRw4BvzypSu980ThzzdcUz_jMthe5_UZnE9Ew@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: Synchronize scan start and LE Meta events
To:     Arkadiusz Bokowy <a.bokowy@samsung.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arkadiusz,

On Thu, Sep 28, 2023 at 4:05=E2=80=AFPM Arkadiusz Bokowy <a.bokowy@samsung.=
com> wrote:
>
> It is possible that the Bluetooth management will receive scan enabled
> signal and LE meta events one by another without any delay. Since the
> start discovery procedure is performed in an asynchronous manner, it is
> possible that these HCI events will be processed concurrently by two
> different worker threads. In such case, it is possible that the LE meta
> event, which reports new device, will be discarded, because discovering
> is still in the starting state.
>
> The problem is most prominent with the btvirt userspace tool, which
> sends LE Meta events just after reporting scan as enabled. Testing
> scenario:
>
>   1. Create two HCI interfaces:
>   > btvirt -l2
>
>   2. Setup BLE advertisement on hci1:
>   > bluetoothctl
>   >> select 00:AA:01:00:00:00
>   >> menu advertise
>   >> uuids 03B80E5A-EDE8-4B33-A751-6CE34EC4C700
>   >> discoverable on
>   >> back
>   >> advertise peripheral
>
>   3. Start scanning on hci2:
>   > bluetoothctl
>   >> select 00:AA:01:01:00:01
>   >> scan le
>   // From time to time, new device is not reported
>
> To make this issue 100% reproducible, one can simply add slight delay,
> e.g. msleep(100) at the beginning of the start_discovery_complete()
> function in the net/bluetooth/mgmt.c file.
>
> This patch adds synchronization for start discovery procedure and device
> found reporting by the Bluetooth management. In case of discovering
> being in the starting state, the worker which processes LE Meta event
> will wait for the cmd_sync_work on which the start discovery procedure
> is queued.
>
> Signed-off-by: Arkadiusz Bokowy <a.bokowy@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |  5 +++++
>  include/net/bluetooth/hci_sync.h |  1 +
>  net/bluetooth/hci_sync.c         |  7 +++++++
>  net/bluetooth/mgmt.c             | 17 +++++++++++++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index f36c1fd5d64e..456bbdf56246 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -916,6 +916,11 @@ static inline void hci_discovery_filter_clear(struct=
 hci_dev *hdev)
>
>  bool hci_discovery_active(struct hci_dev *hdev);
>
> +static inline bool hci_discovery_starting(struct hci_dev *hdev)
> +{
> +       return hdev->discovery.state =3D=3D DISCOVERY_STARTING;
> +}
> +
>  void hci_discovery_set_state(struct hci_dev *hdev, int state);
>
>  static inline int inquiry_cache_empty(struct hci_dev *hdev)
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index 6efbc2152146..67cf6689a692 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -43,6 +43,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev);
>  void hci_cmd_sync_clear(struct hci_dev *hdev);
>  void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
>  void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
> +void hci_cmd_sync_flush(struct hci_dev *hdev);
>
>  int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t f=
unc,
>                         void *data, hci_cmd_sync_work_destroy_t destroy);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 3640d73f9595..58905a5b7b1e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -681,6 +681,13 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int e=
rr)
>  }
>  EXPORT_SYMBOL(hci_cmd_sync_cancel);
>
> +/* Wait for all pending HCI commands to complete.
> + */
> +void hci_cmd_sync_flush(struct hci_dev *hdev)
> +{
> +       flush_work(&hdev->cmd_sync_work);

Afaik this will block waiting the work to complete which sounds a
little dangerous especially if hdev has been locked.

> +}
> +
>  /* Submit HCI command to be run in as cmd_sync_work:
>   *
>   * - hdev must _not_ be unregistered
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ba2e00646e8e..fc494348f2f7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -10374,18 +10374,31 @@ void mgmt_device_found(struct hci_dev *hdev, bd=
addr_t *bdaddr, u8 link_type,
>  {
>         struct sk_buff *skb;
>         struct mgmt_ev_device_found *ev;
> -       bool report_device =3D hci_discovery_active(hdev);
> +       bool report_device;
>
>         if (hci_dev_test_flag(hdev, HCI_MESH) && link_type =3D=3D LE_LINK=
)
>                 mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
>                                   eir, eir_len, scan_rsp, scan_rsp_len,
>                                   instant);
>
> +       /* Discovery start procedure is perfomed on a workqueue in an
> +        * asynchronous manner. This procedure is finished when the scan
> +        * enabled signal is received from the controller. Just after
> +        * this signal, the controller might send another event (e.g. LE
> +        * Meta). In such case, we need to make sure that the discovery
> +        * procedure is finished, because otherwise we might omit some
> +        * scan results.
> +        */
> +       if (hci_discovery_starting(hdev))
> +               hci_cmd_sync_flush(hdev);
> +
> +       report_device =3D hci_discovery_active(hdev);

Couldn't we just do:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 195aea2198a9..78f0a8fb0a19 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -136,6 +136,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
        struct discovery_state *discov =3D &hdev->discovery;

        switch (discov->state) {
+       case DISCOVERY_STARTING:
        case DISCOVERY_FINDING:
        case DISCOVERY_RESOLVING:
                return true;


>         /* Don't send events for a non-kernel initiated discovery. With
>          * LE one exception is if we have pend_le_reports > 0 in which
>          * case we're doing passive scanning and want these events.
>          */
> -       if (!hci_discovery_active(hdev)) {
> +       if (!report_device) {
>                 if (link_type =3D=3D ACL_LINK)
>                         return;
>                 if (link_type =3D=3D LE_LINK && !list_empty(&hdev->pend_l=
e_reports))
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
