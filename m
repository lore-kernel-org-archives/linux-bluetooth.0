Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46420306.8020509@tao-group.com>
Date: Wed, 09 May 2007 18:21:10 +0100
From: David Given <dg@tao-group.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4641DA61.8040709@tao-group.com>	<1178722356.8628.96.camel@aeonflux.holtmann.net>	<4641E662.6080303@tao-group.com>	<1178724426.8628.102.camel@aeonflux.holtmann.net>	<4641EA96.7070204@tao-group.com>	<1178726532.8628.107.camel@aeonflux.holtmann.net>
	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
In-Reply-To: <be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
Subject: Re: [Bluez-users] API documentation?
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

Mark S. Townsley wrote:
[...]
> I tried to search online but could not find any answer.  I searched the
> archive, nothing comes up.   Can you provide your expertise on this one?
> What are these .service files?  How can I make one for org.bluez?

I'm using a Ubuntu Feisty, which is only a few weeks old; bluez-utils appears
to be the critical package, containing hcid (that seems to do the work) and
/etc/dbus-1/system.d/bluetooth.conf (that declares the Bluetooth service). I
can't find any documentation describing how to set all this up, though...

[...]
> On 5/9/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>> to be quite frankly, then don't ask me about it. If you wanna screw with
>> your system you are on your own.

You seem not to have much experience with embedded systems.

On my system, there are two instances of dbus-daemon occupying 432 pages and
304 pages respectively, an instance of dbus-launch with 244, and an instance
of hcid with 348. There are also two *more* instances of dbus-daemon, but they
may be specific to the user and so irrelevant. Even so, that's still a total
of 1328 pages, or 5312kB.

That's just not *reasonable* on a system with low memory, especially since
Bluetooth will be the only thing that uses it.

Since all this code is going to have to go through the kernel interface anyway
to get anything done, it's far more appropriate to use that instead.
Particularly since there's a helpful library, hcilib, that wraps the kernel
interface and makes it easy to use. (And which, BTW, is recommended by all the
tutorial code I've been able to find.)

I was hoping that someone would be able to point me at the document that
specifies what this interface actually *is*.

-- 
David Given
dg@tao-group.com

This message is subject to Tao's e-mail terms ( http://e.tao-group.com/1 )
Tao Group Ltd, 62/63 Suttons Business Park, Suttons Park Avenue,
Reading, Berkshire RG6 1AZ. Registered in England, number 2722079

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
