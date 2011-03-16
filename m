Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 15:46:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: mmvinni@yahoo.com, justinmattock@gmail.com, edt@aei.ca
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
Message-ID: <20110316184639.GA2151@joana>
References: <4D7BB10B.3080100@gmail.com>
 <1300301086-22653-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300301086-22653-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


* Gustavo F. Padovan <padovan@profusion.mobi> [2011-03-16 15:44:46 -0300]:

> We can't send new commands before a cmd_complete for the HCI_RESET commnnd
> shows up.
> 
> Reported-by: Mikko Vinni <mmvinni@yahoo.com>
> Reported-by: Justin P. Mattock <justinmattock@gmail.com>
> Reported-by: Ed Tomlinson <edt@aei.ca>
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/hci.h |    2 ++
>  net/bluetooth/hci_core.c    |    3 +++
>  net/bluetooth/hci_event.c   |    4 +++-
>  3 files changed, 8 insertions(+), 1 deletions(-)

It works for me, but can someone test this and then add a Tested-by line.
Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
