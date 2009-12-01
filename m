Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Dec 2009 19:00:10 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: divide by zero in termios when setting bluetooth
Message-ID: <20091201190010.317d5b29@lxorguk.ukuu.org.uk>
In-Reply-To: <20091201160151.GD2262@elf.ucw.cz>
References: <20091201151315.GC2262@elf.ucw.cz>
	<20091201155244.0523d9c9@lxorguk.ukuu.org.uk>
	<20091201160151.GD2262@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > +	/* Should never happen */
> > +	WARN_ON(1);
> >  	return 0;
> 
> Does this mean WARN_ON() on user error? Maybe printk(KERN_ERR) with
> explanation would be better?

It shouldn't be possible to cause that case user error or otherwise.
