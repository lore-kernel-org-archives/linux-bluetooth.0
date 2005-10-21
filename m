Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de37400f0510210807s3df4b697sab237041cd30c6e1@mail.gmail.com>
From: Tomasz Urbanowicz <tomasz.urbanowicz@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1401_13332190.1129907237012"
Subject: [Bluez-devel] SCO USB isoc transfer
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
Date: Fri, 21 Oct 2005 17:07:17 +0200

------=_Part_1401_13332190.1129907237012
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
 I have a little question regarding sco packets transfer over usb.
To learn about bluetooth I've developed my own stack fragment that works
with usb devices.
Now I'm working on enabling SCO transfer which takes place over isochronous
endpoints in
the usb device. Now to the point. After establishing the SCO connection whe=
n
I read from
the device isoc endpoint I've noticed that the data that is returned
sometimes starts
with the SCO header and sometimes it doesn't.When it doesn't the first SCO
Header appears somewhere later in the data.
For example when I read some number of bytes from isoc endpoint my result
buffer might start like this :
 *)
2C 00 30 22 10 22 10 22 10 22 10 22 10 22 10 22 10
22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22
...
...
Here the 2C0030 is the correct SCO packet header, so the result buffer righ=
t
from the beginning starts with the SCO packet.
But it's not always like that. Somtimes the result buffer will start with
some garbage data, and the proper SCO header appears somewhere later in tha=
t
buffer. For example :
 **)
22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22
10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10
2C 00 30 22 10 22 10 22 10 22 10 22 10 22 10 22 10
 Here first 34 bytes are not preceeded with the SCO Header. A properly
structured packet starts at the 3rd line here with 2C 00 30.
 When I reviewed the BlueZ code for usb driver I found that __recv_frame()
function basicly assumes that the very first 3 bytes that the isochronous
endpoint will send to us will be a SCO Header. So it assumes that it is
always dealing with case *) Am I right ?
 So my question boils down to this. When I start reading from the usb isoc
endpoint how do I determine the begining of the SCO data ? Should I assume
that the data will start with the proper SCO packet ? Or should I be
prepared that there might be some garbage data at the beginning of the
buffer, which would require me to search for the first proper SCO packet
that starts the stream.
 I know this has nothing to do with BlueZ, but I couldn't think of any othe=
r
place to post my question so I hope someone (Max ? maybe Marcell ?) will
help me to understand that issue. I'll appreciate it a lot.
 thanks,
Tomasz

------=_Part_1401_13332190.1129907237012
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I have a little question regarding sco packets transfer over usb. </di=
v>
<div>To learn about bluetooth I've developed my own stack fragment that wor=
ks with usb devices.</div>
<div>Now I'm working on enabling SCO transfer which takes place over isochr=
onous endpoints in </div>
<div>the usb device.&nbsp;Now to the point. After establishing the SCO conn=
ection when I read from </div>
<div>the device isoc endpoint I've noticed that the&nbsp;data that is retur=
ned sometimes starts</div>
<div>with the SCO header and sometimes it doesn't.When it doesn't the first=
&nbsp;SCO Header appears somewhere later in the data.&nbsp;</div>
<div>For example when I read&nbsp;some number of&nbsp;bytes from isoc endpo=
int&nbsp;my result buffer&nbsp;might start like this&nbsp;:</div>
<div>&nbsp;</div>
<div>*)</div>
<div>2C 00 30 22 10 22 10 22 10 22 10 22 10 22 10 22 10<br>22 10 22 10 22 1=
0 22 10 22 10 22 10 22 10 22 10 22<br>...</div>
<div>...</div>
<div>Here the 2C0030 is the correct SCO packet header, so the result buffer=
 right from the beginning starts with the SCO packet. </div>
<div>But it's not always like that. Somtimes&nbsp;the result buffer will st=
art with&nbsp;some garbage data, and the proper SCO header appears somewher=
e later in that buffer. For example :</div>
<div>&nbsp;</div>
<div>**)</div>
<div>22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22<br>10 22 10 22 10 2=
2 10 22 10 22 10 22 10 22 10 22 10<br>2C 00 30 22 10 22 10 22 10 22 10 22 1=
0 22 10 22 10</div>
<div>&nbsp;</div>
<div>Here first 34 bytes&nbsp;are not preceeded with the SCO Header.&nbsp;A=
 properly structured packet starts at&nbsp;the 3rd line here with 2C 00 30.=
&nbsp;</div>
<div>&nbsp;</div>
<div>When I reviewed the BlueZ code for usb driver I found that __recv_fram=
e() function basicly assumes that the very first 3 bytes that&nbsp;the isoc=
hronous endpoint will send to us&nbsp;will be a SCO Header. So it assumes t=
hat it is always dealing with case *) Am I right ?=20
</div>
<div>&nbsp;</div>
<div>So my question boils down to this. When I start reading from the usb i=
soc endpoint how do I determine the begining of the SCO data ? Should I ass=
ume that the data will start with the proper SCO packet ? Or should I be pr=
epared that there might be some garbage data at the beginning of the buffer=
, which would require me to&nbsp;search&nbsp;for the first proper SCO packe=
t that starts the stream.
</div>
<div>&nbsp;</div>
<div>I know this&nbsp;has nothing to do with BlueZ, but I couldn't think of=
 any other place to post my question so I hope someone (Max ? maybe Marcell=
 ?) will help me to understand that issue. I'll appreciate it a lot.</div>
<div>&nbsp;</div>
<div>thanks,</div>
<div>Tomasz</div>

------=_Part_1401_13332190.1129907237012--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
