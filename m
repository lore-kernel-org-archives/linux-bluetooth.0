Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405105824.GH32212@x220>
References: <1333603129-18813-1-git-send-email-hemant.gupta@stericsson.com>
	<20120405105824.GH32212@x220>
Date: Thu, 5 Apr 2012 16:59:13 +0530
Message-ID: <CACj007=AXwV6DRp40dfCwacqBk6VPAvfo+VjfgX6vpwVAV2dFQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Send Discovery Stopped event when discovery fails
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 4:28 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Thu, Apr 05, 2012, Hemant Gupta wrote:
>> This patch sends MGMT_EV_DISCOVERING event to manamgement interface of
>> BlueZ to indicate that discovery is stopped in case of discovery failure.
>> Without this patch discovery session of BlueZ was not getting freed.
>> This event was not sent from kernel in case discovery state is still
>> DISCOVERY_STARTING.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> ---
>>  net/bluetooth/hci_core.c |    2 +-
>>  net/bluetooth/mgmt.c     |   16 +---------------
>>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> This patch in general doesn't make much sense to me.
>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 9629645..b97a7dc 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -384,7 +384,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
>>
>>       switch (state) {
>>       case DISCOVERY_STOPPED:
>> -             if (hdev->discovery.state != DISCOVERY_STARTING)
>> +             if (hdev->discovery.state != DISCOVERY_STOPPED)
>>                       mgmt_discovering(hdev, 0);
>>               break;
>
> This is wrong in several different ways. Firstly it's wrong since we
> only do mgmt_discovering(hdev, 1) when going to DISCOVERY_FINDING state
> so mgmt_discovering(hdev, 0) should not be called before that. Secondly
> it's wrong because the function will return if hdev->discovery.state ==
> state, i.e. your if statement would always evaluate to true and
> therefore be redundant.
>
I found this issue because I found the following situation that LE
Scan failed to start (in my case because of Limited resources). At
that time, the discovery state was DISCOVERY_STARTING. In that case,
user space, had already started the discovery session, which is freed
only on receiving the event in MGMT_EV_DISCOVERING, with state set to
FALSE. If you look at the code of mgmt_start_discovery_failed ()
below, which will be called when LE Scan failed to start, no
MGMT_EV_DISCOVERING is sent to user space, so user space would never
free the discovery session that it has created while calling
start_discovery. In short Inquiry never finishes.

>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -3572,23 +3572,9 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>
>>  int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
>>  {
>> -     struct pending_cmd *cmd;
>> -     u8 type;
>> -     int err;
>> -
>>       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>
>> -     cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
>> -     if (!cmd)
>> -             return -ENOENT;
>> -
>> -     type = hdev->discovery.type;
>> -
>> -     err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
>> -                        &type, sizeof(type));
>> -     mgmt_pending_remove(cmd);
>> -
>> -     return err;
>> +     return 0;
>>  }
>
> So who sends the appropriate command complete event to start_discovery
> now? I don't see any other place that would do it.
It is being sent from the mgmt_discovering(hdev, 0); called because of
call to hci_discovery_set_state, which will set state to
DISCOVERY_STOPPED, since the current state would in this case be
DISCOVERY_STARTING.

Please let me know your views on it ?
>
> Johan



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
