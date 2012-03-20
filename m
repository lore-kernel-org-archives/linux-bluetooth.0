Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 18:24:01 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Silence sparse warning
Message-ID: <20120320162400.GJ27063@aemeltch-MOBL1>
References: <1332259694-9199-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332260307.1870.21.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332260307.1870.21.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 20, 2012 at 09:18:27AM -0700, Marcel Holtmann wrote:
> >  
> > -	memcpy(&val, &uuid128[12], 4);
> > -
> > -	val = le32_to_cpu(val);
> > +	val = get_unaligned_le32(uuid128 + 12);
> >  	if (val > 0xffff)
> >  		return 0;
> >  
> 
> since Gustavo already applied this patch, don't bother ;)

It was not pushed when I sent updated version.

Best regards 
Andrei Emeltchenko 

