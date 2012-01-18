Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120118225634.GA15541@x220.P-661HNU-F1>
References: <CA+bD78jG+f2kaq66YTdJnOhBGE-=gfeoHYPpmpe6OxZUyBZv7Q@mail.gmail.com>
	<20120118225634.GA15541@x220.P-661HNU-F1>
Date: Wed, 18 Jan 2012 15:05:37 -0800
Message-ID: <CA+bD78gWACGpx_eNUCQ5xDZMV72exEeRTWavmU4qBdr3A0ihDw@mail.gmail.com>
Subject: Re: RFA: Implementing HID spec recommendation for Keyboard PINs
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 18, 2012 at 2:56 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> Hi Scott,
>
Hi Johan,

> On Wed, Jan 18, 2012, Scott James Remnant wrote:
>> The Bluetooth HID profile recommends (4.1, p24) that rather than
>> prompting the user for a PIN on the host, which then needs to be
>> entered into the connecting keyboard, instead the host simply generate
>> the PIN and display it to the user instead. Part of this will be
>> implemented as a plugin, but since UI is involved, the Agent is
>> involved as well. As far as I can tell, there are two options:
>>
>>
> 3) Keep using RequestPinCode and have let the agent be responsible for
> generating and showing a PIN to the user which is immediately sent as a
> reply to the agent callback (while the UI prompt remains).
>

Marcel has specifically instructed me not to do that, stating that the
Agent is not supposed to be "smart" like this but only to directly
interact with the user.

See http://thread.gmane.org/gmane.linux.bluez.kernel/20391 yesterday

Scott
-- 
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
