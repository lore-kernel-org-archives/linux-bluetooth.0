Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 7/8] Bluetooth: SCO connection fallback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373036503-1349-8-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 8 Jul 2013 12:23:01 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EAB92B0C-1120-4EC7-A4C6-83D3C7F185CB@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-8-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When initiating a transparent eSCO connection, make use of T2 settings at
> first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
> connection failure, try T1 settings.
> 
> When CVSD is requested and eSCO is supported, try to establish eSCO connection
> using S3 settings. If it fails, fallback in sequence to S2, S1, D1, D0 settings.
> 
> Failure is detected if Synchronous Connection Complete event fails with
> error 0x0d. This error code has been found experimentally by sending a T2
> request to a T1 only SCO listener. It means "Connection Rejected due to
> Limited resource".
> To know which setting should be used, conn->fallback is used.  Bluez only
> attempt to reconnect twice. Since, more than 2 fallback are required,
> conn->fallback is tested as an alternative measure. We want to fallback only if
> conn->fallback is positive. Calling hci_setup_sync with conn->fallback == 0
> triggers initial connection attempt.
> 
> These setting and the fallback order are described in Bluetooth HFP 1.6
> specification p. 101.

before we do the fallback handling, lets get the basic CVSD vs transparent work done properly. The one thing that I am missing is the handling of SCO/eSCO setup error handling. Like say when using connect() and we try to establish transparent link where not available. Or accept() with defer setup and the transparent link does not work out.

The fallback handling can be a separate patch once the others are all in a mergable state.

Regards

Marcel

