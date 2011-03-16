Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110316184639.GA2151@joana>
References: <4D7BB10B.3080100@gmail.com>
	<1300301086-22653-1-git-send-email-padovan@profusion.mobi>
	<20110316184639.GA2151@joana>
Date: Wed, 16 Mar 2011 14:48:31 -0400
Message-ID: <AANLkTimNeqvBMnb55x10LrwXncx1CnV=OLBUCBJXaGpx@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org, mmvinni@yahoo.com,
	justinmattock@gmail.com, edt@aei.ca
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Mar 16, 2011 at 2:46 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>
> * Gustavo F. Padovan <padovan@profusion.mobi> [2011-03-16 15:44:46 -0300]:
>
>> We can't send new commands before a cmd_complete for the HCI_RESET commnnd
>> shows up.
>>
>> Reported-by: Mikko Vinni <mmvinni@yahoo.com>
>> Reported-by: Justin P. Mattock <justinmattock@gmail.com>
>> Reported-by: Ed Tomlinson <edt@aei.ca>
>> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
>> ---
>>  include/net/bluetooth/hci.h |    2 ++
>>  net/bluetooth/hci_core.c    |    3 +++
>>  net/bluetooth/hci_event.c   |    4 +++-
>>  3 files changed, 8 insertions(+), 1 deletions(-)
>
> It works for me, but can someone test this and then add a Tested-by line.
> Thanks.

Which hardware is needed to test this?

I have a 1.1 dongle which doesn't work on current mainline tree, but
I'm not sure it is this same issue. I "fixed" it by upgrading the
firmware to support 1.2, but I can downgrade it to test if this is
related to 1.1 dongles.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
