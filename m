Return-Path: <cyrus@holtmann.org>
Message-ID: <50A62D36.4070006@linux.intel.com>
Date: Fri, 16 Nov 2012 13:10:30 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com> <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com> <20121115203029.GA2026@joana>
In-Reply-To: <20121115203029.GA2026@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 11/15/2012 09:30 PM, Gustavo Padovan wrote:
>>   	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
>> +	defered = hci_proto_defered(hdev, &ev->bdaddr, ev->link_type);
>
> I'm not really happy with this hci_proto thing. Weed need to think more on
> this.

Since hci_proto_connect_ind returns an int, what about using 16 bits for
HCI_LM_* flags, and 16 bits for additional flags (from hci_core.h), 
including one to indicate deferred setup.

Frédéric
