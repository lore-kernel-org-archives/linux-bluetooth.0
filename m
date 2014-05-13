Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 May 2014 22:35:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] Bluetooth: Add support to get connection
 information
Message-ID: <20140513193503.GA25306@t440s.P-661HNU-F1>
References: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399974751-7226-3-git-send-email-andrzej.kaczmarek@tieto.com>
 <2978AA04-546F-4BE3-868E-DD03F243BEE9@holtmann.org>
 <CAF3PWx1GfvfPm5TN9OuDi9jPCWNtjsELyRR-eG3rmDHi6sHPRQ@mail.gmail.com>
 <52A402F5-1159-4BE3-9F2A-8B5713E52B52@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A402F5-1159-4BE3-9F2A-8B5713E52B52@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, May 13, 2014, Marcel Holtmann wrote:
> >>> +static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
> >>> +                      u16 len)
> >>> +{
> >>> +     struct mgmt_cp_get_conn_info *cp = data;
> >>> +     struct mgmt_rp_get_conn_info rp;
> >>> +     struct hci_conn *conn;
> >>> +     unsigned long conn_info_age;
> >>> +     int err = 0;
> >>> +
> >>> +     BT_DBG("%s", hdev->name);
> >>> +
> >>> +     memset(&rp, 0, sizeof(rp));
> >>> +     bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
> >>> +     rp.addr.type = cp->addr.type;
> >> 
> >> Do we really want to just keep zeroed out values and not set the
> >> values to invalid. What are we doing for other commands that
> >> require the same return parameters set to match up with the remote
> >> address.
> > 
> > Actually there's no other command which returns address *and* some
> > parameters so this will be first one. So in case of failure should we
> > put proper 'invalid' values into response parameter and not just
> > leaving them set to zero? There is always error code which means
> > request failed and returned parameters are invalid anyway. And in case
> > of success response we overwrite zeroes with proper values of course.
> 
> good question. Johan, what do you think?

I'm fine with the "zeroes in case of failure" approach. It's also
consistent with the "sender sets to zero and receiver ignores" approach
that's present in various protocol specs for reserved or invalid parts
of PDUs. That said, I'm not sure if there is a simple example to be
taken for reference from the HCI spec.

Johan
