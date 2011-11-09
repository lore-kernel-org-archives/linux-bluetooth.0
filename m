Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Code refactoring
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1320877088.15441.350.camel@aeonflux>
Date: Wed, 9 Nov 2011 19:41:06 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A9331507-78CC-4AC9-9947-1FA37247ECC7@openbossa.org>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org> <1320869667-1373-3-git-send-email-andre.guedes@openbossa.org> <1320877088.15441.350.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 9, 2011, at 7:18 PM, Marcel Holtmann wrote:

> Hi Andre,
> 
>> This patch adds the helper function cmd_failed() to handle mgmt
>> commands failures. This function sends the proper command status
>> event and removes the command from the pending list.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/mgmt.c |   53 +++++++++++++++++--------------------------------
>> 1 files changed, 19 insertions(+), 34 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> <snip>
> 
>> int mgmt_disconnect_failed(struct hci_dev *hdev)
>> {
>> -	struct pending_cmd *cmd;
>> -	int err;
>> -
>> -	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
>> -	if (!cmd)
>> -		return -ENOENT;
>> -
>> -	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT, EIO);
>> -
>> -	mgmt_pending_remove(cmd);
>> -
>> -	return err;
>> +	return cmd_failed(hdev, MGMT_OP_DISCONNECT, EIO);
>> }
> 
> So the only left-over question now is if we need to keep these empty
> stub functions around or can just call cmd_failed directly.
> 
> It might be actually cleaner to just call cmd_failed directly.

I've asked myself the same question. If we wanna have hci_core layer
calling cmd_failed() we need to include mgmt.h header so we have access
to mgmt commands opcodes.

BR,

Andre

