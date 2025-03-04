Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCB1FA178
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119863; cv=none; b=WE6aq8CvuQOAsO/2LJflyckapz6vkyzNv9zJLxKmTvzwuEkB5y8TzAmTv9bhHTnH9Bnpp2PKM1pOdOCkNSmeRg6fM/NIM+45WSoyMzImyG+XBYhi8sFPn9GU6ODVH/jobF7FbnCxWUmr7hsHnUkf3PbapXDlbZaZfY9lS6ijnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119863; c=relaxed/simple;
	bh=ito4rMRP4q8XyIpTguffWQfeaCD+Z9XPv4Mfl+k9YwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=S2zVw0wrmBQvIfC2xG8esOISF4EEo+MJUImRXnldEP5yujazfTLVTsjFht2R98aVQkQK9fkxXZnE9qd4bSFXQ4NswthO0ybErdvT7lEHl4AB+A9yzL8U0nFWhw72OhjJoI97rhXUhLWrKxa+gME0e1yuSQOYelBErF/i/tIMXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yoe2/t5b; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoe2/t5b"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5496301c6afso195439e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741119858; x=1741724658; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3aKebPgAlr246/bbZc5bn/kMYZnJn7dhXo1/8J6tFE=;
        b=Yoe2/t5bqVmZqPAdNafb1UjUDCLAp00zCLqDVcSDHWqwxYgJ0QH3kCnYuuULcDHSLw
         7C+vkX0FFd9RJ7Afh+amYBlzfFBseAKZUaAtsxPWDgn++oC51jBy/hMsx/dhDZTgnsMR
         UjvGN1Wn3/JaOjGCg3pfiihUEwrReSF+G4SZePVvP+RQCrLEh9gKn9YbENhpfnyFs6W5
         1GO/F9Si7nf7dB2zeza3Y+0w2kqYGDV5m/Nrf6sjl5zz1R+kfQhxY4OnOkfcDyP3g61l
         Gt+tW+rgoGDY7bjIhCRXH6E6K8ePNAwTuChX+l3rrBgEM442rceBbfBPy2chHC26lyT3
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119858; x=1741724658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3aKebPgAlr246/bbZc5bn/kMYZnJn7dhXo1/8J6tFE=;
        b=ue/D6TPuy4nm9N/eSyUkIm1Men0VfsIieSPddf3im0sGpdmQWGwyLJtOWiIYgq2Tqk
         T+WvXsypWS/Ie3cseEBq4frC3zrW6thGCBuv2UKwTOzyKPuRsp/cRg7J4k0S5AUPk5f7
         fM1LZiUioikdLaPLizV1+37fspx4zZtLnfvlrkR0zHwkxjcqyPPULAkMFsuc5dUMZJ3a
         XDyPeK4GIr3Jmwn9K4y30I1qGr1KyynWpNIltSj6tIG6HyFnIZ/8a0tNtYnnttFIajBr
         igOA/DHfOHadoX68iSeYByc6O5gC2D0RZPJBbal9lYhMDnD8N7tKuBBoFpubmbctWbq5
         Na9w==
X-Gm-Message-State: AOJu0YzFN+pkV8Z6zwYmFlaSooa70qCJ0qAmlVtANqaPRXSOzQABE69l
	3xvdRKEA/XZRJSQAx0lFbaetF0B593ebtjIYUn71/9n2LzL8GuGIOSepMZzxHdpxBuFprtNTUv5
	E4poWlpk/8lgHLpsjBsyEpdynVEFiJw==
X-Gm-Gg: ASbGncsKxDLwuwgg/YLy/Oo+NQvt9/6AqRRxmwDLh/qud9eZCeKBu9H5RsSsg9pRdC7
	Ve46ZyxM14pN4NcA4jpf+XSNPLWb6mvWJ+0OJSfiiuT0y50QIHp87r11XN2SPmXvJKIH+n02mIz
	hmO4ehh3QLEKb1e7zATizAucZ1
X-Google-Smtp-Source: AGHT+IH6+AzBFeoTX/o6mj5h4f5GX7n+91sq4H2KCMX6Ffgd4xf0i3KLrX3D/V29Y/Z9D6sIlDh1iVpsO1+bwwmzKp0=
X-Received: by 2002:a05:6512:158e:b0:549:69c1:fd32 with SMTP id
 2adb3069b0e04-549756e23a6mr1799445e87.20.1741119857415; Tue, 04 Mar 2025
 12:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304181019.214207-1-luiz.dentz@gmail.com>
In-Reply-To: <20250304181019.214207-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Mar 2025 15:24:04 -0500
X-Gm-Features: AQ5f1JoTZlXfLsqOruZq5hfykx0oqkLCupsAR3OtCS_G4uHT1YzyAjL8dh64h0E
Message-ID: <CABBYNZJx1tz9qDZYESwxNfV6L+jP1mGOCHY6h2DtM7uOTru7CA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 4, 2025 at 1:10=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables buffer flow control for SCO/eSCO
> (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> recently this has caused the following problem and is actually a nice
> addition for the likes of Socket TX complete:
>
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 1021 ACL max packet: 5
>         SCO MTU: 240  SCO max packet: 8
> ...
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > HCI Event: Hardware Error (0x10) plen 1
>         Code: 0x0a
>
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      |  6 ++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 54 +++++++++++++-------------------
>  net/bluetooth/hci_event.c        |  5 +++
>  net/bluetooth/hci_sync.c         | 18 +++++++++++
>  5 files changed, 52 insertions(+), 32 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b99818df8ee7..70169533c940 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -448,6 +448,7 @@ enum {
>         HCI_WIDEBAND_SPEECH_ENABLED,
>         HCI_EVENT_FILTER_CONFIGURED,
>         HCI_PA_SYNC,
> +       HCI_SCO_FLOWCTL,
>
>         HCI_DUT_MODE,
>         HCI_VENDOR_DIAG,
> @@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
>         __s8     tx_power;
>  } __packed;
>
> +#define HCI_OP_WRITE_SYNC_FLOWCTL      0x0c2f
> +struct hci_cp_write_sync_flowctl {
> +       __u8     enable;
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_TYPE     0x0c46
>  struct hci_rp_read_page_scan_type {
>         __u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2f320eeddfec..cf18cf65fe5e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
>  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
>  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
> +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
>  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ=
)
>  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
>  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BRE=
DR))
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..9ea9b4091f8f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3548,45 +3548,35 @@ static void __check_timeout(struct hci_dev *hdev,=
 unsigned int cnt, u8 type)
>  }
>
>  /* Schedule SCO */
> -static void hci_sched_sco(struct hci_dev *hdev)
> +static void hci_sched_sco_type(struct hci_dev *hdev, __u8 type)
>  {
>         struct hci_conn *conn;
>         struct sk_buff *skb;
>         int quote;
> +       unsigned int pkts;
>
> -       BT_DBG("%s", hdev->name);
> +       bt_dev_dbg(hdev, "type %u", type);
>
> -       if (!hci_conn_num(hdev, SCO_LINK))
> +       if (!hci_conn_num(hdev, type))
>                 return;
>
> -       while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, SCO_LINK, &q=
uote))) {
> +       /* Use sco_pkts if flow control has not been enabled yet which wi=
ll
> +        * limit the amount of buffer sent in a row.
> +        */
> +       if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +               pkts =3D hdev->sco_pkts;
> +       else
> +               pkts =3D hdev->sco_cnt;
> +
> +       while (pkts && (conn =3D hci_low_sent(hdev, type, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_frame(hdev, skb);
>
> -                       conn->sent++;
> -                       if (conn->sent =3D=3D ~0)
> -                               conn->sent =3D 0;
> -               }
> -       }
> -}
> +                       pkts--;
>
> -static void hci_sched_esco(struct hci_dev *hdev)
> -{
> -       struct hci_conn *conn;
> -       struct sk_buff *skb;
> -       int quote;
> -
> -       BT_DBG("%s", hdev->name);
> -
> -       if (!hci_conn_num(hdev, ESCO_LINK))
> -               return;
> -
> -       while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, ESCO_LINK,
> -                                                    &quote))) {
> -               while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
> -                       BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(hdev, skb);
> +                       if (hdev->sco_cnt > 0)
> +                               hdev->sco_cnt--;
>
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
> @@ -3628,8 +3618,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>                         chan->conn->sent++;
>
>                         /* Send pending SCO packets right away */
> -                       hci_sched_sco(hdev);
> -                       hci_sched_esco(hdev);
> +                       hci_sched_sco_type(hdev, SCO_LINK);
> +                       hci_sched_sco_type(hdev, ESCO_LINK);
>                 }
>         }
>
> @@ -3684,8 +3674,8 @@ static void hci_sched_le(struct hci_dev *hdev)
>                         chan->conn->sent++;
>
>                         /* Send pending SCO packets right away */
> -                       hci_sched_sco(hdev);
> -                       hci_sched_esco(hdev);
> +                       hci_sched_sco_type(hdev, SCO_LINK);
> +                       hci_sched_sco_type(hdev, ESCO_LINK);
>                 }
>         }
>
> @@ -3730,8 +3720,8 @@ static void hci_tx_work(struct work_struct *work)
>
>         if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
>                 /* Schedule queues and send stuff to HCI driver */
> -               hci_sched_sco(hdev);
> -               hci_sched_esco(hdev);
> +               hci_sched_sco_type(hdev, SCO_LINK);
> +               hci_sched_sco_type(hdev, ESCO_LINK);
>                 hci_sched_iso(hdev);
>                 hci_sched_acl(hdev);
>                 hci_sched_le(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 19e19c9f5e68..e6eadcc13484 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4448,6 +4448,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *=
hdev, void *data,
>                         hdev->sco_cnt +=3D count;
>                         if (hdev->sco_cnt > hdev->sco_pkts)
>                                 hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +                       /* Enable HCI_SCO_FLOWCTL so sco_cnt is used inst=
ead of
> +                        * sco_pkts.
> +                        */
> +                       hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);

I may spin another version implement this logic but before triggering
hci_connect_cfm do send a empty packet just to test if flowctl is
really enabled, this maybe better than always setting the flag above
since in that case the socket interface is not involved so we can
guarantee that only one packet is outstanding.

>                         break;
>
>                 case ISO_LINK:
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c4c2cf51b219..91cfb7c2cb08 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3769,6 +3769,22 @@ static int hci_write_ca_timeout_sync(struct hci_de=
v *hdev)
>                                      sizeof(param), &param, HCI_CMD_TIMEO=
UT);
>  }
>
> +/* Enable SCO flow control if supported */
> +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> +{
> +       struct hci_cp_write_sync_flowctl cp;
> +
> +       /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLO=
WCTL */
> +       if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> +               return 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.enable =3D 0x01;
> +
> +       return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> +                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
>  /* BR Controller init stage 2 command sequence */
>  static const struct hci_init_stage br_init2[] =3D {
>         /* HCI_OP_READ_BUFFER_SIZE */
> @@ -3787,6 +3803,8 @@ static const struct hci_init_stage br_init2[] =3D {
>         HCI_INIT(hci_clear_event_filter_sync),
>         /* HCI_OP_WRITE_CA_TIMEOUT */
>         HCI_INIT(hci_write_ca_timeout_sync),
> +       /* HCI_OP_WRITE_SYNC_FLOWCTL */
> +       HCI_INIT(hci_write_sync_flowctl_sync),
>         {}
>  };
>
> --
> 2.48.1
>


--=20
Luiz Augusto von Dentz
