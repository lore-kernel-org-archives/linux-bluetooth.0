Return-Path: <EXT-Somil.Asthana@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [Bluez-users] DB aliases (wishlist)
Date: Tue, 15 Apr 2003 10:40:13 -0400
Message-ID: <E320A8529CF07E4C967ECC2F380B0CF901403777@bsebe001.americas.nokia.com>
From: <EXT-Somil.Asthana@nokia.com>
To: <marcel@rvs.uni-bielefeld.de>
Cc: <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel=20
  I am still not able to get feature of keeping remote list of devices. I w=
ent through the email thread but could nt get much (unless its something re=
lated to rfcomm) . Since bluetooth is for adhoc scenarios remote devices wi=
ll come and go. The list of remote devices can never be accurate at any giv=
en time. Of course its possible to run a process whose sole purpose is to u=
pdate this device list file. May be I am nt able to understand big picture =
because you agree that this approach , having a separate process, has a maj=
or flaw -- devices will only do inq & paging & page scanning no useful work=
 . I am nt sure how can be develop this feature. Actually I need something =
like this feature. Each devices know about the other devices in the piconet=
  atleast their names so I can run m-DNS over it and make connections on IP=
 what ever.

I have few more doubts may be this is good time to get cleared. I have two =
separate piconet which are using different pins which means different link =
key now I want to join them ,scatternet. suppose A-->B master A of piconet =
A conn to master B of piconet B. A has /bin/bluepin (echo PIN:XXXX) which i=
s pin of B piconet  and during the connection after PIN exchange link key w=
ill be generated & stored as /etc/bluetooth/link_key (hope you are with me)=
. So at A I believe there should be two link_key one for its own piconet an=
d one for being a part of B's piconet. But this doesnt seems to work. I cou=
ldnt connect A-->B ;I got weird errors on hcidump A : No Connection and on =
B : LMP PDU not allowed. I went and deleted link_key on A & gave a shot aga=
in it works fine. Sometimes with iPAQs I have to delete link_key file (beca=
use they become stale ??). Have you tested these scenarios ...

When I do ps I see kbnepd bnep0 etc which is some kind of daemon running on=
 it but I never got the code where is kbnep implemented. The reason why I w=
ant to know this because I want to distinguish two cases. Disconnection don=
e by devices explicitly and Disconnection occurred because device got out o=
f range.

regards
Somil  =20

-----Original Message-----
From: ext Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]
Sent: Thursday, April 10, 2003 10:33 AM
To: Asthana Somil (EXT-NRC/Boston)
Cc: Max Krasnyansky; tomi@virago.in-chemnitz.de; BlueZMailing List
Subject: RE: [Bluez-users] DB aliases (wishlist)


Hi Somil,

>   Just a thought !! Do you really think this is necessary feature because=
 I added a simple cmd in hcitool -i hciX lname <local_name> which calls iss=
ues HCI_CMD to write local name. It was nothing more than cut & paste from =
hcid/main.c file which writes local name...

we don't need this, because you can use

	hciconfig hci0 name <local-name>

and I don't see what this have to do with the mail from Paul. Such an
aliases, hosts or devices file is for the remote devices, not the local
ones.

Regards

Marcel
