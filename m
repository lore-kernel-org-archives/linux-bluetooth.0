Return-Path: <cyrus@holtmann.org>
Subject: Re: Deadlock in bluetooth/sco.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Kucera <xatrix101@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ef67228d0905031346q740aa88es5203a64a151de2e@mail.gmail.com>
References: <ef67228d0905031346q740aa88es5203a64a151de2e@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 03 May 2009 18:17:15 -0700
Message-Id: <1241399835.2899.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jan,

> I've found some possible deadlock in net/bluetooth/sco.c - version
> 2.6.28 (probably this code is in newer versions too).
> Could someone confirm this? Thank you.
> 
> 
> net/bluetooth/sco.c
> ==============
> 
> function sco_conn_ready: (conn <- sk)
> -------------------------------------
> lockig sco_conn_lock(conn) at line 796
> bh_lock_sock(sk)  at line 800
> 
> function  sco_conn_del: (sk <- conn)
> ---------------------------------
> bh_lock_sock(sk); at 154
> calling function sco_chan_del(sk, err); at line 156
>        where at line 767 is sco_conn_lock(conn);

can you please re-test with the bluetooth-testing.git tree so we can
verify that this issue still exists.

Regards

Marcel


