Return-Path: <cyrus@holtmann.org>
Message-ID: <4A94E282.6010302@nokia.com>
Date: Wed, 26 Aug 2009 10:21:38 +0300
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: sniff mode
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>	 <1251139257.2950.60.camel@localhost.localdomain>	 <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com> <1251142428.2950.61.camel@localhost.localdomain>
In-Reply-To: <1251142428.2950.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

ext Marcel Holtmann wrote:
> Hi Luiz,
> 
>>>> It is just me or hci_conn_enter_active_mode will never do what its
>>>> name suggests. This check will always succeed:
>>>>
>>>>       if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
>>>>               goto timer;
>>> so conn->power_save is used to disable automatic sniff mode for incoming
>>> connections. Mainly HID since they manager it by themselves.
>> Hmm, but this seems to be done for any device regardless of its type.
>> So for example we start sending/receiving data to a headset it will
>> triggers hci_conn_enter_active_mode which I thought would exit sniff
>> mode, right? (yep, I have seem some headset that doesn't leave sniff
>> mode by their own).
> 
> I said this before. We need a socket option for L2CAP and RFCOMM that
> can trigger leaving sniff mode even if the remote device initiated the
> connection.
> 

I guess I need to take this on my TODO list. Or is some one already 
working on this?

-- 
Ville
