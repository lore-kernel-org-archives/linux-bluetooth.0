Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Some fun with Apple devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1136375284.3711.29.camel@bnocera.surrey.redhat.com>
References: <1136374748.13931.17.camel@localhost>
	 <1136375284.3711.29.camel@bnocera.surrey.redhat.com>
Content-Type: text/plain
Message-Id: <1136376075.13931.28.camel@localhost>
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
Date: Wed, 04 Jan 2006 13:01:15 +0100

Hi Bastien,

> > This means that the service on the phones initiates the protocol.
> > Seems
> > like another way to sync Symbian based phones under Linux. Nobody
> > really
> > uses the crappy mRouter stuff.
> 
> That looks very much like what gnokii does for Symbian phones, using
> gnapplet, although without the additional Bluetooth service.

but this seems to be complete and fully working. It might be worth it to
reverse engineer this protocol.

The iSync phone identification is also interesting. Seems like they use
some kind of fingerprinting, because the old Symbian phones don't really
have the Nokia ID record.

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
