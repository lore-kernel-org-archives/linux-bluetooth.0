Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Nov 2009 12:25:54 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        pm list <linux-pm@lists.linux-foundation.org>,
        Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org
Subject: Re: GPF in run_workqueue()/list_del_init(cwq->worklist.next) on
 resume (was: Re: Help needed: Resume problems in 2.6.32-rc, perhaps related
 to preempt_count leakage in keventd)
In-Reply-To: <1257970719.21467.4.camel@violet>
Message-ID: <alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl>  <200911100119.38019.rjw@sisk.pl>  <alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>  <200911111252.48214.rjw@sisk.pl>  <alpine.LFD.2.01.0911111142340.31845@localhost.localdomain>
 <1257970719.21467.4.camel@violet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>



On Wed, 11 Nov 2009, Marcel Holtmann wrote:
> 
> As it seems the btusb_close() only cancels the work workqueue and not
> the waker workqueue. Could that be the problem.

It's the waker workqueue that Rafael apparently sees with the debug patch 
from Oleg, so yeah, that sounds possible.

Rafael, since apparently htusb_close() _is_ called, does the following 
simpler patch fix it for you? I bet your patch does it too.

		Linus

---
 drivers/bluetooth/btusb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7ba91aa..2fb3802 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -591,6 +591,7 @@ static int btusb_close(struct hci_dev *hdev)
 		return 0;
 
 	cancel_work_sync(&data->work);
+	cancel_work_sync(&data->waker);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
