Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <72176e700511021316x428bf98aw9ae8d36965a8f092@mail.gmail.com>
From: =?ISO-8859-1?Q?Bart_Thom=E9e?= <bart.thomee@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6494_9310058.1130966214694"
Subject: [Bluez-users] probe remote device for security mode
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
Date: Wed, 2 Nov 2005 22:16:54 +0100

------=_Part_6494_9310058.1130966214694
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Is it possible to find out which security mode a remote device is in?

Part of the project I am working on concerns sending messages to mobile
phones, using the OBEX Object Push Service (the project has some bluejackin=
g
characteristics, but is inherently different). The OOP Service usually
requires no authentication, but some phones have it turned on or some phone=
s
leave the possibility open to the user to turn it on or off.

Using my phone, HTC (Orange) C500 smartphone, as an example, I might be abl=
e
to clarify a little more what I'm trying to achieve.
- with bluetooth turned on in discoverable mode and the 'authentication
required' option turned off, I can easily send a message 'Hello' to the
phone, which instantly lights up and says "Do you want to save 'Hello' to
your phone?". Perfect, the message comes across.
- with bluetooth still on but now 'authentication required' turned on,
sending a message becomes a cumbersome undertaking, as the phone lights up
and asks "Do you want to add [device] to your list of trusted devices?"...
and then the devices first have to pair before the message can be sent.
Since the project will send the messages in an automated fashion, the
authentication is a horrible process, so I only want to send the messages t=
o
phones that do not require authentication/passkeys/pin codes/pairing, but i=
s
this possible to do? e.g. can you query for the authentication setting of a
remote device, or is it just something that can't be done (i.e. you have to
find out the hard way if authentication is required, if the message is sent
straight on then it's apparently turned off, otherwise not). I know that yo=
u
can query your local device using hci_send_cmd and with a parameter that is
called something like READ_AUTHENTICATION_ENABLE, so maybe there is a way t=
o
relay that request to a remote device?

Thanks.

Bart

------=_Part_6494_9310058.1130966214694
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Is it possible to find out which security mode a remote device is in?<br><b=
r>Part of the project I am working on concerns sending messages to mobile p=
hones, using the OBEX Object Push Service (the project has some bluejacking=
 characteristics, but is inherently different). The OOP Service usually req=
uires no authentication, but some phones have it turned on or some phones l=
eave the possibility open to the user to turn it on or off.
<br><br>Using my phone, HTC (Orange) C500 smartphone, as an example, I migh=
t be able to clarify a little more what I'm trying to achieve.<br>- with bl=
uetooth turned on in discoverable mode and the 'authentication required' op=
tion turned off, I can easily send a message 'Hello' to the phone, which in=
stantly lights up and says &quot;Do you want to save 'Hello' to your phone?=
&quot;. Perfect, the message comes across.
<br>- with bluetooth still on but now 'authentication required' turned on, =
sending a message becomes a cumbersome undertaking, as the phone lights up =
and asks &quot;Do you want to add [device] to your list of trusted devices?=
&quot;... and then the devices first have to pair before the message can be=
 sent.
<br>Since the project will send the messages in an automated fashion, the a=
uthentication is a horrible process, so I only want to send the messages to=
 phones that do not require authentication/passkeys/pin codes/pairing, but =
is this possible to do?=20
e.g. can you query for the authentication setting of a remote device, or is=
 it just something that can't be done (i.e. you have to find out the hard w=
ay if authentication is required, if the message is sent straight on then i=
t's apparently turned off, otherwise not). I know that you can query your l=
ocal device using hci_send_cmd and with a parameter that is called somethin=
g like READ_AUTHENTICATION_ENABLE, so maybe there is a way to relay that re=
quest to a remote device?
<br><br>Thanks.<br><br>Bart<br>

------=_Part_6494_9310058.1130966214694--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
