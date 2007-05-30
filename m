Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750705300036v3409e6a7kcb58e9f746f6cac@mail.gmail.com>
References: <80236d750705290911g619e3d9eu8c6cda81c884b44d@mail.gmail.com>
	<1180470054.21432.141.camel@aeonflux.holtmann.net>
	<80236d750705300036v3409e6a7kcb58e9f746f6cac@mail.gmail.com>
Date: Wed, 30 May 2007 09:58:04 +0200
Message-Id: <1180511884.21432.170.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] [Bluez Users] Page timeout during sdp on
	heavy	traffic.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Emanuele,

> Maybe I was not clear sorry, the sdp search I do on hci1 is
> serialized. It's a thread started each one a new device is discovered.
> He does 1 sdp search and quit. Then another one is started on next
> device on the list of the discovered ones. 

please don't use the word threads if it has nothing to do with your
setup. It confuses people and it confuses me. It is a minor technical
detail.

> I know I cant do inquiry and page at same time but I read elsewhere on
> this forum that using 2 separate hci at once you can actually achieve
> that. But maybe I was wrong if so sorry for the silly question.
> Simply I do inquiry with hci0 (never stops) and each time it finds a
> group devices I start an sdp search on hci1 (1 device at time
> serialized) but as I wrote sometimes this request return page timeout
> while other time it works well as per the hcidump I attached on
> previous message. 
> At this time the inquiry is always running (not periodic inquiry
> simply a looped inquiry request)
> That's only to check what's happening on heavy traffic.

So in general that works perfectly fine. Having inquiry on one and
service discovery running on another dongle.

However there are some minor details that needs to taken into account.
The piconets you create with your service discovery need also to be
taken down and this will be done by kernel automatically. This might
interfere with the next page. A sdp_close() will close the SDP session,
but it might still take another 3 seconds or more before the kernel
finally terminates the piconet. Never underestimate this.

Also the name resolving will create a temporary piconet and thus a page
from a different device might fail.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
