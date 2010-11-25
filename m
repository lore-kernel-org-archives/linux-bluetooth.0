Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 25 Nov 2010 16:16:14 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	andrei.emeltchenko@nokia.com
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
Message-ID: <20101125181614.GA25686@vigoh>
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

* Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-11-25 12:55:33 +0300]:

> This patch is an addition to my previous patch for this issue.
> The problem is in resynchronization between two loops:
> 1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
> l2cap_config_rsp, l2cap_disconnect_req, etc.)
> 2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
> bt_accept_dequeue, etc.).
> In case of fast sequence of connect/disconnect operations the loop #1
> makes several cycles, while the loop #2 only has time to make one
> cycle and it results crash.

What is the crash point? Can you provide a log?

-- 
Gustavo F. Padovan
http://profusion.mobi
