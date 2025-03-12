Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5821EE7D9
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811428; cv=none; b=p64vdg65MFMJk/Y1OgSmXILUl2BEfwEtDcsbvIECWNJxiCxLbqTqAYXX4Ke4t4gNQA61LogHSfjg683xHHKlmTvd3tT+TtMNWcbOpAriUy3aAmb0ULtPiJuKjdHSt4awQP7ksxpygylX4xgPN+hS6Y3kQrsL7G+wuP4FWht4kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811428; c=relaxed/simple;
	bh=bE2MFDG9JbBywzjGK4WyrIFRbddqh7JUGWBzpHo6xpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDOyfdDhAUkrpvIPHEBL3/kUzVzVBs0bU0/o1sfojkxmGW/IR1vkPs8I1KlELB87vRyNHOdBD52HyUqtCIz4phqcYwVccW5HvZmVf52sC+f+fZdr3XYPDNLQzHDYvncvDMVafMZTErIh3qisuFbf3+PvU/MLSxoqjwBUXXPoAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8w3nrDI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8w3nrDI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30761be8fcfso3197021fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741811424; x=1742416224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFAuqHXbMB4sCI0zCL9QC4OM/RKh6UD2rG6iWD0ufRU=;
        b=a8w3nrDIPF0chZsb311EOp9AeMXueEFjr597TuypfhuUJRzJUVtZZYFyXf1BfWQqgi
         wkSKquwT4A19iNL8hFln6V6ldMeC74yiouwtgI4bg4BUtC563QljoFp9rrNaoRRHrHvf
         iQm+3Mq0VbeQ/aAKGax1/p/cNYRZSS6bMvstkXrZT3BVTd0LZyAuOGlDV8j3SQtmqbP2
         BGl8Hgfvm045itQgYeHf+NLqbqs8/X4la2U0yGRmhPsNrwzkfPdFHLwxhn1dreBsVpZU
         x1jWj9ggdULI08yY0m12i0sw6gjKyUeqQ/fMrpIYPYyD4rqAUMN5QB2XxLAXbqpodisT
         xHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741811424; x=1742416224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFAuqHXbMB4sCI0zCL9QC4OM/RKh6UD2rG6iWD0ufRU=;
        b=M22+JQQn2zPxnY4nIikdipJLZCgdZkBgrcsKRQAHJ0i+bAfY1BCdKCUUZBsZ3Q0ciK
         2GqiD1cMlsPIEGL7LH3xyN4o0sMwTuVi2/0KmjJRRhmSS3fb8gfwG9Jf101Gfzg/nOj1
         pa8Vy8DqOBGddEbyHlJsUX4cZ/Uy79tPFOqf1H+HF1Ow/Q8RTQcFXWgpiiQKksblKfFr
         85M8x7LUPUmf+1+4SKBRxh6NK4T2VzYOPMI5wR/PwrP4rrMu/EcG9tFzu70D3wmWT7tU
         kbnjkxej3RIu8On8gBcEiNhmqO5YZ+8M9GQk3/PBmGj+WGkii2Ycq6u+TrircB76Xo5X
         Pltg==
X-Gm-Message-State: AOJu0YwLMJjYY8W02/AFgjwFKTaL6fEdXKfyHeOM5YtTSvvOvfH2EfgN
	k42kWS6YsPDywWnKp3gBXyIL10ky2UFQVk57mKeFwFjtl8JmF8McxC5ZYKvvW3JfwRr+f7ltipQ
	M7s5MeG3JXpBuzDnswrlSnX4JJrMKvxXM
X-Gm-Gg: ASbGncsSPAyOL0sBblWOihY0f3OQgKQ/rX/9hCuj5S/hEp0NxEpUUN+XR2bmKJ/uT1D
	ybbj4RSx60KEgdJ8NUvZbga/HA9OxuP56uS5T94OhbjwUCFdYJzWcJ49HuVZlkBkN9aw9Bwn7fT
	iaWUnSUasxZeBIy2LgMNOoGyl8
X-Google-Smtp-Source: AGHT+IGjrDmoNrW89O0E809FWMgNNhrK/7/UzGOQ9/jBJ11JGSnmur6GmWGskdZ3Wq0ifIW38fj1jylCUbmGIWFoiR4=
X-Received: by 2002:a2e:bc23:0:b0:30c:1002:faa8 with SMTP id
 38308e7fff4ca-30c1002ff06mr53388461fa.7.1741811423941; Wed, 12 Mar 2025
 13:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312151421.201772-1-luiz.dentz@gmail.com> <f82dd646f177ed414fe4864b0fd66e95d885a089.camel@iki.fi>
In-Reply-To: <f82dd646f177ed414fe4864b0fd66e95d885a089.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Mar 2025 16:30:11 -0400
X-Gm-Features: AQ5f1JpBbwW0cBZnyRTZJMTWUkXB0Inj60mZvBeBL2dySMZleDS1AwGrpHXd-NU
Message-ID: <CABBYNZKJSoTK2sLL7ns67F6EQWj5qd7Hu7kTe5LgWyZaOwAgmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_core: Enable buffer flow control
 for SCO/eSCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 12, 2025 at 4:00=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-03-12 kello 11:14 -0400, Luiz Augusto von Dentz kirjoitti:
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
> > To fix the code will now attempt to enable buffer flow control when
> > HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED is set by the driver:
> >
> > < HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
> >         Flow control: Enabled (0x01)
> > > HCI Event: Command Complete (0x0e) plen 4
> >       Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
> >         Status: Success (0x00)
> >
> > On success then HCI_SCO_FLOWCTL would be set which indicates sco_cnt
> > shall be used for flow contro.
>
> Tested-by: Pauli Virtanen <pav@iki.fi>
>
> ... to the degree that this does not break things on hardware that does
> not support SCO flow control, and that the flow control case seemed to
> be fine in the emulator.

Yes, thanks to you we have tests that cover both cases and with these
changes it can confirm if NOCP is being generated or not, so at least
it gives you the ability to implement the TX complete logic for SCO
using the emulator, right?

> I don't seem to have HW that support SCO flow control at hand, the
> controllers I tested claim to support these commands, but either the
> enable command reports success but the feature doesn't actually work
> (Intel/Realtek), or the command fails (CSR, error code 0x11).

Yeah, I am afraid we can't do much about that if the controller is
just not generating NOCP then we cannot enable the quirk, but at least
in the case of Intel it should work so perhaps there is something else
missing which I am trying to dig out.

> >
> > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      | 13 +++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 62 +++++++++++++++-----------------
> >  net/bluetooth/hci_event.c        |  2 ++
> >  net/bluetooth/hci_sync.c         | 24 +++++++++++++
> >  5 files changed, 68 insertions(+), 34 deletions(-)
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
> > index 012fc107901a..94d9147612da 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3552,18 +3552,27 @@ static void __check_timeout(struct hci_dev *hde=
v, unsigned int cnt, u8 type)
> >  }
> >
> >  /* Schedule SCO */
> > -static void hci_sched_sco(struct hci_dev *hdev)
> > +static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
> >  {
> >       struct hci_conn *conn;
> >       struct sk_buff *skb;
> > -     int quote;
> > +     int quote, *cnt;
> > +     unsigned int pkts =3D hdev->sco_pkts;
> >
> > -     BT_DBG("%s", hdev->name);
> > +     bt_dev_dbg(hdev, "type %u", type);
> >
> > -     if (!hci_conn_num(hdev, SCO_LINK))
> > +     if (!hci_conn_num(hdev, type) || !pkts)
> >               return;
> >
> > -     while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, SCO_LINK, &q=
uote))) {
> > +     /* Use sco_pkts if flow control has not been enabled which will l=
imit
> > +      * the amount of buffer sent in a row.
> > +      */
> > +     if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > +             cnt =3D &pkts;
> > +     else
> > +             cnt =3D &hdev->sco_cnt;
> > +
> > +     while (*cnt && (conn =3D hci_low_sent(hdev, type, &quote))) {
> >               while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> > @@ -3571,32 +3580,17 @@ static void hci_sched_sco(struct hci_dev *hdev)
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
> > +                     (*cnt)--;
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
> > @@ -3632,8 +3626,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hde=
v)
> >                       chan->conn->sent++;
> >
> >                       /* Send pending SCO packets right away */
> > -                     hci_sched_sco(hdev);
> > -                     hci_sched_esco(hdev);
> > +                     hci_sched_sco(hdev, SCO_LINK);
> > +                     hci_sched_sco(hdev, ESCO_LINK);
> >               }
> >       }
> >
> > @@ -3688,8 +3682,8 @@ static void hci_sched_le(struct hci_dev *hdev)
> >                       chan->conn->sent++;
> >
> >                       /* Send pending SCO packets right away */
> > -                     hci_sched_sco(hdev);
> > -                     hci_sched_esco(hdev);
> > +                     hci_sched_sco(hdev, SCO_LINK);
> > +                     hci_sched_sco(hdev, ESCO_LINK);
> >               }
> >       }
> >
> > @@ -3734,8 +3728,8 @@ static void hci_tx_work(struct work_struct *work)
> >
> >       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> >               /* Schedule queues and send stuff to HCI driver */
> > -             hci_sched_sco(hdev);
> > -             hci_sched_esco(hdev);
> > +             hci_sched_sco(hdev, SCO_LINK);
> > +             hci_sched_sco(hdev, ESCO_LINK);
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
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
