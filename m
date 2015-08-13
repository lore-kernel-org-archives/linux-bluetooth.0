Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55CC96DB.5000607@intel.com>
Date: Thu, 13 Aug 2015 07:17:44 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <C06191D8-B470-45D9-9D9D-8C457DA9F25D@holtmann.org>
References: <1437472694-4805-1-git-send-email-loic.poulain@intel.com> <B70087AE-159E-4483-B599-11A4DD3D4538@holtmann.org> <55B5E896.4000707@intel.com> <8EF24238-152F-4D2C-ADCE-7AF5CAE2A160@holtmann.org> <55CC96DB.5000607@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>> it seems the second UART bardrate change command behaves exactly the same. So it is of no help.
>> 
> 
> Ok, seems we don't have other choice. Did you try this patch on your side ?

I do not have my UART board with me. See on how the Qualcomm UART driver handled the UART change. Maybe that is an easier way to handle this in the UART driver.

Otherwise lets get the support merged upstream and we refine this later. Please send me an updated version.

Regards

Marcel

