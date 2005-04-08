Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE2621033CFE5@ont06exm01.comm.mot.com>
From: Belokour Victor-Y18342C <Y18342C@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C53C50.A4B94946"
Subject: [Bluez-users] Re: PIN for Microsoft Mouse (Marcel Holtmann)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 8 Apr 2005 11:35:50 -0400

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C53C50.A4B94946
Content-Type: text/plain

Hello Marcel
Thanks for you reply.

Here's the output of hciconfig as well as some other commands, if you have the time
to read them :)

As I've mentioned in my first post, I can connect mouse with security manager, auth and encryption all off, however the connection does not "stay", ie. I need to pair the mouse each time I turn on the computer.

Keyboard works great with security manager (PIN)+authentication+encryption and I need to pair only once.

bash-2.05b# tail /var/log/messages
Apr  7 17:18:36 crypt hcid[7272]: Starting security manager 0
Apr  7 17:18:36 crypt Bluetooth: L2CAP ver 2.7
Apr  7 17:18:36 crypt Bluetooth: L2CAP socket layer initialized
Apr  7 17:18:36 crypt sdpd[7276]: Bluetooth SDP daemon
Apr  7 17:18:36 crypt Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Apr  7 17:18:36 crypt hidd[7292]: Bluetooth HID daemon
Apr  7 17:18:36 crypt init: Activating demand-procedures for 'A'
Apr  7 17:19:17 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:D1:21)
Apr  7 17:19:18 crypt hidd[7292]: New HID device 00:50:F2:E3:D1:21 (Microsoft Bluetooth keyboard)
Apr  7 17:19:27 crypt login(pam_unix)[7383]: session opened for user root by (uid=0)
bash-2.05b# hciconfig -a
hci0:   Type: USB
        BD Address: 00:50:F2:E4:4D:3C ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH
        RX bytes:7615 acl:354 sco:0 events:122 errors:0
        TX bytes:1143 acl:32 sco:0 commands:19 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver: 0x1f9
        Manufacturer: Cambridge Silicon Radio (10)
bash-2.05b# hcitool con
Connections:
        > ACL 00:50:F2:E3:D1:21 handle 41 state 1 lm MASTER AUTH ENCRYPT
bash-2.05b# hcitool info 00:50:F2:E3:D1:21
Requesting information ...
        BD Address:  00:50:F2:E3:D1:21
        Device Name: Microsoft Keyboard
        LMP Version: 1.1 (0x1) LMP Subversion: 0x1df
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control> <transparent SCO>
bash-2.05b# hcitool scan
Scanning ...
        00:50:F2:E3:67:63       Microsoft Mouse
bash-2.05b# hcitool info 00:50:F2:E3:67:63
Requesting information ...
Can't create connection: Input/output error
bash-2.05b# hcitool cc 00:50:F2:E3:67:63
Can't create connection: Input/output error
bash-2.05b# cat /etc/bluetooth/pin
0000
bash-2.05b# hidd --connect 00:50:F2:E3:67:63
Can't create HID control channel: Permission denied
bash-2.05b# tail /var/log/messages
Apr  7 17:23:04 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:23:04 crypt hcid[7272]: pin_code_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:23:44 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:23:44 crypt hcid[7272]: pin_code_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:23:47 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:23:47 crypt hcid[7272]: pin_code_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:24:22 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:24:22 crypt hcid[7272]: pin_code_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:24:48 crypt hcid[7272]: link_key_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
Apr  7 17:24:48 crypt hcid[7272]: pin_code_request (sba=00:50:F2:E4:4D:3C, dba=00:50:F2:E3:67:63)
bash-2.05b# hidd --encrypt --connect 00:50:F2:E3:67:63
Can't create HID control channel: Permission denied
bash-2.05b# hciconfig hci0 nosecmgr noauth encrypt
bash-2.05b# tail -1 /var/log/messages
Apr  7 17:46:36 crypt hidd: New HID device 00:50:F2:E3:67:63 (Microsoft Five Button Mouse)
bash-2.05b# hcitool con
Connections:
        < ACL 00:50:F2:E3:67:63 handle 44 state 1 lm MASTER ENCRYPT
        > ACL 00:50:F2:E3:D1:21 handle 41 state 1 lm MASTER AUTH ENCRYPT



------_=_NextPart_001_01C53C50.A4B94946
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVMtQVNDSUkiPg0KPFRJVExFPk1lc3NhZ2U8L1RJVExF
Pg0KDQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4wMC4yODAwLjE0OTEiIG5hbWU9R0VORVJBVE9S
PjwvSEVBRD4NCjxCT0RZPjwhLS0gQ29udmVydGVkIGZyb20gdGV4dC9wbGFpbiBmb3JtYXQgLS0+
DQo8UD48Rk9OVCBzaXplPTI+SGVsbG8gTWFyY2VsPEJSPlRoYW5rcyBmb3IgeW91IHJlcGx5LjxC
Uj48QlI+SGVyZSdzIHRoZSBvdXRwdXQgDQpvZiBoY2ljb25maWcgYXMgd2VsbCBhcyBzb21lIG90
aGVyIGNvbW1hbmRzLCBpZiB5b3UgaGF2ZSB0aGUgdGltZTxCUj50byByZWFkIA0KdGhlbSA6KTxC
Uj48QlI+QXMgSSd2ZSBtZW50aW9uZWQgaW4gbXkgZmlyc3QgcG9zdCwgSSBjYW4gY29ubmVjdCBt
b3VzZSB3aXRoIA0Kc2VjdXJpdHkgbWFuYWdlciwgYXV0aCBhbmQgZW5jcnlwdGlvbiBhbGwgb2Zm
LCBob3dldmVyIHRoZSBjb25uZWN0aW9uIGRvZXMgbm90IA0KInN0YXkiLCBpZS4gSSBuZWVkIHRv
IHBhaXIgdGhlIG1vdXNlIGVhY2ggdGltZSBJIHR1cm4gb24gdGhlIA0KY29tcHV0ZXIuPEJSPjxC
Uj5LZXlib2FyZCB3b3JrcyBncmVhdCB3aXRoIHNlY3VyaXR5IG1hbmFnZXIgDQooUElOKSthdXRo
ZW50aWNhdGlvbitlbmNyeXB0aW9uIGFuZCBJIG5lZWQgdG8gcGFpciBvbmx5IA0Kb25jZS48QlI+
PEJSPjxTVFJPTkc+YmFzaC0yLjA1YiMgdGFpbCAvdmFyL2xvZy9tZXNzYWdlczwvU1RST05HPjxC
Uj5BcHImbmJzcDsgNyANCjE3OjE4OjM2IGNyeXB0IGhjaWRbNzI3Ml06IFN0YXJ0aW5nIHNlY3Vy
aXR5IG1hbmFnZXIgMDxCUj5BcHImbmJzcDsgNyAxNzoxODozNiANCmNyeXB0IEJsdWV0b290aDog
TDJDQVAgdmVyIDIuNzxCUj5BcHImbmJzcDsgNyAxNzoxODozNiBjcnlwdCBCbHVldG9vdGg6IEwy
Q0FQIA0Kc29ja2V0IGxheWVyIGluaXRpYWxpemVkPEJSPkFwciZuYnNwOyA3IDE3OjE4OjM2IGNy
eXB0IHNkcGRbNzI3Nl06IEJsdWV0b290aCBTRFAgDQpkYWVtb248QlI+QXByJm5ic3A7IDcgMTc6
MTg6MzYgY3J5cHQgQmx1ZXRvb3RoOiBISURQIChIdW1hbiBJbnRlcmZhY2UgRW11bGF0aW9uKSAN
CnZlciAxLjE8QlI+QXByJm5ic3A7IDcgMTc6MTg6MzYgY3J5cHQgaGlkZFs3MjkyXTogQmx1ZXRv
b3RoIEhJRCANCmRhZW1vbjxCUj5BcHImbmJzcDsgNyAxNzoxODozNiBjcnlwdCBpbml0OiBBY3Rp
dmF0aW5nIGRlbWFuZC1wcm9jZWR1cmVzIGZvciANCidBJzxCUj5BcHImbmJzcDsgNyAxNzoxOTox
NyBjcnlwdCBoY2lkWzcyNzJdOiBsaW5rX2tleV9yZXF1ZXN0IA0KKHNiYT0wMDo1MDpGMjpFNDo0
RDozQywgZGJhPTAwOjUwOkYyOkUzOkQxOjIxKTxCUj5BcHImbmJzcDsgNyAxNzoxOToxOCBjcnlw
dCANCmhpZGRbNzI5Ml06IE5ldyBISUQgZGV2aWNlIDAwOjUwOkYyOkUzOkQxOjIxIChNaWNyb3Nv
ZnQgQmx1ZXRvb3RoIA0Ka2V5Ym9hcmQpPEJSPkFwciZuYnNwOyA3IDE3OjE5OjI3IGNyeXB0IGxv
Z2luKHBhbV91bml4KVs3MzgzXTogc2Vzc2lvbiBvcGVuZWQgDQpmb3IgdXNlciByb290IGJ5ICh1
aWQ9MCk8QlI+PC9GT05UPjxGT05UIHNpemU9Mj48U1RST05HPmJhc2gtMi4wNWIjIGhjaWNvbmZp
ZyANCi1hPEJSPjwvU1RST05HPmhjaTA6Jm5ic3A7Jm5ic3A7IFR5cGU6IA0KVVNCPEJSPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBCRCBBZGRyZXNzOiAwMDo1MDpG
MjpFNDo0RDozQyANCkFDTCBNVFU6IDE5Mjo4IFNDTyBNVFU6IDY0Ojg8QlI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFVQIA0KUlVOTklORyBQU0NBTiBJU0NBTiBB
VVRIPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBSWCANCmJ5
dGVzOjc2MTUgYWNsOjM1NCBzY286MCBldmVudHM6MTIyIA0KZXJyb3JzOjA8QlI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFRYIGJ5dGVzOjExNDMgYWNsOjMyIA0K
c2NvOjAgY29tbWFuZHM6MTkgZXJyb3JzOjA8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IA0KRmVhdHVyZXM6IDB4ZmYgMHhmZiAweDBmIDB4MDAgMHgwMCAweDAw
IDB4MDAgDQoweDAwPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBQYWNrZXQgdHlwZTogRE0xIERNMyBETTUgREgxIA0KREgzIERINSBIVjEgSFYyIEhWMzxCUj4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTGluayBwb2xpY3k6IA0K
UlNXSVRDSCBIT0xEIFNOSUZGIFBBUks8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IExpbmsgbW9kZTogDQpTTEFWRSBBQ0NFUFQ8QlI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE5hbWU6ICdCbHVlWiANCigwKSc8QlI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IENsYXNzOiANCjB4M2UwMTAwPEJS
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBTZXJ2aWNlIENsYXNz
ZXM6IA0KTmV0d29ya2luZywgUmVuZGVyaW5nLCBDYXB0dXJpbmc8QlI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KRGV2aWNlIENsYXNzOiBDb21wdXRlciwgDQpV
bmNhdGVnb3JpemVkPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBIQ0kgVmVyOiAxLjEgKDB4MSkgDQpIQ0kgUmV2OiAweDFmOSBMTVAgVmVyOiAxLjEgKDB4MSkg
TE1QIFN1YnZlcjogDQoweDFmOTxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgTWFudWZhY3R1cmVyOiBDYW1icmlkZ2UgDQpTaWxpY29uIFJhZGlvICgxMCk8QlI+
PFNUUk9ORz5iYXNoLTIuMDViIyBoY2l0b29sIA0KY29uPC9TVFJPTkc+PEJSPkNvbm5lY3Rpb25z
OjxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmd0OyANCkFD
TCAwMDo1MDpGMjpFMzpEMToyMSBoYW5kbGUgNDEgc3RhdGUgMSBsbSBNQVNURVIgQVVUSCBFTkNS
WVBUPEJSPjwvRk9OVD48Rk9OVCANCnNpemU9Mj48U1RST05HPmJhc2gtMi4wNWIjIGhjaXRvb2wg
aW5mbyAwMDo1MDpGMjpFMzpEMToyMTxCUj48L1NUUk9ORz5SZXF1ZXN0aW5nIA0KaW5mb3JtYXRp
b24gLi4uPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBCRCBB
ZGRyZXNzOiZuYnNwOyANCjAwOjUwOkYyOkUzOkQxOjIxPEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEZXZpY2UgTmFtZTogDQpNaWNyb3NvZnQgS2V5Ym9hcmQ8
QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IExNUCBWZXJzaW9u
OiANCjEuMSAoMHgxKSBMTVAgU3VidmVyc2lvbjogMHgxZGY8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IA0KTWFudWZhY3R1cmVyOiBDYW1icmlkZ2UgU2lsaWNv
biBSYWRpbyANCigxMCk8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IEZlYXR1cmVzOiAweGZjIDB4ZmIgMHgwZiAweDAwIA0KMHgwMCAweDAwIDB4MDAgDQoweDAw
PEJSPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyANCiZsdDtlbmNyeXB0aW9uJmd0
OyAmbHQ7c2xvdCBvZmZzZXQmZ3Q7ICZsdDt0aW1pbmcgYWNjdXJhY3kmZ3Q7ICZsdDtyb2xlIA0K
c3dpdGNoJmd0OzxCUj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQombHQ7aG9s
ZCBtb2RlJmd0OyAmbHQ7c25pZmYgbW9kZSZndDsgJmx0O3Bhcmsgc3RhdGUmZ3Q7ICZsdDtSU1NJ
Jmd0OyAmbHQ7U0NPIA0KbGluayZndDs8QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IA0KJmx0O0hWMiBwYWNrZXRzJmd0OyAmbHQ7SFYzIHBhY2tldHMmZ3Q7ICZsdDt1LWxhdyBs
b2cmZ3Q7ICZsdDtBLWxhdyBsb2cmZ3Q7IA0KJmx0O0NWU0QmZ3Q7PEJSPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyANCiZsdDtwYWdpbmcgc2NoZW1lJmd0OyAmbHQ7cG93ZXIgY29u
dHJvbCZndDsgJmx0O3RyYW5zcGFyZW50IA0KU0NPJmd0OzxCUj48U1RST05HPmJhc2gtMi4wNWIj
IGhjaXRvb2wgc2NhbjxCUj48L1NUUk9ORz5TY2FubmluZyANCi4uLjxCUj4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQowMDo1MDpGMjpFMzo2Nzo2MyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBNaWNyb3NvZnQgDQpNb3VzZTxCUj48U1RST05H
PmJhc2gtMi4wNWIjIGhjaXRvb2wgaW5mbyANCjAwOjUwOkYyOkUzOjY3OjYzPEJSPjwvU1RST05H
PlJlcXVlc3RpbmcgaW5mb3JtYXRpb24gLi4uPEJSPkNhbid0IGNyZWF0ZSANCmNvbm5lY3Rpb246
IElucHV0L291dHB1dCBlcnJvcjxCUj48U1RST05HPmJhc2gtMi4wNWIjIGhjaXRvb2wgY2MgDQow
MDo1MDpGMjpFMzo2Nzo2MzwvU1RST05HPjxCUj5DYW4ndCBjcmVhdGUgY29ubmVjdGlvbjogSW5w
dXQvb3V0cHV0IA0KZXJyb3I8QlI+PFNUUk9ORz5iYXNoLTIuMDViIyBjYXQgDQovZXRjL2JsdWV0
b290aC9waW48QlI+PC9TVFJPTkc+MDAwMDxCUj48U1RST05HPmJhc2gtMi4wNWIjIGhpZGQgLS1j
b25uZWN0IA0KMDA6NTA6RjI6RTM6Njc6NjM8QlI+PC9TVFJPTkc+Q2FuJ3QgY3JlYXRlIEhJRCBj
b250cm9sIGNoYW5uZWw6IFBlcm1pc3Npb24gDQpkZW5pZWQ8QlI+PFNUUk9ORz5iYXNoLTIuMDVi
IyB0YWlsIC92YXIvbG9nL21lc3NhZ2VzPC9TVFJPTkc+PEJSPkFwciZuYnNwOyA3IA0KMTc6MjM6
MDQgY3J5cHQgaGNpZFs3MjcyXTogbGlua19rZXlfcmVxdWVzdCAoc2JhPTAwOjUwOkYyOkU0OjRE
OjNDLCANCmRiYT0wMDo1MDpGMjpFMzo2Nzo2Myk8QlI+QXByJm5ic3A7IDcgMTc6MjM6MDQgY3J5
cHQgaGNpZFs3MjcyXTogDQpwaW5fY29kZV9yZXF1ZXN0IChzYmE9MDA6NTA6RjI6RTQ6NEQ6M0Ms
IGRiYT0wMDo1MDpGMjpFMzo2Nzo2Myk8QlI+QXByJm5ic3A7IDcgDQoxNzoyMzo0NCBjcnlwdCBo
Y2lkWzcyNzJdOiBsaW5rX2tleV9yZXF1ZXN0IChzYmE9MDA6NTA6RjI6RTQ6NEQ6M0MsIA0KZGJh
PTAwOjUwOkYyOkUzOjY3OjYzKTxCUj5BcHImbmJzcDsgNyAxNzoyMzo0NCBjcnlwdCBoY2lkWzcy
NzJdOiANCnBpbl9jb2RlX3JlcXVlc3QgKHNiYT0wMDo1MDpGMjpFNDo0RDozQywgZGJhPTAwOjUw
OkYyOkUzOjY3OjYzKTxCUj5BcHImbmJzcDsgNyANCjE3OjIzOjQ3IGNyeXB0IGhjaWRbNzI3Ml06
IGxpbmtfa2V5X3JlcXVlc3QgKHNiYT0wMDo1MDpGMjpFNDo0RDozQywgDQpkYmE9MDA6NTA6RjI6
RTM6Njc6NjMpPEJSPkFwciZuYnNwOyA3IDE3OjIzOjQ3IGNyeXB0IGhjaWRbNzI3Ml06IA0KcGlu
X2NvZGVfcmVxdWVzdCAoc2JhPTAwOjUwOkYyOkU0OjREOjNDLCBkYmE9MDA6NTA6RjI6RTM6Njc6
NjMpPEJSPkFwciZuYnNwOyA3IA0KMTc6MjQ6MjIgY3J5cHQgaGNpZFs3MjcyXTogbGlua19rZXlf
cmVxdWVzdCAoc2JhPTAwOjUwOkYyOkU0OjREOjNDLCANCmRiYT0wMDo1MDpGMjpFMzo2Nzo2Myk8
QlI+QXByJm5ic3A7IDcgMTc6MjQ6MjIgY3J5cHQgaGNpZFs3MjcyXTogDQpwaW5fY29kZV9yZXF1
ZXN0IChzYmE9MDA6NTA6RjI6RTQ6NEQ6M0MsIGRiYT0wMDo1MDpGMjpFMzo2Nzo2Myk8QlI+QXBy
Jm5ic3A7IDcgDQoxNzoyNDo0OCBjcnlwdCBoY2lkWzcyNzJdOiBsaW5rX2tleV9yZXF1ZXN0IChz
YmE9MDA6NTA6RjI6RTQ6NEQ6M0MsIA0KZGJhPTAwOjUwOkYyOkUzOjY3OjYzKTxCUj5BcHImbmJz
cDsgNyAxNzoyNDo0OCBjcnlwdCBoY2lkWzcyNzJdOiANCnBpbl9jb2RlX3JlcXVlc3QgKHNiYT0w
MDo1MDpGMjpFNDo0RDozQywgDQpkYmE9MDA6NTA6RjI6RTM6Njc6NjMpPEJSPjxTVFJPTkc+YmFz
aC0yLjA1YiMgaGlkZCAtLWVuY3J5cHQgLS1jb25uZWN0IA0KMDA6NTA6RjI6RTM6Njc6NjM8QlI+
PC9TVFJPTkc+Q2FuJ3QgY3JlYXRlIEhJRCBjb250cm9sIGNoYW5uZWw6IFBlcm1pc3Npb24gDQpk
ZW5pZWQ8QlI+PFNUUk9ORz5iYXNoLTIuMDViIyBoY2ljb25maWcgaGNpMCBub3NlY21nciBub2F1
dGggDQplbmNyeXB0PEJSPmJhc2gtMi4wNWIjIHRhaWwgLTEgL3Zhci9sb2cvbWVzc2FnZXM8QlI+
PC9TVFJPTkc+QXByJm5ic3A7IDcgDQoxNzo0NjozNiBjcnlwdCBoaWRkOiBOZXcgSElEIGRldmlj
ZSAwMDo1MDpGMjpFMzo2Nzo2MyAoTWljcm9zb2Z0IEZpdmUgQnV0dG9uIA0KTW91c2UpPEJSPjxT
VFJPTkc+YmFzaC0yLjA1YiMgaGNpdG9vbCANCmNvbjwvU1RST05HPjxCUj5Db25uZWN0aW9uczo8
QlI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZsdDsgDQpBQ0wg
MDA6NTA6RjI6RTM6Njc6NjMgaGFuZGxlIDQ0IHN0YXRlIDEgbG0gTUFTVEVSIA0KRU5DUllQVDxC
Uj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmd0OyBBQ0wgMDA6
NTA6RjI6RTM6RDE6MjEgDQpoYW5kbGUgNDEgc3RhdGUgMSBsbSBNQVNURVIgQVVUSCBFTkNSWVBU
PEJSPjwvUD48L0ZPTlQ+PC9CT0RZPjwvSFRNTD4NCg==

------_=_NextPart_001_01C53C50.A4B94946--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
