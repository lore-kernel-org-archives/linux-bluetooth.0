Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050914064849913a76@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2824_615623.1126705736301"
Subject: [Bluez-devel] hcid and bluetoothd
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
Date: Wed, 14 Sep 2005 10:48:56 -0300

------=_Part_2824_615623.1126705736301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

You said in an old e-mail that hcid is your playground for D-Bus services.=
=20
Probably, hcid D-Bus should be the starting point for bluetoothd.

I would like to align your ideas to avoid future reworks.

D-Bus provides 4 types of messages:
1. Method call
2. Method reply
3. Signals
4. Error
Currently, only signals are sent. The following signals are sent as result=
=20
of the hci commands:
- InquiryStart
- InquiryResult
- InquiryComplete
- RemoteName
path: /org/bluez/DevAgent
interface: org.bluez.DevAgent

The topics that I want discuss are:
1. hcid signals
In my opinion it is not necessary send signals to notity inquiry=20
start/complete. Only signals for news devices are enough.=20
Another aspect is, inquiry result can contain repeated devices. This=20
approach could cause D-Bus app client overhead(inconsistency), by other han=
d=20
if periodic inquiry is active repeated signals must be sent because more=20
than one client can be filtering these signals and they can start at=20
different time. :)

2. hcid and bluetoothd object path
What is the object path that you want use?
I suggested in an old email use a hierarchical paths. bluetoothd can be the=
=20
main object path provided at /org/bluez/bluetoothd, hci D-Bus services coul=
d=20
be provided at /org/bluez/bluetoothd/hci

3. D-Bus services
hci D-BUS services is the next step, I am going to starting coding ASAP.=20
Regarding inquiry requests, what kind of implementation do you prefer, send=
=20
method reply message or send only signals(like the current)?
If you use signals, all D-Bus client capturing D-Bus hci signals are able t=
o=20
see the new devices found. Using a method reply only the peer (requestor)=
=20
will receive. Using a method reply approach, we can implement device class=
=20
filters and avoid repeated devices. We have the same problem for remote=20
name, disconnect, authentication/security, info, role switch and display=20
connections.

4. bluetoothd
There are shared codes like(pand/bnep.c, pand/sdp.c, hidd/sdp.c, ...) that=
=20
we need be aware.
It is NOT clear for me how hcid and bluetoothd should work. hcid must be=20
running all the time, but the hci D-Bus service will be running only if the=
=20
system has a D-Bus system daemon running. Therefore, who should register th=
e=20
hci object path? IMHO, bluetoothd should centralize all D-Bus services. It=
=20
will not be easy separate the "normal" code from the "D-Bus code". Maybe=20
your "new interface" that your are defining can solve this problem.

5. new interface
You said that a new interface for kernel and the userspace communication is=
=20
being defined. What is the current status?


Regards,
Claudio.

------=_Part_2824_615623.1126705736301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
You said in an old e-mail that hcid is your playground for D-Bus
services. Probably, hcid D-Bus should be the starting point for
bluetoothd.<br>
<br>
I would like to align your ideas to avoid future reworks.<br>
<br>
D-Bus provides 4 types of messages:<br>
1. Method call<br>
2. Method reply<br>
3. Signals<br>
4. Error<br>
Currently, only signals are sent. The following signals are sent as result =
of the hci commands:<br>
- InquiryStart<br>
- InquiryResult<br>
- InquiryComplete<br>
- RemoteName<br>
path: /org/bluez/DevAgent<br>
interface: org.bluez.DevAgent<br>
<br>
The topics that I want discuss are:<br>
1. hcid signals<br>
In my opinion it is not necessary send signals to notity inquiry start/comp=
lete. Only signals for news devices are enough. <br>
Another aspect is, inquiry result can contain repeated devices. This
approach could cause D-Bus app client overhead(inconsistency), by other
hand if periodic inquiry is active repeated signals must be sent
because more than one client can be filtering these signals and they
can start at different time. :)<br>
<br>
2. hcid and bluetoothd object path<br>
What is the object path that you want use?<br>
I suggested in an old email use a hierarchical paths. bluetoothd can be
the main object path provided at /org/bluez/bluetoothd, hci D-Bus
services could be provided at /org/bluez/bluetoothd/hci<br>
<br>
3. D-Bus services<br>
hci D-BUS services is the next step, I am going to starting coding
ASAP. Regarding inquiry requests, what kind of implementation do you
prefer, send method reply message or send only signals(like the
current)?<br>
If you use signals, all D-Bus client capturing D-Bus hci signals are
able to see the new devices found. Using a method reply only the peer
(requestor) will receive. Using a method reply approach, we can
implement device class filters and avoid repeated devices. We have the
same problem for remote name, disconnect, authentication/security,
info, role switch and display connections.<br>
<br>
4. bluetoothd<br>
There are shared codes like(pand/bnep.c, pand/sdp.c, hidd/sdp.c, ...) that =
we need be aware.<br>
It is NOT clear for me how hcid and bluetoothd should work. hcid must
be running all the time, but the hci D-Bus service will be running only
if the system has a D-Bus system daemon running. Therefore, who should
register the hci object path? IMHO, bluetoothd should centralize all
D-Bus services. It will not be easy separate the &quot;normal&quot; code fr=
om the
&quot;D-Bus code&quot;. Maybe your &quot;new interface&quot; that your are =
defining can
solve this problem.<br>
<br>
5. new interface<br>
You said that a new interface for kernel and the userspace communication is=
 being defined. What is the current status?<br>
<br>
<br>
Regards,<br>
Claudio.<br>

------=_Part_2824_615623.1126705736301--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
