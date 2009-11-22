Return-Path: <cyrus@holtmann.org>
Message-ID: <4B0968F9.6050807@sezampro.rs>
Date: Sun, 22 Nov 2009 16:38:17 +0000
From: Aleksandar Radovanovic <biblbroks@sezampro.rs>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: struct hci_conn leaked on 2.6.31.6
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I noticed recently that my "size-512" slab cache is constantly growing
on a machine with a lot of Bluetooth activity. kmemleak points to struct
hci_conn allocation in hci_conn_add().

After examining the code I found out that, on a successful connection
attempt, the connection is registered with sysfs and that sysfs code is
responsible for freeing struct hci_conn once sysfs device is released.
However, on an unsuccessful connection attempt (connection complete
event returns with a non-zero status in hci_conn_complete_evt()), the
connection is never registered with sysfs in the first place, so it
never gets unregistered and struct hci_conn is subsequently leaked.

This leak can be reliably reproduced by trying to page a dummy BDADDR,
e.g. with something like

while true
do
    hcitool cc 11:22:33:44:55:66
done

and watching the "size-512" slab cache grow.

I instrumented the code with printk's to confirm that del_conn() is
never queued and executed in this case. I tested this on 2.6.31.5 and
2.6.31.6, on arm and x86 with same results.

IMHO, there are two problems here:

First, conn->devref counting is wrong, it is initialized to zero and
only incremented once a successful connection complete event arrives.
But any hci_conn_del() will decrement it, (whether from a failed
connection complete event or maybe for some other reason) - in this case
below 0, so del_conn() never gets queued for execution.

Second, del_conn() never calls put_device(&conn->dev) if the connection
has not been actually added to the sysfs tree - which, in this case, it
isn't.

I've created a simple patch that fixes these problems, which follows.

Cheers,
Aleksandar


