Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 106691] New: BNEP multicast filter is filtering multicast
 addresses in default case although differently specified
Date: Tue, 27 Oct 2015 11:32:01 +0000
Message-ID: <bug-106691-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=106691

            Bug ID: 106691
           Summary: BNEP multicast filter is filtering multicast addresses
                    in default case although differently specified
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.0.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: danny.schweizer@proofnet.de
        Regression: No

A Linux PC is connected with another device over Bluetooth PAN using a BNEP
interface.

Whenever a packet is tried to be sent over the BNEP interface, the function
"bnep_net_xmit()" in "net/bluetooth/bnep/netdev.c" is called. This function
calls "bnep_net_mc_filter()", which checks (if the destination address is
multicast) if the address is set in a certain multicast filter (&s->mc_filter).
If it is not, then it is not sent out.

This filter is only changed in two other functions, found in
net/bluetooth/bnep/core.c": in "bnep_ctrl_set_mc_filter()", which is only
called if a message of type "BNEP_FILTER_MULTI_ADDR_SET" is received.
Otherwise, it is set in "bnep_add_connection()", where it is set to a default
value which only adds the broadcast address to the filter:

set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);


To sum up, if the BNEP interface does not receive any message of type
"BNEP_FILTER_MULTI_ADDR_SET", it will not send out any messages with multicast
destination addresses except for broadcast.


However, in the BNEP specification (page 27 in
http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf), it is said that per
default, all multicast addresses should not be filtered, i.e. the BNEP
interface should be able to send packets with any multicast destination
address.

It seems that the default case is wrong: the multicast filter should not block
almost all multicast addresses, but should not filter out any.

This leads to the problem that e.g. Neighbor Solicitation messages sent with
Bluetooth PAN over the BNEP interface to a multicast destination address other
than broadcast are blocked and not sent out.

-- 
You are receiving this mail because:
You are the assignee for the bug.
