Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Giannis Georgalis <jgeorgal@uoc.gr>
Reply-To: jgeorgal@uoc.gr
Message-ID: <874qzf3sav.fsf@hciat-16.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] command tx timeout and continuous inquiry.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 15 Sep 2003 01:43:04 +0300


Hello,

I have a thread doing an hci_inquiry() all the time, while at the same
time another thread is talking to other bluetooth devices via l2cap
connections. Additionally, I do an IREQ_CACHE_FLUSH every 20 - 30
seconds.

This whole scheme works fine most of the time, but as the time passes
I get a lot of:

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 36:55:05:02:90:00
hci_cmd_task: hci0 command tx timeout

and the hci_inquiry() fails with errno set to "Device or resource
busy".

Additionaly, there are times that hci_inquiry() cannot discover the
other bt devices (all running bluez). And even sometimes an l2cap
connection cannot be established.

Note that I'm using a 3COM (3CREB96) usb bluetooth device, a vanilla
2.4.22 kernel and libbluetooth 2.4-1 (debian unstable).

Firstly, I want to ask whether this behavior should be "expected" in
an environment that makes "heavy" use of the bluetooth resources. In
any case, how can this effect be minimized ? Any hints/pointers are
highly appreciated.

Secondly, I want to ask what the optimal call frequency (and
arguments) of hci_inquiry() should be in order to obtain "consistent"
results from it, when it is used in a while (1) {} loop.

Thank you,
Giannis

-- 
question = ( to ) ? be : ! be;
                -- Wm. Shakespeare



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
