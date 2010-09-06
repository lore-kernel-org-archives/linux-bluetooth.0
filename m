Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Make the path to oui.txt a compile-time option
From: Bastien Nocera <hadess@hadess.net>
To: pacho@condmat1.ciencias.uniovi.es
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1283785976.28657.1.camel@localhost.localdomain>
References: <1283784432.7529.24.camel@localhost.localdomain>
	 <1283785976.28657.1.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 06 Sep 2010 16:15:14 +0100
Message-ID: <1283786114.7529.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-09-06 at 17:12 +0200, Pacho Ramos wrote:
> El lun, 06-09-2010 a las 15:47 +0100, Bastien Nocera escribió:
> > Heya,
> > 
> > We've been carrying a similar (but hard-coded) patch in Fedora for a
> > long while, and it would be nice if we could do this properly upstream
> > instead.
> > 
> > Patch attached with explanations.
> > 
> > Cheers
> 
> What is the proper package to ship oui.txt file? Thanks a lot for the
> information :-)

No idea. In Fedora we ship it in hwdata. No idea where it lives for
Debian-based distributions, or others.

