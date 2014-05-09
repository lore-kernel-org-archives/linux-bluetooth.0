Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 15:31:42 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH BlueZ 4/5] plugins/sixaxis: add a get_leds_data()
 function
Message-Id: <20140509153142.100490c1aebbe09021be229c@ao2.it>
In-Reply-To: <20140509122232.GB4436@t440s.lan>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
	<1399370776-5027-5-git-send-email-ao2@ao2.it>
	<20140509122232.GB4436@t440s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 9 May 2014 15:22:32 +0300
Johan Hedberg <johan.hedberg@gmail.com> wrote:

> Hi Antonio,
> 
[...] 
> >  
> > -	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> > +	if (data == NULL)
> >  		return FALSE;
> >  
> > -	DBG("number %d", number);
> > +	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> > +		goto out;
> >  
> >  	fd = g_io_channel_unix_get_fd(channel);
> >  
> > -	if (calc_leds_bitmap(number, &bitmap))
> > -		set_leds_hidraw(fd, bitmap);
> > +	set_leds_hidraw(fd, data->bitmap);
> > +
> > +out:
> > +	for (i = 0; i < 4; i++)
> > +		free(data->syspaths[i]);
> > +	free(data);
> >  
> >  	return FALSE;
> >  }
> 
> I don't see you using the "int ret" anywhere in this function. Even if
> you do end up using it later for returning something I suppose it should
> be a boolean type and not int. However even then the variable should be
> introduced in the patch that actually makes use of it. If you build test
> each patch individually with --enable-maintainer-mode the compiler
> should warn about unused variables (amongst many other things) for you.
>

Thanks Johan, I forgot about --enable-maintainer-mode.

I'll use it for the v2.

Ciao ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
