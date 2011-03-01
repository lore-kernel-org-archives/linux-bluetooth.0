Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6D480E.7080908@codeaurora.org>
Date: Tue, 01 Mar 2011 11:25:02 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
CC: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On 11-03-01 10:16 AM, Andrzej Kaczmarek wrote:
> Adds counter for HCI commands which were sent but are not yet acked.
> This is to prevent race conditions in scenarios where HCI commands
> are sent between complete event and command status event, i.e.
> last sent HCI command is not accounted in credits number returned
> by command status event.
>
> <  HCI Command: Create Connection (0x01|0x0005) plen 13
>      bdaddr 00:23:76:E3:24:58 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) status 0x00 ncmd 1
>> HCI Event: Connect Complete (0x03) plen 11
>      status 0x00 handle 1 bdaddr 00:23:76:E3:24:58 type ACL encrypt 0x00
> <  HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>      handle 1
>> HCI Event: Command Status (0x0f) plen 4
>      Unknown (0x00|0x0000) status 0x00 ncmd 2
>> HCI Event: Command Status (0x0f) plen 4
>      Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>      handle 1 slots 5
>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>      status 0x00 handle 1
>      Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
> <  HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>      handle 1 page 1
>> HCI Event: Command Status (0x0f) plen 4
>      Unknown (0x00|0x0000) status 0x00 ncmd 2
>> HCI Event: Command Status (0x0f) plen 4
>      Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
>> HCI Event: Read Remote Extended Features (0x23) plen 13
>      status 0x00 handle 1 page 1 max 1
>      Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> <  HCI Command: Authentication Requested (0x01|0x0011) plen 2
>      handle 1
>> HCI Event: Command Status (0x0f) plen 4
>      Unknown (0x00|0x0000) status 0x00 ncmd 2
> <  HCI Command: Remote Name Request (0x01|0x0019) plen 10
>      bdaddr 00:23:76:E3:24:58 mode 2 clkoffset 0x0000
>> HCI Event: Command Status (0x0f) plen 4
>      Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
>> HCI Event: Link Key Request (0x17) plen 6
>      bdaddr 00:23:76:E3:24:58
>
> Following command should not be sent here since we have effectively no
> credits for HCI command, i.e. 1 credit returned by CS for Authentication
> Requested was already consumed by Remote Name Request.
>
> <  HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>      bdaddr 00:23:76:E3:24:58
>> HCI Event: Command Status (0x0f) plen 4
>      Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
>> HCI Event: Command Complete (0x0e) plen 10
>      Link Key Request Negative Reply (0x01|0x000c) ncmd 0
>      status 0x0c bdaddr 00:23:76:E3:24:58
>      Error: Command Disallowed
>
> Signed-off-by: Andrzej Kaczmarek<andrzej.kaczmarek@tieto.com>
> ---
>   include/net/bluetooth/hci_core.h |    1 +
>   net/bluetooth/hci_core.c         |   10 ++++++++--
>   net/bluetooth/hci_event.c        |    8 ++++++--
>   3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 441dadb..baf190b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -121,6 +121,7 @@ struct hci_dev {
>   	unsigned long	quirks;
>
>   	atomic_t	cmd_cnt;
> +	atomic_t	cmd_not_ack;
>   	unsigned int	acl_cnt;
>   	unsigned int	sco_cnt;
>   	unsigned int	le_cnt;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b372fb8..1c6886d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -531,6 +531,7 @@ int hci_dev_open(__u16 dev)
>
>   	if (!test_bit(HCI_RAW,&hdev->flags)) {
>   		atomic_set(&hdev->cmd_cnt, 1);
> +		atomic_set(&hdev->cmd_not_ack, 0);
>   		set_bit(HCI_INIT,&hdev->flags);
>   		hdev->init_last_cmd = 0;
>
> @@ -606,6 +607,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>   	/* Reset device */
>   	skb_queue_purge(&hdev->cmd_q);
>   	atomic_set(&hdev->cmd_cnt, 1);
> +	atomic_set(&hdev->cmd_not_ack, 0);
>   	if (!test_bit(HCI_RAW,&hdev->flags)) {
>   		set_bit(HCI_INIT,&hdev->flags);
>   		__hci_request(hdev, hci_reset_req, 0,
> @@ -684,6 +686,7 @@ int hci_dev_reset(__u16 dev)
>   		hdev->flush(hdev);
>
>   	atomic_set(&hdev->cmd_cnt, 1);
> +	atomic_set(&hdev->cmd_not_ack, 0);
>   	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
>
>   	if (!test_bit(HCI_RAW,&hdev->flags))
> @@ -1074,6 +1077,7 @@ static void hci_cmd_timer(unsigned long arg)
>
>   	BT_ERR("%s command tx timeout", hdev->name);
>   	atomic_set(&hdev->cmd_cnt, 1);
> +	atomic_add_unless(&hdev->cmd_not_ack, -1, 0);
>   	tasklet_schedule(&hdev->cmd_task);
>   }
>
> @@ -2015,10 +2019,11 @@ static void hci_cmd_task(unsigned long arg)
>   	struct hci_dev *hdev = (struct hci_dev *) arg;
>   	struct sk_buff *skb;
>
> -	BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));
> +	BT_DBG("%s cnt %d not_ack %d", hdev->name, atomic_read(&hdev->cmd_cnt),
> +					atomic_read(&hdev->cmd_not_ack));
>
>   	/* Send queued commands */
> -	if (atomic_read(&hdev->cmd_cnt)) {
> +	if (atomic_read(&hdev->cmd_cnt)>  atomic_read(&hdev->cmd_not_ack)) {

See below for fuller explanation of my opinion.

But I would make this test be-->   cmd_cnt && !cmd_not_acked

>   		skb = skb_dequeue(&hdev->cmd_q);
>   		if (!skb)
>   			return;
> @@ -2028,6 +2033,7 @@ static void hci_cmd_task(unsigned long arg)
>   		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
>   		if (hdev->sent_cmd) {
>   			atomic_dec(&hdev->cmd_cnt);
> +			atomic_inc(&hdev->cmd_not_ack);
>   			hci_send_frame(skb);
>   			mod_timer(&hdev->cmd_timer,
>   				  jiffies + msecs_to_jiffies(HCI_CMD_TIMEOUT));
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3fbfa50..3cf63a1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1766,8 +1766,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
>   		break;
>   	}
>
> -	if (ev->opcode != HCI_OP_NOP)
> +	if (ev->opcode != HCI_OP_NOP) {
>   		del_timer(&hdev->cmd_timer);
> +		atomic_add_unless(&hdev->cmd_not_ack, -1, 0);
> +	}
>
>   	if (ev->ncmd) {
>   		atomic_set(&hdev->cmd_cnt, 1);
> @@ -1844,8 +1846,10 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
>   		break;
>   	}
>
> -	if (ev->opcode != HCI_OP_NOP)
> +	if (ev->opcode != HCI_OP_NOP) {
>   		del_timer(&hdev->cmd_timer);
> +		atomic_add_unless(&hdev->cmd_not_ack, -1, 0);
> +	}
>
>   	if (ev->ncmd) {
>   		atomic_set(&hdev->cmd_cnt, 1);


The problem you describe sounds like one I had to solve in the past, but 
unfortunately, I think it may be a little more difficult to solve here. 
  This particular baseband appears to have an outstanding Cmd queue of 
2.  It also appears to consume one of them for extended periods of time 
when making requests of the remote device, and using the NOP 
Cmd-Status-Event to inform the host that the slot is now free.

As you are observing, the completion of the task (triggering additional 
requests locally) overlaps with these NOP responses, giving a false 
count to the host of available cmd slots.

Personally, I consider this to be a baseband bug, which could have been 
avoided by having a max outstanding queue of 1.

Note 1:
My biggest problem with your patch is the point marked above.  I agree 
that it would solve the problem you observed, and your overall analysis 
of the situation, but because of the way this particular baseband is 
operating, and the way I have seen other basebands operate in the past, 
I think this decision point as to when to send the next command is 
incorrect.

A flaw in the HCI command handshaking paradigm is that a baseband can 
decide to take away or not take away one of these slots, and give you 
notification asynchronously. I have seen basebands with presumptively 
two slots return a cmd status with ncmd 0 when getting a remote device 
name, if no ACL connection was currently established, for example.

The safest way I have seen this problem handled is to force a 
psuedo-single-threading of commands on the system by NEVER sending a 
command while another command has not yet received it's Cmd-Status or 
Cmd-Cmplt event. In other words, instead of the test for cmd_cnt > 
cmd_not_acked, I would simply make into cmd_cnt && !cmd_not_acked.

I think the rest of it is basically OK.

Note that it is still then possible to have multiple "very-asynchronous" 
commands that include remote interaction, but it ensures that that part 
that is suppose to be functionally syncrounous (Cmd + Status || Cmplt) 
is done the way most basebands are expecting them to be. I believe this 
to be the intended usage mode of the HCI paradigm.




-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
