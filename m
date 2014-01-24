Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jan 2014 23:57:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib: Fix crash if g_attrib_new() fails
Message-ID: <20140124215704.GA15197@x220.p-661hnu-f1>
References: <1390593469-18511-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390593469-18511-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 24, 2014, Anderson Lizardo wrote:
> If g_attrib_new() fails for some reason (e.g. bt_io_get() fails), it
> will return NULL.
> 
> Crash reported by Valgrind:
> 
> ==2845== Invalid read of size 4
> ==2845==    at 0x40C6CC4: g_io_channel_unix_get_fd (giounix.c:655)
> ==2845==  Address 0x3c is not stack'd, malloc'd or (recently) free'd
> ---
>  src/attrib-server.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
