Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/2] Regression fixes for rfcomm/tty.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
Date: Mon, 6 Jan 2014 09:35:18 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Message-Id: <D4D6DA93-0C44-4F35-AD45-9EDE4775B052@holtmann.org>
References: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

> The following two patches fix a couple of regressions introduced with
> the rfcomm tty_port conversion.
> 
> The first patch restores the expected behaviour of the rfcomm port when
> it's created with the flag RFCOMM_RELEASE_ONHUP.
> 
> The second patch fixes a bug that affect userspace (ModemManager) when
> the port is created with the flag RFCOMM_REUSE_DLC.
> 
> Gianluca Anzolin (2):
>  rfcomm: release the port when the last user closes the tty
>  rfcomm: move the device under its parent if already connected
> 
> net/bluetooth/rfcomm/tty.c | 68 ++++++++++++++++++++++++++--------------------
> 1 file changed, 39 insertions(+), 29 deletions(-)

I applied both patches to bluetooth-next to expose them wider testing. I like to have them go through bluetooth-next first before we push them back into -stable.

Regards

Marcel

