Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Some notes about device provisioning
Message-Id: <D68AA3DF-B2CF-4904-8F4E-C3D7C80CD2AF@holtmann.org>
Date: Mon, 7 Jul 2014 10:26:31 +0200
To: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

from now on every Bluetooth controller can be in one of three different states. It is either in raw-only mode, unconfigured state or configured state.

The raw-only mode means that the controller will not be recognized as general purpose device. It just provides the HCI transport and the only means of access is via HCI user channel socket. This mode is useful for sniffer devices or special boot protocol modes. This mode has always existing, but is now enforced strongly.

The raw-only mode controllers are not announced via management interface. No Index Added or Index Removed event will be issued. The HCI_RAW flag will be set for these controllers clearly indicating that only HCI user channel socket can be used to access it.

The unconfigured state is new addition and it means that the device is registered and can be used for general purpose operation. However it requires additional configuration. One example here is that the Bluetooth public device address is not valid.

Controllers in unconfigured state are announced via management interface using Unconfigured Index Added and Unconfigured Index Removed events. These events are now send instead of Index Added and Index Removed events. Only limited management commands are supported in this state. One of them is Set Public Address and once executed, the controller can transition over into configured state. HCI user channel is the only other mode of operation. This fact is clearly indicated via the HCI_RAW flag similar to raw-only mode.

The configured state is the fully functional state of a controller. It is announced via management interface using Index Added and Index Removed. This is a fully functional general purpose controller. In this state, the HCI_RAW flag will not be set.

	State			Access methods
	--------------------------------------
	Raw-only mode		User channel
	Unconfigured state	User channel + limited mgmt API
	Configured state	User channel + full mgmt API

Controllers in raw-only mode stay in raw-only mode. They can not change to unconfigured or configured state without a full device reset. For example some USB bootloaders will just do a full USB reset.

>From the unconfigured state it is possible to enter the configured state and thus transition to fully operational mode without a device reset.

	-> Unconfigured Index Added
	<- Read Controller Configuration Information
		Missing options: public-address
	<- Set Public Address
	-> New Configuration Options
		Missing options: none
	-> Unconfigured Index Removed
	-> Index Added
	<- Read Controller Information
	...
	<- Set Powered

The commands and events are designed in a way that there is no need to handle the unconfigured state within bluetoothd. It can be easily handled via an external program. However a more generic option might be added to bluetoothd in the future. One example would be to generate random addresses for development purposes.

Currently this is supported by Intel and Broadcom Bluetooth controllers, but adding support for other manufacturers is simple. The kernel driver only needs to provide support for hdev->set_bdaddr callback to implement the vendor specific command for public address configuration. And in case of invalid addresses set HCI_QUIRK_INVALID_BDADDR.

Regards

Marcel

