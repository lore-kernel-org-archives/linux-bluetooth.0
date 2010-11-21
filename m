Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101121192538.GA12163@jh-x301>
References: <1290343578-986-1-git-send-email-santoscadenas@gmail.com>
 <20101121131442.GA22320@jh-x301> <AANLkTi=_BVKOptuGTz8eoHPaTQrkr6-3oCK8mzJq4oea@mail.gmail.com>
 <20101121192538.GA12163@jh-x301>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Sun, 21 Nov 2010 20:38:33 +0100
Message-ID: <AANLkTikkUT7SUnSEgcEV6Nfbkq++b8Wq8VJdwvACdEus@mail.gmail.com>
Subject: Re: [PATCH] Remove parameter entered from the DisplayPasskey agent method
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2010/11/21 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Jose,
>
> On Sun, Nov 21, 2010, Jose Antonio Santos Cadenas wrote:
>> > On Sun, Nov 21, 2010, Jose Antonio Santos Cadenas wrote:
>> >> In the current method implementation the parameter is not used.
>> >> ---
>> >>  doc/agent-api.txt |    5 +----
>> >>  1 files changed, 1 insertions(+), 4 deletions(-)
>> >
>> > Do you actually have a BT 2.1 keyboard to test this with?
>>
>> I'm lost, why do I need a BT keyboard?
>
> Because DisplayPasskey will only happen if the other side has
> KeyboardOnly as its SSP IO capability.
>
>> > The right fix
>> > is to fix the code and not the spec since we do want the UI to get the
>> > hints about entered characters.
>>
>> I also think that an other way to correct this is to change the code
>> to follow the specification, but as I see that the specification
>> didn't have changes since 2008 I thought that was an obsolete
>> documentation, because in the source code there is no reference to the
>> entered parameter. Have you got any suggestions about the better way
>> to add this parameter in order to follow the API in the documentation?
>>  Nevertheless I'll have a deeper look to the code looking for hints.
>
> The third parameter is supposed to be bound to the Keypress Notification
> HCI event which should come when the remote side does a
> HCI_Send_Keypress_Notification HCI command (again only a keyboard would
> do something like this).

Thanks for the explanation now I understand the use of the method.
Unfortunately right now I don't have a 2.1 keyboard so I can't test
it.

>
> Johan
>

Jose.
