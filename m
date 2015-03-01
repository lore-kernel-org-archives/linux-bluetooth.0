Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: HID fast reconnects broken on Linux 3.19 / BlueZ 5.28
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150228080724.GA11998@t440s.P-661HNU-F1>
Date: Sat, 28 Feb 2015 21:13:47 -0800
Cc: Petri Gynther <pgynther@google.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <1D092832-4533-4BC8-BED1-7A6C7B2817EF@holtmann.org>
References: <CAGXr9JFCzqUQXU7cLwPi0Q3_rinBd+A+kT2F=LxDJ75pPOiO4w@mail.gmail.com> <20150228080724.GA11998@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> We recently updated our platform to use Linux 3.19 and BlueZ 5.28.
>> 
>> I immediately noticed that HID remote control reconnects back to BlueZ
>> host got slower. It would often take 3-5 seconds for the host to see
>> the first keypress from HID remote.
>> 
>> Running "btmgmt info" reveals that hci0 is no longer "connectable" and
>> "fast-connectable".
> 
> We've never had code explicitly enabling fast-connectable, so that's at
> least not a regression.
> 
>> hci0: addr XX:XX:XX:XX:XX:XX version 6 manufacturer 72 class 0x000100
>> supported settings: powered connectable fast-connectable discoverable
>> bondable link-security ssp br/edr hs le advertising secure-conn
>> debug-keys privacy configuration
>> current settings: powered bondable ssp br/edr le secure-conn
>> name ...
>> short name ...
>> 
>> Regardless of the above, a previously paired HID remote is still able
>> to reconnect, so somewhere in BlueZ code the page scan must be turned
>> on.
>> 
>> I think what is missing from the code is that wherever page scan is
>> turned on, the page scan interval should be configured as well, when
>> fast reconnects are desired.
>> 
>> In order to work around this issue, I had to use the following patch
>> in src/adapter.c to force "connectable" and "fast-connectable" on at
>> all times:
>> 
>> @@ -7142,6 +7143,11 @@ static void read_info_complete(uint8_t status,
>> uint16_t length,
>> 
>>        if (adapter->current_settings & MGMT_SETTING_POWERED)
>>                adapter_start(adapter);
>> +       else
>> +               set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
> 
> Powered defaulting to false is also not a regression - that's how the
> policy has been ever since BlueZ 5.0. The expectation is that higher
> software layers manage this.
> 
>> +       set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
>> +       set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
>> 
>> Can someone clarify how previously paired BT Classic devices reconnect
>> back to host when the hci interface is not connectable?
> 
> The major change you've discovered is a kernel-side whitelist for
> devices which can connect to us. Once you set up a device with
> bluetoothd it gets added to the kernel-side list using the Add Device
> mgmt command. The __hci_update_page_scan() function in
> net/bluetooth/hci_request.c decides what the state should be:
> 
> 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
> 	    disconnected_whitelist_entries(hdev))
> 		scan = SCAN_PAGE;
> 	else
> 		scan = SCAN_DISABLED;
> 
> The following piece of code in net/bluetooth/hci_event.c function
> hci_conn_request_evt() in turn decides whether to accept incoming
> connect requests:
> 
> 	/* Require HCI_CONNECTABLE or a whitelist entry to accept the
> 	 * connection. These features are only touched through mgmt so
> 	 * only do the checks if HCI_MGMT is set.
> 	 */
> 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
> 	    !test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
> 	    !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
> 				    BDADDR_BREDR)) {
> 		hci_reject_conn(hdev, &ev->bdaddr);
> 		return;
> 	}
> 
> The 'connectable' mgmt property (i.e. the HCI_CONNECTABLE flag) only
> describes general connectable mode, where any (even previously unknown)
> device is able to connect to us. With a recent kernel and user-space
> combination this setting is tied to the bondable and discoverable
> settings, i.e. you'd need to enable the Discoverable D-Bus property to
> get all these 'general' settings enabled.
> 
> This all said, I don't think anyone thought of how the 'fast-connectable'
> setting should behave in a system where 'connectable' is mostly set to
> false. My initial feeling is that it should be possible to use it to
> adjust our page scan settings whenever page scan is enabled, i.e. it
> shouldn't be strictly tied to 'connectable'. If that's not the case
> right now it's something that needs fixing.

I wonder if we just allow fast-connectable at all times to make this simple. We did restrict the fast-connectable setting to runtime and when connectable is enabled. We could just lift both of these restrictions.

However I do wonder if we should introduce a fast-connectable option 0x02 that also allows to provide a timeout value. Since always having fast-connectable on is a bit of a power drain. We want the option to keep fast-connectable for a certain amount of time after disconnect and if that timeout passes, then switch back to normal connectable settings.

At least that was the original intend when we actually introduced the fast-connectable setting.

Regards

Marcel

