Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap xfer fails
References: <200401281135.58062.mtortonesi@ing.unife.it>
In-Reply-To: <200401281135.58062.mtortonesi@ing.unife.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401281200.07012.mtortonesi@ing.unife.it>
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
Date: Wed, 28 Jan 2004 12:00:07 +0100

On Wednesday 28 January 2004 11:35, Mauro Tortonesi wrote:
> i've been testing bluetooth support for nc6. unfortunately, i couldn't
> transfer data. both kernels are 2.4.25-pre7.

sorry, my kmail client sucks. it keeps crashing and sending unfinished emai=
ls=20
instead of postponining them. good old pine was not so bad :-(

what i wanted to say is that i can transfer (over L2CAP) data from console,=
=20
but transfer of files redirected to stdin always fails. perhaps i am doing=
=20
something wrong? such as calling write(2) over L2CAP sockets with buffers=20
larger that 762 bytes?

> 1st test - client side:
>
> [mauro@daneel nc6]$ ./src/nc6 -b 00:0D:88:8E:CA:07 10
> erneuwenoun
> ervimn=F2orinw=F2trin=F2ri
> rtbon=F2reonb=F2obre=F2eorinrt
> weinbrt=F2oint=F2io1re
> trbon=F2beone=F2otrn=F2rtietr
> rin=F2eroinrt=F2inr=F2int
> rbn=F2on=F2rtibit
> rinr=F2tboinrt=F2inrirbtmrkimfr
> rebmrtmre=F2ireireo=F2
>
> 1st test - server side:
>
> [mauro@giskard nc6]$ ./src/nc6 -vvv -b -l -p 10 > dump.bin
> nc6: listening on (null) psm 10 ...
> nc6: connect to (null) psm 10 from 00:0D:88:8E:CA:07 psm 10
> nc6: using seqpacket socket
> nc6: using buffer size of 8192
> nc6: read eof from remote
> nc6: closed local for write
> nc6: remote hold timed out
> nc6: closed local for read
> nc6: closed remote for write
> nc6: connection closed (sent 0, rcvd 182)
>
>
> 2nd test - client side:
>
> [mauro@daneel nc6]$ cat src/main.c | ./src/nc6 -vvv -b 00:0D:88:8E:CA:07 =
10
> nc6: using buffer size of 8192
> nc6: error writing to remote: Invalid argument
> nc6: connessione terminata (inviati 0, ricevuti 0)
> nc6: closed local
> nc6: closed remote
>
> 2nd test - server side:
>
> [mauro@giskard nc6]$ ./src/nc6 -vvv -b -l -p 10 > dump.bin
> nc6: listening on (null) psm 10 ...
> nc6: connect to (null) psm 10 from 00:0D:88:8E:CA:07 psm 10
> nc6: using seqpacket socket
> nc6: using buffer size of 8192
> nc6: read eof from remote
> nc6: closed local for write
> nc6: remote hold timed out
> nc6: closed local for read
> nc6: closed remote for write
> nc6: connection closed (sent 0, rcvd 0)

=2D-=20
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
=46errara Linux User Group        http://www.ferrara.linux.it





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
