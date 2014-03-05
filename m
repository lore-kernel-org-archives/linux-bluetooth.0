Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <7E804DF3-E191-427E-8E20-FE6ECDC490EA@holtmann.org>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
	<7E804DF3-E191-427E-8E20-FE6ECDC490EA@holtmann.org>
Date: Wed, 5 Mar 2014 12:50:28 -0500
Message-ID: <CA+5PVA56oO6FS2pG+D7yJtNrTqBGZ1CtPygjid4E0f3cPPi83g@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for
 virtual HCI driver"
From: Josh Boyer <jwboyer@fedoraproject.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 5, 2014 at 11:46 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Thomas,
>
>> Adding the devname:vhci alias and thus adding a static /dev/vhci device node
>> only works when assigning a fixed major/minor number. However, the code
>> currently uses a dynamically assigned minor number. It is therefore impossible
>> to create a static device and to autoload the module when accessing it.
>>
>> Reverting this fixes the kmod error message
>> depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and minor information. Ignoring.
>>
>> This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.
>
> NAK. We allocated a static minor for this.

Johan mentioned that.  Commit b075dd40c95d11c2c8690f6c4d6232fc,
correct?  Why isn't that headed into 3.14 right now, and CC'd to
stable?  Currently you have a somewhat broken driver in 3.13 and
3.14-rcX that seems to have a pretty clear fix.

josh
