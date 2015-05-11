Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Can't update remote name in function of "hci_check_pending_name" because of discov->state == DISCOVERY_STOPPED
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAAJ3C+iyc+YwWBPpoQnnQKmCb3oJ3weaDtxvEfUb9FwRqWx9Q@mail.gmail.com>
Date: Mon, 11 May 2015 19:15:53 +0200
Cc: jpawlowski@google.com, armansito@chromium.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BE452B3B-EF90-4389-8B1C-878EF3DBA0C5@holtmann.org>
References: <CAAAJ3C+iyc+YwWBPpoQnnQKmCb3oJ3weaDtxvEfUb9FwRqWx9Q@mail.gmail.com>
To: Ethan <ethancsge@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

so first of all, you need to stop sending HTML emails to the mailing list. They will not get through and are not helping you in getting attention.

> We found this issue in Chromebook with kernel 3.14. From btmon, Stack received event of Remote Name Req Complete with Device name “Name: VGP-BMS21”, but it’s after @ Discovering: 0x00 (7). It means le_scan_disable_work_complete set discover status to STOPPED for starting new discovery which caused hci_check_pending_name return without update the name information because discovery status is STOPPED. Then user space will always get null name, even hci_remote_name_evt shows everything is correct at HCI layer.
> 
> Is it possible setting LE Set Scan Enable to disable after Remote Name Req Complete? Or adding condition for hci_discovery_set_state(hdev, DISCOVERY_STOPPED) in function of le_scan_disable_work_complete?

I have been asking for mgmt-tester test cases for simultaneous discovery for a while. Getting this feature tested in more detail and reproducible is needed. Things need to happen reliable.

I am not convinced that the name request result is something that I would consider relevant. If it comes in too late, then it comes in too late. Bad luck. However the code should have send a HCI Remote Name Request Cancel command to actual free the baseband resources in case this is ongoing.

Now the real question might be is if we disable LE scanning after the time and continue trying to resolve BR/EDR names that still need resolving. Even these days with 4.2 out the door, there are still new devices that do not want to include their name in EIR and behave like 2.0 and earlier devices.

I feel really uncomfortable trying to change anything until we have mgmt-tester test case that can be run on a regular basis and ensuring the behavior stays the same.

Regards

Marcel

