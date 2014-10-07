Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/6] test/map-client: Add D-Bus API support to make MASInstance
 request
Date: Tue, 07 Oct 2014 09:36:52 +0530
Message-id: <1412654816-14971-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/map-client | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/map-client b/test/map-client
index b9695da..a1666b2 100755
--- a/test/map-client
+++ b/test/map-client
@@ -66,6 +66,8 @@ def parse_options():
 			help="Undeletes the message")
 	parser.add_option("-u", "--update-inbox", action="store_true", dest="update_inbox",
 			help="Checks for new mails")
+	parser.add_option("-m", "--mas-instance-info", action="store_true", dest="get_mas_info",
+			help="Get MAS Instance Information")
 
 	return parser.parse_args()
 
@@ -172,6 +174,10 @@ class MapClient:
 	def update_inbox(self):
 		self.map.UpdateInbox()
 
+	def get_mas_instance_info(self):
+		ret = self.map.GetMASInstanceInfo()
+		print(pformat(unwrap(ret)))
+
 
 if  __name__ == '__main__':
 
@@ -229,4 +235,7 @@ if  __name__ == '__main__':
 	if options.update_inbox:
 		map_client.update_inbox()
 
+	if options.get_mas_info:
+		map_client.get_mas_instance_info()
+
 	mainloop.run()
-- 
1.9.1

