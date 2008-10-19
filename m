Return-Path: <cyrus@holtmann.org>
Subject: Re: Add application header support to gwobex
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <D94DFDBF-DAB1-4343-96F0-FFBA05A58373@gmail.com>
References: <1224404909.9386.29.camel@californication>
	 <D94DFDBF-DAB1-4343-96F0-FFBA05A58373@gmail.com>
Content-Type: text/plain
Date: Sun, 19 Oct 2008 19:00:44 +0200
Message-Id: <1224435644.9386.33.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > for the PBAP support, we need to handle the application header and for
> > our client/test applications, I extended gwobex to allow us to specify
> > this header. What do you think?
> 
> Looks good to me, though the parameter lists to the _get and_put  
> functions are starting to grow pretty long. In general it'd be nice to  
> get the same functionality into libopenobex-glib soonish since I'm not  
> particularly enjoying looking at this ancient code and coding style  
> that should just die away ;)

I agree on that one, but currently it is more important to get this
functionality working and then later we can do the cleanups. Main
problem with libopenobex-glib at the moment is that I based it around
GObject which does make sense for GTK+ programs, but will not make sense
for obex-client. So parts of gwobex might be still living a long life.

After actually working with the PBAP details, I realized that besides
giving the application parameters in the command, so we do have another
pair of buf+size for the response.

Regards

Marcel


