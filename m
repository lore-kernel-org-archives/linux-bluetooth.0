Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Intel: Introduce btvnd_intel library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427387863-2629-1-git-send-email-loic.poulain@intel.com>
Date: Thu, 26 Mar 2015 09:56:20 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <3354DD05-A6FC-4F73-9D77-485D570944B1@holtmann.org>
References: <1427387863-2629-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Most Intel Bluetooth controllers use a same set of vendor HCI commands
> and procedures regardless of the transport layer (USB, UART, etc).
> In order to prevent code duplication, this patch adds common library
> for Intel bluetooth drivers.
> This is essentially a move of btusb Intel code to btvnd_intel.

actually in the beginning I would prefer to actually go with independent code for USB and UART for the Intel silicon. The reason I am saying that is because there are still things to be figured out before we can have generic code. So we might accept duplicate at first and once both transports are working, we will slowly start moving code out into a common module.

Also I think only BTUSB_INTEL_NEW support needs to be considered in the beginning. The older Intel silicon support should only be considered when the need arises.

To give a little bit background, the functions that we need to consider are hdev->shutdown, hdev->setup and hdev->set_bdaddr. That would be simplest split into a separate module. However they are a bit tricky since for BTUSB_INTEL_NEW we already know that we have to handle asynchronous event reception from the firmware download. With regard, I would like to see the UART code first merged upstream and then we go and move common pieces into a more generic solution.

Regards

Marcel

