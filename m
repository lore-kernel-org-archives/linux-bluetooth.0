Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2
	devices?
From: Marcel Holtmann <marcel@holtmann.org>
To: albert@csail.mit.edu
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec041019171179f1e8d0@mail.gmail.com>
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
	 <1097658003.4643.17.camel@notepaq>
	 <ef9938ec04101511326a6342c3@mail.gmail.com>
	 <1097928625.4911.30.camel@pegasus>
	 <ef9938ec04101914447e122c22@mail.gmail.com>
	 <1098222911.23046.5.camel@pegasus>
	 <ef9938ec04101916584d188ffc@mail.gmail.com>
	 <ef9938ec041019171179f1e8d0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098690211.24932.4.camel@pegasus>
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
Date: Mon, 25 Oct 2004 09:43:30 +0200

Hi Albert,

> > Attached is a patch for bluez-libs.  Two functions are added.
> 
> please ignore previous message.  That patch doesn't follow the
> naming/tabbing conventions in the rest of bluez-libs.  Attached is a
> patch that does.

the coding style is still not correct and you screwed the patch up by
inserting memset() that overrides previous set values. Besides this you
set the rq.rlen wrong.

I implemented the hci_{read|write}_inquiry_mode() functions by myself
and also changed hciconfig to use them. My version is not so different
from yours, but the details matter. Please compare them and start
sending in more patches to enhance the Bluetooth library.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
