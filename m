Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH  2/2] emulator/le: Add LE test commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <002301d0a1d1$0c707dc0$25517940$@samsung.com>
Date: Mon, 8 Jun 2015 13:42:03 +0200
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
Message-Id: <CEE5B3E3-43E5-46F7-992B-309D6C1A410B@holtmann.org>
References: <1433413568-26382-1-git-send-email-gowtham.ab@samsung.com> <1433413568-26382-2-git-send-email-gowtham.ab@samsung.com> <399E856C-28E8-4A5A-98AB-BFB037680906@holtmann.org> <000601d09f89$58a9e6d0$09fdb470$@samsung.com> <5389621D-DA80-4253-9E88-344800BDFFAD@holtmann.org> <002301d0a1d1$0c707dc0$25517940$@samsung.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

>>>>> ---
>>>>> emulator/le.c | 45
>> ++++++++++++++++++++++++++++++++++++++++++--
>>>> -
>>>>> 1 file changed, 42 insertions(+), 3 deletions(-)
>>>>> 
>>>>> diff --git a/emulator/le.c b/emulator/le.c index dc51469..7f852a9
>>>>> 100644
>>>>> --- a/emulator/le.c
>>>>> +++ b/emulator/le.c
>>>>> @@ -258,9 +258,9 @@ static void reset_defaults(struct bt_le *hci)
>>>>> 	//hci->commands[28] |= 0x02;	/* LE Long Term Key Request Reply
>>>> */
>>>>> 	//hci->commands[28] |= 0x04;	/* LE Long Term Key Request
>>>> Negative Reply */
>>>>> 	hci->commands[28] |= 0x08;	/* LE Read Supported States */
>>>>> -	//hci->commands[28] |= 0x10;	/* LE Receiver Test */
>>>>> -	//hci->commands[28] |= 0x20;	/* LE Transmitter Test */
>>>>> -	//hci->commands[28] |= 0x40;	/* LE Test End */
>>>>> +	hci->commands[28] |= 0x10;	/* LE Receiver Test */
>>>>> +	hci->commands[28] |= 0x20;	/* LE Transmitter Test */
>>>>> +	hci->commands[28] |= 0x40;	/* LE Test End */
>>>>> 	//hci->commands[33] |= 0x10;	/* LE Remote Connection Parameter
>>>> Request Reply */
>>>>> 	//hci->commands[33] |= 0x20;	/* LE Remote Connection Parameter
>>>> Request Negative Reply */
>>>>> 	hci->commands[33] |= 0x40;	/* LE Set Data Length */
>>>>> @@ -1218,6 +1218,36 @@ static void
>>>> cmd_le_read_supported_states(struct bt_le *hci,
>>>>> 							&rsp, sizeof(rsp));
>>>>> }
>>>>> 
>>>>> +static void cmd_le_receiver_test(struct bt_le *hci,
>>>>> +						const void *data, uint8_t
>>> size)
>>>> {
>>>>> +	uint8_t status;
>>>>> +
>>>>> +	status = BT_HCI_ERR_SUCCESS;
>>>>> +	cmd_complete(hci, BT_HCI_CMD_LE_RECEIVER_TEST,
>>>>> +					&status, sizeof(status));
>>>>> +}
>>>>> +
>>>>> +static void cmd_le_transmitter_test(struct bt_le *hci,
>>>>> +						const void *data, uint8_t
>>> size)
>>>> {
>>>>> +	uint8_t status;
>>>>> +
>>>>> +	status = BT_HCI_ERR_SUCCESS;
>>>>> +	cmd_complete(hci, BT_HCI_CMD_LE_TRANSMITTER_TEST,
>>>>> +					&status, sizeof(status));
>>>>> +}
>>>>> +
>>>>> +static void cmd_le_end_test(struct bt_le *hci, const void *data,
>>>>> +uint8_t size) {
>>>>> +	struct bt_hci_rsp_le_test_end lte;
>>>>> +
>>>>> +	lte.status = BT_HCI_ERR_SUCCESS;
>>>>> +	lte.num_packets = 0;
>>>>> +
>>>>> +	cmd_complete(hci, BT_HCI_CMD_LE_TEST_END, &lte, sizeof(lte)); }
>>>>> +
>>>> 
>>>> this is actually not enough. You need to put a bit of logic into this
>>> code. For
>>>> example it is either RX or TX test and not both at the same time. You
>>>> need
>>> to
>>>> return proper errors. And the test end command you also return the
>>>> correct value for num_packets. So if you do a receiver test against a
>>>> transmitter
>>> test
>>>> you are getting some useful values here. Otherwise there are just
>>>> empty stubs and we better not bother having them at all.
>>>> 
>>> 
>>> Thanks for the quick review.
>>> Below are the assumptions that I want to clarify:
>>> 1) Need to check  rx_chan and tx_chan are in 0x00 to 0x27 range, if
>>> not return BT_HCI_ERR_INVALID_PARAMETERS.
>> 
>> that is the first thing that needs to be done.
>> 
>> For the TX test also test data length needs to be checked for 0x00 - 0x25.
> This
>> might actually depend on if data length extension is supported or not.
>> 
>> Also the packet payload is limited to 0x00 - 0x07.
>> 
>>> 2) Need to maintain a global variable (rx_test, tx_test) to track
>>> which test is going on.
>> 
>> Yes, and command disallowed needs to be return if either of the tests is
>> active.
>> 
>>> 3) When receiver test is called, a global variable (pkt_recv ) is
>>> incremented to track  num of packets received.
>>> 
>>> Or Should I maintain a structure for (2) & (3) instead of maintaining
>>> globals?
>> 
>> The receiving side needs to track the num of packets received on that
>> specified channel. Meaning that if no other transceiver is testing, that
> should
>> return 0. If some other transceiver is active, it should increment with
> the
>> proper interval depending on how long the test is active.
>> 
>> You might realise why I have not yet implemented these commands. They
>> require a bit of timing accuracy that we currently do not really have in
> the LE
>> only emulator.
> 
> Thanks for the reply. Then I probably skip this one and work on the other
> commands as well.
> Listed below are few missing LE commands that I am planning to work on le.c
> which requires suggestion:
> 1) BT_HCI_CMD_READ_TX_POWER
> 2) BT_HCI_CMD_READ_RSSI
> 3) BT_HCI_CMD_LE_CONN_UPDATE
> 4) BT_HCI_CMD_LE_SET_HOST_CLASSIFICATION
> 5) BT_HCI_CMD_LE_READ_CHANNEL_MAP
> 
> 
> Apart from that is there any specific reason why BDADDR for LE is not
> created/used anywhere in le.c,
> whereas in btdev.c it was created and used wherever necessary?
> Because of this, LE emulator never gets up, since le.c is using
> 00:00:00:00:00:00 as BDADDR.
> Does it need to be fixed as in btdev?

the explicit intent is that emulator/le.c provide a LE only single mode controller without a public BD_ADDR. So this means that you have to use Set Static Address management command to first set an identity address.

> One more thing, I am not able to write/read the local name for LE
> emulator(le.c).
> The cmd itself it not supported right now. Is it good to be fixed?

LE only single mode controllers do not support HCI command for local name. That is a BR/EDR only feature.

Regards

Marcel

