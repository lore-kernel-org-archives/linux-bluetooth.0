Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <7.0.0.10.0.20051121130729.0122d150@impulsesoft.com>
To: bluez-devel@lists.sourceforge.net
From: Pragya Gupta <pragya@impulsesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_14162703==_"
Subject: [Bluez-devel] Authentication failure
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
Date: Mon, 21 Nov 2005 13:14:24 +0530

--=====================_14162703==_
Content-Type: text/plain; charset="us-ascii"; format=flowed


Hi,

I have enabled authentication on BlueZ and I try to issue connection 
from another bluetooth device. I am seeing random behaviour with 
respect to authentication. Sometimes the authentication procedure 
goes through and a file "link_key" is created in /etc/bluetooth/.

But most of the times, I see a link key request and no response from BlueZ.
I am attaching the hcid.conf being used by me and also some logs (see 
below) collected using hcidump.

Please help me to understand if I am doing something incorrect.

Thanks and Regards
Pragya

-------------------------------------------------
[root@localhost bluetooth]# hcidump -X
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff

 > HCI Event: Connect Request (0x04) plen 10

   0000: 0e b3 5f 3e 04 00 1c 04 28 01                     .._>....(.
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
   0000: 0e b3 5f 3e 04 00 01                              .._>...

 > HCI Event: Command Status (0x0f) plen 4

   0000: 00 01 09 04                                       ....

 > HCI Event: Link Key Request (0x17) plen 6

   0000: 0e b3 5f 3e 04 00                                 .._>..

 > HCI Event: Connect Complete (0x03) plen 11

   0000: 10 2a 00 0e b3 5f 3e 04 00 01 00                  .*..._>....

 > HCI Event: Connect Request (0x04) plen 10

   0000: 0e b3 5f 3e 04 00 1c 04 28 01                     .._>....(.
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
   0000: 0e b3 5f 3e 04 00 01                              .._>...

 > HCI Event: Command Status (0x0f) plen 4

   0000: 00 01 09 04                                       ....

 > HCI Event: Link Key Request (0x17) plen 6

   0000: 0e b3 5f 3e 04 00
-------------------------------------------------


[root@localhost bluetooth]# hcidump -R
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff

 > 04 04 0A 0E B3 5F 3E 04 00 1C 04 28 01

< 01 09 04 07 0E B3 5F 3E 04 00 01

 > 04 0F 04 00 01 09 04
 > 04 17 06 0E B3 5F 3E 04 00
-------------------------------------------------
--=====================_14162703==_
Content-Type: application/octet-stream; name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid.conf"

IwojIEhDSSBkYWVtb24gY29uZmlndXJhdGlvbiBmaWxlLgojCiMgJElkOiBoY2lkLmNvbmYsdiAx
LjQgMjAwNC8wNC8yOSAyMDoxNDoyMSBob2x0bWFubiBFeHAgJAojCgojIEhDSWQgb3B0aW9ucwpv
cHRpb25zIHsKCSMgQXV0b21hdGljYWxseSBpbml0aWFsaXplIG5ldyBkZXZpY2VzCglhdXRvaW5p
dCB5ZXM7CgoJIyBTZWN1cml0eSBNYW5hZ2VyIG1vZGUKCSMgICBub25lIC0gU2VjdXJpdHkgbWFu
YWdlciBkaXNhYmxlZAoJIyAgIGF1dG8gLSBVc2UgbG9jYWwgUElOIGZvciBpbmNvbWluZyBjb25u
ZWN0aW9ucwoJIyAgIHVzZXIgLSBBbHdheXMgYXNrIHVzZXIgZm9yIGEgUElOCgkjCglzZWN1cml0
eSBhdXRvOwoKCSMgUGFpcmluZyBtb2RlCgkjICAgbm9uZSAgLSBQYWlyaW5nIGRpc2FibGVkCgkj
ICAgbXVsdGkgLSBBbGxvdyBwYWlyaW5nIHdpdGggYWxyZWFkeSBwYWlyZWQgZGV2aWNlcwoJIyAg
IG9uY2UgIC0gUGFpciBvbmNlIGFuZCBkZW55IHN1Y2Nlc3NpdmUgYXR0ZW1wdHMKCXBhaXJpbmcg
bXVsdGk7CgoJIyBQSU4gaGVscGVyCgkjcGluX2hlbHBlciAvdXNyL2Jpbi9ibHVlcGluOwoJcGlu
X2hlbHBlciAvZXRjL2JsdWV0b290aC9naXZlcGluOwoKCSMgRC1CdXMgUElOIGhlbHBlcgoJI2Ri
dXNfcGluX2hlbHBlcjsKfQoKIyBEZWZhdWx0IHNldHRpbmdzIGZvciBIQ0kgZGV2aWNlcwpkZXZp
Y2UgewoJIyBMb2NhbCBkZXZpY2UgbmFtZQoJIyAgICVkIC0gZGV2aWNlIGlkCgkjICAgJWggLSBo
b3N0IG5hbWUKCW5hbWUgIiVoLSVkIjsKCgkjIExvY2FsIGRldmljZSBjbGFzcwoJI2NsYXNzIDB4
MTIwMTA0OwoJY2xhc3MgMHgyNDA0MDAKCgkjIERlZmF1bHQgcGFja2V0IHR5cGUKCSNwa3RfdHlw
ZSBESDEsRE0xLEhWMTsKCgkjIElucXVpcnkgYW5kIFBhZ2Ugc2NhbgoJI2lzY2FuIGVuYWJsZTsg
Cglwc2NhbiBlbmFibGU7CgoJIyBEZWZhdWx0IGxpbmsgbW9kZQoJIyAgIG5vbmUgICAtIG5vIHNw
ZWNpZmljIHBvbGljeSAKCSMgICBhY2NlcHQgLSBhbHdheXMgYWNjZXB0IGluY29taW5nIGNvbm5l
Y3Rpb25zCgkjICAgbWFzdGVyIC0gYmVjb21lIG1hc3RlciBvbiBpbmNvbWluZyBjb25uZWN0aW9u
cywKCSMgICAgICAgICAgICBkZW55IHJvbGUgc3dpdGNoIG9uIG91dGdvaW5nIGNvbm5lY3Rpb25z
CgkjCgkjbG0gYWNjZXB0LG1hc3RlcjsKCSMKCWxtIGFjY2VwdDsKCgkjIERlZmF1bHQgbGluayBw
b2xpY3kKCSMgICBub25lICAgIC0gbm8gc3BlY2lmaWMgcG9saWN5CgkjICAgcnN3aXRjaCAtIGFs
bG93IHJvbGUgc3dpdGNoCgkjICAgaG9sZCAgICAtIGFsbG93IGhvbGQgbW9kZQoJIyAgIHNuaWZm
ICAgLSBhbGxvdyBzbmlmZiBtb2RlCgkjICAgcGFyayAgICAtIGFsbG93IHBhcmsgbW9kZQoJIwoJ
I2xwIGhvbGQsc25pZmY7CgkjCglscCByc3dpdGNoLGhvbGQsc25pZmYscGFyazsKCgkjIEF1dGhl
bnRpY2F0aW9uIGFuZCBFbmNyeXB0aW9uCglhdXRoIGVuYWJsZTsKCSNlbmNyeXB0IGVuYWJsZTsK
fQo=
--=====================_14162703==_--




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
