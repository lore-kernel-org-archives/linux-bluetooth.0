Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <444018.59197.qm@web52606.mail.re2.yahoo.com>
References: <444018.59197.qm@web52606.mail.re2.yahoo.com>
Date: Fri, 23 Jul 2010 23:15:30 +0300
Message-ID: <AANLkTinA-E6v157y0DOf2gBzKykvT22vEn=9TddSvgy7@mail.gmail.com>
Subject: Re: How to past connect complete event status (page timeout) to apps
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 23, 2010 at 8:48 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> Hi,  I tried to implement my apps to do different things depend on the failed
> connection attempt.
> On Hci dump I could saw the connect complete status is different depend on the
> actual failure (e.g. 0x10 accept timeout, 0x06, PIN missing, 0x04 page
> timeout).  But the apps (base on obex-client) is not able to see those status
> code.
>   The obex-client attempt a sdp_connect and then g_io_add_watch.  On the
> callback, we could see the G_IO_ERROR but I could not figure out a way to get
> more detail on the failed condition.  I tried look into the Bluez and could not
> figure what to change to pass those connect event status up..
>    Anyone could offer some advise/hint...

Well first you will not get the same error on the socket, they will be
translated to errno but the errors will be very similar e.g: page
timeout is mapped to EHOSTDOWN.

But it seems we have a bug in obex-client, basically we need to check
SO_ERROR with getsockopt before proceeding with sdp_set_notify. If you
are fixing this please have a look at btio.c, it should be ok and it
seems ofono does it in a similar fashion:

	/* If the user aborted this connect attempt */
	if ((cond & G_IO_NVAL) || check_nval(io))
		return FALSE;

	if (cond & G_IO_OUT) {
		int err = 0, sock = g_io_channel_unix_get_fd(io);
		socklen_t len = sizeof(err);

		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
			err = errno;

		if (err)
			g_set_error(&gerr, BT_IO_ERROR,
					BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
					strerror(err), err);
	} else if (cond & (G_IO_HUP | G_IO_ERR))
		g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
				"HUP or ERR on socket");

-- 
Luiz Augusto von Dentz
Computer Engineer
