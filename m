Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Add opcode parameter to hci_req_complete_t callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150112092404.GA4548@t440s.lan>
Date: Mon, 12 Jan 2015 09:15:45 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <82D39EC7-4302-4C2B-A295-0FDC7B3C0EBC@holtmann.org>
References: <1421013044-8613-1-git-send-email-marcel@holtmann.org> <20150112092404.GA4548@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> When hci_req_run() calls its provided complete function and one of the
>> HCI commands in the sequence fails, then provide the opcode of failing
>> command. In case of success HCI_OP_NOP is provided since all commands
>> completed.
>> 
>> This patch fixes the prototype of hci_req_complete_t and all its users.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/bluetooth.h |  2 +-
>> net/bluetooth/hci_conn.c          |  2 +-
>> net/bluetooth/hci_core.c          |  9 ++++----
>> net/bluetooth/hci_request.c       |  3 ++-
>> net/bluetooth/mgmt.c              | 44 ++++++++++++++++++++++-----------------
>> 5 files changed, 34 insertions(+), 26 deletions(-)
> 
> Applied to bluetooth-next. Thanks.
> 
> Would it make sense to also change the return value of the callback from
> void to bool. That way the callback could let the request handling code
> know whether to proceed even after a single command failure or to abort
> the request.

do we need this actually? Is there a case where we can continue if one of the commands fails.

I think what we actually need is to have a way to revert the actions taken by an earlier command. So if a command in sequence configured something, we might want to revert that action when a later command fails.

Regards

Marcel

