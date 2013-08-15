Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Aug 2013 10:08:13 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix getting SCO socket options in deferred
 state
Message-ID: <20130815080813.GB1980@joana>
References: <1375962836-3050-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375962836-3050-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2013-08-08 14:53:56 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When a socket is in deferred state there does actually exist an
> underlying connection even though the connection state is not yet
> BT_CONNECTED. In the deferred state it should therefore be allowed to
> get socket options that usually depend on a connection, such as
> SCO_OPTIONS and SCO_CONNINFO.
> 
> This patch fixes the behavior of some user space code that behaves as
> follows without it:
> 
> $ sudo tools/btiotest -i 00:1B:DC:xx:xx:xx -d -s
> accept=2 reject=-1 discon=-1 defer=1 sec=0 update_sec=0 prio=0 voice=0x0000
> Listening for SCO connections
> bt_io_get(OPT_DEST): getsockopt(SCO_OPTIONS): Transport endpoint is not connected (107)
> Accepting connection
> Successfully connected to 60:D8:19:xx:xx:xx. handle=43, class=000000
> 
> The conditions that the patch updates the if-statements to is taken from
> similar code in l2cap_sock.c which correctly handles the deferred state.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/sco.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
