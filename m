Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051207125556.GA13152@localhost.localdomain>
References: <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
	 <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
	 <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
	 <1132949177.10237.5.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
	 <1133471112.18554.8.camel@blade>
	 <3013cac80512070429g5fb992b7i7131d570f9023086@mail.gmail.com>
	 <20051207125556.GA13152@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1133960579.3752.17.camel@blade>
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
Date: Wed, 07 Dec 2005 14:02:59 +0100

Hi Johan,

> Your patch looks ok, except that you seem to append the arguments in
> the wrong order to the "name" property changed signal:
> 
> On Wed, Dec 07, 2005, Eduardo Rocha wrote:
> >  	dbus_message_append_args(message,
> >  				DBUS_TYPE_STRING, &pname,
> > +				DBUS_TYPE_STRING, &pprop_name,

and some coding style issues :(

> Btw, maybe we should have a common function for sending property changed
> signals, e.g:
> send_property_changed(const char *prop_name, int prop_type, void *value);

Sounds like a good idea to me. Please integrate this and if needed split
the patch into two separate patches.

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
