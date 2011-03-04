Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Mar 2011 23:17:39 +0530
Message-ID: <AANLkTik+X9VBwJ_W=SbGTncGe2Teu03yh4=7QkCGYcL_@mail.gmail.com>
Subject: hci_conn_timeout
From: Koustuv Ghosh <koustuvg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ,

I am using vcgomes kernel for LE .

I observed two thing...

once I  issue LE connect via gatttool  from my host  , after 2 or 3s I
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
