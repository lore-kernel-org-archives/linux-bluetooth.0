Return-Path: <cyrus@holtmann.org>
Message-ID: <55A8FF10.2090108@intel.com>
Date: Fri, 17 Jul 2015 15:11:44 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
CC: Arend Van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_uart: Add PM for BCM2E39
References: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com> <55A7D771.9020705@linux.intel.com> <E0D3336E15B58B4294723AC879BA5E9426DDF7@IRVEXCHMB15.corp.ad.broadcom.com>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9426DDF7@IRVEXCHMB15.corp.ad.broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,
> IF: Sorry for the delay in responding. I am not actively working on the similar DT driver at the moment as we have hit a DT maintainer roadblock for its development. I do not read this bulletin board much therefore. Great seeing a first take on the Broadcom BT UART ACPI driver! Looks like a good start to me. A few comments:
>

Most of Bluetooth UART chips have some extra configuration (PCM, I2S, 
LPM...)
with specific vendor commands. Since it looks hard to include this 
information
into DT and much more difficult into ACPI, I suggest to implement a 
common way
to that with a generic btconf file. This file could be retrieved via 
request_firmware
and filled with a list of HCI commands for vendor config. This 
configuration should
happen after firmware download. If no conf file found, you can apply a 
default
configuration or just ignore it.

It's just a proposal, I don't know if it does completely match your 
requirements.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

