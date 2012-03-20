Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:34:10 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Silence sparse warning
Message-ID: <20120320083407.GC27063@aemeltch-MOBL1>
References: <1332156398-25953-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332178760.14217.213.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332178760.14217.213.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 19, 2012 at 10:39:20AM -0700, Marcel Holtmann wrote:
> > -	memcpy(&val, &uuid128[12], 4);
> > +	memcpy(&tmp, &uuid128[12], 4);
> >  
> > -	val = le32_to_cpu(val);
> > +	val = le32_to_cpu(tmp);
> 
> why aren't we using get_unaligned_le32?

You are right here, just sent new version.

Best regards 
Andrei Emeltchenko 
