Return-Path: <cyrus@holtmann.org>
Message-ID: <4D76ADFD.5080708@gmail.com>
Date: Tue, 08 Mar 2011 14:30:21 -0800
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

alright..

<------clip --------->

  finally had time to get online and look at this issue. from playing 
around(hopefully)I found the trouble spot in of which this is 
hitting(but could be wrong).

By doing the below:

 From ff80f03c351018b53a630de8f256137a7af8f00c Mon Sep 17 00:00:00 2001
From: Justin P. Mattock <justinmattock@gmail.com>
Date: Tue, 8 Mar 2011 13:28:22 -0800
Subject: [PATCH] test
  Signe-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
  net/bluetooth/hci_core.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c4541b..9b8f425 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -99,8 +99,8 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, 
int result)
  	 * command requests) check if the completed command matches
  	 * this, and if not just return. Single HCI command requests
  	 * typically leave req_last_cmd as 0 */
-	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
-		return;
+	/*if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
+		return; */

  	if (hdev->req_status == HCI_REQ_PEND) {
  		hdev->req_result = result;
-- 
1.7.4.1


I am able to have a clean connect every reboot and hard shutdown/start.

strange thing with this, is I was able to have a clean connect on the 
current with nothing added or removed(but only one time out of 6 
restarts) with the above every time.

if you guys need any info let me know and/or if you want me to test 
anything out(keep in mind I am limited to intranet so I might take some 
time to respond)

Justin P. Mattock



