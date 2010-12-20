Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Dec 2010 10:16:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix memory leak in src/rfkill.c
Message-ID: <20101220081622.GA3002@jh-x301>
References: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 20, 2010, Anderson Lizardo wrote:
> Watches must be removed with g_source_remove() otherwise they leak a
> reference count to the GIOChannel and internal memory allocations.
> 
> Also g_io_channel_set_close_on_unref() is used, so there is no need to
> call g_io_channel_shutdown() by hand.

You do realize that the watch gets freed and removed from the main
context when the callback function returns FALSE, right? The only case
for all of these patches where you'd have unfreed memory is when you
stop iterating the mainloop while still having the sockets open (or even
if you close them during the very last iteration), i.e. when bluetoothd
is exiting. Is that the problem you're trying to fix here, i.e. getting
rid of unnecessary "noise" in the valgrind leak report?

Johan
