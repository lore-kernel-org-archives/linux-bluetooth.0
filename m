Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
From: dsas@mega.ist.utl.pt
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems while sending and receiving with rfcomm sockects
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt> <1086094054.1978.26.camel@fischer>
In-Reply-To: <1086094054.1978.26.camel@fischer>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Tue,  1 Jun 2004 16:07:54 +0100

Hi Julien and Marcel,

When I execute 2 servers on masters side (one only sending and the other =
only
receiving) using diferents rfcomm channels, I also receive corrupt data (=
very
rarely :-( ). If they're both sending or receiving, everything works fine=
... I
think it's possible to use semaphores to synchronize the 2 processes but =
I'd
like to use a simpler solution or at least understand where the problem i=
s.

Regards

Didier

> Am Di, den 01.06.2004 schrieb dsas@mega.ist.utl.pt um 13:16:
>
> Hi Didier,
>
> > Hello,
> >
> > I'm writting a server-client application over bluez using rfcomm sock=
ets.
> I've
> > created two threads: one for sending and the other for receiving. The
> problem
> > occurs sometimes (sporadical) and only when I'm sending and receiving=
 data
> at
> > the same time: The received data seems to be corrupt... Do I have to =
use
> > mutexes or other synchronizing method?
>
> If you are using wo threads to read/write RFCOMM packets, your
> read/write methods should be synchronized.
>
> Regards,
>
> Julien
>
> > The error ocurrs more often if I execute
> > more than one server at the same time.
> >
> > Thanks.
> >
> > PS: Please tell me if I'm sending this message to the right mailing l=
ist...
> >
> > Didier.
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle 1=
0g.
> > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3Dclick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
