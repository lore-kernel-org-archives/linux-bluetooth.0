Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: steven.singer@csr.com
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] AUX1 packets
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F9yDAGmbSTM5TP00003ee1@hotmail.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 01 Mar 2004 09:02:36 -0800

I am doing research on quality of service and fault tolerance in distributed 
systems,
and what I am working on is a configurable middleware with QoS 
(MicroQoSCORBA).
Currently I am researching meaningful QoS mechanisms for wireless 
transports, and right
now I am focusing on Bluetooth.

Middleware is supposed to mask all these things for the user (application 
designer),
including the different mechanisms for getting Bluetooth or whatever 
wireless or wired
transport to achieve the QoS that he/she expects.

So I am doing a lot of tests by playing around with the things you can do to 
make a BT connection
behave differently, to define a QoS space. In other wireless transports 
there are other switches
to play with. I am not necessarily looking to prove that a certain thing 
works, but also to prove
it doesn't.

What I wanted to do was let the middleware decide on the packet types for 
Bluetooth,
and since the same logic will be at both ends, both transports will choose 
the same packet
type as the link quality changes. Which makes sense since the time between a 
request is
sent from a client to a reply is sent from a server could be enough to have 
a decent change
in link quality.

Bringing me to the next question:

If I issue create_connection with a DH5 packet, the LM knows it can use DH5 
and DM1.
If I later issue change_conn_packet_type with DH3, is the LM allowed to 
switch to
DH5 behind my back if it wants to? Or is there a stored bit pattern in the 
LM of the
packet types that I allow that gets overwritten completely with the pattern 
in change_conn_pt?

I understand that the more meaningful thing to do is allowing all DH and DM 
packets, and let
the LM decide.

Thor

_________________________________________________________________
Click, drag and drop. My MSN is the simple way to design your homepage. 
http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
