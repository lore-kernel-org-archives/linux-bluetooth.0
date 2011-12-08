Return-Path: <cyrus@holtmann.org>
Message-ID: <1323356160.1965.45.camel@aeonflux>
Subject: Re: [PATCHv1 0/6] Implement basic HCI block-based flow control
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Dec 2011 16:56:00 +0200
In-Reply-To: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Changes:
> 	PATCHv1: added check for packet len before accessing it.
> 	RFCv2: taken Marcel's comments: added check for flow control,
> 	removed magic pointers and numbers, added SCO type check.
> 
> Simplify current handling of number of completed packets.
> Adds basic HCI commands and event handlers related to data block
> flow control.
> 
> Andrei Emeltchenko (6):
>   Bluetooth: Add HCI Read Data Block Size function
>   Bluetooth: Simplify num_comp_pkts_evt function
>   Bluetooth: Check for flow control mode
>   Bluetooth: Clean up magic pointers
>   Bluetooth: Correct packet len calculation
>   Bluetooth: Process num completed data blocks event
> 
>  include/net/bluetooth/hci.h      |   28 +++++++-
>  include/net/bluetooth/hci_core.h |    5 +
>  net/bluetooth/hci_event.c        |  151 +++++++++++++++++++++++++++++++-------
>  3 files changed, 157 insertions(+), 27 deletions(-)

this whole set is fine now. So ACK.

Regards

Marcel


