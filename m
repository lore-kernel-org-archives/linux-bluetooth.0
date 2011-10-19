Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 19 Oct 2011 09:17:16 +0200
Subject: LE discovery procedure
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DC6AADCE@dnce01.ent.ti.com>
References: <4E9E65FF.1000400@globaledgesoft.com>
In-Reply-To: <4E9E65FF.1000400@globaledgesoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I'm trying to figure out how the current implementation of the discovery procedure for LE. I'm using the mgmtops plugin, and a rather recent version of the Bluetooth-next git.
My reference is Bluetooth Core 4.0, Part C, 9.2 Discovery modes and precoedures.

According to the code in hci_event.c :
----->8------------------
static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
						struct sk_buff *skb)
{
	u8 num_reports = skb->data[0];
	void *ptr = &skb->data[1];
	s8 rssi;

	hci_dev_lock(hdev);

	while (num_reports--) {
		struct hci_ev_le_advertising_info *ev = ptr;

		hci_add_adv_entry(hdev, ev);

		rssi = ev->data[ev->length];
		mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
								ev->length);

		ptr += sizeof(*ev) + ev->length + 1;
	}

	hci_dev_unlock(hdev);
}
-----8<------------------

In this code, we use the hci_add_adv_entry to add the device to the connectable list, without even looking at the eir data itself. We simply check if it is connectable by checking the evt_type to be either ADB_IND or ADV_DIRECT_IND.

After that, a mgmt_device_found event is fired, which is then translated into btd_event_device_found, and then into adapter_update_found_devices, which calls adapter_emit_device_found. At no point there is a check for flags value, other than making sure it's not <0 for LE indication.

According to the spec, there are 3 discoverable modes available : None, Limited and general. Here's how the spec defines General discovery procedure :
"The Host shall check for the Flags AD type in the advertising data. If the Flags
AD type is present and either the LE General Discoverable Mode flag is set to
one or the LE Limited Discoverable Mode flag is set to one then the Host shall
consider the device as a discovered device, otherwise the advertising data
shall be ignored."

We do not do that right now. Moreover - we simply ignore the flags, and just treat every advertising event as device found.

Am I missing something here ? If not, I am going to sumbit a patch for fixing this, like this :

----->8------------------
#define EIR_FLAGS	0x01
static inline int get_le_discoverable_mode(struct hci_ev_le_advertising_info *ev)
{
	u8 *eir_data = ev->data;
	u8 idx = 0;

	if (!is_connectable_adv(ev->evt_type))
		return 0;

	while (idx < HCI_MAX_EIR_LENGTH - 1) {
		u8 field_len = ev->data[0];
		if (field_len == 0)
			break;
		switch (ev->data[1]) {
		case EIR_FLAGS:
			return eir_data[2] & 0x3;
		default:
			break;
		}
		idx += field_len + 1;
		eir_data += field_len + 1;
	}
	return 0;
}

static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
						struct sk_buff *skb)
{
	u8 num_reports = skb->data[0];
	void *ptr = &skb->data[1];
	s8 rssi;

	hci_dev_lock(hdev);

	while (num_reports--) {
		struct hci_ev_le_advertising_info *ev = ptr;

		if (get_le_discoverable_mode(ev) > 0) {
			hci_add_adv_entry(hdev, ev);

			rssi = ev->data[ev->length];
			mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
								ev->length);
		}
		ptr += sizeof(*ev) + ev->length + 1;
	}

	hci_dev_unlock(hdev);
}
-----8<------------------

A proper patch will be sent once I get to test this properly.

Thanks,
Chen Ganir
