Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 03/11] Bluetooth: Split HCI init sequence into three stages
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_Pn6fx1RNu9DH2GmEHRPRdhU_FR4RoDx15cMUmynS-s9Q@mail.gmail.com>
Date: Mon, 4 Mar 2013 10:54:38 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F1DBC779-E43C-4171-A473-9DFEE05FBD70@holtmann.org>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com> <1362391748-21653-4-git-send-email-johan.hedberg@gmail.com> <CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com> <20130304113511.GA24442@x220> <CAJdJm_Pn6fx1RNu9DH2GmEHRPRdhU_FR4RoDx15cMUmynS-s9Q@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>>>> +       /* AMP controllers do not need stage 2/3 init */
>>>> +       if (hdev->dev_type != HCI_BREDR)
>>>> +               return 0;
>>> 
>>> What about checking for "dev_type == HCI_AMP" instead? I had to check
>>> net/bluetooth/hci.h because for a moment I thought Dual mode and
>>> single mode LE devices were being left out as well. I then realized
>>> you can only have BREDR vs. AMP controller types.
>> 
>> This logic is a direct copy-paste from the beginning of the existing
>> hci_setup() function in net/bluetooth/hci_event.c. I could change it to
>> test specifically for AMP, but then what happens if we add more dev_type
>> values that also shouldn't have more than the stage 1 init? In that case
>> a stricter != HCI_BREDR test is safer than a looser == HCI_AMP test.
> 
> My concern is that the "HCI_BREDR" name is a bit misleading, specially
> if it matches a single mode LE device (is that the case?)
> 
> If changing the macro name is not an option, can it be clarified on the comment?

the HCI_BREDR and HCI_AMP define the difference between a BR/EDR and/or LE controller and the AMP controller. It does not define the difference between BR/EDR and LE.

While the name is not super perfect, it makes sense from a historic point of view how Bluetooth as a technology evolved. If you figure out a better naming, let me know.

Or start complaining to the Bluetooth SIG, that we can not tell AMP controllers apart from BR/EDR controllers on the HCI level. Unless we start checking for some magic supported HCI commands/events, but there is clearly no standard. And the init procedure of the two controller types to differ.

Regards

Marcel

