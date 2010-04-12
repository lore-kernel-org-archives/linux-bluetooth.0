Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd-0.22 causes gnome-bluetooth sendto dialog to stop
 closing when operation ends
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: pacho@condmat1.ciencias.uniovi.es, linux-bluetooth@vger.kernel.org
In-Reply-To: <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
References: <1270898546.5646.28.camel@localhost.localdomain>
	 <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 12 Apr 2010 16:22:39 +0100
Message-ID: <1271085759.6731.6348.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2010-04-10 at 11:17 -0300, Vinicius Gomes wrote:
> Hi Pacho,
> 
> 2010/4/10 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> > Hello
> >
> > This is a regression over obexd-0.21. After updating to 0.22,
> > gnome-bluetooth sendto dialog no longer closes when operation finishes,
> > even if file is already properly sent.
> >
> 
> We noticed this regression as well. Luiz already has a fix for this,
> it was just not integrated yet.
> 
> In case you want to take a look and perhaps help test it, the fix is here[1].

Except that the patch is absolutely huge, and doesn't apply cleanly on
0.22 either.

