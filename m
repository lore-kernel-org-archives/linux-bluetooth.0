Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 19:58:46 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management
 interface callbacks
Message-ID: <20101124215846.GD2592@vigoh>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
 <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
 <AANLkTik0x3tjnM85Mu=vwU6GB2pXAgWXnqe28aKS+QkN@mail.gmail.com>
 <20101124214747.GA8626@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20101124214747.GA8626@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Johan Hedberg <johan.hedberg@gmail.com> [2010-11-24 23:47:47 +0200]:

> Hi Andrei,
> 
> On Wed, Nov 24, 2010, Andrei Emeltchenko wrote:
> > > -       if (haddr->hci_dev != HCI_DEV_NONE) {
> > > -               if (!(hdev = hci_dev_get(haddr->hci_dev))) {
> > > +       if (haddr.hci_dev != HCI_DEV_NONE) {
> > > +               if (!(hdev = hci_dev_get(haddr.hci_dev))) {
> > 
> > doesn't checkpatch give errors here?
> 
> Probably, but I've understood that it's ok if it's the existing code
> that contains the coding style issue.
> 
> > Would be more clean like:
> > ...
> > hdev = hci_dev_get(haddr.hci_dev);
> > if (!hdev)
> > ...
> > 
> > At some point shall be fixed in the old code also
> 
> Agreed. A separate code cleanup patch would be nice. I've intentionally
> kept the old style to not mix coding style and functional changes into
> the same patch and to make it clear that I'm not introducing any changes
> to the code logic at this place.

Yes, that should be a separated patch.

Johan, your patches are fine, but I have to wait the wireless-next-2.6
be synced with the net-next-2.6 tree. Then I'll able to apply it.

-- 
Gustavo F. Padovan
http://profusion.mobi
