Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Jul 2013 11:09:23 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>, linux-bluetooth@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: hidp: remove wrong send_report at init
Message-ID: <20130712100923.GA2065@joana>
References: <1373550090-30379-1-git-send-email-benjamin.tissoires@redhat.com>
 <1373550090-30379-3-git-send-email-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373550090-30379-3-git-send-email-benjamin.tissoires@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Benjamin,

* Benjamin Tissoires <benjamin.tissoires@redhat.com> [2013-07-11 15:41:30 +0200]:

> The USB hid implementation does retrieve the reports during the start.
> However, this implementation does not call the HID command GET_REPORT
> (which would fetch the current status of each report), but use the
> DATA command, which is an Output Report (so transmitting data from the
> host to the device).
> The Wiimote controller is already guarded against this problem in the
> protocol, but it is not conformant to the specification to set all the
> reports to 0 on start.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  net/bluetooth/hidp/core.c | 14 --------------
>  1 file changed, 14 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
