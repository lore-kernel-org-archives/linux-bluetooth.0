Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: Device Scan and connection collision fix
Date: Wed, 18 Jul 2012 07:18:14 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4AF11C@DNCE05.ent.ti.com>
References: <1342542094-13486-1-git-send-email-ramm@ti.com>
 <20120718071148.GC18697@aemeltch-MOBL1>
 <20120718071338.GD18697@aemeltch-MOBL1>
In-Reply-To: <20120718071338.GD18697@aemeltch-MOBL1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Andrei,

> -----Original Message-----
> From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com]
> Sent: Wednesday, July 18, 2012 10:14 AM
> To: Malovany, Ram; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v3] Bluetooth: Device Scan and connection collision fix
> 
> On Wed, Jul 18, 2012 at 10:11:50AM +0300, Andrei Emeltchenko wrote:
> > Hi Ram,
> >
> > On Tue, Jul 17, 2012 at 07:21:34PM +0300, ramm@ti.com wrote:
> > > From: Ram Malovany <ramm@ti.com>
> > >
> > > During search of devices, HCI Remote Name Request Command is sent for
> > > every device which name was not included in inquiry result. But the
> > > same command is also sent during incoming connection establishing
> > > procedure. Function hci_check_pending_name() was fixed in order to
> > > handle this situation which led to a kernel crash when initiating
> > > an incoming connection from a device that was not found in the
> > > inquiry while doing a search. There is no need to continue resolving
> > > the next name if we get the request from the incoming connection
> > > procedure as it will be done upon receiving another remote name
> > > request complete event
> 
> You can also change subject
> from:
> [PATCH v3] Bluetooth: Device Scan and connection collision fix
> to:
> [PATCH v3] Bluetooth: Fix Device Scan and connection collision
> 
> Best regards
> Andrei Emeltchenko

Thanks , will send a new update.

Regards,

Ram

