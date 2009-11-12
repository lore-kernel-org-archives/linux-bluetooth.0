Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: fix memory leak in fixed btusb_close
Date: Thu, 12 Nov 2009 23:13:30 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
References: <200911121652.31850.oliver@neukum.org>
In-Reply-To: <200911121652.31850.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911122313.31045.rjw@sisk.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 12 November 2009, Oliver Neukum wrote:
> If the waker is killed before it can replay outstanding URBs,
> these URBs won't be freed or will be replayed at the next open.
> This patch closes the window by explicitely discarding outstanding
> URBs.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> Rafael, could you test this just to make sure? I don't want to screw
> up the same driver twice.

It doesn't appear to kill the box right away and I have no traces of failure
in the logs after several consecutive suspend-resume cycles.

Thanks,
Rafael
