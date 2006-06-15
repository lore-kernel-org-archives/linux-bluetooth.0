Return-Path: <philipl@mail.utexas.edu>
Message-ID: <4490C0F1.1090704@mail.utexas.edu>
Date: Wed, 14 Jun 2006 19:07:45 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: Latest 2.6.16-mh1 patch.
References: <44867199.2000409@mail.utexas.edu>	 <1149664531.22472.4.camel@localhost>  <4486EE2D.3010507@mail.utexas.edu>	 <1149714318.22472.59.camel@localhost>  <4487B00F.7070204@mail.utexas.edu>	 <1149803817.4219.61.camel@localhost>  <448A4385.4020809@mail.utexas.edu> <1149986039.5358.25.camel@aeonflux.holtmann.net>
In-Reply-To: <1149986039.5358.25.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Philip,
> 
>>> okay. I released patch-2.6.16-mh2 with doesn't contain the automatic
>>> sniff mode feature anymore. Please check if your mouse is now working as
>>> expected. 
>> Yep, that did the trick, but I hope you can get the two to play well
>> together.

Marcel,

I've been working with mh3 over the last couple of days and have
noticed another regression. The mouse no longer auto-reconnects
after being turned off and on or after it auto-disconnects due
to a timeout.

This didn't happen with mh2.

--phil
