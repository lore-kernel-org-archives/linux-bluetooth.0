Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for virtual HCI driver"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+5PVA56oO6FS2pG+D7yJtNrTqBGZ1CtPygjid4E0f3cPPi83g@mail.gmail.com>
Date: Wed, 5 Mar 2014 10:36:59 -0800
Cc: =?iso-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Message-Id: <424A74F3-7646-449C-9F72-A0F4E9A28551@holtmann.org>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org> <7E804DF3-E191-427E-8E20-FE6ECDC490EA@holtmann.org> <CA+5PVA56oO6FS2pG+D7yJtNrTqBGZ1CtPygjid4E0f3cPPi83g@mail.gmail.com>
To: Josh Boyer <jwboyer@fedoraproject.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

>>> Adding the devname:vhci alias and thus adding a static /dev/vhci device node
>>> only works when assigning a fixed major/minor number. However, the code
>>> currently uses a dynamically assigned minor number. It is therefore impossible
>>> to create a static device and to autoload the module when accessing it.
>>> 
>>> Reverting this fixes the kmod error message
>>> depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and minor information. Ignoring.
>>> 
>>> This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.
>> 
>> NAK. We allocated a static minor for this.
> 
> Johan mentioned that.  Commit b075dd40c95d11c2c8690f6c4d6232fc,
> correct?  Why isn't that headed into 3.14 right now, and CC'd to
> stable?  Currently you have a somewhat broken driver in 3.13 and
> 3.14-rcX that seems to have a pretty clear fix.

somewhat broken? kmod prints this as an error, but it is not a regression in user functionality. The driver works just as before. The error message can be ignored.

So if anybody feels strongly that the static device node assignment should be put into -stable, then I am fine with it. However I do not see this as passing requirement for a -stable fix since it is really not affecting anyone (minus the misleading message from kmod).

Regards

Marcel

