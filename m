Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Aug 2013 11:21:27 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: peter@hurleysoftware.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [PATCH v5 6/6] rfcomm: Purge the dlc->tx_queue to avoid circular
 dependency
Message-ID: <20130820092127.GA1908@joana>
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
 <1375110493-5237-7-git-send-email-gianluca@sottospazio.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375110493-5237-7-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

2013-07-29 Gianluca Anzolin <gianluca@sottospazio.it>:

> In rfcomm_tty_cleanup we purge the dlc->tx_queue which may contain
> socket buffers referencing the tty_port and thus preventing the tty_port
> destruction.
> 
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>  net/bluetooth/rfcomm/tty.c | 6 ++++++
>  1 file changed, 6 insertions(+)

all patches have been applied to bluetooth-next. Thanks.

	Gustavo
