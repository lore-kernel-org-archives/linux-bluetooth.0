Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075565699.14644.186.camel@akka.yeti.nocrew.org>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
	 <1075355567.26729.65.camel@pegasus>
	 <1075405154.22564.64.camel@akka.yeti.nocrew.org>
	 <1075406315.22564.67.camel@akka.yeti.nocrew.org>
	 <1075563018.2720.19.camel@pegasus>
	 <1075564164.14644.167.camel@akka.yeti.nocrew.org>
	 <1075564788.2720.49.camel@pegasus>
	 <1075565699.14644.186.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075572554.2720.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 31 Jan 2004 19:09:14 +0100

Hi Fredrik,

> The "char *ref" comment in hcid.h? I understand the kernel people you
> referred to before use this type of comment as well. :)

no, this comment is correct.

> The other three comments do not refer to the if:s but the code inside
> each if. So I don't think these are misplaced either.

	/* First try to get BD_ADDR based settings ... */
	di.dev_id = hdev;
	if (!ioctl(sock, HCIGETDEVINFO, (void *) &di))
		device_opts = get_bdaddr_device_opts(&di.bdaddr);

	/* ... then try HCI based settings ... */
	if (!device_opts)
		device_opts = get_hci_device_opts(hdev);

	/* ... and last use the default settings. */
	if (!device_opts)               
		device_opts = &default_device;

Make it look like this. It is much more easier to read :)

> More places? That's the only comments I know of...

Not comments. Whitespaces and braces.

> > And of course in this case inlining the function is a good idea.
> 
> Why is that?

Short code that only init a structure can be inlined.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
