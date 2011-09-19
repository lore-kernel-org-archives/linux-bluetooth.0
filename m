Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH BlueZ] Fix batostr(): return the bdaddr in the right
 order
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Sep 2011 13:14:09 +0200
In-Reply-To: <20110919130200.93d5e77df3bae3f35949c34c@studenti.unina.it>
References: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
	 <1316022826.1937.44.camel@aeonflux>
	 <20110914210812.2f33e1ad702e5727b5256bd0@studenti.unina.it>
	 <20110919130200.93d5e77df3bae3f35949c34c@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316430850.1937.57.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

> > > > lib/bluetooth.c::batostr() is returning the bdaddr reversed, fix this
> > > > and put more arguments on the same line to look more like ba2str().
> > > 
> > > this would be breaking existing API. So NAK.
> > > 
> > 
> > OK, but it is still weird that batostr() and ba2str() work differently.
> > batostr() has no in-tree user AFAICS, just FYI.
> > 
> 
> Would a batostr_bis() which behaves more like ba2str() wrt. bdaddr
> ordering be accepted, or do I just duplicate the code in my function?

just simply use ba2str. With batostr you have potential side effects
with the lifetime of the return memory anyway. That is also the reason
why none of the official BlueZ utilities or the daemon uses it.

Regards

Marcel


