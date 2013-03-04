Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 03/11] Bluetooth: Split HCI init sequence into three stages
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130304210700.GA6078@x220.P-661HNU-F1>
Date: Mon, 4 Mar 2013 13:58:59 -0800
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <36968723-C35E-455B-B596-2359865C988A@holtmann.org>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com> <1362391748-21653-4-git-send-email-johan.hedberg@gmail.com> <CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com> <20130304113511.GA24442@x220> <CAJdJm_Pn6fx1RNu9DH2GmEHRPRdhU_FR4RoDx15cMUmynS-s9Q@mail.gmail.com> <F1DBC779-E43C-4171-A473-9DFEE05FBD70@holtmann.org> <20130304210700.GA6078@x220.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> This logic is a direct copy-paste from the beginning of the existing
>>>> hci_setup() function in net/bluetooth/hci_event.c. I could change it to
>>>> test specifically for AMP, but then what happens if we add more dev_type
>>>> values that also shouldn't have more than the stage 1 init? In that case
>>>> a stricter != HCI_BREDR test is safer than a looser == HCI_AMP test.
>>> 
>>> My concern is that the "HCI_BREDR" name is a bit misleading, specially
>>> if it matches a single mode LE device (is that the case?)
>>> 
>>> If changing the macro name is not an option, can it be clarified on
>>> the comment?
>> 
>> the HCI_BREDR and HCI_AMP define the difference between a BR/EDR
>> and/or LE controller and the AMP controller. It does not define the
>> difference between BR/EDR and LE.
>> 
>> While the name is not super perfect, it makes sense from a historic
>> point of view how Bluetooth as a technology evolved. If you figure out
>> a better naming, let me know.
> 
> The only idea I have is HCI_BREDRLE (since the core spec uses
> "BR/EDR/LE" for dual mode references). I'll anyway try to clarify the
> code comment that was partly responsible here.

which is an even worse letter soup ;)

And might be even more confusing when you really have single BR/EDR only controller which is still pretty much common these days.

So the fact that a LE only controller would be labeled as HCI_BREDR is confusing, but then again, the cases where BlueZ is normally used (besides testing) we will not see an LE only controller anyway. So optimizing for that case is rather pointless since no matter what we do, we have a trade off here.

A2MP uses the term "Primary BR/EDR controller". So we could use HCI_PRIMARY, but even that is confusing since BlueZ has been supporting multiple controllers since the beginning. So for me it is HCI_BREDR and unless some one comes up with a better name, it should stay that way.

Regards

Marcel

