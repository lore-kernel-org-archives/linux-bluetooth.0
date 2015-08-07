Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55B5E896.4000707@intel.com>
Date: Fri, 7 Aug 2015 11:18:12 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <8EF24238-152F-4D2C-ADCE-7AF5CAE2A160@holtmann.org>
References: <1437472694-4805-1-git-send-email-loic.poulain@intel.com> <B70087AE-159E-4483-B599-11A4DD3D4538@holtmann.org> <55B5E896.4000707@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>> this is a really bad behavior from our firmware then. We would actually like to get the cmd status or cmd complete on the current baud rate and once that has been confirmed, we switch to the new baud rate. I remember that there are actually two different baud rate change commands for the Intel controllers. Are you using the right one?
> 
> I don't know about a second vendor command to change the baudrate.
> I use the same one used in hciattach_intel where the behavior seems identical.

it seems the second UART bardrate change command behaves exactly the same. So it is of no help.

Regards

Marcel

