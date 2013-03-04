Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130304113511.GA24442@x220>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
	<1362391748-21653-4-git-send-email-johan.hedberg@gmail.com>
	<CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com>
	<20130304113511.GA24442@x220>
Date: Mon, 4 Mar 2013 09:36:30 -0400
Message-ID: <CAJdJm_Pn6fx1RNu9DH2GmEHRPRdhU_FR4RoDx15cMUmynS-s9Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] Bluetooth: Split HCI init sequence into three stages
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Mar 4, 2013 at 7:35 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > +       /* AMP controllers do not need stage 2/3 init */
>> > +       if (hdev->dev_type != HCI_BREDR)
>> > +               return 0;
>>
>> What about checking for "dev_type == HCI_AMP" instead? I had to check
>> net/bluetooth/hci.h because for a moment I thought Dual mode and
>> single mode LE devices were being left out as well. I then realized
>> you can only have BREDR vs. AMP controller types.
>
> This logic is a direct copy-paste from the beginning of the existing
> hci_setup() function in net/bluetooth/hci_event.c. I could change it to
> test specifically for AMP, but then what happens if we add more dev_type
> values that also shouldn't have more than the stage 1 init? In that case
> a stricter != HCI_BREDR test is safer than a looser == HCI_AMP test.

My concern is that the "HCI_BREDR" name is a bit misleading, specially
if it matches a single mode LE device (is that the case?)

If changing the macro name is not an option, can it be clarified on the comment?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
