Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100923162521.GA15641@null>
References: <1281442367.12579.206.camel@localhost.localdomain>
	<1281990059-3562-1-git-send-email-alan@signal11.us>
	<20100923162521.GA15641@null>
Date: Thu, 23 Sep 2010 10:07:07 -0700
Message-ID: <AANLkTinJXYbZh_MvG81iJMu84LKBOKL3s-Gbfe77Vq7q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Get and Set Feature Reports on HIDRAW (USB and Bluetooth)
From: Ping Cheng <pinglinux@gmail.com>
To: Ville Tervo <ville.tervo@nokia.com>, =?ISO-8859-2?Q?Przemys=B3aw_Firszt?= <przemo@firszt.eu>
Cc: ext Alan Ott <alan@signal11.us>, Jiri Kosina <jkosina@suse.cz>,
	Stefan Achatz <erazor_de@users.sourceforge.net>, Antonio Ospite <ospite@studenti.unina.it>,
	Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>,
	Marcel Holtmann <marcel@holtmann.org>, Stephane Chatty <chatty@enac.fr>,
	Michael Poole <mdpoole@troilus.org>, "David S. Miller" <davem@davemloft.net>,
	Bastien Nocera <hadess@hadess.net>, Eric Dumazet <eric.dumazet@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 23, 2010 at 9:25 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Alan,
>
> On Mon, Aug 16, 2010 at 10:20:57PM +0200, ext Alan Ott wrote:
>> This is version 4. Built against 2.6.35+ revision 320b2b8de12698 .
>
> I gave a try to to this patch using your test tool [1] and very old BT
> keyboard. I don't have anything else ATM to test with. Is there some BT hid
> devices which support setting and getting features?

As far as I know Wacom BT devices (Graphire and Intuos4) need to get
and set features.

Przemo,

Do you have time to test the patchset with your Graphire BT and
provide your result here?

Thank you,

Ping
