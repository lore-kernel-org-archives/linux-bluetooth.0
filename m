Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 4/5] Bluetooth: btbcm: Split setup() function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5555FE93.30401@linux.intel.com>
Date: Fri, 15 May 2015 19:17:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7CF6B366-744C-4F28-88BE-32EB138D8B0C@holtmann.org>
References: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com> <1431008699-6419-4-git-send-email-frederic.danis@linux.intel.com> <6F8C6327-C7F0-4081-B3A8-8A3A609C915E@holtmann.org> <5555FE93.30401@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>>> Split btbcm_setup_patchram in 3 functions : btbcm_setup_patchram,
>>> btbcm_patchram (already existing) and btbcm_setup_post.
>>> For UART controllers this will allow to reset speed to default one
>>> after firmware loading, which will have reseted controller speed to
>>> default one.
>>> 
>>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>>> ---
>>> drivers/bluetooth/btbcm.c   | 29 +++++++++++++++++------------
>>> drivers/bluetooth/btbcm.h   | 11 +++++++++--
>>> drivers/bluetooth/btusb.c   | 23 ++++++++++++++++++++++-
>>> drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
>>> 4 files changed, 66 insertions(+), 16 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>> index b258454..f2efbbd 100644
>>> --- a/drivers/bluetooth/btbcm.c
>>> +++ b/drivers/bluetooth/btbcm.c
>>> @@ -277,9 +277,8 @@ static const struct {
>>> 	{ }
>>> };
>>> 
>>> -int btbcm_setup_patchram(struct hci_dev *hdev)
>>> +int btbcm_setup_patchram(struct hci_dev *hdev, char *fw_name, size_t len)
>> 
>> what is this len for? The fw_name is not a return value. I think the functions for doing the patchram should just get a firmware and then just do patchram.
> 
> I split btbcm_setup_patchram() in 3 functions:
> - btbcm_setup_patchram() which resets the controller and returns the firmware name.
> - btbtcm_patchram() (already existing and public), which takes the firmware name as parameter, requests the firmware and loads it to the controller.
> - btbcm_setup_post() which resets the controller, reads local version and checks if the controller address is a default one or not.
> 
> I split it between btbcm_patchram() and btbcm_setup_post() as firmware loading may reset the controller UART speed and it needs to set host UART speed back to init speed.
> 
> I also split it between btbcm_setup_patchram() and btbtcm_patchram() because error is not managed the same way for both of them.
> When btbcm_setup_patchram() returns an error, this error is forwarded to caller.
> When btbtcm_patchram() returns an error, if the error is -ENOENT then this error is discarded and 0 is returned to caller. Otherwise, the error is also discarded but there is a need to call btbcm_setup_post() to reset controller.

my proposal to make this a bit smoother and have less changes is to keep the btbcm_setup_patchram as is. Lets keep using that as is for USB and introduce helper functions to be used by the UART side of things.

To get things moving, lets assume that firmware filename comes in from somewhere. Maybe coded in DTS or ACPI or something else. In the long run, we need to have a “manifest” file that lets us map original Broadcom firmware file names to platforms. For USB that will become simple since it is USB VID/PID map. For ACPI we can use the ACPI ID mapping. So my thinking is to use a simple table mapping modalias to filename and that be it. However I would put that a little bit as a problem to solve later and bring the basic UART and speed handling into place.

This means that UART setup routine should be doing this:

	- UART call to switch to default speed
		-> switch to default speed
	- btbcm_initialize()
	- UART call to switch operational speed
		-> trigger vendor command
		-> switch speed
	- btbcm_patchram()
	- UART call to switch to default speed
		-> switch to default speed
	- UART call to switch to operational speed
		-> trigger vendor command
		-> switch speed
	- btbcm_finalize()

Maybe default speed and operational speed changes should always be combined. We have to see there.

Regards

Marcel

