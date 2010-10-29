Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Fix NULL pointer dereference issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: davem@davemloft.net, padovan@profusion.mobi,
	jprvita@profusion.mobi, linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com, andrei.emeltchenko@nokia.com
In-Reply-To: <456b20879a6fc3e434463389ef25c4d5cf8803d4.1288262806.git.ext-yuri.ershov@nokia.com>
References: <456b20879a6fc3e434463389ef25c4d5cf8803d4.1288262806.git.ext-yuri.ershov@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Oct 2010 23:43:29 +0200
Message-ID: <1288388609.3322.40.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

> This patch fixes NULL pointer dereference at running test with
> connect-transfer-disconnect in loop. The problem conditions are the
> following: there are 2 BT devices. The first one listens and
> receives (l2test -r), the second one makes "connect-disconnect-
> connect..." sequence (l2test -c -b 1000 -i hci0 -P 10 <addr>).
> After some time this will cause the race between functions
> bt_accept_dequeue and l2cap_chan_del. The function l2cap_chan_del
> sets the socket state to BT_CLOSED, unlinks and kills the socket
> in the middle of bt_accept_dequeue, then at running the removed code
> kernel oops appears.

it could be that we have this in here for RFCOMM. Can you retest it with
this with using RFCOMM and see if we get dangling RFCOMM sockets. You
need to test both directions, incoming and outgoing.

Regards

Marcel


