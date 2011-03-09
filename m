Return-Path: <cyrus@holtmann.org>
Message-ID: <4D77EFEB.1020804@gmail.com>
Date: Wed, 09 Mar 2011 13:23:55 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Mikko Vinni <mmvinni@yahoo.com>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com> <20110302140055.GA15047@jh-x301> <574436.88358.qm@web161820.mail.bf1.yahoo.com> <20110303143154.GA2342@jh-x301> <359639.21781.qm@web161807.mail.bf1.yahoo.com>
In-Reply-To: <359639.21781.qm@web161807.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


looking more into this issue I am noticing that it seems this might be a 
timing issue. I have tried adding msleep to the function but endedup 
having a system freeze(only because I am not sure how msleep 
works)udelay I have not played around with just yet.

the below patch gets everything working for me:


 From 8065e37b546cdf6e42a5de4277e08ebba0a18637 Mon Sep 17 00:00:00 2001
From: Justin P. Mattock <justinmattock@gmail.com>
Date: Tue, 8 Mar 2011 22:01:19 -0800
Subject: [PATCH] bluetooth_bug_fix_test_1
  Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
  net/bluetooth/hci_core.c |   11 +++++------
  1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c4541b..f690eb5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -95,18 +95,17 @@ void hci_req_complete(struct hci_dev *hdev, __u16 
cmd, int result)
  {
  	BT_DBG("%s command 0x%04x result 0x%2.2x", hdev->name, cmd, result);

+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = result;
+		hdev->req_status = HCI_REQ_DONE;
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
  	/* If the request has set req_last_cmd (typical for multi-HCI
  	 * command requests) check if the completed command matches
  	 * this, and if not just return. Single HCI command requests
  	 * typically leave req_last_cmd as 0 */
  	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
  		return;
-
-	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = result;
-		hdev->req_status = HCI_REQ_DONE;
-		wake_up_interruptible(&hdev->req_wait_q);
-	}
  }

  static void hci_req_cancel(struct hci_dev *hdev, int err)
-- 
1.7.4.1


I have done multiple reboots warm/cold and the bluetooth connects 
everytime with the above. If this seems to be a good solution let me 
know, if its not then maybe udelay/msleep is better(or not!)

Justin P. Mattock
