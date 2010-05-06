Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE342F5.3060200@qualcomm.com>
Date: Thu, 06 May 2010 15:30:13 -0700
From: Max Krasnyansky <maxk@qualcomm.com>
MIME-Version: 1.0
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: multiple HCI_UART protocols over hci_ldisc
References: <987394.67247.qm@web94902.mail.in2.yahoo.com>
In-Reply-To: <987394.67247.qm@web94902.mail.in2.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/06/2010 03:04 PM, Pavan Savoy wrote:
> Hi Marcel,
>
> I am working on a line discipline which in many respects is similar to the hci_ldisc, but only extended to do plenty of other functionality.
>
> One road block which i have hit is to support multiple devices/or as Alan Cox puts it "avoid single device limits"
>
> So, in somewhat relation to this, I wanted to ask, If in a system I have 2 UARTs both connected to BT chips but only from different vendors say TI/HCI-Ll and broadcomm with BCSP ..
>
> Can I have those 2 protocols on top of HCI-ldisc on different UARTs at the same time?
> Is something like that feasible?
Sure. You'll get two separate HCI devices in that case.

Max
