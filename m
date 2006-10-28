Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2ca6f8400610272054g524db3b9n509c3d0b7d33fd8@mail.gmail.com>
Date: Sat, 28 Oct 2006 09:24:33 +0530
From: "viren sharma" <viren0007@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_99414_11648748.1162007673189"
Subject: [Bluez-users] problem in OBEX connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_Part_99414_11648748.1162007673189
Content-Type: multipart/alternative;
	boundary="----=_Part_99415_23954853.1162007673190"

------=_Part_99415_23954853.1162007673190
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
i m newbie to bluez . i m struggling to sending file from Linux PC to Nokia
7610 mobile.
i have installed following packages  bluez-utils-3.7 & related packages as
mentioned in site.
i have followed the procedure as i got help from net . Here is the part of
hcidump  before disconnection.

procedure i have followed after usual bluetooth stop/start, daemon start &
hciconfig etc is

1. start gnome-bluetooth manager. it shows me graphically scanned devices
which lists my phone.
2. starting gnome-obex-send application, choose the mobile from list & press
OK.
Please refer to attached file for detailed hcidump log file.  Tail of it is
as below.

ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x01da len 20 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 16 fcs 0xce
        OBEX: Connect cmd(f): len 16 version 1.0 flags 0 mtu 1024
        Who (0x4a) = Sequence length 6
        0000: 4c 69 6e 75 78 00                                 Linux.
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 03 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 4
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(d): cid 0x0041 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 4000
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x01da len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x01da len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x01da scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 03 00                                    .....
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x01da scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0c 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 0c 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 0c 00 16                                       ....

Please let me know what i am missing or why it is not working ?

i am using BCM 2045 usb dongle. also tried with ISSCBTA  (CSR chipset) ,
result is same.
i would love to transfer files between 2 linux PC's but trying with mobile
as faced much probles communicating with PC.

Thanks in advance. Please reply soon as already wasted lot of time .

Thanks & Regards
viren

------=_Part_99415_23954853.1162007673190
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br>i m newbie to bluez . i m struggling to sending file from Linux PC to Nokia 7610 mobile. <br>i have installed following packages&nbsp; bluez-utils-3.7 &amp; related packages as mentioned in site.<br>i have followed the procedure as i got help from net . Here is the part of hcidump&nbsp; before disconnection. 
<br><br>procedure i have followed after usual bluetooth stop/start, daemon start &amp; hciconfig etc is <br><br>1. start gnome-bluetooth manager. it shows me graphically scanned devices which lists my phone.<br>2. starting gnome-obex-send application, choose the mobile from list &amp; press OK. 
<br>Please refer to attached file for detailed hcidump log file.&nbsp; Tail of it is as below.<br><br>ACL data: handle 12 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x01da len 20 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 16 fcs 0xce 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBEX: Connect cmd(f): len 16 version 1.0 flags 0 mtu 1024<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Who (0x4a) = Sequence length 6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 4c 69 6e 75 78 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux.<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 0c 00 03 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&gt; ACL data: handle 12 flags 0x02 dlen 9<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 4
<br>&gt; ACL data: handle 12 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 12 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 4000
<br>&lt; ACL data: handle 12 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x01da len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3 <br>&gt; ACL data: handle 12 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9 <br>&lt; ACL data: handle 12 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x01da len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd <br>&lt; ACL data: handle 12 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x01da scid 0x0041<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 0c 00 03 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&gt; ACL data: handle 12 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x01da scid 0x0041<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 0c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3
<br>&nbsp; 0000: 0c 00 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 06 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: Disconn Complete (0x05) plen 4
<br>&nbsp; 0000: 00 0c 00 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br><br>Please let me know what i am missing or why it is not working ?<br>
<br>
i am using BCM 2045 usb dongle. also tried with ISSCBTA&nbsp; (CSR chipset) , result is same.<br>
i would love to transfer files between 2 linux PC's but trying with mobile as faced much probles communicating with PC.<br><br>Thanks in advance. Please reply soon as already wasted lot of time .<br><br>Thanks &amp; Regards
<br>viren<br> 

------=_Part_99415_23954853.1162007673190--

------=_Part_99414_11648748.1162007673189
Content-Type: text/plain; name="abc3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="abc3.txt"
X-Attachment-Id: f_etth8nrg

SENJIHNuaWZmZXIgLSBCbHVldG9vdGggcGFja2V0IGFuYWx5emVyIHZlciAxLjMwCmRldmljZTog
aGNpMCBzbmFwX2xlbjogMTAyOCBmaWx0ZXI6IDB4ZmZmZmZmZmYKPCBIQ0kgQ29tbWFuZDogQ3Jl
YXRlIENvbm5lY3Rpb24gKDB4MDF8MHgwMDA1KSBwbGVuIDEzCiAgMDAwMDogZWIgOTIgMjYgYmMg
MTYgMDAgMTggY2MgIDAyIDAwIDAwIDAwIDAxICAgICAgICAgICAuLiYuLi4uLi4uLi4uCj4gSENJ
IEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0CiAgMDAwMDogMDAgMDEgMDUgMDQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4uCj4gSENJIEV2ZW50OiBD
b25uZWN0IENvbXBsZXRlICgweDAzKSBwbGVuIDExCiAgMDAwMDogMDAgMGMgMDAgZWIgOTIgMjYg
YmMgMTYgIDAwIDAxIDAwICAgICAgICAgICAgICAgICAuLi4uLiYuLi4uLgo8IEFDTCBkYXRhOiBo
YW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDEyCiAgICBMMkNBUChzKTogQ29ubmVjdCByZXE6IHBz
bSAxIHNjaWQgMHgwMDQwCjwgSENJIENvbW1hbmQ6IFJlbW90ZSBOYW1lIFJlcXVlc3QgKDB4MDF8
MHgwMDE5KSBwbGVuIDEwCiAgMDAwMDogZWIgOTIgMjYgYmMgMTYgMDAgMDEgMDAgIDAwIDAwICAg
ICAgICAgICAgICAgICAgICAuLiYuLi4uLi4uCj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAo
MHgwZikgcGxlbiA0CiAgMDAwMDogMDAgMDEgMTkgMDQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAuLi4uCjwgSENJIENvbW1hbmQ6IFJlbW90ZSBOYW1lIFJlcXVlc3QgKDB4
MDF8MHgwMDE5KSBwbGVuIDEwCiAgMDAwMDogZWIgOTIgMjYgYmMgMTYgMDAgMDEgMDAgIDAwIDAw
ICAgICAgICAgICAgICAgICAgICAuLiYuLi4uLi4uCj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1
cyAoMHgwZikgcGxlbiA0CiAgMDAwMDogMTcgMDEgMTkgMDQgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAuLi4uCj4gSENJIEV2ZW50OiBNYXggU2xvdHMgQ2hhbmdlICgweDFi
KSBwbGVuIDMKICAwMDAwOiAwYyAwMCAwNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC4uLgo+IEhDSSBFdmVudDogUmVtb3RlIE5hbWUgUmVxIENvbXBsZXRlICgweDA3
KSBwbGVuIDI1NQogIDAwMDA6IDAwIGViIDkyIDI2IGJjIDE2IDAwIDQxICA2ZSA2OSA2YyAyMCAz
NyAzNiAzMSAzMCAgLi4uJi4uLkFuaWwgNzYxMAogIDAwMTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwMjA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4u
Li4uLi4uLgogIDAwMzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwNDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
ICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwNTA6IDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4u
Li4uLgogIDAwNjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwODA6IDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4u
LgogIDAwOTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwYjA6IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgog
IDAwYzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAg
Li4uLi4uLi4uLi4uLi4uLgogIDAwZDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAwZTA6IDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogIDAw
ZjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgICAgLi4u
Li4uLi4uLi4uLi4uCj4gQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTYKICAg
IEwyQ0FQKHMpOiBDb25uZWN0IHJzcDogZGNpZCAweDAxZDkgc2NpZCAweDAwNDAgcmVzdWx0IDEg
c3RhdHVzIDIKICAgICAgQ29ubmVjdGlvbiBwZW5kaW5nIC0gQXV0aG9yaXphdGlvbiBwZW5kaW5n
Cj4gQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTYKICAgIEwyQ0FQKHMpOiBD
b25uZWN0IHJzcDogZGNpZCAweDAxZDkgc2NpZCAweDAwNDAgcmVzdWx0IDAgc3RhdHVzIDAKICAg
ICAgQ29ubmVjdGlvbiBzdWNjZXNzZnVsCjwgQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAy
IGRsZW4gMTIKICAgIEwyQ0FQKHMpOiBDb25maWcgcmVxOiBkY2lkIDB4MDFkOSBmbGFncyAweDAw
IGNsZW4gMAo+IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDEyCiAgICBMMkNB
UChzKTogQ29uZmlnIHJlcTogZGNpZCAweDAwNDAgZmxhZ3MgMHgwMCBjbGVuIDAKPCBBQ0wgZGF0
YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiAxNAogICAgTDJDQVAocyk6IENvbmZpZyByc3A6
IHNjaWQgMHgwMWQ5IGZsYWdzIDB4MDAgcmVzdWx0IDAgY2xlbiAwCiAgICAgIFN1Y2Nlc3MKPiBI
Q0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1CiAgMDAw
MDogMDEgMGMgMDAgMDMgMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4u
Lgo+IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDE0CiAgICBMMkNBUChzKTog
Q29uZmlnIHJzcDogc2NpZCAweDAwNDAgZmxhZ3MgMHgwMCByZXN1bHQgMCBjbGVuIDAKICAgICAg
U3VjY2Vzcwo8IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDI0CiAgICBMMkNB
UChkKTogY2lkIDB4MDFkOSBsZW4gMjAgW3BzbSAxXQogICAgICAgIFNEUCBTU0EgUmVxOiB0aWQg
MHgwIGxlbiAweGYKICAgICAgICAgIHBhdCB1dWlkLTE2IDB4MTEwNSAoT0JFWE9ialB1c2gpCiAg
ICAgICAgICBtYXggNjU1MzUKICAgICAgICAgIGFpZChzKSAweDAwMDAgLSAweGZmZmYKICAgICAg
ICAgIGNvbnQgMDAKPiBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiAxMjEKPiBB
Q0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDEgZGxlbiA0CiAgICBMMkNBUChkKTogY2lkIDB4
MDA0MCBsZW4gMTIxIFtwc20gMV0KICAgICAgICBTRFAgU1NBIFJzcDogdGlkIDB4MCBsZW4gMHg3
NAogICAgICAgICAgY291bnQgMTEzCiAgICAgICAgICByZWNvcmQgIzAKICAgICAgICAgICAgICBh
aWQgMHgwMDAwIChTcnZSZWNIbmRsKQogICAgICAgICAgICAgICAgIHVpbnQgMHgxMDA0NgogICAg
ICAgICAgICAgIGFpZCAweDAwMDEgKFNydkNsYXNzSURMaXN0KQogICAgICAgICAgICAgICAgIDwg
dXVpZC0xNiAweDExMDUgKE9CRVhPYmpQdXNoKSA+CiAgICAgICAgICAgICAgYWlkIDB4MDAwMiAo
U3J2UmVjU3RhdGUpCiAgICAgICAgICAgICAgICAgdWludCAweDcKICAgICAgICAgICAgICBhaWQg
MHgwMDA0IChQcm90b2NvbERlc2NMaXN0KQogICAgICAgICAgICAgICAgIDwgPCB1dWlkLTE2IDB4
MDEwMCAoTDJDQVApID4gPAogICAgICAgICAgICAgICAgIHV1aWQtMTYgMHgwMDAzIChSRkNPTU0p
IHVpbnQgMHg5ID4gPAogICAgICAgICAgICAgICAgIHV1aWQtMTYgMHgwMDA4IChPQkVYKSA+ID4K
ICAgICAgICAgICAgICBhaWQgMHgwMDA1IChCcndHcnBMaXN0KQogICAgICAgICAgICAgICAgIDwg
dXVpZC0xNiAweDEwMDIgKFB1YkJyd3NHcnApID4KICAgICAgICAgICAgICBhaWQgMHgwMDA2IChM
YW5nQmFzZUF0dHJJRExpc3QpCiAgICAgICAgICAgICAgICAgPCB1aW50IDB4NDU0ZSB1aW50IDB4
NmEgdWludCAweDEwMCA+CiAgICAgICAgICAgICAgYWlkIDB4MDAwOSAoQlRQcm9maWxlRGVzY0xp
c3QpCiAgICAgICAgICAgICAgICAgPCA8IHV1aWQtMTYgMHgxMTA1IChPQkVYT2JqUHVzaCkgdWlu
dCAweDEwMCA+ID4KICAgICAgICAgICAgICBhaWQgMHgwMTAwIChTcnZOYW1lKQogICAgICAgICAg
ICAgICAgIHN0ciAiT0JFWCBPYmplY3QgUHVzaCIKICAgICAgICAgICAgICBhaWQgMHgwMzAzIChT
dXBwRm9ybWF0c0xpc3QpCiAgICAgICAgICAgICAgICAgPCB1aW50IDB4ZmYgPgogICAgICAgICAg
Y29udCAwMAo8IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDEyCiAgICBMMkNB
UChzKTogRGlzY29ubiByZXE6IGRjaWQgMHgwMWQ5IHNjaWQgMHgwMDQwCjwgQUNMIGRhdGE6IGhh
bmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTIKICAgIEwyQ0FQKHMpOiBDb25uZWN0IHJlcTogcHNt
IDMgc2NpZCAweDAwNDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAo
MHgxMykgcGxlbiA1CiAgMDAwMDogMDEgMGMgMDAgMDMgMDAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAuLi4uLgo+IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVu
IDEyCiAgICBMMkNBUChzKTogRGlzY29ubiByc3A6IGRjaWQgMHgwMWQ5IHNjaWQgMHgwMDQwCj4g
QUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTYKICAgIEwyQ0FQKHMpOiBDb25u
ZWN0IHJzcDogZGNpZCAweDAxZGEgc2NpZCAweDAwNDEgcmVzdWx0IDEgc3RhdHVzIDIKICAgICAg
Q29ubmVjdGlvbiBwZW5kaW5nIC0gQXV0aG9yaXphdGlvbiBwZW5kaW5nCj4gQUNMIGRhdGE6IGhh
bmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTYKICAgIEwyQ0FQKHMpOiBDb25uZWN0IHJzcDogZGNp
ZCAweDAxZGEgc2NpZCAweDAwNDEgcmVzdWx0IDAgc3RhdHVzIDAKICAgICAgQ29ubmVjdGlvbiBz
dWNjZXNzZnVsCjwgQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTYKICAgIEwy
Q0FQKHMpOiBDb25maWcgcmVxOiBkY2lkIDB4MDFkYSBmbGFncyAweDAwIGNsZW4gNAogICAgICBN
VFUgMTAxMyAKPiBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiAxMgogICAgTDJD
QVAocyk6IENvbmZpZyByZXE6IGRjaWQgMHgwMDQxIGZsYWdzIDB4MDAgY2xlbiAwCjwgQUNMIGRh
dGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTQKICAgIEwyQ0FQKHMpOiBDb25maWcgcnNw
OiBzY2lkIDB4MDFkYSBmbGFncyAweDAwIHJlc3VsdCAwIGNsZW4gMAogICAgICBTdWNjZXNzCj4g
QUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTgKICAgIEwyQ0FQKHMpOiBDb25m
aWcgcnNwOiBzY2lkIDB4MDA0MSBmbGFncyAweDAwIHJlc3VsdCAwIGNsZW4gNAogICAgICBTdWNj
ZXNzCiAgICAgIE1UVSA2NzIgCjwgQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4g
OAogICAgTDJDQVAoZCk6IGNpZCAweDAxZGEgbGVuIDQgW3BzbSAzXQogICAgICBSRkNPTU0ocyk6
IFNBQk06IGNyIDEgZGxjaSAwIHBmIDEgaWxlbiAwIGZjcyAweDFjIAo+IEhDSSBFdmVudDogTnVt
YmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUKICAwMDAwOiAwMSAwYyAwMCAw
MyAwMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uCj4gQUNMIGRhdGE6
IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gOAogICAgTDJDQVAoZCk6IGNpZCAweDAwNDEgbGVu
IDQgW3BzbSAzXQogICAgICBSRkNPTU0ocyk6IFVBOiBjciAxIGRsY2kgMCBwZiAxIGlsZW4gMCBm
Y3MgMHhkNyAKPCBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiAxOAogICAgTDJD
QVAoZCk6IGNpZCAweDAxZGEgbGVuIDE0IFtwc20gM10KICAgICAgUkZDT01NKHMpOiBQTiBDTUQ6
IGNyIDEgZGxjaSAwIHBmIDAgaWxlbiAxMCBmY3MgMHg3MCBtY2NfbGVuIDgKICAgICAgZGxjaSAx
OCBmcmFtZV90eXBlIDAgY3JlZGl0X2Zsb3cgMTUgcHJpIDcgYWNrX3RpbWVyIDAKICAgICAgZnJh
bWVfc2l6ZSA2NjcgbWF4X3JldHJhbnMgMCBjcmVkaXRzIDcKPiBBQ0wgZGF0YTogaGFuZGxlIDEy
IGZsYWdzIDB4MDIgZGxlbiAxOAogICAgTDJDQVAoZCk6IGNpZCAweDAwNDEgbGVuIDE0IFtwc20g
M10KICAgICAgUkZDT01NKHMpOiBQTiBSU1A6IGNyIDAgZGxjaSAwIHBmIDAgaWxlbiAxMCBmY3Mg
MHhhYSBtY2NfbGVuIDgKICAgICAgZGxjaSAxOCBmcmFtZV90eXBlIDAgY3JlZGl0X2Zsb3cgMTQg
cHJpIDcgYWNrX3RpbWVyIDAKICAgICAgZnJhbWVfc2l6ZSA2NjcgbWF4X3JldHJhbnMgMCBjcmVk
aXRzIDMKPCBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiA4CiAgICBMMkNBUChk
KTogY2lkIDB4MDFkYSBsZW4gNCBbcHNtIDNdCiAgICAgIFJGQ09NTShzKTogU0FCTTogY3IgMSBk
bGNpIDE4IHBmIDEgaWxlbiAwIGZjcyAweDMyIAo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBs
ZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUKICAwMDAwOiAwMSAwYyAwMCAwMiAwMCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uCj4gQUNMIGRhdGE6IGhhbmRsZSAxMiBm
bGFncyAweDAyIGRsZW4gOAogICAgTDJDQVAoZCk6IGNpZCAweDAwNDEgbGVuIDQgW3BzbSAzXQog
ICAgICBSRkNPTU0ocyk6IFVBOiBjciAxIGRsY2kgMTggcGYgMSBpbGVuIDAgZmNzIDB4ZjkgCjwg
QUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTIKICAgIEwyQ0FQKGQpOiBjaWQg
MHgwMWRhIGxlbiA4IFtwc20gM10KICAgICAgUkZDT01NKHMpOiBNU0MgQ01EOiBjciAxIGRsY2kg
MCBwZiAwIGlsZW4gNCBmY3MgMHg3MCBtY2NfbGVuIDIKICAgICAgZGxjaSAxOCBmYyAwIHJ0YyAx
IHJ0ciAxIGljIDAgZHYgMSBiMSAxIGIyIDAgYjMgMCBsZW4gMAo+IEFDTCBkYXRhOiBoYW5kbGUg
MTIgZmxhZ3MgMHgwMiBkbGVuIDEyCiAgICBMMkNBUChkKTogY2lkIDB4MDA0MSBsZW4gOCBbcHNt
IDNdCiAgICAgIFJGQ09NTShzKTogTVNDIENNRDogY3IgMCBkbGNpIDAgcGYgMCBpbGVuIDQgZmNz
IDB4YWEgbWNjX2xlbiAyCiAgICAgIGRsY2kgMTggZmMgMCBydGMgMSBydHIgMSBpYyAwIGR2IDEg
YjEgMSBiMiAwIGIzIDAgbGVuIDAKPCBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxl
biAxMgogICAgTDJDQVAoZCk6IGNpZCAweDAxZGEgbGVuIDggW3BzbSAzXQogICAgICBSRkNPTU0o
cyk6IE1TQyBSU1A6IGNyIDEgZGxjaSAwIHBmIDAgaWxlbiA0IGZjcyAweDcwIG1jY19sZW4gMgog
ICAgICBkbGNpIDE4IGZjIDAgcnRjIDEgcnRyIDEgaWMgMCBkdiAxIGIxIDEgYjIgMCBiMyAwIGxl
biAwCj4gQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTIKICAgIEwyQ0FQKGQp
OiBjaWQgMHgwMDQxIGxlbiA4IFtwc20gM10KICAgICAgUkZDT01NKHMpOiBNU0MgUlNQOiBjciAw
IGRsY2kgMCBwZiAwIGlsZW4gNCBmY3MgMHhhYSBtY2NfbGVuIDIKICAgICAgZGxjaSAxOCBmYyAw
IHJ0YyAxIHJ0ciAxIGljIDAgZHYgMSBiMSAxIGIyIDAgYjMgMCBsZW4gMAo8IEFDTCBkYXRhOiBo
YW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDkKICAgIEwyQ0FQKGQpOiBjaWQgMHgwMWRhIGxlbiA1
IFtwc20gM10KICAgICAgUkZDT01NKGQpOiBVSUg6IGNyIDEgZGxjaSAxOCBwZiAxIGlsZW4gMCBm
Y3MgMHhkMiBjcmVkaXRzIDMzCjwgQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4g
MjQKICAgIEwyQ0FQKGQpOiBjaWQgMHgwMWRhIGxlbiAyMCBbcHNtIDNdCiAgICAgIFJGQ09NTShk
KTogVUlIOiBjciAxIGRsY2kgMTggcGYgMCBpbGVuIDE2IGZjcyAweGNlIAogICAgICAgIE9CRVg6
IENvbm5lY3QgY21kKGYpOiBsZW4gMTYgdmVyc2lvbiAxLjAgZmxhZ3MgMCBtdHUgMTAyNAogICAg
ICAgIFdobyAoMHg0YSkgPSBTZXF1ZW5jZSBsZW5ndGggNgogICAgICAgIDAwMDA6IDRjIDY5IDZl
IDc1IDc4IDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTGludXguCj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNQogIDAwMDA6IDAx
IDBjIDAwIDAzIDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLi4KPiBB
Q0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxlbiA5CiAgICBMMkNBUChkKTogY2lkIDB4
MDA0MSBsZW4gNSBbcHNtIDNdCiAgICAgIFJGQ09NTShkKTogVUlIOiBjciAwIGRsY2kgMTggcGYg
MSBpbGVuIDAgZmNzIDB4OCBjcmVkaXRzIDQKPiBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4
MDIgZGxlbiAxNgogICAgTDJDQVAoZCk6IGNpZCAweDAwNDEgbGVuIDEyIFtwc20gM10KICAgICAg
UkZDT01NKGQpOiBVSUg6IGNyIDAgZGxjaSAxOCBwZiAxIGlsZW4gNyBmY3MgMHg4IGNyZWRpdHMg
MQogICAgICAgIE9CRVg6IENvbm5lY3QgcnNwKGYpOiBzdGF0dXMgMjAwIGxlbiA3IHZlcnNpb24g
MS4wIGZsYWdzIDAgbXR1IDQwMDAKPCBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdzIDB4MDIgZGxl
biA4CiAgICBMMkNBUChkKTogY2lkIDB4MDFkYSBsZW4gNCBbcHNtIDNdCiAgICAgIFJGQ09NTShz
KTogRElTQzogY3IgMSBkbGNpIDE4IHBmIDEgaWxlbiAwIGZjcyAweGQzIAo+IEFDTCBkYXRhOiBo
YW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDgKICAgIEwyQ0FQKGQpOiBjaWQgMHgwMDQxIGxlbiA0
IFtwc20gM10KICAgICAgUkZDT01NKHMpOiBVQTogY3IgMSBkbGNpIDE4IHBmIDEgaWxlbiAwIGZj
cyAweGY5IAo8IEFDTCBkYXRhOiBoYW5kbGUgMTIgZmxhZ3MgMHgwMiBkbGVuIDgKICAgIEwyQ0FQ
KGQpOiBjaWQgMHgwMWRhIGxlbiA0IFtwc20gM10KICAgICAgUkZDT01NKHMpOiBESVNDOiBjciAx
IGRsY2kgMCBwZiAxIGlsZW4gMCBmY3MgMHhmZCAKPCBBQ0wgZGF0YTogaGFuZGxlIDEyIGZsYWdz
IDB4MDIgZGxlbiAxMgogICAgTDJDQVAocyk6IERpc2Nvbm4gcmVxOiBkY2lkIDB4MDFkYSBzY2lk
IDB4MDA0MQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBw
bGVuIDUKICAwMDAwOiAwMSAwYyAwMCAwMyAwMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC4uLi4uCj4gQUNMIGRhdGE6IGhhbmRsZSAxMiBmbGFncyAweDAyIGRsZW4gMTIKICAg
IEwyQ0FQKHMpOiBEaXNjb25uIHJzcDogZGNpZCAweDAxZGEgc2NpZCAweDAwNDEKPiBIQ0kgRXZl
bnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1CiAgMDAwMDogMDEg
MGMgMDAgMDEgMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4uLgo8IEhD
SSBDb21tYW5kOiBEaXNjb25uZWN0ICgweDAxfDB4MDAwNikgcGxlbiAzCiAgMDAwMDogMGMgMDAg
MTMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4KPiBIQ0kgRXZl
bnQ6IENvbW1hbmQgU3RhdHVzICgweDBmKSBwbGVuIDQKICAwMDAwOiAwMCAwMSAwNiAwNCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4KPiBIQ0kgRXZlbnQ6IERpc2Nv
bm4gQ29tcGxldGUgKDB4MDUpIHBsZW4gNAogIDAwMDA6IDAwIDBjIDAwIDE2ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLgo=
------=_Part_99414_11648748.1162007673189
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_99414_11648748.1162007673189
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_99414_11648748.1162007673189--
