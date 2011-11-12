Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 08:28:16 +0900
In-Reply-To: <CAOazyz3PxrYfXXy4Weh68Vkz7Atp3nUFG14ufivcFrQJH65p5Q@mail.gmail.com>
References: <CAOazyz26ywy+OWMCbL6JMdEd3zt9Ui8XTAWVXtLLRj_wKq+Uvw@mail.gmail.com>
	 <1321139715.15441.438.camel@aeonflux>
	 <CAOazyz3PxrYfXXy4Weh68Vkz7Atp3nUFG14ufivcFrQJH65p5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321140499.15441.441.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon,

> >> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> >
> > please no Signed-off-by lines, we are not using them for the userspace
> > parts.
> 
> I did not think it damage anything...

our policy is to NOT use Signed-off-by. That simple.

> > And also please send patches inline and via attachments.
> 
> This would be difficult, as gmail does not allow no wrapping.
> git accepts this correctly, I use:
> 
> $ curl article.gmane.org/gmane.linux.bluez.kernel/18337/raw | git am
> 
> If this is really important I will try to find some other mail client.

This is not about being able to apply it, this is about being able to
review it properly and give inline comments.

Also just use git send-email. Works perfectly fine.

Regards

Marcel


