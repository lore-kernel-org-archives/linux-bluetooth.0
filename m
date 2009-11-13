Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: fix memory leak in fixed btusb_close
Date: Fri, 13 Nov 2009 10:53:38 +0100
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
 linux-bluetooth@vger.kernel.org
References: <200911121652.31850.oliver@neukum.org> <1258081700.7715.1.camel@violet>
In-Reply-To: <1258081700.7715.1.camel@violet>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911131053.38152.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag, 13. November 2009 04:08:20 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > If the waker is killed before it can replay outstanding URBs,
> > these URBs won't be freed or will be replayed at the next open.
> > This patch closes the window by explicitely discarding outstanding
> > URBs.
> >
> > Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> > Rafael, could you test this just to make sure? I don't want to screw
> > up the same driver twice.
> 
> Feel free to send this directly to Linus for inclusion.

This late in the RCs?

	Regards
		Oliver
