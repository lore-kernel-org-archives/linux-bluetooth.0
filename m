Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ff026c52050802174272eb2525@mail.gmail.com>
From: Byron Poland <wpoland@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Connecting to LAN-ACCESS on an OGO
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
Date: Tue, 2 Aug 2005 20:42:33 -0400

Hi.

I'm attempting to get this "hack" to work with bluez under linux:=20

http://www.ogomatic.com/modules/newbb/viewtopic.php?topic_id=3D34&forum=3D4=
&viewmode=3Dflat&order=3DASC&start=3D0

I got it to work from my WinXP machine, but have yet to get anything
beyond pairing to work with my linux box.  The ogo is a handheld
communicator that was sold by attwireless for awhile.  It has
bluetooth built in, and its called "PMG"  on the Ogo I'm able to set a
name, scan for devices, pair, and set temporary visibility (1 minute
intervals).

under linux when I do an hcitool scan, I am able to see the ogo when I
enable the temporary visibility option:
$ hcitool scan
Scanning ...
        00:11:94:00:23:C0       OGO013

so next up I initiate pairing from the ogo, and recieve a success
message after entering my PIN on the ogo. logs:

Aug  2 20:32:46 localhost hcid[30371]: link_key_request
(sba=3D00:E0:03:25:53:19, dba=3D00:11:94:00:23:C0)
Aug  2 20:32:46 localhost hcid[30371]: pin_code_request
(sba=3D00:E0:03:25:53:19, dba=3D00:11:94:00:23:C0)
Aug  2 20:32:46 localhost hcid[30371]: link_key_notify
(sba=3D00:E0:03:25:53:19, dba=3D00:11:94:00:23:C0)

next I run hcitool info:

$ hcitool info 00:11:94:00:23:C0
Requesting information ...
Can't create connection: Input/output error

Next I try to browse for services (after enabling the visibility) :
$ sdptool browse
Inquiring ...
Failed to connect to SDP server on 00:11:94:00:23:C0: Protocol error

at this point I'm pretty much stuck.  under windows xp (widcomm) I'm
able to pair the device in a similar fashway, and then enable
visibility or the ogo, and windows is able to identify the following:=20
Audio Gateway, DUN, LAN-Access, OBEX Imaging and Serial Port.

once this is done in windows I'm able to double click the LAN-Access
and I get a "Connect BluetoothNullConnection" window, I can leave user
and pass blank and click connect and I have a ppp connection:
described as WAN (PPP/SLIP) Interface with a 10.10.10.x ip address. I
believe access is blocked on everything but the mail ports, so I set
up a proxy server and can then connect through the proxy to the web.

my goal is to create a similar connection from linux, but I'm unsure
how.  from the forum I referenced above, it looks like Windows,
PocketPC2003, and OSX are all able to make this connection.

if anyone has any experience with this device, or has any thoughts or
ideas to possibly get this to work, let me know, I'd greatly
appreciate it.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
