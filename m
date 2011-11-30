Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 5/9] Bluetooth: LE scan infra-structure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1322497442.29909.36.camel@aeonflux>
Date: Wed, 30 Nov 2011 15:11:47 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <65E3B21D-EC4E-4443-ADAB-39576B981F70@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org> <1322265226-6404-6-git-send-email-andre.guedes@openbossa.org> <1322497442.29909.36.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 28, 2011, at 1:24 PM, Marcel Holtmann wrote:

> Hi Andre,
> 
>> This patch does the proper init of the structs required to carry
>> out LE scan and implement the LE scan work.
>> 
>> The LE scan work sends the commands (Set LE Scan Parameters and Set
>> LE Scan Enable) to the controller in order to start LE scanning. If
>> commands were executed successfully the le_scan_timer is set to
>> disable the ongoing scanning after some amount of time.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h |    1 +
>> net/bluetooth/hci_core.c    |   38 ++++++++++++++++++++++++++++++++++++++
>> net/bluetooth/hci_event.c   |    5 +++++
>> 3 files changed, 44 insertions(+), 0 deletions(-)
> 
> combine patch 4 and 5 since the split is weird.

Ok.

> 
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index b7c6452..6e2b88f 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -130,6 +130,7 @@ enum {
>> #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
>> #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
>> #define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
>> +#define HCI_LE_SCAN_TIMEOUT	(3000)	/* 3 seconds */
>> 
>> /* HCI data types */
>> #define HCI_COMMAND_PKT		0x01
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 28ef2ac..8e96e3b 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -981,6 +981,33 @@ static void hci_power_on(struct work_struct *work)
>> 		mgmt_index_added(hdev);
>> }
>> 
>> +static void le_scan_req(struct hci_dev *hdev, unsigned long opt)
>> +{
>> +	struct le_scan_params *params = (void *) opt;
>> +
>> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +		return;
>> +
>> +	send_le_scan_param_cmd(hdev, params->type, params->interval,
>> +							params->window);
>> +	send_le_scan_enable_cmd(hdev, 1);
>> +}
>> +
>> +static void hci_le_scan(struct work_struct *work)
>> +{
>> +	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan);
>> +	struct le_scan_params *params = &hdev->le_scan_params;
>> +	int err;
>> +
>> +	err = hci_request(hdev, le_scan_req, (unsigned long) params,
>> +					msecs_to_jiffies(HCI_LE_SCAN_TIMEOUT));
>> +	if (err < 0)
>> +		return;
>> +
>> +	mod_timer(&hdev->le_scan_timer, jiffies +
>> +					msecs_to_jiffies(params->timeout));
>> +}
>> +
>> static void hci_power_off(struct work_struct *work)
>> {
>> 	struct hci_dev *hdev = container_of(work, struct hci_dev,
>> @@ -1447,6 +1474,13 @@ int hci_add_adv_entry(struct hci_dev *hdev,
>> 	return 0;
>> }
>> 
>> +static void le_scan_timeout(unsigned long arg)
>> +{
>> +	struct hci_dev *hdev = (void *) arg;
>> +
>> +	send_le_scan_enable_cmd(hdev, 0);
>> +}
>> +
>> /* Register HCI device */
>> int hci_register_dev(struct hci_dev *hdev)
>> {
>> @@ -1500,6 +1534,8 @@ int hci_register_dev(struct hci_dev *hdev)
>> 	skb_queue_head_init(&hdev->raw_q);
>> 
>> 	setup_timer(&hdev->cmd_timer, hci_cmd_timer, (unsigned long) hdev);
>> +	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
>> +							(unsigned long) hdev);
>> 
>> 	for (i = 0; i < NUM_REASSEMBLY; i++)
>> 		hdev->reassembly[i] = NULL;
>> @@ -1526,6 +1562,7 @@ int hci_register_dev(struct hci_dev *hdev)
>> 						(unsigned long) hdev);
>> 
>> 	INIT_WORK(&hdev->power_on, hci_power_on);
>> +	INIT_WORK(&hdev->le_scan, hci_le_scan);
>> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
>> 
>> 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
> 
> I am beginning to question how many work structs we really want here.
> And more important that we need to ensure that they are scheduled from
> the main workqueue that we have per HCI controller.
> 
> And while at this, we might wanna actually move away from tasklets
> finally so that we actually can sleep and can reduce the number of work
> structs here. I am open for ideas.
> 
> Regards
> 
> Marcel
> 
> 

Andre
