Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help me solve the rfcomm programming.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <e14f8bedaa101.heejune@snut.ac.kr>
References: <e14f8bedaa101.heejune@snut.ac.kr>
Content-Type: text/plain
Message-Id: <1106674102.8242.42.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 25 Jan 2005 18:28:22 +0100

Hi,

> I am writing a programm using serial profile. But it makes me crzay.
> When I am using serial port program (client and server) after I am setting 
> using "rfcomm command" ,i.e, listen and connect, it is ok.
> But, When I try to merge with my program The Peer doesnot gets Data even though the connection is opened successfully and 
> client sent data successfully.
> My program is like this.
>                                                            open("/dev/rfcomm0") 
>      test "config1" -----fork--------------------------^----*----- read( nothing or less than sent!!!) 
>                            |                           | signal (to let parent know I can reciev
>                            +----     exec ( rfcomm listen) .... 
>                                                       | 
>                           +------- exec (rfcomm connect) 
>                           |                            | signal (to let parent know it can send something) 
>      test "config2" -----fork ----                     v ----*------* write( 100 bytes)
>                                                           open("/dev/rfcomm4")

if you don't use a legacy application that needs an TTY then you also
don't need to use the TTY feature of RFCOMM. Use the RFCOMM sockets
directly and your life will be a lot more easier.

>  IS THIS Because I am using two USB dongle in the same Desktop linux????

No. This works perfect. They only situation where this is problematic is
PAN/BNEP, because the Linux TCP/IP then routes all data of the loopback
interface.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
