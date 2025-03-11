Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B571E7C2B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732702; cv=none; b=kL9+94d011JW795Rjad0wR8aEuUERaOkw5OOC1xfJuYqnGydg6FkNaw0EUdK+WsYs81nOCbHTt53P4n1h3ZbWTRHPytBoYyMN+OT76bODM/meoTIoiHpqQOsd3GcL2v7xFBNpiuvDIAgp8QF2KbfZlF0IWZhTd1Gxyeg9MIyXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732702; c=relaxed/simple;
	bh=aGURrWxkmnF2i6u9AJ9+TWimgbt+V7BT2G3249CKodQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPhHJqYQkNKyp63L6LC+/hgJnzrSBQAOE2HO2NqbCmqAicfqRNG9dez7tBS8rdnso8HHTgw7bo3DWp2vpTYMheUw6FmJt9UNGju0zH0aFw/ImSyOO2/ECbhttJHt7WiOY1dYu4fWsFnd2gI9aEh8PX17D6zpxuA8ed2YiT5dHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeHtNtTG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeHtNtTG"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfed67e08so40731391fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741732699; x=1742337499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgX7t43bm7Rg2YMMT/4j2MErAjy6trNOcQRSbeFqvxY=;
        b=IeHtNtTGs9bI/JgjA4RaozuL4xb+XoLYQnjG3fmO8mrp9I6W8RX5OmswM0bPbmykCR
         ZDO/U3WdfvsO1cnS/uF0hGMk1/jSzEyPSWqW+S5MtJRqwGz5R4u7hMfF25aesf+8vb1S
         2CPc2g3WJe/HtWODwhmADqq5/wgB6H3ubuKSn3DKuF2aCmgdtmrEvUJqhZrMyhxPho6+
         kNKp7lx/r60/PJZCa6KbyjPmJy5jvGuyv0kaGjw0M15M4kpJ0QluSa/Qm6Hj5SKKWJc7
         FFCscBlV7V9+bNpVv+qT6aLiM8FvqtpGMWfZDijkTBY6iF8e8QKzIWvC3lxDDZejLZWw
         cxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741732699; x=1742337499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgX7t43bm7Rg2YMMT/4j2MErAjy6trNOcQRSbeFqvxY=;
        b=lbu/rPAgAZTqw48AY3V87dwc4IER7KDKlxDG4Q+HuTvD1rUpVX/EjDRuTFOvO45fNu
         b2kIWEl8VBOmQfNFZX+UE0KXFN9Qtts5D6cOLCuts5MeNApFRIBzNWJVPgnVA3rBc7Pe
         cxWmvtd+LiQlF/YB43rd5I9pQeAOwcrqswiWcREVnr32J5CP5yy5J+ILXE+a+QAyGZzs
         nPWhb6IS356iR3M155LtNomzw/XYKpfPySQEyWtLhWY+uzEM3TIrrIIy9IcjpM5s6s/T
         qEb+4hzaSd0LJX4lv/d2WuTb6eAUuMVsRvVsYykK4SFVVouZHZX28x8fHqH+hIjp2dzK
         RaEQ==
X-Gm-Message-State: AOJu0YyBnc0bZMbqRWkeMykrroJN3JTEMPkyh7JTDSrOghpAMw7n6daK
	ahzRtdrnXQsFgptWY4hnfIeAi2lokoyzHluI1PXrlizEr6W/fqvUygGvxzh1SttTVtCa0m5Tp36
	jWClGvdjCOEXQIEnNS5ltF8Tu0+7eKK6M
X-Gm-Gg: ASbGncsAPuNNLn2jfjhAQL0iRGQc6DLLWxpGjfN8hjyUVbw2Jvve7FTdo7RLqOe94uq
	WStPAa6b41xtxmNrpr+4/HLRsW3Ko1NEhm+93/t31yYWCcJmn2UCFXDj4lg2TVSb5bIWtyk0kbs
	Q9iCDa2Rjvo9MQE1ZM5JuYoB5T
X-Google-Smtp-Source: AGHT+IE+hTKnuEVqSCfIOzBobkdZhOiTNRrK2l/fMI7UeAGbhDAyOmclJDmhq4G5Xgfr2GnWIukblKE6BsYQX8nYZgE=
X-Received: by 2002:a2e:a54e:0:b0:30b:c637:fcc2 with SMTP id
 38308e7fff4ca-30bf44fa63emr67528151fa.6.1741732698404; Tue, 11 Mar 2025
 15:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311195528.41993-1-luiz.dentz@gmail.com> <a52405aac2e8b90b4fca840f9c606cf1a0085e30.camel@iki.fi>
In-Reply-To: <a52405aac2e8b90b4fca840f9c606cf1a0085e30.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Mar 2025 18:38:06 -0400
X-Gm-Features: AQ5f1Jo8urobt4KOVElDC0Xc9zHMo4YhyZ2xPbkKtJ7etiWYln2mcKG05kn5bh0
Message-ID: <CABBYNZKbOnFbjtLQBk-jrC7ZMsYKdzSD-DdCpHONqQga5tBidg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Enable buffer flow control
 for SCO/eSCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Mar 11, 2025 at 6:21=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2025-03-11 kello 15:55 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This enables buffer flow control for SCO/eSCO
> > (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> > recently this has caused the following problem and is actually a nice
> > addition for the likes of Socket TX complete:
> >
> > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > HCI Event: Command Complete (0x0e) plen 11
> >       Read Buffer Size (0x04|0x0005) ncmd 1
> >         Status: Success (0x00)
> >         ACL MTU: 1021 ACL max packet: 5
> >         SCO MTU: 240  SCO max packet: 8
> > ...
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > HCI Event: Hardware Error (0x10) plen 1
> >         Code: 0x0a
> >
> > To fix the code will now attempt to enable buffer flow control:
> >
> > < HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
> >         Flow control: Enabled (0x01)
> > > HCI Event: Command Complete (0x0e) plen 4
> >       Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
> >         Status: Success (0x00)
> >
> > And then test it by sending an empty packet to confirm the controller
> > will generate HCI_EV_NUM_COMP_PKTS events:
>
> It's not doing this any more in this version.

Oh yeah, forgot to remove it from the patch description.

> >
> > sco-tester[40]: < SCO Data TX:.. flags 0x00 dlen 9
> > > HCI Event: Number of Completed P.. (0x13) plen 5
> >         Num handles: 1
> >         Handle: 42 Address: 00:AA:01:01:00:00 (Intel Corporation)
> >         Count: 1
> >         #103: len 10 (40 Kb/s)
> >         Latency: 2 msec (2-2 msec ~2 msec)
> >
> > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      | 13 +++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 67 ++++++++++++++++----------------
> >  net/bluetooth/hci_event.c        |  2 +
> >  net/bluetooth/hci_sync.c         | 24 ++++++++++++
> >  5 files changed, 74 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index b99818df8ee7..3c8f95174fcf 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -208,6 +208,13 @@ enum {
> >        */
> >       HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> >
> > +     /* When this quirk is set consider Sync Flow Control as supported=
 by
> > +      * the driver.
> > +      *
> > +      * This quirk must be set before hci_register_dev is called.
> > +      */
> > +     HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED,
> > +
> >       /* When this quirk is set, the LE states reported through the
> >        * HCI_LE_READ_SUPPORTED_STATES are invalid/broken.
> >        *
> > @@ -448,6 +455,7 @@ enum {
> >       HCI_WIDEBAND_SPEECH_ENABLED,
> >       HCI_EVENT_FILTER_CONFIGURED,
> >       HCI_PA_SYNC,
> > +     HCI_SCO_FLOWCTL,
> >
> >       HCI_DUT_MODE,
> >       HCI_VENDOR_DIAG,
> > @@ -1544,6 +1552,11 @@ struct hci_rp_read_tx_power {
> >       __s8     tx_power;
> >  } __packed;
> >
> > +#define HCI_OP_WRITE_SYNC_FLOWCTL    0x0c2f
> > +struct hci_cp_write_sync_flowctl {
> > +     __u8     enable;
> > +} __packed;
> > +
> >  #define HCI_OP_READ_PAGE_SCAN_TYPE   0x0c46
> >  struct hci_rp_read_page_scan_type {
> >       __u8     status;
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 7966db4038cc..f78e4298e39a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1858,6 +1858,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
> >  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
> >  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
> > +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
> >  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_I=
NQ)
> >  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
> >  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_B=
REDR))
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 012fc107901a..efba2b539902 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3552,51 +3552,52 @@ static void __check_timeout(struct hci_dev *hde=
v, unsigned int cnt, u8 type)
> >  }
> >
> >  /* Schedule SCO */
> > -static void hci_sched_sco(struct hci_dev *hdev)
> > +static void hci_sched_sco_type(struct hci_dev *hdev, __u8 type)
> >  {
> >       struct hci_conn *conn;
> >       struct sk_buff *skb;
> >       int quote;
> > +     unsigned int pkts;
> >
> > -     BT_DBG("%s", hdev->name);
> > +     bt_dev_dbg(hdev, "type %u", type);
> >
> > -     if (!hci_conn_num(hdev, SCO_LINK))
> > +     if (!hci_conn_num(hdev, type))
> >               return;
> >
> > -     while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, SCO_LINK, &q=
uote))) {
> > +     /* Use sco_pkts if flow control has not been enabled yet which wi=
ll
> > +      * limit the amount of buffer sent in a row.
> > +      */
> > +     if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > +             pkts =3D hdev->sco_pkts;
> > +     else
> > +             pkts =3D hdev->sco_cnt;
> > +
> > +     if (!pkts)
> > +             return;
> > +
> > +     while (pkts && (conn =3D hci_low_sent(hdev, type, &quote))) {
> >               while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>
> hci_low_sent -> hci_quote_sent uses the current value of hdev->sco_cnt
> to determine `quote`, which can then be larger than pkts, possibly
> causing it to underflow here.

Well there is a check for pkts not underflow (< 0), or do you mean
something else?

> I guess this is why the other sched() functions are doing the (*cnt)--
> thing.

Right, we might want to switch to do that here as well, that said
perhaps hci_low_sent shouldn't be using sco_cnt if HCI_SCO_FLOWCTL is
not enabled.

>
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> >
> > +                     pkts--;
> > +
> > +                     if (hdev->sco_cnt > 0)
> > +                             hdev->sco_cnt--;
> > +
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
> >               }
> >       }
> > -}
> >
> > -static void hci_sched_esco(struct hci_dev *hdev)
> > -{
> > -     struct hci_conn *conn;
> > -     struct sk_buff *skb;
> > -     int quote;
> > -
> > -     BT_DBG("%s", hdev->name);
> > -
> > -     if (!hci_conn_num(hdev, ESCO_LINK))
> > -             return;
> > -
> > -     while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, ESCO_LINK,
> > -                                                  &quote))) {
> > -             while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
> > -                     BT_DBG("skb %p len %d", skb, skb->len);
> > -                     hci_send_frame(hdev, skb);
> > -
> > -                     conn->sent++;
> > -                     if (conn->sent =3D=3D ~0)
> > -                             conn->sent =3D 0;
> > -             }
> > -     }
> > +     /* Rescheduled if all packets were sent and flow control is not e=
nabled
> > +      * as there could be more packets queued that could not be sent a=
nd
> > +      * since no HCI_EV_NUM_COMP_PKTS event will be generated the resc=
hedule
> > +      * needs to be forced.
> > +      */
> > +     if (!pkts && !hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > +             queue_work(hdev->workqueue, &hdev->tx_work);
> >  }
> >
> >  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> > @@ -3632,8 +3633,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hde=
v)
> >                       chan->conn->sent++;
> >
> >                       /* Send pending SCO packets right away */
> > -                     hci_sched_sco(hdev);
> > -                     hci_sched_esco(hdev);
> > +                     hci_sched_sco_type(hdev, SCO_LINK);
> > +                     hci_sched_sco_type(hdev, ESCO_LINK);
> >               }
> >       }
> >
> > @@ -3688,8 +3689,8 @@ static void hci_sched_le(struct hci_dev *hdev)
> >                       chan->conn->sent++;
> >
> >                       /* Send pending SCO packets right away */
> > -                     hci_sched_sco(hdev);
> > -                     hci_sched_esco(hdev);
> > +                     hci_sched_sco_type(hdev, SCO_LINK);
> > +                     hci_sched_sco_type(hdev, ESCO_LINK);
> >               }
> >       }
> >
> > @@ -3734,8 +3735,8 @@ static void hci_tx_work(struct work_struct *work)
> >
> >       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> >               /* Schedule queues and send stuff to HCI driver */
> > -             hci_sched_sco(hdev);
> > -             hci_sched_esco(hdev);
> > +             hci_sched_sco_type(hdev, SCO_LINK);
> > +             hci_sched_sco_type(hdev, ESCO_LINK);
> >               hci_sched_iso(hdev);
> >               hci_sched_acl(hdev);
> >               hci_sched_le(hdev);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 19e19c9f5e68..6d0138b778aa 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4445,9 +4445,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev=
 *hdev, void *data,
> >                       break;
> >
> >               case SCO_LINK:
> > +             case ESCO_LINK:
> >                       hdev->sco_cnt +=3D count;
> >                       if (hdev->sco_cnt > hdev->sco_pkts)
> >                               hdev->sco_cnt =3D hdev->sco_pkts;
> > +
> >                       break;
> >
> >               case ISO_LINK:
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c4c2cf51b219..609b035e5c90 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3769,6 +3769,28 @@ static int hci_write_ca_timeout_sync(struct hci_=
dev *hdev)
> >                                    sizeof(param), &param, HCI_CMD_TIMEO=
UT);
> >  }
> >
> > +/* Enable SCO flow control if supported */
> > +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> > +{
> > +     struct hci_cp_write_sync_flowctl cp;
> > +     int err;
> > +
> > +     /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLO=
WCTL */
> > +     if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)) ||
> > +         !test_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks))
> > +             return 0;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +     cp.enable =3D 0x01;
> > +
> > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> > +                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +     if (!err)
> > +             hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> > +
> > +     return err;
> > +}
> > +
> >  /* BR Controller init stage 2 command sequence */
> >  static const struct hci_init_stage br_init2[] =3D {
> >       /* HCI_OP_READ_BUFFER_SIZE */
> > @@ -3787,6 +3809,8 @@ static const struct hci_init_stage br_init2[] =3D=
 {
> >       HCI_INIT(hci_clear_event_filter_sync),
> >       /* HCI_OP_WRITE_CA_TIMEOUT */
> >       HCI_INIT(hci_write_ca_timeout_sync),
> > +     /* HCI_OP_WRITE_SYNC_FLOWCTL */
> > +     HCI_INIT(hci_write_sync_flowctl_sync),
> >       {}
> >  };
> >
>


--=20
Luiz Augusto von Dentz
