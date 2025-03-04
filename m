Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE81FC7FF
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113363; cv=none; b=QXRUfenIXlR6+Bqg2R3PxSo72pRqgAaIewENK4X2FHibFkUcFzj85pqt2xmHITfof7I0CkD914MuJvARMpIQgE8NqqZDHJ2WGcA6GpAi2wnMbgVwcWU+AMFtRWCYFIx/8ipu9R1FcXHCS1ML8FrqomPQf31Vw9dNZL9WR+w5tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113363; c=relaxed/simple;
	bh=ImPClyzLHhIHBPbEeM/hO0Dm9J8VexGwEjva85N2fag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yn0x7f0s7CDbGwbeaHePUuUVQnVc/fUlfQzH9UZ1PI6OAg/i/5wiYowazvtZG0nMgGdpN8IXg/thzxtM2weMh3AcX0MzEwOGoaw5JxTeSYZ2JKoivHtUd2fYKBJvtaKm4uoGo5Nr3OBIfLuN2ivAD0YFpgsNEM0b7zVuNpKduig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdUr+lCp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdUr+lCp"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fcfso64861971fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113359; x=1741718159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecrUYiJ0RKTmljIzIUROjLLza/1DoIv4MdUFHQ11Vvg=;
        b=IdUr+lCpCL+2AqnrD69of/noFsYAAxTVg/VmD4qCsFR8TKUcgZUPYfUmoLVMgYEGKk
         q3S3bLJjB8rS3eyi4yLSuKNcB8QFMmHHK9+OnMbTQLDfBT012XDeUR1E9T9BORXco+6+
         gAo1FmQG0YVS59iV4qozWWOK2zfPcy8hHSpCBv/vCQAU6EguMsYL7gO/+A5JywcFBoNa
         R/vdSFUk0a5o225GEm61aNpTJrDTkxrPgWRJFMIoSEBxWivxwjgCCysz62N5fNX/GuK4
         9VYPlduFZJBUQq/LO4+xxTVn7zzMp5uyrXOLocZ4YRBD9+UmZUpaO7CA/rVKe5GSdIDX
         Ok7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113359; x=1741718159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecrUYiJ0RKTmljIzIUROjLLza/1DoIv4MdUFHQ11Vvg=;
        b=nctQ0XxJrHc6gnyB9Dh7wxeHFUV9XAwW+A4+OWQJzAvGXbH3BnQsz/bvyjnMjfstk0
         Taz84M0SZZIl2Y9ZOztsgdmmgH339Xb7RVRA43HEIl8+TApEDaHYEqwqT9q8qTIXaSFv
         vz067jr+8WGW47T4oM1qvax8LM+Hx6uuisOynLZ3v8tj7RpO0jlTHzPck8lHnkQZ/nkQ
         h5ihx1y9MbWYULg8Yg80ZnOZvjVXJfofyYv/oz6q2YvoZd58oeZkMBS7zLZbWuypSeyG
         /jeLaRnxw9gqrWAvouSNEBp5aV3KbbpX6SVsiLtyP//rkGq4VhxltLj6+zPThaSJu3oE
         8KMQ==
X-Gm-Message-State: AOJu0Yz3pbHgqPN+OMOTrgY39vDF7LA5UGVPkpfjS+SjK8FGB7OESe9+
	mZfXTicrn3MU/8LNmVS1yg1fiDWY3TP609u6xifFwl0vkSujwgjzq0mMI14eMSed9OSlDvF8R4v
	7/MyaVnErME2accR/ygVW0D+DX+mbI1zy
X-Gm-Gg: ASbGncvXILHfdLNMCfGs8CAwaYjuuvvzOgwzcNX7j9mrdh2f+whV+FbA+ZUBpLcRyX7
	XlvrfHeRExDqYGvVy16gr+jiafabIYqYofTltG3Rrl9GMx4nq77w1ZC2mwAOEVHU7fDufue6Vzd
	RVjWDfB1NWD4OavcHiNkb21jiU
X-Google-Smtp-Source: AGHT+IET4T2s5EZ7+6GURn1EPR1apvSwTV6rLdwG0rpYfOLVOEDtD8jP4mqR3p+UmWOpj5ZO5jNlbTuxxUY7FNhJtKY=
X-Received: by 2002:a05:651c:2224:b0:309:2283:bea8 with SMTP id
 38308e7fff4ca-30bd7af891fmr810401fa.34.1741113359186; Tue, 04 Mar 2025
 10:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304162955.149884-1-luiz.dentz@gmail.com> <ccded4b8858f3455c832229fd26f63795f5a3030.camel@iki.fi>
In-Reply-To: <ccded4b8858f3455c832229fd26f63795f5a3030.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Mar 2025 13:35:47 -0500
X-Gm-Features: AQ5f1Jql-RX3DKPexJZFMiYyukQWQVZajnKexrAgOr0AeeyUNOAPriKUi8CJo_8
Message-ID: <CABBYNZJ-Z8u2m=+_khFCb9HH-U93=AVoSfJbeWYStE42zHcyag@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Mar 4, 2025 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2025-03-04 kello 11:29 -0500, Luiz Augusto von Dentz kirjoitti:
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
> > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      |  6 ++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 28 ++++++++++++++++++++++++++++
> >  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
> >  4 files changed, 58 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index b99818df8ee7..70169533c940 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -448,6 +448,7 @@ enum {
> >       HCI_WIDEBAND_SPEECH_ENABLED,
> >       HCI_EVENT_FILTER_CONFIGURED,
> >       HCI_PA_SYNC,
> > +     HCI_SCO_FLOWCTL,
> >
> >       HCI_DUT_MODE,
> >       HCI_VENDOR_DIAG,
> > @@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
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
> > index 2f320eeddfec..cf18cf65fe5e 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
> > index e7ec12437c8b..63eec8b80ff1 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3564,11 +3564,25 @@ static void hci_sched_sco(struct hci_dev *hdev)
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> >
> > +                     hdev->sco_cnt--;
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
> >               }
> >       }
> > +
> > +     /* Restore sco_cnt if flow control has not been enabled as
> > +      * HCI_EV_NUM_COMP_PKTS won't be generated.
> > +      */
> > +     if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> > +             hdev->sco_cnt =3D hdev->sco_pkts;
> > +
> > +             /* As flow control is disabled force tx_work to run if th=
ere are
> > +              * still packets left in the queue.
> > +              */
> > +             if (conn && !skb_queue_empty(&conn->data_q))
>
> conn may be uninitialized pointer here (if sco_cnt =3D=3D 0 when entering
> function).
>
> I think this should be doing something like
>
>         if (hci_low_sent(hdev, SCO_LINK, &quote))
>                 ...
>
> otherwise some other conn than that last seen in the loop may still
> have data to send.

There is a v5 which reworks most of the code that you had just
commented since it implements the idea of only enabling
HCI_SCO_FLOWCTL if we observe NOCP is generated:

https://patchwork.kernel.org/project/bluetooth/patch/20250304181019.214207-=
1-luiz.dentz@gmail.com/

> > +                     queue_work(hdev->workqueue, &hdev->tx_work);
> >
> > +     }
> >  }
> >
> >  static void hci_sched_esco(struct hci_dev *hdev)
> > @@ -3588,11 +3602,25 @@ static void hci_sched_esco(struct hci_dev *hdev=
)
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> >
> > +                     hdev->sco_cnt--;
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
> >               }
> >       }
> > +
> > +     /* Restore sco_cnt if flow control has not been enabled as
> > +      * HCI_EV_NUM_COMP_PKTS won't be generated.
> > +      */
> > +     if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> > +             hdev->sco_cnt =3D hdev->sco_pkts;
> > +
> > +             /* As flow control is disabled force tx_work to run if th=
ere are
> > +              * still packets left in the queue.
> > +              */
> > +             if (!skb_queue_empty(&conn->data_q))
>
> Same here.
>
> > +                     queue_work(hdev->workqueue, &hdev->tx_work);
> > +     }
> >  }
> >
> >  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c4c2cf51b219..aaa6164fc3e3 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3769,6 +3769,27 @@ static int hci_write_ca_timeout_sync(struct hci_=
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
> > +     if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
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
> > @@ -3787,6 +3808,8 @@ static const struct hci_init_stage br_init2[] =3D=
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
