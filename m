Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408031529.40100.harbaum@beecon.de>
References: <200408021859.44496.harbaum@beecon.de>
	 <200408031416.46803.harbaum@beecon.de> <1091538562.4259.77.camel@pegasus>
	 <200408031529.40100.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1091540708.4259.88.camel@pegasus>
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
Date: Tue, 03 Aug 2004 15:45:08 +0200

Hi Till,

> > the point is that we don't really thought about it when we were writing
> > our RFCOMM layer. It worked out, but I never checked the granted credits
> > against the receive buffer. Sounds like a work for a diploma thesis ;)
> Sorry, i already have a diploma and a ph.d., but we do have some bluetooth 
> related projects at the university. I'll propose this to some of the 
> professors.

I know and actually this hint was meant like if you know someone who
wants do write something about Bluetooth propose this.

> > The checksum stuff is historical and you will only get the sense behind
> I know. But they thought enough about it to remove the need to build the 
> chechsum over the payload. Why did they still keep a checksum? (i have to 
> admit, it helped me a lot, since it found some bugs in my l2cap/rfcomm code). 
> I'd really like to talk about the person who made the bluetooth changes to 
> rfcomm :-)

They didn't thought enough. The original ETSI specification include UIH
and UI data frames and they simple left out the UI frames, because the
L2CAP channel have to be reliable.

> > The first time I realized why people asking for host to host controller
> > flow control (BlueZ don't supports it btw) I screamed out loud. Then I
> You are talking about the buffer management on hci layer for the buffers on 
> host side aren't you? As long as you have "enough" buffer space this doesn't 
> seem very important. But with my devices having only few bytes buffer space, 
> it really is necessary.

Yes. We never needed it and so nobody implemented it.

> > flow control of a lower layer for its own purpose. Implementation
> > details must reside inside the layer. This is one of the basics of the
> > OSI model.
> And the L2CAP start/continuation flags are part of the acl header :-)

This is ugly, I know. I never said that the Bluetooth stack design was
perfect ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
