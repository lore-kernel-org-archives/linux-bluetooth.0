Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Peter Bergmann <bergmann.peter@gmx.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F83F423.7020406@csr.com>
References: <1065171540.1734.97.camel@pegasus>
	<28385.1065174121@www39.gmx.net> <1065174943.1734.101.camel@pegasus>
	<3F7D5B72.1050900@csr.com> <1065443556.21958.39.camel@pegasus>
	<3F83F423.7020406@csr.com>
Content-Type: text/plain
Message-Id: <1065613768.5327.138.camel@pegasus>
Mime-Version: 1.0
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
Date: 08 Oct 2003 13:49:22 +0200

Hi Steven,

> > this idea is nice and it sounds like a useful feature. But it can't
> > depend on the RFCOMM traffic. It must depend on the ACL traffic and the
> > BlueZ core must handle it.
> 
> Yes, sorry. Of course it must depend on ACL traffic not RFCOMM. I
> suspect the easiest way to do it is to advertise an ioctl for this
> feature. I'm not quite sure what the interface should be, but I'm sure
> you can think of something.

I think more of an on/off flag with some additional parameters. And it
maybe described the best with "Automatic Sniff Mode".

> We're getting ahead of ourselves though. We need confirmation from Peter
> that sniff helps the problem. If it doesn't we're wasting our time
> (unless you think the feature is useful for other applications).

It can be useful for all kind of devices where power consumption is
essential. Even an iPAQ with a PAN connection can profit from it. The
Microsoft HID devices make heavy use of sniff mode, before they
disconnect the ACL link after 12 minutes of idle time. And everyone
talks about the long battery life time of Bluetooth HID devices, so this
looks like the right way to reduce power consumption.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
