Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: hciuart: Add support QCA chipset for
 UART
To: Marcel Holtmann <marcel@holtmann.org>
References: <55BAB444.8070306@qca.qualcomm.com>
 <C0463D0B-A1C3-400A-B842-873F49AA72F1@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Message-ID: <55C28766.3080001@qca.qualcomm.com>
Date: Wed, 5 Aug 2015 15:00:06 -0700
MIME-Version: 1.0
In-Reply-To: <C0463D0B-A1C3-400A-B842-873F49AA72F1@holtmann.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/31/15 09:42, Marcel Holtmann wrote:
>
>> +	unsigned long flags;
>> +	void *hci_uart; /* keeps the hci_uart pointer for reference */
> I do not like this. I need to see if this can not be done better with private data or other accessor functions.

I will use struct hci_uart* type instead of void*. But we still need this because workqueue handler is using hci_uart pointer

+}
+
+static void qca_wq_awake_rx(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_awake_rx);
+	struct hci_uart *hu = (struct hci_uart *)qca->hci_uart;
+
+	BT_DBG(" %p wq awake rx", hu);
+
+	serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_ON, hu);
+
+	spin_lock(&qca->hci_ibs_lock);
+	qca->rx_ibs_state = HCI_IBS_RX_AWAKE;
+
+	/* Always acknowledge device wake up,
+	 * sending IBS message doesn't count as TX ON
+	 */
+	if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0)
+		BT_ERR("cannot acknowledge device wake up");
+
+	qca->ibs_sent_wacks++; /* debug */
+
+	spin_unlock(&qca->hci_ibs_lock);
+
+	/* actually send the packets */
+	hci_uart_tx_wakeup(hu);
+}
+
+static void qca_wq_serial_rx_clock_vote_off(struct work_struct *work)
+{
+	struct qca_data *qca = container_of(work, struct qca_data,
+					    ws_rx_vote_off);
+	struct hci_uart *hu = (struct hci_uart *)qca->hci_uart;

> I am not really convinced this is a good idea. I think the serial stuff should be abstracted in the serial driver or via some common stuff.

Yeah but in workqueue structure, it is only way to access hci_uart pointer in work queue handler. I can find similar code on hci_ath.c code to have a hci_uart pointer in ath_data and use it on workqueue handler.

>> +
>> +}
>> +
>> +/* Initialize protocol */
>> +static int qca_open(struct hci_uart *hu)
>> +{
>> +	struct qca_data *qca;
>> +
>> +	BT_DBG("hu %p qca_open", hu);
>> +
>> +	qca = kzalloc(sizeof(struct qca_data), GFP_ATOMIC);
>> +	if (!qca)
>> +		return -ENOMEM;
>> +
>> +	skb_queue_head_init(&qca->txq);
>> +	skb_queue_head_init(&qca->tx_wait_q);
>> +	spin_lock_init(&qca->hci_ibs_lock);
>> +	qca->workqueue = create_singlethread_workqueue("qca_wq");
>> +	if (!qca->workqueue) {
>> +		BT_ERR("QCA Workqueue not initialized properly");
>> +		kfree(qca);
>> +		return -ENOMEM;
>> +	}
> Explain to me why you need your own work queue?

Ths is for sleep control to trigger 0xFE/0xFC packet to controller. if there is NO activity on the hci_qca driver during 2s, it should trigger 0xFE packet to controller going to the sleep and controller will send us back 0xFC as acknowledge. Controller does use same sequences / packets. If want to wake up the host/controller, 0xFD is triggered. In order to invoke this IBS command, workqueue is needed.
  
>> +
>> +static int qca_event_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>> +{
>> +	int ret;
>> +
>> +	rome_debug_dump(skb->data, skb->len, false);
>> +	ret = rome_vendor_frame(hdev, skb);
>> +	if (!ret)
>> +		ret = hci_recv_frame(hdev, skb);
>> +
> I think all the vendor hacking around and making this a proper cmd complete event should go here. Or we just start creating some new __hci_cmd_sync. Have you actually looked at using __hci_cmd_sync_ev since that should allow you to wait for a specific event.

I think __hci_cmd_sync_ev() would be fine. I'll use this function.

>
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
-- Ben Kim
