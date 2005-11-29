Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200511291146.42749.Loial@home.nl>
References: <200511262023.23140.Loial@home.nl>
	 <200511291038.22058.Loial@home.nl> <1133259183.12447.4.camel@blade>
	 <200511291146.42749.Loial@home.nl>
Content-Type: text/plain
Message-Id: <1133271543.5769.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Nov 2005 14:39:03 +0100

Hi Rutger,

> > > I already saw you were using report ID 16 and 17, so I will try that too.
> >
> > You need to send and receive reports with ID 16 and 17. Both have fixed
> > length and 16 was for the short messages and 17 for the long messages if
> > I remember that correctly. They are the same we used for switching the
> > dongle from HID into HCI mode.
> >
> > The problem is to get these reports to the device. The HIDP kernel
> > module with the report protocol (see -mh patch) lacks hiddev support.
> 
> Is there a specific reason for the lack of hiddev support?

basically its because of lack of time and my report protocol patch is
still considered a hack by me.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
