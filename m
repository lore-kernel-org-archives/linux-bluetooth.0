Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <89B53B23AEC845998BA7BD97586A5556@sisodomain.com>
References: <1331189303-6734-1-git-send-email-jaganath.k@samsung.com>
	<20120308234250.GB15265@x220.amr.corp.intel.com>
	<22D13068A6CE4724BFD60D3D46B5FD11@sisodomain.com>
	<20120309130804.GA31252@x220.spectrum.wifi>
	<89B53B23AEC845998BA7BD97586A5556@sisodomain.com>
Date: Fri, 16 Mar 2012 16:31:58 +0200
Message-ID: <CABBYNZLibp5+LE3ESgrn4Woj+eOx=f0y-FvZq0Xw-F7T8sSE5g@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] gobex: flush tx_queue before disconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 12, 2012 at 7:42 AM, Jaganath <jaganath.k@samsung.com> wrote:
> I have already sent a patch which wait for abort response before
> disconnection.
> Subject:  [PATCH obexd] client: Fix ABORT command not sending when user
> cancels the transfer.
> Please review it and let me know your comments

Afaik it didn't invalidate the transfer id thus the callback and
user_data are still reachable so you might need to check again, also
it should no longer be possible to cancel using the same id too.

My proposal was actually to add g_obex_flush/g_obex_shutdown which can
be used similarly to g_io_channel_shutdown, although for this specific
problem it may not be the best solution due to stacks breaking if the
transport is disconnected while responding, in case of SRM there maybe
no response to wait and several packet are queued waiting POLL_OUT
while the application wants to disconnect.

Btw I don't think calling write_data will block since the io channel
should be non-blocking so we could have the same behavior as
g_io_channel_shutdown and return G_IO_STATUS_AGAIN if the packets
could not be flushed.

-- 
Luiz Augusto von Dentz
