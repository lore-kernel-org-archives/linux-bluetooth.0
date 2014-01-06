Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
Date: Mon, 6 Jan 2014 13:57:12 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Message-Id: <53C8DDF7-94EA-4E01-A2A9-C366F9F85530@holtmann.org>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

> The following patches fix three regressions introduced with the
> rfcomm tty_port conversion.
> 
> The first patch restores the expected behaviour of the rfcomm port when
> it's created with the flag RFCOMM_RELEASE_ONHUP.
> 
> The second patch moves rfcomm_get_device() and is preparatory for the
> third patch.
> 
> The third patch fixes two regressions:
> 1) when the tty is opened with O_NONBLOCK or CLOCAL is set (fixes
>   wvdial)
> 2) when the rfcomm device is created with the flag RFCOMM_REUSE_DLC
>   (fixes ModemManager)
> 
> The fourth patch removes rfcomm_dev_carrier_raised().
> 
> Changes from v2:
>  * Fix the style of if statements in rfcomm_dev_activate().
> 
> Changes from v1:
>  * Removed the device_move() fix which is now incorporated in a new patch.
> 
> Gianluca Anzolin (4):
>  rfcomm: release the port when the last user closes the tty
>  rfcomm: move rfcomm_get_device() before rfcomm_dev_activate()
>  rfcomm: always wait for a bt connection on open()
>  rfcomm: remove rfcomm_carrier_raised()
> 
> net/bluetooth/rfcomm/tty.c | 103 +++++++++++++++++++++++++++++----------------
> 1 file changed, 66 insertions(+), 37 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

