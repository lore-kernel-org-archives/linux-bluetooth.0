Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2014 18:11:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for
 virtual HCI driver"
Message-ID: <20140305161123.GA31928@localhost.P-661HNU-F1>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
 <CA+5PVA5JuMLLG82YB8Z2FrOz3a0JrbeGzjamGYh1Qt89LtBEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+5PVA5JuMLLG82YB8Z2FrOz3a0JrbeGzjamGYh1Qt89LtBEfA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 05, 2014, Josh Boyer wrote:
> On Wed, Mar 5, 2014 at 6:59 AM, Thomas Bächler <thomas@archlinux.org> wrote:
> > Adding the devname:vhci alias and thus adding a static /dev/vhci device node
> > only works when assigning a fixed major/minor number. However, the code
> > currently uses a dynamically assigned minor number. It is therefore impossible
> > to create a static device and to autoload the module when accessing it.
> >
> > Reverting this fixes the kmod error message
> >  depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and minor information. Ignoring.
> >
> > This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.
> 
> We've had several reports of this in Fedora as well.  I hadn't gotten
> around to digging into it yet, so thanks for bringing this up Thomas.

How does this relate to the "Bluetooth: allocate static minor for vhci"
patch that we have in the bluetooth-next tree (also in wireless-next,
going to the 3.15 kernel). It's commit b075dd40c95d11c2c8690f6c4d6232fc.

Johan
