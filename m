Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 23:49:08 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 18/18] Bluetooth: hidp: fix sending output reports on
 intr channel
Message-ID: <20130418024908.GA17064@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365166670-3271-19-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365166670-3271-19-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-05 14:57:50 +0200]:

> According to the specifications, data output reports must be sent on the
> interrupt channel. See also usbhid implementation.
> Sending these reports on the control channel breaks newer Wii Remotes.
> 
> Note that this will make output reports asynchronous. However, that's how
> hid_output_raw_report() is supposed to work with HID_OUTPUT_REPORT as
> report type. There are no responses to output reports.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/bluetooth/hidp/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

All patches in this series are now applied. Thanks.

	Gustavo
