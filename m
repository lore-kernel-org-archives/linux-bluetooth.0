Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] bluetooth socket + rfcomm tty
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <A4D3CD3715C9DD4089BFE00A7279399406EB@posthoorn.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 26 Jan 2005 12:00:44 +0100

Hello Marcel,

Now I close the socket after converting to TTY. After this I open
"/dev/rfcomm0" with O_RDWR | O_NOCTTY and write ATD12345\n\r command to
it, then read the response (receive echo), and sleep, meanwhile phone
starts to dial the number, but then stops for no reason. If I do the
same with original (non-converted) socket (skipping converting to TTY),
everything is OK.

I've taken a look at hcidump output and it looks rather strange if I
compare it for both cases. In the case of file handle to converted TTY
all the data looks fragmented between ACL packets (like ATD1234 is not
sent in one packet, like in the case of non-converted socket, but piece
by piece in a number of packets) + there is a lot of activity from the
phone during the sleep phase when I do not do anything with the file
handle.

Regards,
    Victor.

P.S. I can send the output, but first check if it is really needed.
P.S.S running 2.6.10

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, January 24, 2005 10:25 PM
To: BlueZ Mailing List
Subject: Re: [Bluez-devel] bluetooth socket + rfcomm tty

Hi Victor,

> Could not find it through the archives...=20
> I create a bluetooth socket and then create TTY (/dev/rfcomm0) based
on it (like it is done in dund from bluez-utils).=20
> Is it still allowed to use the descriptor of the open socket to
send/receive data through the channel?=20
> Cause when I send data to the _socket_ it looks like it is sent (like=20
> ATD1234 command to the phone, I see the phone starting to dial, though
it=20
> stops half way for no reason), but when I'm trying to read from the
socket=20
> select() returns that there is data to be read, but then read()
blocks.

this is maybe possible, but it is not intended. When you converted a
socket into a TTY the socket should be closed. Otherwise we must
duplicate the incoming data and if one party is not reading the flow
control will be brocken and both parties are blocked.

> P.S. Is there any way to check if read() is non-blocking (like ioctl()

> FIONREAD)?

Check the fcntl() manpage.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Address change | On the 31st of January 2005 TomTom will be moving to | =
Rembrandtplein 35 | 1017 CT Amsterdam | The Netherlands | T + 31 =
(0)20-8500 800 | F + 31 (0)20-8501 099



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
