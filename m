Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 17:03:26 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] bluetooth: Take a runtime pm reference on hid
	connections
Message-ID: <20101019160326.GC25861@srcf.ucam.org>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com> <1286962345.3316.1.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286962345.3316.1.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 13, 2010 at 12:32:25PM +0300, Marcel Holtmann wrote:
> Hi Matthew,
> 
> > Bluetooth runtime PM interacts badly with input devices - the connection
> > will be dropped if the device becomes idle, resulting in noticable lag when
> > the user interacts with the input device again. Bump the pm runtime count
> > when the device is associated and release it when it's disassociated in
> > order to avoid this.
> 
> we already have hci_conn_hold_device() and hci_conn_put_device() calls
> for HID to hold reference of the ACL connection. Why do we need more?

Because doing so doesn't do anything to influence runtime PM behaviour. 
Putting the calls in these functions might be reasonable though - would 
you prefer that?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
