Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Oct 2010 11:48:55 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Peculiar stuff in hci_ath3k/badness in hci_uart
Message-ID: <20101008114855.7dfd255d@lxorguk.ukuu.org.uk>
In-Reply-To: <4CAEE1DB.1070202@Atheros.com>
References: <20101007214134.6bcd2e8f@lxorguk.ukuu.org.uk>
	<4CAEE1DB.1070202@Atheros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 8 Oct 2010 14:48:19 +0530
Suraj Sumangala <suraj@Atheros.com> wrote:

> Hi Alan,
> 
> On 10/8/2010 2:11 AM, Alan Cox wrote:
> > Noticed this while looking at Savoy's stuff
> >
> >
> > ath_wakeup_ar3k:
> >
> >         int status = tty->driver->ops->tiocmget(tty, NULL);
> >
> I agree, it will be a problem if the underlying driver try to access the 
> "struct file". Is there any other way I can get the MCR status here 
> without providing user space pointer?

Currently no - that should get fixed in the tty layer and I will look
into it end of next week as a priority.

Alan
