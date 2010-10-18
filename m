Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 18 Oct 2010 04:06:25 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/3] bluetooth: Enable USB autosuspend by default on
 btusb
Message-ID: <20101018060625.GA5217@vigoh>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
 <1284659895-27984-3-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284659895-27984-3-git-send-email-mjg@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

* Matthew Garrett <mjg@redhat.com> [2010-09-16 13:58:15 -0400]:

> We've done this for a while in Fedora without any obvious problems other
> than some interaction with input devices. Those should be fixed now, so
> let's try this in mainline.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/bluetooth/btusb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Patch has been applied, thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
