Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Aug 2013 10:41:55 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Gustavo Padovan <gustavo@padovan.org>, peter@hurleysoftware.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org, jslaby@suse.cz
Subject: Re: [PATCH v5 6/6] rfcomm: Purge the dlc->tx_queue to avoid circular
 dependency
Message-ID: <20130821084155.GA1339@sottospazio.it>
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
 <1375110493-5237-7-git-send-email-gianluca@sottospazio.it>
 <20130820092127.GA1908@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130820092127.GA1908@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 20, 2013 at 11:21:27AM +0200, Gustavo Padovan wrote:
> Hi Gianluca,
> 
> 2013-07-29 Gianluca Anzolin <gianluca@sottospazio.it>:
> 
> > In rfcomm_tty_cleanup we purge the dlc->tx_queue which may contain
> > socket buffers referencing the tty_port and thus preventing the tty_port
> > destruction.
> > 
> > Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> > ---
> >  net/bluetooth/rfcomm/tty.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> all patches have been applied to bluetooth-next. Thanks.
> 
> 	Gustavo

Hello,

Thank you!

Gianluca
