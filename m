Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Jul 2013 16:39:02 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?J=F6rg?= Esser <jackfritt@boh.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20130723233902.GA7835@x220.p-661hnu-f1>
References: <51E7ED11.7010103@boh.de>
 <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org>
 <51E8DBFF.4060702@boh.de>
 <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org>
 <20130719162051.GA7373@x220.p-661hnu-f1>
 <51ECDB03.8090109@boh.de>
 <4A86B920-6A47-4E2D-8F6F-90A626CFC878@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <4A86B920-6A47-4E2D-8F6F-90A626CFC878@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

On Mon, Jul 22, 2013, Marcel Holtmann wrote:
> >>>>> HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
> >>>>      Read Local Version Information (0x04|0x0001) ncmd 1
> >>>>        Status: Success (0x00)
> >>>>        HCI version: 2 - 0x2006
> >>>>        LMP version: 2 - 0x1806
> >>>>        Manufacturer: AVM Berlin (31)
> >>> it declares itself here as Bluetooth 1.2 device. Which means it is the
> >>> second generation of BlueFritz! USB device.
> >>> 
> >>> <snip>
> >>> 
> >>>> < HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 0.210014
> >>>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
> >>>>      Read Local Supported Commands (0x04|0x0002) ncmd 1
> >>>>        Status: Unknown HCI Command (0x01)
> >>> And here is your failing command. Newer kernels have been strict with
> >>> failing commands and will just abort the setup if anything goes wrong.
> >>> 
> >>> Johan, we need to figure out on how to work around this one. Might
> >>> just match for the manufacturer before sending the command.
> >> Either that or a quirk based on the USB id. Wouldn't matching just the
> >> manufacturer be a bit problematic for any newer chips from this company,
> >> or they stopped doing Bluetooth dongles after this one?
> > They stopped doing Bluetooth dongles after this one. I found no more
> > Product with bluetooth on their website.
> > The support from AVM endet on 01.12.2009.
> > As I read here http://www.wehavemorefun.de/fritzbox/BlueFRITZ!_USB
> 
> yes, they ever only made two products. And their baseband was based on
> Silicon Wave which actually got bought by Qualcomm if I remember this
> correctly. So going by the manufacturer id and adding a good comment
> into the code might make this work nicely again.
> 
> Johan, if you prefer a quirk, then go for that one.

Since we know that these are the only pieces of hardware that exist with
this manufacturer id I think it's simplest to just use that instead of
creating more code for this.

Attached is a patch that still needs to be tested. It might e.g. reveal
other commands that also fail with this hardware.

Johan

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Fix-HCI-init-for-BlueFRITZ-devices.patch"

>From 6c95ba1014b1949543fb16d3999fa3ed58e0f0d5 Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@intel.com>
Date: Wed, 24 Jul 2013 02:32:46 +0300
Subject: [PATCH] Bluetooth: Fix HCI init for BlueFRITZ! devices

None of the BlueFRITZ! devices with manufacurer ID 31 (AVM Berlin)
support HCI_Read_Local_Supported_Commands. It is safe to use the
manufacturer ID (instead of e.g. a USB ID specific quirk) because the
company never created any newer controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dc34bfa..d651aa7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -513,7 +513,10 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 
 	hci_setup_event_mask(req);
 
-	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
+	/* AVM Berlin (31), aka "BlueFRITZ!", doesn't support the read
+	 * local supported commands HCI command.
+	 */
+	if (hdev->manufacturer != 31 && hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (lmp_ssp_capable(hdev)) {
-- 
1.8.3.2


--ReaqsoxgOBHFXBhH--
