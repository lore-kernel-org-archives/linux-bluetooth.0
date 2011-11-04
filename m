Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <CAJdJm_PMUz4L=Vm3=nAdU7c8Y5DicMbGywoczOfcsuZ1K+oSDA@mail.gmail.com>
Date: Fri, 4 Nov 2011 15:33:26 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9BC7D9E4-7E22-4FA7-9CB7-5DB2A2492177@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org> <CAJdJm_PMUz4L=Vm3=nAdU7c8Y5DicMbGywoczOfcsuZ1K+oSDA@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Nov 4, 2011, at 3:20 PM, Anderson Lizardo wrote:

> Hi Guedes,
> 
> On Fri, Nov 4, 2011 at 1:16 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
>> -       err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
>> +       err = hci_do_inquiry(hdev, 0x08);
> 
> In a later patch in your tree you introduce this new definition:
> 
> net/bluetooth/mgmt.c:#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
> 
> Does it make sense to introduce it already here and use it above?

Sure, I'll add INQUIRY_LEN_BREDR macro to this patch and
resend it. Thanks.

Padovan, please don't consider this patch.

Andre