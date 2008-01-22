Return-Path: <cyrus@holtmann.org>
Message-ID: <4795F9EC.20509@aircable.net>
Date: Tue, 22 Jan 2008 12:13:00 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <QiqzmGYI.1201010734.9272710.fma@alezan.org>
In-Reply-To: <QiqzmGYI.1201010734.9272710.fma@alezan.org>
Subject: Re: [Bluez-users] Newbie needs help to start
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


> Ok, I got it. But how and where do I generate link keys?
>   
You don't after the PIN transaction has completed successfully the
stacks handle the link generation. Links are stored under
/var/lib/bluetooth/<hci address>/linkkeys take into account that if you
switch from windows into linux, or if you plug your bluetooth dongle to
another pc, you will need to remove the linkkey from the file or it will
never work. It's like when RSA keys changes for a server.

> So, after I connect the BT device to the rfcomm channel, I can read/write
> to it using the /dev/rfcomm entry, like if I'm using a /dev/ttySxx ?
>   
Exactly.

> If I understand correctly, rfcomm is not supported anymore? If it is the
> old way, what is the new way?
>   
rfcomm as a tool isn't supported any more, rfcomm as technology is and
is the base for most of the bluetooth services. The new way is using the
dbus serial service. Which will also generate the rfcomm node, in a more
simple way, but if your distro is not well configured, it can be a
headhacke to get it to work.

> I certainly don't want to deep inside d-bus, but the fact is that python
> examples on bluez wiki use d-bus module :o/
>   
You WANT to get deep into bluez dbus api, not into the old hci lib api ;).

> I attached it.
>   
Where? I don't think this list can take attached files.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
