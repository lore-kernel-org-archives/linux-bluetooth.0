Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 17 Dec 2009 15:44:45 +0200
Message-ID: <eb7933e20912170544p2d07fc0endc0c50026e42f8c1@mail.gmail.com>
Subject: [PATCH] spurious disconnection attempt
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e652f6b0734ec1047aecd3b5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e652f6b0734ec1047aecd3b5
Content-Type: text/plain; charset=ISO-8859-1

This sequence can happen when disconnecting the MOTOROKR T505

2009-11-27 12:05:30.636932 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048
2009-11-27 12:05:30.637054 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
2009-11-27 12:05:30.822540 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 11 packets 1
2009-11-27 12:05:30.985656 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x13
    Reason: Remote User Terminated Connection
2009-11-27 12:05:32.655273 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 0 reason 0x13
    Reason: Remote User Terminated Connection
2009-11-27 12:05:32.661621 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters

A similar situation (trying to disconnect handle 0) can occur by
increasing the timeout value DISCONNECT_TIMER in src/device.c (default
is 2).

The problem seems to be that bluetoothd still calls
src/device.c:do_disconnect even though the link has been disconnected.
Attaching a patch proposal for function device_remove_connection to
try to avoid this. The function looks to be called only when there is
no longer an hci connection to the remote.

/Daniel

--0016e652f6b0734ec1047aecd3b5
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-adding-removal-of-disconnect-timer-to-avoid-spurious.patch"
Content-Disposition: attachment;
	filename="0001-adding-removal-of-disconnect-timer-to-avoid-spurious.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3bkukyh0

RnJvbSAxNWRhNGRjNWFlNjYyMzVmNzI3NDAwODkzOGVkMGEyMTQxMjYzNGQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgT3JzdGFkaXVzIDxkYW5pZWwub3JzdGFkaXVzQGdt
YWlsLmNvbT4KRGF0ZTogVGh1LCAxNyBEZWMgMjAwOSAxNToyOTo1MSArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIGFkZGluZyByZW1vdmFsIG9mIGRpc2Nvbm5lY3QgdGltZXIgdG8gYXZvaWQgc3B1cmlv
dXMgZGlzY29ubmVjdGlvbiBhdHRlbXB0CgotLS0KIHNyYy9kZXZpY2UuYyB8ICAgIDUgKysrKysK
IDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NyYy9kZXZpY2UuYyBiL3NyYy9kZXZpY2UuYwppbmRleCAxN2U0ZWExLi41MTNhODEz
IDEwMDY0NAotLS0gYS9zcmMvZGV2aWNlLmMKKysrIGIvc3JjL2RldmljZS5jCkBAIC03NjUsNiAr
NzY1LDExIEBAIHZvaWQgZGV2aWNlX3JlbW92ZV9jb25uZWN0aW9uKHN0cnVjdCBidGRfZGV2aWNl
ICpkZXZpY2UsIERCdXNDb25uZWN0aW9uICpjb25uLAogCiAJZGV2aWNlLT5oYW5kbGUgPSAwOwog
CisJaWYgKGRldmljZS0+ZGlzY29ubl90aW1lciA+IDApIHsKKwkJZ19zb3VyY2VfcmVtb3ZlKGRl
dmljZS0+ZGlzY29ubl90aW1lcik7CisJCWRldmljZS0+ZGlzY29ubl90aW1lciA9IDA7CisJfQor
CiAJd2hpbGUgKGRldmljZS0+ZGlzY29ubmVjdHMpIHsKIAkJREJ1c01lc3NhZ2UgKm1zZyA9IGRl
dmljZS0+ZGlzY29ubmVjdHMtPmRhdGE7CiAKLS0gCjEuNi4wLjQKCg==
--0016e652f6b0734ec1047aecd3b5--
