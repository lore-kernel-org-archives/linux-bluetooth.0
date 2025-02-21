Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A90253331
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169746; cv=none; b=IgEC7EGdYXbuPX2LNmzrXxeS+7o4s+JFzWz0c6MHzvXtVHvpzf4GwoQgR3tb4GiQoA90t+NQd59pcqx/ZfVBQHwpS2AMOqUN5VHZa8mNwdsXGKc0lve7i2NPKi4M+0Ih+VjU/Jyvpkx/7H2MXy80O9HTaC0Mjm7jyt+tHpOAIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169746; c=relaxed/simple;
	bh=pXHszaAVS65XDuLvcFEMjFoOPx18d8+KorMdFpxhm+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5rFSIyPDmla8UBf/LGVBdr3yvzsjqhn1orBb/teqWpI2xwxm9A3em35bYjOCESI0K7hHSl6MTbzdoixSXi7zuD71aXCZ5IArQZnNzafIK79Kg1ZR9TobgYghkPq2Rw+5jL60QASRuD+vp3yDicQiwF0dF3132bTAcviOt4NmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/6cG5ic; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/6cG5ic"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a2594435dso35598641fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169743; x=1740774543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uzX/L490TWQv9IiHeqp3+6gxi+IyDPgpYAyhAfP2Zo=;
        b=h/6cG5icvjmaHpluRquYmTp67lu6IqUeu6Vi+WvQuEJrpY3mxuieqItVtYAAAJlwTi
         c0uxYvk62dqeDWhzpqMNoojkT7G6eQkp6rxPauGqGaTG5OzlMsFq4XuoppHgEceVYGyw
         rd/KLBX1unktDGQiXvUsPZu7ktBIpO3WVzYF691oDZFtFrJzEUfdQlt0k/veBKzNNtnu
         3ABv9kniTIwjOrszaL7N0BEi0vlImktTHXNGW47h+yCjfBQAr3VyQNiPIDNmrEPKKcZB
         T39gAsZvrQ8/vjvKI50BPlPFBeLak0qbUsHcpbT+C4r/ksmTO6H/XP+WD96vXhSBxNef
         +T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169743; x=1740774543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uzX/L490TWQv9IiHeqp3+6gxi+IyDPgpYAyhAfP2Zo=;
        b=HRyCuSfWYjcytp/fgY2BB4QNOpjSAD3vcvn0B4XtPd3v0GNDnUlIY5tJ7kPHVWRl5p
         994Gfp8RXxWOq9WkjN64rihkT0HJRVoz29fWOB8LsnwBc+74AfJugSQOW9294MrHa1l3
         UI7X84OnUcYJvT5aX19HbZyaasbFOOj5I93uKAtBENJSB6K6e/ok5DYSD+Hv4kaUo5Fz
         5uhu9tEg2jGFvdCeMH5Wt1iBYb1Tf3Wmg7TlrrmB2MOtS3Ca5MiqXs0y1i0LVsaSB+92
         uMT4pVI49f0DT9N1YCLPRlRQtYyIz9l0Q/HK1rEn5IXI3f4DCTt1+zoFazpfARjQu8Ma
         ehlA==
X-Gm-Message-State: AOJu0YwVk9iNydmsgvRpeR4uWO6xodGCe3mLxCn/cEW6oE7KB4C5/Mak
	K21Pnby+BOmE5O+a+lGV4KpU3pHut5U4mLddt2nWnbDWIwaWcbbWy9jKEG6544xu9QoNmNwpskm
	242jk1UtVQF8fhWnCAwPoN62QW+gLP6mSqcs=
X-Gm-Gg: ASbGncvCEf6SDejb26HE/p6UkVXtfvyMsGiqFN4EwZ8lzbiCtwBiJxzxMtyqr5IemVD
	5/P7aGZxKLXfOsgfqQN9qtBvwSgnuq9xkah2E4EsJOYuu3M27lduPXo6bE0PDwrtbuvjqVo/pu8
	akEgGvpP3e
X-Google-Smtp-Source: AGHT+IEgsvifuc1gdPRNHwXl2TMBRsumYkzTK0z5iXCBlqy+zKqVIvMQdjH3nIf6o1n6AE8oucYtKW4ghJf65YdAIgU=
X-Received: by 2002:a2e:9bd9:0:b0:30a:2a8a:e4d0 with SMTP id
 38308e7fff4ca-30a599ad6bdmr16541991fa.17.1740169742229; Fri, 21 Feb 2025
 12:29:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220215727.2035833-1-luiz.dentz@gmail.com>
 <CABBYNZK+GhCuRQApr4F81Y3a4a4KzuJ2nNPJ=wN+4EhBOJ1RCw@mail.gmail.com> <a8bc82f46e64e060cc3469f3db97f453f70ec871.camel@iki.fi>
In-Reply-To: <a8bc82f46e64e060cc3469f3db97f453f70ec871.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Feb 2025 15:28:22 -0500
X-Gm-Features: AWEUYZmbctUDKRHZM-YIZxj1Hr-B0Wrgml0yIC9Lewvml_KHn3_TBc4zH-XS6CA
Message-ID: <CABBYNZKit=h2bCbTjkrjks5KxCkhFoKBPRLEZ8aEf8A=3e5u5w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Feb 21, 2025 at 1:51=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2025-02-20 kello 16:59 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Thu, Feb 20, 2025 at 4:57=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This enables buffer flow control for SCO/eSCO
> > > (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable)=
,
> > > recently this has caused the following problem and is actually a nice
> > > addition for the likes of Socket TX complete:
>
> I tested this on Intel AX210 (current firmware) -- it doesn't seem to
> work:
>
> < HCI Command: Write Sync Flow Control Enable (0x03|0x002f) plen 1       =
                           #43 [hci0] 7.611473
>         Flow control: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                           #44 [hci0] 7.612831
>       Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
>         Status: Success (0x00)

Ouch, so it claims the command is supported, return success but then
don't generate the event anyway, hmm sounds broken.

> ...
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #494 [hci0] 21.120883
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #495 [hci0] 21.120883
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #496 [hci0] 21.131190
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #497 [hci0] 21.131272
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #498 [hci0] 21.132282
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #499 [hci0] 21.132287
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #500 [hci0] 21.132288
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #501 [hci0] 21.132288
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #502 [hci0] 21.137072
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #503 [hci0] 21.137144
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #504 [hci0] 21.140898
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #505 [hci0] 21.140903
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #506 [hci0] 21.140903
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #507 [hci0] 21.142969
> wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48          =
                         #508 [hci0] 21.143108
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #509 [hci0] 21.150848
> > SCO Data RX: Handle 257 flags 0x00 dlen 48                             =
                         #510 [hci0] 21.150854
>
> No Number of Completed Packets are generated for SCO Data TX, so it
> gets stuck here and no sound output.
>
> Same situation with Realtek 8761BU.
>
> Maybe that hardware does not seem to be implementing this as required
> in spec, is the reason why flow control for SCO was not enabled?

Yeah, no wonder it wasn't implemented for this long, which is really
too bad since then there is no flow control and no way to do TX
complete either.

> > >
> > > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > > HCI Event: Command Complete (0x0e) plen 11
> > >       Read Buffer Size (0x04|0x0005) ncmd 1
> > >         Status: Success (0x00)
> > >         ACL MTU: 1021 ACL max packet: 5
> > >         SCO MTU: 240  SCO max packet: 8
> > > ...
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > > HCI Event: Hardware Error (0x10) plen 1
> > >         Code: 0x0a
> > >
> > > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  include/net/bluetooth/hci.h      |  6 ++++++
> > >  include/net/bluetooth/hci_core.h |  1 +
> > >  net/bluetooth/hci_core.c         | 15 +++++++++++++++
> > >  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
> > >  4 files changed, 45 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> > > index 0d51970d809f..a6a375cf97f9 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -432,6 +432,7 @@ enum {
> > >         HCI_WIDEBAND_SPEECH_ENABLED,
> > >         HCI_EVENT_FILTER_CONFIGURED,
> > >         HCI_PA_SYNC,
> > > +       HCI_SCO_FLOWCTL,
> > >
> > >         HCI_DUT_MODE,
> > >         HCI_VENDOR_DIAG,
> > > @@ -1528,6 +1529,11 @@ struct hci_rp_read_tx_power {
> > >         __s8     tx_power;
> > >  } __packed;
> > >
> > > +#define HCI_OP_WRITE_SYNC_FLOWCTL      0x0c2f
> > > +struct hci_cp_write_sync_flowctl {
> > > +       __u8     enable;
> > > +} __packed;
> > > +
> > >  #define HCI_OP_READ_PAGE_SCAN_TYPE     0x0c46
> > >  struct hci_rp_read_page_scan_type {
> > >         __u8     status;
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index f756fac95488..6abe1115fa92 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> > >  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD=
)
> > >  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIF=
F)
> > >  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK=
)
> > > +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
> > >  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI=
_INQ)
> > >  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO=
)
> > >  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO=
_BREDR))
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index e7ec12437c8b..a0a14fb8a496 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -3564,11 +3564,19 @@ static void hci_sched_sco(struct hci_dev *hde=
v)
> > >                         BT_DBG("skb %p len %d", skb, skb->len);
> > >                         hci_send_frame(hdev, skb);
> > >
> > > +
> > > +                       hdev->sco_cnt--;
> > >                         conn->sent++;
> > >                         if (conn->sent =3D=3D ~0)
> > >                                 conn->sent =3D 0;
> > >                 }
> > >         }
> > > +
> > > +       /* Restore sco_cnt if flow control has not been enabled as
> > > +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> > > +        */
> > > +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
>
> I think this check is inverted.

Yeah, I will fix it.

> > > +               hdev->sco_cnt =3D hdev->sco_pkts;
>
> If there are unsent SCO skbs in the queue, I think they are not
> guaranteed to be sent here.
>
> hdev->tx_work would need to be queued for this to run again. With
> FLOWCTL this is guaranteed by hci_num_comp_pkts_evt(), but without it's
> not.
>
> Maybe without flowctl this should use the old behavior, like:
>
>         if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
>                 hdev->sco_cnt =3D hdev->sco_pkts;

I left at the end we don't try to send more than sco_cnt in a row, but
you are probably right that if there are still packets enqueued
without the hci_num_comp_pkts_evt to submit the tx_work won't resume
so we might need to trigger it tx_work to resume in that case.

>         while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, ESCO_LINK,
>         ...
>                         if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
>                                 hdev->sco_cnt--;
>
> > >  }
> > >
> > >  static void hci_sched_esco(struct hci_dev *hdev)
> > > @@ -3588,11 +3596,18 @@ static void hci_sched_esco(struct hci_dev *hd=
ev)
> > >                         BT_DBG("skb %p len %d", skb, skb->len);
> > >                         hci_send_frame(hdev, skb);
> > >
> > > +                       hdev->sco_cnt--;
> > >                         conn->sent++;
> > >                         if (conn->sent =3D=3D ~0)
> > >                                 conn->sent =3D 0;
> > >                 }
> > >         }
> > > +
> > > +       /* Restore sco_cnt if flow control has not been enabled as
> > > +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> > > +        */
> > > +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > > +               hdev->sco_cnt =3D hdev->sco_pkts;
> > >  }
> > >
> > >  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index dd770ef5ec36..42ee9c5e11ad 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -3766,6 +3766,27 @@ static int hci_write_ca_timeout_sync(struct hc=
i_dev *hdev)
> > >                                      sizeof(param), &param, HCI_CMD_T=
IMEOUT);
> > >  }
> > >
> > > +/* Enable SCO flow control if supported */
> > > +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> > > +{
> > > +       struct hci_cp_write_sync_flowctl cp;
> > > +       int err;
> > > +
> > > +       /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC=
_FLOWCTL */
> > > +       if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> > > +               return 0;
> > > +
> > > +       memset(&cp, 0, sizeof(cp));
> > > +       cp.enable =3D 0x01;
> > > +
> > > +       err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL=
,
> > > +                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT)=
;
> > > +       if (!err)
> > > +               hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> > > +
> > > +       return err;
> > > +}
> > > +
> > >  /* BR Controller init stage 2 command sequence */
> > >  static const struct hci_init_stage br_init2[] =3D {
> > >         /* HCI_OP_READ_BUFFER_SIZE */
> > > @@ -3784,6 +3805,8 @@ static const struct hci_init_stage br_init2[] =
=3D {
> > >         HCI_INIT(hci_clear_event_filter_sync),
> > >         /* HCI_OP_WRITE_CA_TIMEOUT */
> > >         HCI_INIT(hci_write_ca_timeout_sync),
> > > +       /* HCI_OP_WRITE_SYNC_FLOWCTL */
> > > +       HCI_INIT(hci_write_sync_flowctl_sync),
> > >         {}
> > >  };
> > >
> > > --
> > > 2.48.1
> > >
> >
> > Let me know if this addresses your concerns, I figure this was why we
> > could not track packet completion of SCO/eSCO so I guess it is a plus
> > if we can finally enable it across all sockets.
> >
>


--=20
Luiz Augusto von Dentz
