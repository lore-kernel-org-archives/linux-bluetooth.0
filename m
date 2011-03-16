Return-Path: <cyrus@holtmann.org>
Message-ID: <4D810B4E.7040702@gmail.com>
Date: Wed, 16 Mar 2011 12:11:10 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, mmvinni@yahoo.com, edt@aei.ca
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
References: <4D7BB10B.3080100@gmail.com> <1300301086-22653-1-git-send-email-padovan@profusion.mobi> <20110316184639.GA2151@joana> <AANLkTimNeqvBMnb55x10LrwXncx1CnV=OLBUCBJXaGpx@mail.gmail.com> <20110316190154.GB2151@joana>
In-Reply-To: <20110316190154.GB2151@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/16/2011 12:01 PM, Gustavo F. Padovan wrote:
> Hi Anderson,
>
> * Anderson Lizardo<anderson.lizardo@openbossa.org>  [2011-03-16 14:48:31 -0400]:
>
>> Hi Gustavo,
>>
>> On Wed, Mar 16, 2011 at 2:46 PM, Gustavo F. Padovan
>> <padovan@profusion.mobi>  wrote:
>>>
>>> * Gustavo F. Padovan<padovan@profusion.mobi>  [2011-03-16 15:44:46 -0300]:
>>>
>>>> We can't send new commands before a cmd_complete for the HCI_RESET commnnd
>>>> shows up.
>>>>
>>>> Reported-by: Mikko Vinni<mmvinni@yahoo.com>
>>>> Reported-by: Justin P. Mattock<justinmattock@gmail.com>
>>>> Reported-by: Ed Tomlinson<edt@aei.ca>
>>>> Signed-off-by: Gustavo F. Padovan<padovan@profusion.mobi>
>>>> ---
>>>>   include/net/bluetooth/hci.h |    2 ++
>>>>   net/bluetooth/hci_core.c    |    3 +++
>>>>   net/bluetooth/hci_event.c   |    4 +++-
>>>>   3 files changed, 8 insertions(+), 1 deletions(-)
>>>
>>> It works for me, but can someone test this and then add a Tested-by line.
>>> Thanks.
>>
>> Which hardware is needed to test this?
>
> I don't know, I have a dongle that can cause this issue. It's CSR 1.1.
> I don't know which other dongles have a similar issue.
>

I started to test this out, but crapped out at hci_cmd_timer with the 
current Mainline do you have this for the current?
