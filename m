Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 26 Feb 2010 21:32:03 +0800
Message-ID: <6aeb672b1002260532v6e209d7dr8370003463334b3@mail.gmail.com>
Subject: [PATCH] Allow disable park state in main.conf
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001485ec0e58c6ca3a048080ec38
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001485ec0e58c6ca3a048080ec38
Content-Type: text/plain; charset=ISO-8859-1

Currently BlueZ is reading a bunch of configuration from main.conf.
However it hard-codes the default link policy to enable role switch,
hold mode, park state and sniff mode. We've found that there're some
Bluetooth devices such as Motorola HF850 can't work well when park
state is enabled. Once the link is parked, the Motorola HF850 car-kit
will fail to unpark and lose connection. After that the car-kit will
keep re-connect and disconnect. Also, if it's the remote device who
initiates connection, the connection will be stable but once the link
is in park state, the SCO connection can't be setup. Feedback from
accessory team is that park state often causes some interoperability
problem so it's used rarely now.

Because these devices have been available on market, one option is to
turn off park state on the phone side. Instead of making a blacklist
to include devices who have problem with park state, adding a single
configuration item to disable park state will provide the flexibility
with limited change. Default value for this configuration item will be
false to keep current behavior unchanged.

Here's the log captured with the HF850 and a Droid phone. Note
entering park state at 14:58:40.534427 and the connection timeout at
2010-01-05 14:58:46.372714. The Droid will keep entering park state,
detect timeout and accept re-connection.

2010-01-05 14:58:34.456210 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x02 interval 2048
    Mode: Sniff
2010-01-05 14:58:34.940677 > ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 1 ilen 10 fcs 0x2d credits 1
      A T + N R E C = 0 .
2010-01-05 14:58:34.951480 < ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x004d len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 6 fcs 0xeb
      . . O K . .
2010-01-05 14:58:36.217044 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2010-01-05 14:58:37.500095 > ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 1 ilen 10 fcs 0x2d credits 1
      A T + C C W A = 1 .
2010-01-05 14:58:37.506900 < ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x004d len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 6 fcs 0xeb
      . . O K . .
2010-01-05 14:58:38.777072 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2010-01-05 14:58:40.062412 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x00 interval 0
    Mode: Active
2010-01-05 14:58:40.534427 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x03 interval 1152
    Mode: Park
2010-01-05 14:58:46.372714 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout
2010-01-05 14:58:47.689975 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:50:CD:20:BA:E6 class 0x200404 type ACL
2010-01-05 14:58:47.690097 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
    bdaddr 00:50:CD:20:BA:E6 role 0x00
    Role: Master
2010-01-05 14:58:47.690616 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2010-01-05 14:58:47.851596 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:50:CD:20:BA:E6 role 0x00
    Role: Master
2010-01-05 14:58:47.961978 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:50:CD:20:BA:E6
2010-01-05 14:58:47.963748 < HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
    bdaddr 00:50:CD:20:BA:E6 key 9752FA7985E81F9282DCDD80FB9C2B40
2010-01-05 14:58:47.964450 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:50:CD:20:BA:E6
2010-01-05 14:58:48.076389 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:50:CD:20:BA:E6 type ACL encrypt 0x01
2010-01-05 14:58:48.076541 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2010-01-05 14:58:48.076602 > HCI Event: Page Scan Repetition Mode
Change (0x20) plen 7
    bdaddr 00:50:CD:20:BA:E6 mode 1
2010-01-05 14:58:48.077579 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2010-01-05 14:58:48.079257 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2010-01-05 14:58:48.079776 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004e
2010-01-05 14:58:48.079898 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004e result 1 status 0
      Connection pending - No futher information available
2010-01-05 14:58:48.079959 < ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2010-01-05 14:58:48.083896 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 2
2010-01-05 14:58:48.092990 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
2010-01-05 14:58:48.098422 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:50:CD:20:BA:E6 mode 2 clkoffset 0x0000
2010-01-05 14:58:48.098941 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2010-01-05 14:58:48.101444 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2010-01-05 14:58:48.101596 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004e result 0 status 0
      Connection successful

--001485ec0e58c6ca3a048080ec38
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-Allow-disable-park-state-in-main.conf.patch"
Content-Disposition: attachment;
	filename="0001-Allow-disable-park-state-in-main.conf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6255vf30

RnJvbSAzMzFiMTIwMTUzYzA0Njk0YzczNTU2YzAyODc0NTZhMTE4NzQyNTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW0gQmFvIDx0aW0uYmFvQGdtYWlsLmNvbT4KRGF0ZTogV2Vk
LCAyNCBGZWIgMjAxMCAyMDo0ODoyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFsbG93IGRpc2Fi
bGUgcGFyayBzdGF0ZSBpbiBtYWluLmNvbmYKCkN1cnJlbnRseSBCbHVlWiBpcyBoYXJkLWNvZGlu
ZyB0aGUgZGVmYXVsdCBsaW5rIHBvbGljeSB0byBpbmNsdWRlCmhvbGQgbW9kZSwgcm9sZSBzd2l0
Y2gsIHNuaWZmIG1vZGUgYW5kIHBhcmsgc3RhdGUuIEhvd2V2ZXIsIHNvbWUKZGV2aWNlIHdpbGwg
aGF2ZSBwcm9ibGVtIHRvIG1haW50YWluIHRoZSBjb25uZWN0aW9uIG9yIHNldHVwIFNDTwppZiB0
aGV5IGFyZSBpbiBwYXJrIHN0YXRlLiBNYWtpbmcgdGhlIHBhcmsgc3RhdGUgY29uZmlndXJhYmxl
IGluCm1haW4uY29uZiBpbXByb3ZlcyBmbGV4aWJpbGl0eSBzbyBpdCBjYW4gYmUgZGlzYWJsZWQg
d2hlbiBuZWVkZWQuCgpTaWduZWQtb2ZmLWJ5OiBUaW0gQmFvIDx0aW0uYmFvQGdtYWlsLmNvbT4K
LS0tCiBzcmMvbWFpbi5jICAgIHwgICAxMyArKysrKysrKystLS0tCiBzcmMvbWFpbi5jb25mIHwg
ICAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NyYy9tYWluLmMgYi9zcmMvbWFpbi5jCmluZGV4IDAxNGQ4YjYu
Ljk3N2M4N2IgMTAwNjQ0Ci0tLSBhL3NyYy9tYWluLmMKKysrIGIvc3JjL21haW4uYwpAQCAtMjAx
LDEwICsyMDEsMTIgQEAgc3RhdGljIHZvaWQgcGFyc2VfY29uZmlnKEdLZXlGaWxlICpjb25maWcp
CiAJZWxzZQogCQltYWluX29wdHMubmFtZV9yZXNvbHYgPSBib29sZWFuOwogCi0JbWFpbl9vcHRz
LmxpbmtfbW9kZSA9IEhDSV9MTV9BQ0NFUFQ7Ci0KLQltYWluX29wdHMubGlua19wb2xpY3kgPSBI
Q0lfTFBfUlNXSVRDSCB8IEhDSV9MUF9TTklGRiB8Ci0JCQkJCQlIQ0lfTFBfSE9MRCB8IEhDSV9M
UF9QQVJLOworCWJvb2xlYW4gPSBnX2tleV9maWxlX2dldF9ib29sZWFuKGNvbmZpZywgIkdlbmVy
YWwiLAorCQkJCQkJIkRpc2FibGVQYXJrU3RhdGUiLCAmZXJyKTsKKwlpZiAoZXJyKQorCQlnX2Ns
ZWFyX2Vycm9yKCZlcnIpOworCWVsc2UgaWYgKGJvb2xlYW4pCisJCW1haW5fb3B0cy5saW5rX3Bv
bGljeSAmPSAofkhDSV9MUF9QQVJLKTsKIH0KIAogLyoKQEAgLTI3Niw2ICsyNzgsOSBAQCBzdGF0
aWMgdm9pZCBpbml0X2RlZmF1bHRzKHZvaWQpCiAJbWFpbl9vcHRzLnJlbWVtYmVyX3Bvd2VyZWQg
PSBUUlVFOwogCW1haW5fb3B0cy5yZXZlcnNlX3NkcCA9IFRSVUU7CiAJbWFpbl9vcHRzLm5hbWVf
cmVzb2x2ID0gVFJVRTsKKwltYWluX29wdHMubGlua19tb2RlID0gSENJX0xNX0FDQ0VQVDsKKwlt
YWluX29wdHMubGlua19wb2xpY3kgPSBIQ0lfTFBfUlNXSVRDSCB8IEhDSV9MUF9TTklGRiB8CisJ
CQkJSENJX0xQX0hPTEQgfCBIQ0lfTFBfUEFSSzsKIAogCWlmIChnZXRob3N0bmFtZShtYWluX29w
dHMuaG9zdF9uYW1lLCBzaXplb2YobWFpbl9vcHRzLmhvc3RfbmFtZSkgLSAxKSA8IDApCiAJCXN0
cmNweShtYWluX29wdHMuaG9zdF9uYW1lLCAibm9uYW1lIik7CmRpZmYgLS1naXQgYS9zcmMvbWFp
bi5jb25mIGIvc3JjL21haW4uY29uZgppbmRleCBiMjUyYTgyLi42Zjk3NWZjIDEwMDY0NAotLS0g
YS9zcmMvbWFpbi5jb25mCisrKyBiL3NyYy9tYWluLmNvbmYKQEAgLTUwLDMgKzUwLDggQEAgUmV2
ZXJzZVNlcnZpY2VEaXNjb3ZlcnkgPSB0cnVlCiAjIEVuYWJsZSBuYW1lIHJlc29sdmluZyBhZnRl
ciBpbnF1aXJ5LiBTZXQgaXQgdG8gJ2ZhbHNlJyBpZiB5b3UgZG9uJ3QgbmVlZAogIyByZW1vdGUg
ZGV2aWNlcyBuYW1lIGFuZCB3YW50IHNob3J0ZXIgZGlzY292ZXJ5IGN5Y2xlLiBEZWZhdWx0cyB0
byAndHJ1ZScuCiBOYW1lUmVzb2x2aW5nID0gdHJ1ZQorCisjIERpc2FibGUgcGFyayBzdGF0ZSBp
biBkZWZhdWx0IGxpbmsgcG9saWN5LiBTb21lIGRldmljZXMgaGF2ZSBjb25uZWN0aW9uCisjIHN0
YWJpbGl0eSBpc3N1ZSBvciBmYWlsIHRvIHNldHVwIFNDTyB3aGVuIHRoZSBsaW5rIGlzIGluIHBh
cmsgc3RhdGUuIERlZmF1bHRzCisjIHRvICdmYWxzZScuCitEaXNhYmxlUGFya1N0YXRlID0gZmFs
c2UKLS0gCjEuNS42LjMKCg==
--001485ec0e58c6ca3a048080ec38--
