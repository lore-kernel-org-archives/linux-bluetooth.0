Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40437D65.9050004@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Thor Egil Skaug <paxtonrd@hotmail.com>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] AUX1 packets
References: <BAY1-F9yDAGmbSTM5TP00003ee1@hotmail.com>
In-Reply-To: <BAY1-F9yDAGmbSTM5TP00003ee1@hotmail.com>
Content-Type: text/plain; charset="us-ascii"
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
Date: Mon, 01 Mar 2004 18:13:57 +0000

Thor Egil Skaug wrote:
> Middleware is supposed to mask all these things for the user (application designer),
> including the different mechanisms for getting Bluetooth or whatever wireless or wired
> transport to achieve the QoS that he/she expects.

If you want to mask it from the user then just let the controller do
the right thing. It has much more direct control than you do. It will
continuously be trying to optimise link.

It's not clear to me how knowing the QoS settings for link will alter
what settings are best for the link, so it's not clear to me what your
middleware brings to the situation.

Rather than concentrating on packet types, there are more useful things
the middleware can be doing - such as working out what are the optimum
number of ACL tokens to use for each link to avoid having so few
associated with a given link that the link starves and yet to avoid
having so many that if the link stalls (for example, because the two
devices are out of range) then there are insufficient to keep the other
links running.

> What I wanted to do was let the middleware decide on the packet types for Bluetooth,
> and since the same logic will be at both ends, both transports will choose the same packet
> type as the link quality changes. Which makes sense since the time between a request is
> sent from a client to a reply is sent from a server could be enough to have a decent change
> in link quality.

No.

The link quality is not symmetric. It's perfectly possible to have a
clear link in one direction and a noisy return link. For example, if
one end were near an interferer (such as the not unlikely scenario of
having an 802.11b card in the same PC one of the Bluetooth devices).

If we call the Bluetooth transmit power P_B dBm, the interferer power
P_I dBm and the link loss L dB, then at the end far from the interferer,
the Bluetooth power is P_B - L dBm and the interferer power is P_I - L dBm
so the signal to interferer ratio is (P_B - L) - (P_I - L) = P_B - P_I dB.
However, at the end near the interferer, the received Bluetooth power
is P_B - L dBm, but the received interferer power is P_I, so the signal
to interferer ratio is P_B - P_I - L dB. It would be easy to have a
signal to noise ratio at the far end of +20 dB (virtually every packet
received cleanly) and simultaneously for the near end to be at -20 dB
(virtually every packet lost while the interferer is on).

Then, to make matters worse, you can measure only the *received* bit
error rate, yet you can alter only the *transmitted* packet types. In
the scenario above, the far end will be receiving a low bit error rate
and, by your algorithm, be transmitting DH packets, yet the near end
will be receiving a high bit error rate and be transmitting DM packets.

This type of link control doesn't work unless you can communcate the
information to the other side in real time which, funnily enough, is
exactly what the standard Bluetooth CQDDR system will do.

You're trying to reinvent the wheel badly.

> If I issue create_connection with a DH5 packet, the LM knows it can use DH5  and DM1.
> If I later issue change_conn_packet_type with DH3, is the LM allowed to switch to
> DH5 behind my back if it wants to?

It's not allowed to do that - it's allowed to use only the packets in
the last command it received.

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
