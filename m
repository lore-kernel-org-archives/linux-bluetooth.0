Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1086536804.40c33c64e8456@webmail.rnl.ist.utl.pt>
From: dsas@mega.ist.utl.pt
To: bluez-devel@lists.sourceforge.net
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt> <1086094054.1978.26.camel@fischer> <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
In-Reply-To: <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Problems while sending and receiving with rfcomm sockects
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
Date: Sun,  6 Jun 2004 16:46:44 +0100

Hello Marcel,

I've compiled kernel-2.6.6 with the new mh3 patch and now, everything wor=
ks
fine. So, I think it is a kernel bug (2.4.20). It also works without
semaphores.

Just one more thing about this: The number of bytes sent and received is =
the
same but the data received appears shifted by one byte... Strange.

If you're still interested, I'll send you a small program in a few days (=
I have
some work to do for now...).

Once again, thank you Marcel.

Regards,

Didier

> > When I execute 2 servers on masters side (one only sending and the ot=
her
> > only receiving) using diferents rfcomm channels, I also receive corru=
pt
> > data (very rarely :-( ). If they"re both sending or receiving, everyt=
hing
> > works fine...
> >
> > think it"s possible to use semaphores to synchronize the 2 processes =
but I"d
> > like to use a simpler solution or at least understand where the probl=
em is.
>
> if you are using two different RFCOMM channels and this happens it look=
s
> like a bug in the kernel code. As I said, check the latest kernel and
> try to send us a simple program that triggers this effect.





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
