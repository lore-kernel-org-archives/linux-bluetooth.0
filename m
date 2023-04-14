Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BCC77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNUNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNUNQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:13:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD786581
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:13:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a76b2a36e2so237561fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681503193; x=1684095193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKwHqAgVHy/0tduAZM9uGm5T+u/56JLY5nnUj/n+Ys4=;
        b=LFUEnbL8oGDbFu7kIzX4DNZ8r2DS6lyPaEzl4KEd3KS8AlXjbVQiPG3FQvKekVRkQ1
         vsGX962Cvc8et1jglCT2o70gIlap5yjFZZ7BWod4eK6F3fWuFJF+ZSsXJU19dDrDeMOL
         zDrpi3YVg8LnWNK0m+J8+jZYOPvEhlTaEDNPeiwMN912nYtEbqP+iZjNyz/2NDL3QRqx
         95bxH5k33nsKkKzL3Z1MBHtYqTl9RaaD4wx6AoP311vEsifAAuiKy2LBd9Elfdaf6GNn
         5F5NWtIFRmbjFSZXg62Gic7jgL9u47SvLCS5k6TZFqvEMUL2ZJLP/mVHTUtZrNWVgs3n
         u/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503193; x=1684095193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKwHqAgVHy/0tduAZM9uGm5T+u/56JLY5nnUj/n+Ys4=;
        b=PEpinUHAWrwn/+PNRG2+yB8Jqm/poBn+EzhhnkRiFupS4jAYMiJZvqLCEbZR7RVmO0
         ogjpXFhKIcpQg3rHApCxsho5OBnhLoSd3f0OdiXOTF3zRL7ZLenbHd5LX6WBtUGvT8h/
         LyNZkKIIyhe8HSaENq7iLrfOMWI8fqnT3lmgLSwCJT2DVGTpdpboFwt8MNAXm67JvMj+
         VeOG0FEbfq/UW8auMfqrcf1pZUfz4/iuQdjFb8UfD8cJL7faRFoqCf4/RtW1td1/mVV9
         qeYZ5MxKvt06x2/k1+IKhSjYxU+AUfqJwWmfQwQvlS1Ec7tFGuRteWSmxtlDV/Vzj9fL
         y/rA==
X-Gm-Message-State: AAQBX9dQ5LF8F3G6iHy0qttoqdQ3hLDBXNKg+aVThGGBl8URew70+lER
        Jv27ZJ9bcmuwb1owydhywpTbwhxPgPK0+6AIx9mA1Hm2
X-Google-Smtp-Source: AKy350YW1ioVBV5UV6wJDBrq/Tcw5h2kXEPwDc6iJ8MJxwSzFuW+XIB6ZYdgqeXmjd9T32IAq+StQadrrjF3VWHoY6I=
X-Received: by 2002:a19:c50f:0:b0:4ec:8e50:5032 with SMTP id
 w15-20020a19c50f000000b004ec8e505032mr27326lfe.13.1681503192842; Fri, 14 Apr
 2023 13:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230413183113.896669-1-luiz.dentz@gmail.com> <20230413183113.896669-2-luiz.dentz@gmail.com>
 <1ae133312ec9d702ebf18cbf3a2b106e8c27acd4.camel@iki.fi>
In-Reply-To: <1ae133312ec9d702ebf18cbf3a2b106e8c27acd4.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Apr 2023 13:13:00 -0700
Message-ID: <CABBYNZ+eDB7ajTM2ktkwSrQB-8RWrhixkChW9DKfV3aazX-RSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Apr 14, 2023 at 12:53=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-04-13 kello 11:31 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes only matching CIS by address which prevents creating new hco=
n
> > if upper layer is requesting a specific CIS ID.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h | 7 ++++++-
> >  net/bluetooth/hci_conn.c         | 2 +-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 4fe1e71cb9d8..6f5e8594ff2d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1180,7 +1180,8 @@ static inline struct hci_conn *hci_conn_hash_look=
up_le(struct hci_dev *hdev,
> >
> >  static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev=
 *hdev,
> >                                                       bdaddr_t *ba,
> > -                                                     __u8 ba_type)
> > +                                                     __u8 ba_type,
> > +                                                     __u8 id)
> >  {
> >       struct hci_conn_hash *h =3D &hdev->conn_hash;
> >       struct hci_conn  *c;
> > @@ -1191,6 +1192,10 @@ static inline struct hci_conn *hci_conn_hash_loo=
kup_cis(struct hci_dev *hdev,
> >               if (c->type !=3D ISO_LINK)
> >                       continue;
> >
> > +             /* Match CIS ID if set */
> > +             if (id !=3D BT_ISO_QOS_CIS_UNSET && id !=3D c->iso_qos.uc=
ast.cis)
> > +                     continue;
> > +
>
> Should this also check the CIG ID?
>
> Core v5.3 4.E Sec. 5.3: "The CIS_ID has a separate number space for
> each CIG_ID.", and I didn't manage to find restriction that you
> couldn't have the same peripheral in multiple CIG.

That is a good point, it seems the BAP Audio Configurations are
limited to just one CIG but in theory there could be multiple if they
don't need to be synchronized, I will fix that to check both CIG and
CIS.

> >               if (ba_type =3D=3D c->dst_type && !bacmp(&c->dst, ba)) {
> >                       rcu_read_unlock();
> >                       return c;
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 204164ee5f9a..b9ecfc782be9 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1842,7 +1842,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hde=
v, bdaddr_t *dst,
> >  {
> >       struct hci_conn *cis;
> >
> > -     cis =3D hci_conn_hash_lookup_cis(hdev, dst, dst_type);
> > +     cis =3D hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.=
cis);
> >       if (!cis) {
> >               cis =3D hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER=
);
> >               if (!cis)
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
