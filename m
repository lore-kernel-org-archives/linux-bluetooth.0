Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Suresh Srinivasan <sspriniv@engr.smu.edu>
To: bluez-users@lists.sf.net
Message-ID: <Pine.OSF.4.10.10406121321460.6753-100000@speed.seas.smu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Broadcasting in Bluetooth
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
Date: Sat, 12 Jun 2004 13:28:36 -0500 (CDT)


Dear Maxim Krasnyansky,
                        Iam suresh srinivasan, doing my masters in computer
science at SMU. Iam currently looking at broadcasting in a bluetooth piconet.
>From my understanding from the bluetooth protocol stack is that broadcast
is not supported as of now. Iam trying do the following to broadcast a packet in the bluetooth
piconet:

1) Creating a connection(ACL) to all the slaves.
2) In function "HCI_ACL_SEND" the parameter "flag" in the function
hci_add_acl_hdr(skb,conn->handle,flags|ACL_START) is modified to flags|ACL_ACTIVE_BCAST".
Can i broadcast with the above changes? or do i ned some more changes?
Please, give me your valueable sugestions? please, guide me if iam in
the wrong direction.Eagerly waiting for your response,

Thanking you,
Warm regards,
suresh




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
