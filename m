Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110728084948.GA13243@dell>
References: <CABUK1ahn-HxWWwaqO=eeYUvLoJcBRLeg1Z+sPikRTbg=zimYWQ@mail.gmail.com>
	<20110728084948.GA13243@dell>
Date: Thu, 28 Jul 2011 11:11:25 -0500
Message-ID: <CABUK1aiSG4JHMEB-EB+Po_oTWTpAvYPvW1Ku8rn2R=96DKnrdA@mail.gmail.com>
Subject: Re: can adapters have a say in automatic setup procedure?
From: Pavan Savoy <pavan_savoy@sify.com>
To: Pavan Savoy <pavan_savoy@sify.com>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 28, 2011 at 3:49 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Pavan,
>
> On Wed, Jul 27, 2011, Pavan Savoy wrote:
>> The patch mentioned below seem to power on the adapters for before
>> they are being actually used and the user-space bluetoothd exists.
>> I am not sure in what situations or what sort of adapters would
>> require such information to be available before-hand, even before the
>> adapter is intended to be used.
>
> The reason why this behavior was implemented is that there's absolutely
> nothing user-space can do with an adapter for which we don't even know
> the Bluetooth address. Since adapter-specific configuration is stored in
> /var/lib/bluetooth/<address>/config user-space doesn't even know if the
> adapter should be kept switched off or not without switching it on at
> least once (to read the address).
>
> With the new management interface the existence of adapters isn't even
> reported to user space (MGMT_EV_INDEX_ADDED) before they've been
> switched on and had the basic information fetched about them.
>
> *If* there's no user-space available the kernel has a timer to switch
> the adapter back off, but I guess this isn't helpful for you since you
> just want to postpone hdev->open() to the last possible moment.
>
>> However, what I would really like is the adapters to have say in this.
>> I do-not want my bluetooth device to be accessed before the bluetooth
>> user-space exists, Because I would require to do a bunch of
>> initialization upon hdev->open of my interface, which I don't want to
>> go thru' just to provide information.
>>
>> So please suggest on this....
>
> Maybe a module parameter to disable this "auto-on" feature? The problem
> with that would be that it wouldn't really work with the management
> interface (like I pointed out above). Another option would be to make
> the kernel wait until it gets some indication that user-space is
> available and only after that proceed with doing this auto-on for all
> available adapters (after which they'd all be reported to user-space
> through ev_index_added).
>
> I'd also like to get some comment from Marcel about this since the
> feature was originally his idea.

would a patch like this work ? where in each adapter can have the
AUTO_ON or some better name like MGMT feature required or not....
I kind of understand why this one's required, but what would be the
effects of not having this for an adapter ?

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 65d27af..0db4c18 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -327,6 +327,7 @@ static int bt_ti_probe(struct platform_device *pdev)
 	hdev->destruct = ti_st_destruct;
 	hdev->owner = THIS_MODULE;

+	set_bit(HCI_QUIRK_NOAUTOMATIC, &hdev->quirks);
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device error %d", err);
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 1f973ce..c7b6235 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -18,7 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-
+#define DEBUG
 #define pr_fmt(fmt)	"(stc): " fmt
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0489b8b..e864b5b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -60,7 +60,8 @@
 enum {
 	HCI_QUIRK_NO_RESET,
 	HCI_QUIRK_RAW_DEVICE,
-	HCI_QUIRK_FIXUP_BUFFER_SIZE
+	HCI_QUIRK_FIXUP_BUFFER_SIZE,
+	HCI_QUIRK_NOAUTOMATIC
 };

 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 908fcd3..257c4a9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -23,7 +23,7 @@
 */

 /* Bluetooth HCI core. */
-
+#define DEBUG
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/kmod.h>
@@ -1542,7 +1542,12 @@ int hci_register_dev(struct hci_dev *hdev)

 	set_bit(HCI_AUTO_OFF, &hdev->flags);
 	set_bit(HCI_SETUP, &hdev->flags);
-	queue_work(hdev->workqueue, &hdev->power_on);
+	if (!test_bit(HCI_QUIRK_NOAUTOMATIC, &hdev->quirks)) {
+		pr_debug("HCI_QUIRK_NOAUTOMATIC not set\n");
+		queue_work(hdev->workqueue, &hdev->power_on);
+	} else {
+		pr_debug("HCI_QUIRK_NOAUTOMATIC set");
+	}

 	hci_notify(hdev, HCI_DEV_REG);






> Johan
>
