Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 5 Mar 2011 13:04:45 +0530
Message-ID: <AANLkTik9H33kmgZSZ6+_uVONq0tMa4XcM5O9W9xNXrxW@mail.gmail.com>
Subject: hci_conn_timeout
From: Koustuv Ghosh <koustuvg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Koustuv Ghosh <koustuvg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ,

I am using vcgomes kernel for LE .

I observed two thing...

once I  issue LE connect via gatttool(bluez-4.88)  from my host  ,
after 2 or 3s I
am geeting a hci_conn_timeout, which causes existing  LE connection
disconnected.

So I noticed there is a hci_conn_hold(conn) which I feel basically
deactivate  the timer, and as a work around   I introduced it in
hci_le_conn_complete_evt ,and  after that  disconnect time out does
not occur.

But then if I am trying to connect remote device  via gatttool with
same parameter  twice , system hangs.

Any help...

rgds
Koustuv
