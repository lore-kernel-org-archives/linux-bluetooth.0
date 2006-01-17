Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <005e01c61b2b$d7bdc640$6ceda8c0@accelsemi>
From: "wzhang" <wzhang@accelsemi.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: [Bluez-devel] The state machine of LMP
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 Jan 2006 14:04:08 +0800

SGkgZ3V5cywNCiAgICBJIGVuY291bnRlciBhIHByb2JsZW0gZHVyaW5nIHRoZSBpbXBsZW1lbnRh
dGlvbiBvZiBMTVAgbGF5ZXIgb2YgQlQgcHJvdG9jb2wgc3RhY2sgaW4gYSBwcm9qZWN0OiBUaGUg
c3RhdGVzIG9mIExNUCBsYXllciBhcmUgc28gbWFueSB0aGF0IHRoZSBzdHJ1Y3R1cmUgb2YgZG9p
bmcgaXQgaXMgYmlnLg0KICAgIFRoZSBCVCBjb3JlIHNwZWMgZG9lc24ndCBwcm92aWRlIGEgZnVs
bCBzdGF0ZSBtYWNoaW5lLldobyBjYW4gZ2l2ZSBtZSBzb21lIGFkdmljZXMgYWJvdXQgTE1QIGlt
cGxlbWVudGF0aW9uIC4NCiAgICBUaGFua3MgYWhlYWQhDQoNCg0KDQpDbGlmZg==



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
