Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 13:47:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 3/8] Bluetooth: Unwind l2cap_sock_shutdown()
Message-ID: <20150714104756.GA13886@t440s.lan>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com>
 <20150713110731.GA21598@t440s.lan>
 <55A3F5F8.4070800@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A3F5F8.4070800@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Mon, Jul 13, 2015, Dean Jenkins wrote:
> The use of the
> 
> mutex_lock(&conn->chan_lock)
> 
> is troublesome because the underlying conn connection can disappear whilst
> waiting for acks, that is why I eliminated the conn variable and used
> chan->state instead. Is there an atomic method to check conn and take the
> lock ?

There might be some more elegant way to solve this whole issue (maybe
with RCU helpers or something like that), but at least the following
could work, I think:

static struct l2cap_conn *lock_conn(struct l2cap_chan *chan)
{
	struct l2cap_conn *conn;

	l2cap_chan_lock(chan);

	if (chan->conn)
		conn = l2cap_conn_get(chan->conn);
	else
		conn = NULL;

	l2cap_chan_unlock(chan);

	if (conn)
		mutex_lock(&conn->chan_lock);

	return conn;
}

static void unlock_conn(struct l2cap_conn *conn)
{
	if (conn) {
		mutex_unlock(&conn->chan_lock);
		l2cap_conn_put(conn);
	}
}

{
	...

	conn = lock_conn(chan);
	l2cap_chan_lock(chan);

	l2cap_chan_close(chan, 0);

	l2cap_chan_unlock(chan);
	unlock_conn(conn);

	...
}

Johan
