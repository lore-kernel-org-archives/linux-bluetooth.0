Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80512130927k1d83978ey33be0540e15a08ba@mail.gmail.com>
References: <1132872886.3170.3.camel@blade> <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
	 <1132949177.10237.5.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
	 <1133471112.18554.8.camel@blade>
	 <3013cac80512070429g5fb992b7i7131d570f9023086@mail.gmail.com>
	 <20051207125556.GA13152@localhost.localdomain>
	 <1133960579.3752.17.camel@blade>
	 <3013cac80512070801o5b60cc20y7098dc36f2326458@mail.gmail.com>
	 <3013cac80512130927k1d83978ey33be0540e15a08ba@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134511385.24447.15.camel@blade>
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
Date: Tue, 13 Dec 2005 23:03:05 +0100

Hi Eduardo,

> here is the patch with the send_property_changed_signal function included.

nice, but please follow the coding style. I don't wanna correct the
whitespaces in all patches. Some examples what should be changed:

(void*)&pdata				==> (void *) &pdata
= SCAN_PAGE|SCAN_INQUIRY;		==> = SCAN_PAGE | SCAN_INQUIRY;
se = (rp.enable & SCAN_PAGE)?1:0;	se = (rp.enable & SCAN_PAGE) ? 1 : 0;

This is also bad coding style:

       if (dd < 0) {
               syslog(LOG_ERR, "HCI device open failed: hci%d", id);
               goto failed;
       } else {

We don't need the else branch. I results in an needless indentation.

I also think that we need some more newlines in your code, but I am
going to fix it when applying the patch.

This part might work, but I don't like it:

       if (ispscan) {
               if (scan && !(rp.enable & SCAN_PAGE))
                       enable = (rp.enable & SCAN_INQUIRY) | SCAN_PAGE;
               else if (!scan && (rp.enable & SCAN_PAGE))
                       enable = (rp.enable & SCAN_INQUIRY);
               else {
                       reply = dbus_message_new_method_return(msg);
                       goto failed;
               }
       } else {
               if (scan && !(rp.enable & SCAN_INQUIRY))
                       enable = (rp.enable & SCAN_PAGE) | SCAN_INQUIRY;
               else if (!scan && (rp.enable & SCAN_INQUIRY))
                       enable = (rp.enable & SCAN_PAGE);
               else {
                       reply = dbus_message_new_method_return(msg);
                       goto failed;
               }
       }

And this includes this:

       if((rp.enable & SCAN_PAGE) != (old_data & SCAN_PAGE)) {
               se = (rp.enable & SCAN_PAGE)?1:0;
               send_property_changed_signal(id, DEV_PROPERTY_PSCAN, DBUS_TYPE_BOOLEAN, &se);
       }
       if ((rp.enable & SCAN_INQUIRY) != (old_data & SCAN_INQUIRY)) {
               se = (rp.enable & SCAN_INQUIRY)?1:0;
               send_property_changed_signal(id, DEV_PROPERTY_ISCAN, DBUS_TYPE_BOOLEAN, &se);
       }
       dbus_connection_flush(connection);

I don't have any better idea to solve this at the moment, but if you
read this code it takes too much time too understand what it is actually
doing. And normally this is not a good idea. However we might fix it
later and get the patch in now for further testing. So please correct
the other parts and resend it.

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
