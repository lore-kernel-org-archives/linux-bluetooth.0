Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Jan Kucera <xatrix101@gmail.com>
Date: Sun, 3 May 2009 22:46:48 +0200
Message-ID: <ef67228d0905031346q740aa88es5203a64a151de2e@mail.gmail.com>
Subject: Deadlock in bluetooth/sco.c
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've found some possible deadlock in net/bluetooth/sco.c - version
2.6.28 (probably this code is in newer versions too).
Could someone confirm this? Thank you.


net/bluetooth/sco.c
==============

function sco_conn_ready: (conn <- sk)
-------------------------------------
lockig sco_conn_lock(conn) at line 796
bh_lock_sock(sk)  at line 800

function  sco_conn_del: (sk <- conn)
---------------------------------
bh_lock_sock(sk); at 154
calling function sco_chan_del(sk, err); at line 156
       where at line 767 is sco_conn_lock(conn);



caught by Stanse
http://iti.fi.muni.cz/stanse/
