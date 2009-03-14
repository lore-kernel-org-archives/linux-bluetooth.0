Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Mar 2009 10:29:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Broken SDP parsing?
Message-ID: <20090314132926.GA17305@jh-x301>
References: <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com> <1236608040.16880.1580.camel@cookie.hadess.net> <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com> <1236612318.16880.1656.camel@cookie.hadess.net> <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com> <1236618579.32264.23.camel@cookie.hadess.net> <20090309174644.GA4340@jh-x301> <1236958673.32264.5799.camel@cookie.hadess.net> <20090313181533.GA12975@jh-x301> <1236991168.32264.6353.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1236991168.32264.6353.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Mar 14, 2009, Bastien Nocera wrote:
> > Thanks. I had to fix the following warning in the cups patch, but
> > otherwise they were fine:
> > main.c: In function ‘device_get_ieee1284_id’:
> > main.c:129: error: ‘id’ may be used uninitialized in this function
> 
> I didn't see this. Must be my gcc being low on warnings.

Yeah, you'll need to compile with --disable-debug to get the full list
of warnings since the optimization level seems to affect them.

> I did notice a "return FALSE" in device_get_ieee1284_id(), when it
> should be a "return NULL" though. Could you get that pushed?

Done.

Johan
