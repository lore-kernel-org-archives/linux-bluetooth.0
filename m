Return-Path: <jeanplord@videotron.ca>
Date: Thu, 15 Apr 2004 21:17:47 -0400
From: Jean-Pierre Lord <jeanplord@videotron.ca>
Subject: Re: [Bluez-users] Connection dropped or cannot connect
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <000601c42350$a1aa60b0$0100a8c0@terre>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <000801c41e98$9e75d080$0100a8c0@terre>
 <1081592935.3028.3.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Thank you for your quick reply, Marcel...and sorry for being so slow to
answer.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Jean-Pierre Lord" <jeanplord@videotron.ca>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Sent: Saturday, April 10, 2004 6:28 AM
Subject: Re: [Bluez-users] Connection dropped or cannot connect


> Hi Jean-Pierre,
>
> > My Linux box has a Anycom usb-220 bluetooth adapter connected to it
> > which is used to serve my iPAQ1940.  Works "superbly great" except
> > those times it won't work at all ;-).  Either a long connection (like
> > a download) will be cut or i will not be able to open a new
> > connection.  When it happens, i have 2 choices: unplung the bluetooth
> > adapter for a few seconds (which requires no other intervention on the
> > software side) and replug it or reset the device using hciconfig.
> > Except that doing this reset will sometimes crash the hole Linux box.
> > I then get a stack dump and once i got a message that looked like
> > this: "...killing interrupt handler...".  Sorry i wasn't fast enough
> > to write down the message.
>
> this message is important and you should try to get it over a serial
> console. Please try a 2.4.25-mh3 or a 2.4.26-rc2. Maybe there is already
> a fix for it.
>
You're right, you need the message and i was able to get one.  I had 2 other
crashes, this time only by insisting to connect.  By insisting i mean
turning on the bluetooth on the iPaq and try to connect, turn it off, retry
and so on a few times.

Here are the dump details:

Unable to handle kernel paging request at virtual address 413e3344
Oops: 0000
CPU: 0
EIP: 0010:[<c485920e>] not tainted
EFlags: 00010086

eax: c1747180 ebx: c1747140 ecx: 01747180 edx: 01747180
esi: 413e333c edi: c2dca000 ebp: c1745000 esp: c02a9f10
ds: 0018 es:0018 ss: 0018

Process swapper (pid: 0, stackpage = c02a9000)

stack: c1838f20 c1747180 c1747200 0 0 c2dcac08 00084000 00000282 1 0
c011973b 1 c1745000 c4851000 1 4 c485a38a c1745000 0 c1db1a80 04000001 f
c02a9fb0 c01081fa

call trace: [<c011973b>] [<c485a38a>] [<c01081fa>] [<c010837d>] [<c0105250>]
[<c010a788>] [<c0105250>] [<c0105274>] [<c01052e2>] [>c0105000>]

Code 83 7e 08 01 74 06 f6 47 18 04 74 3c 8b 03 c1 e8 1c 83 f8 0d

<0> Kernel panic: Aiee killing interrupt handler!
Interrupt handler - not syncing

That's it!
I will move to 2.4.26rc2 (or better).  I will also install the patches you
may have for this kernel (i haven't check yet).

> > I'm running "Kernel 2.4.24-mh2 on an i586" with bluez-libs-2.5,
> > bluez-sdp-1.5, bluez-utils-2.5.  I normally run hcid, sdpd, "dund
> > --listen --msdun call dun".  It seems to me that enabling
> > authentification and encryption has made the whole thing less
> > reliable.
>
> Setting auth and encrypt switches to security mode 3 which is not what
> your really want.
>
May be.  What i want is making sure no uninvited party connects to my Linux
server.  I also feel at ease knowing the communications are not easy to
sniff.  But may be i am a bit to paranoid.  Especially considering that
Bluetooth is definitly not popular here in Montreal.

I will chech for another way to put a minimum of protection.

Merci!

> Regards
>
> Marcel
>
>
