Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110713202020.GC23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
	<1310418719-12296-6-git-send-email-andre.guedes@openbossa.org>
	<20110713202020.GC23921@joana>
Date: Thu, 14 Jul 2011 11:29:35 -0300
Message-ID: <CACJA=fVN7OqQu2zz=wTBCX2z3V1nqaVujfbQ8RZjtoTyJ8aErg@mail.gmail.com>
Subject: Re: [PATCH 05/16] Bluetooth: Check pending commands in stop_discovery()
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jul 13, 2011 at 5:20 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>> @@ -1674,6 +1674,17 @@ static int stop_discovery(struct sock *sk, u16 index)
>>
>>       hci_dev_lock_bh(hdev);
>>
>> +     if (!mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
>> +             err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, EINVAL);
>> +             goto failed;
>> +     }
>> +
>> +     if (mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index)) {
>> +             err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
>> +                                                             EINPROGRESS);
>> +             goto failed;
>> +     }
>
> So here is what I said. Doesn't it fix that sync issue?

No, it doesn't. This peice of code only prevents you from carrying out
a MGMT_OP_STOP_DISCOVERY when there is no ongoing discovery.
IOW, if there is no ongoing discovery then MGMT_OP_STOP_DISCOVERY
command should failed.

The race condition scenario described in 08/16 you have a ongoing
discovery and a MGMT_OP_STOP_DISCOVERY command is issued.
During stop_discovery() execution, after checking for pending
MGMT_OP_START_DISCOVERY command, an inquiry complete event is
raised.

Andre
