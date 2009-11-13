Return-Path: <cyrus@holtmann.org>
Subject: Re: fix memory leak in fixed btusb_close
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-bluetooth@vger.kernel.org
In-Reply-To: <200911121652.31850.oliver@neukum.org>
References: <200911121652.31850.oliver@neukum.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Nov 2009 04:08:20 +0100
Message-ID: <1258081700.7715.1.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> If the waker is killed before it can replay outstanding URBs,
> these URBs won't be freed or will be replayed at the next open.
> This patch closes the window by explicitely discarding outstanding
> URBs.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> Rafael, could you test this just to make sure? I don't want to screw
> up the same driver twice.

Feel free to send this directly to Linus for inclusion.

Regards

Marcel


