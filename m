Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: Add option to enable/disable A2MP module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3B8E4CEA2CC045459E7856C66B82CE931135CD03@SHSMSX103.ccr.corp.intel.com>
Date: Sat, 6 Jun 2015 06:57:00 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <730F9DAC-E12D-4F00-A478-E0EC23216D2C@holtmann.org>
References: <1432274165-23569-1-git-send-email-arron.wang@intel.com> <1432274165-23569-2-git-send-email-arron.wang@intel.com> <669F121F-A1EE-47A7-8A15-27E1A2FAFF26@holtmann.org> <3B8E4CEA2CC045459E7856C66B82CE931135CD03@SHSMSX103.ccr.corp.intel.com>
To: "Wang, Arron" <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

>>> Make Bluetooth 3.0 HS feature configurable
>>> 
>>> Signed-off-by: Arron Wang <arron.wang@intel.com>
>>> ---
>>> net/bluetooth/Kconfig          |    5 +
>>> net/bluetooth/Makefile         |    3 +-
>>> net/bluetooth/a2mp.h           |   19 +++
>>> net/bluetooth/amp.h            |   11 ++
>>> net/bluetooth/hci_event.c      |  260 +-----------------------------------
>>> net/bluetooth/hci_event_a2mp.c |  283
>> ++++++++++++++++++++++++++++++++++++++++
>>> net/bluetooth/hci_event_a2mp.h |   91 +++++++++++++
>>> 7 files changed, 412 insertions(+), 260 deletions(-) create mode
>>> 100644 net/bluetooth/hci_event_a2mp.c create mode 100644
>>> net/bluetooth/hci_event_a2mp.h
>> 
>> I don’t think this is the solution here. I think A2MP support should be self
>> contained and utilises the synchronous HCI command framework we have in place
>> and also use in mgmt.
> 
> Yes, create a separate file for hci a2mp event maybe not suitable, but there are many hci ops/events for different Bluetooth controller BREDR/AMP/LE, add the macro to separate them in one file may not easy to maintain, can we move these AMP releated hci ops/event function to file amp.c?

unless it has some complicated state machine impact, using the hci_request infrastructure should be preferred compared to go through callback handlers in hci_event.c. So first of all it needs to be investigated which of the A2MP HCI functions can be turned into using hci_request.

Regards

Marcel

