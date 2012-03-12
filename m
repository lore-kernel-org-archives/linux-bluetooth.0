Return-Path: <cyrus@holtmann.org>
Message-ID: <1331573506.14217.79.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix broken usage of put_unaligned_le16
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:31:46 -0700
In-Reply-To: <CAJdJm_PVtxF3qQY0+UWFr-6cXQFxXwXt4Qt4K6hZ5-FBNJ=0bw@mail.gmail.com>
References: <1331520186-30184-1-git-send-email-marcel@holtmann.org>
	 <CAJdJm_PVtxF3qQY0+UWFr-6cXQFxXwXt4Qt4K6hZ5-FBNJ=0bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > @@ -275,7 +275,7 @@ static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
> >        BT_DBG("sock %p", sk);
> >
> >        rp.version = MGMT_VERSION;
> > -       put_unaligned_le16(MGMT_REVISION, &rp.revision);
> > +       rp.revision = __constant_cpu_to_le16(MGMT_VERSION);
> 
> Looks like a typo here: MGMT_VERSION -> MGMT_REVISION

yep, that is a stupid typo :(

Regards

Marcel


