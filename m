Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031029092401.GA10447@smartdata.ch>
References: <20031028232335.GA6411@smartdata.ch>
	<1067386611.24043.201.camel@pegasus>  <20031029092401.GA10447@smartdata.ch>
Content-Type: text/plain
Message-Id: <1067428568.24042.246.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: diNovo LT information
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 29 Oct 2003 12:56:02 +0100

Hi Olivier,

> > I am working on the design document of the HID parser userspace to
> > kernel interface. My userspace bthid daemon is almost ready for daily
> > use, but the modification of the USB HID parser will take some time. I
> > am thinking of copying the needed HID stuff into an extra module.
> 
> I'm impatient to try this new userspace bthid daemon. :-)

but without the kernel side HID parser modification it is useless :(

> > Is there any chance that you can tell Logitech to send some demo or beta
> > devices to me for testing with Linux. I like to play with the devices to
> > see how they have done some things.
> 
> I'm looking this point now. I hope answer soon. Stay tuned... :-)

This would be great. Thanks.

> > > > If you have some extra time, please compile the new libs2 from CVS and
> > > > run "sdptest records ..." and/or "sdptest browse ..." for me.
> 
> FYI: ltmain.sh is missing in the libs2 CVS. I have copyed the one from
> libs at this time.

You have to run bootstrap first and all needed files will be created.

> Results of sdptest records are attached. (browse is only a sub-set of
> the records, so I don't attach them).

This is what I expected, because the records command will also find the
hidden PNP record that is also present in the Microsoft devices. The HID
descriptors of the diNovo are now online available on my site.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
