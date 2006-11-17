Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70A14.404E5F29"
Date: Fri, 17 Nov 2006 07:46:08 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA9@eumonex01.palmsource.com>
References: <455CCAF4.8020007@silicom.fr>
	<ef9938ec0611161238p63da651dr497c04024c8ecbb7@mail.gmail.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  SCO on bluez : some architectural tips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70A14.404E5F29
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Albert,

> just curious, was setvbuf( fp, NULL, _IONBUF, 0 ) to disable socket
> buffering an option?

Would this work on a bluetooth L2CAP socket?

Fr=E9d=E9ric

------_=_NextPart_001_01C70A14.404E5F29
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ih4GAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAOgAAAFJFIDogW0JsdWV6LWRldmVs
XSBTQ08gb24gYmx1ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwDlEwEFgAMADgAAANYHCwAR
AAcALgAIAAUAOwEBIIADAA4AAADWBwsAEQAHAC8AHQAFAFEBAQmAAQAhAAAAQzQxRTU3QkJCNUM1
OUU0MkI4QUI4NkE2MkRGQ0Q0OEMAhAcBA5AGAGwJAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQBR
FpIPFArHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADYAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7
bD1FVU1PTkVYMDEtMDYxMTE3MDY0NzI5Wi0xMzM2NAAAAB4ASQABAAAAOQAAAFJlOiBbQmx1ZXot
ZGV2ZWxdIFNDTyBvbiBibHVleiA6IHNvbWUgYXJjaGl0ZWN0dXJhbCB0aXBzAAAAAEAATgAATYMq
vwnHAR4AWgABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0
AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYm91bmNl
c0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLURFVkVMLUJPVU5DRVNATElT
VFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAAA0AAABBbGJlcnQgSHVhbmcAAAAAAgFeAAEAAAA/
AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAQWxiZXJ0IEh1YW5nAFNNVFAAYWxiZXJ0QGNzYWls
Lm1pdC5lZHUAAAIBXwABAAAAGgAAAFNNVFA6QUxCRVJUQENTQUlMLk1JVC5FRFUAAAAeAGYAAQAA
AAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNl
Zm9yZ2UubmV0AAAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABUAAABhbGJlcnRAY3NhaWwu
bWl0LmVkdQAAAAAeAHAAAQAAADoAAABSRSA6IFtCbHVlei1kZXZlbF0gU0NPIG9uIGJsdWV6IDog
c29tZSBhcmNoaXRlY3R1cmFsIHRpcHMAAAACAXEAAQAAABsAAAABxwm/OjlqnBrF6cZOB6zeemeS
2WwSABU1VqsAHgB0AAEAAAASAAAAQmx1ZVogZGV2ZWxvcG1lbnQAAAAeABoMAQAAABEAAABGcmVk
ZXJpYyBEYWxsZWF1AAAAAB4AHQ4BAAAAOgAAAFJFIDogW0JsdWV6LWRldmVsXSBTQ08gb24gYmx1
ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwAAAAIBCRABAAAAMgEAAC4BAADaAQAATFpGdTFg
3m8DAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAfdPCoACpAPjAgBjaArAc/BldDAgBxMCgA/zAFB/BFYI
VQeyEcUOUQMBEMcy9wYABsMRxTMERhDJEtsR09sI7wn3Oxi/DjA1EcIMYM5jAFALCQFkMzYRUAum
SCBIaRFgbGIEkHQOLAqiCoQKgD4ganUacwVAYwhxCGBzLCAMd2EEIBEhdmJ1ZhAoIGZwH9BOVUwC
TB/QX0lPTkJVBkYf0BFQKSB0byAmZAQAAaBsZSAgb2MuaxEwHpYgcWYGcW5nmiADkW8FMB+Qbj8e
OtJXCGBsZCIgaAQAH+DtBbBrJIADoGEjsApBIjACbyYgIEwyQ0FQAyLVJPtGclwnZTlfCzApcQUQ
AOAeQ30qkAAAHgA1EAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2
RUE5QGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAAAeADkQAQAAAFwAAAA8NDU1Q0NBRjQuODAy
MDAwN0BzaWxpY29tLmZyPiA8ZWY5OTM4ZWMwNjExMTYxMjM4cDYzZGE2NTFkcjQ5N2MwNDAyNGM4
ZWNiYjdAbWFpbC5nbWFpbC5jb20+AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAA
AB8A8xABAAAAhAAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAFMA
QwBPACAAbwBuACAAYgBsAHUAZQB6ACAAJQAzAEEAIABzAG8AbQBlACAAYQByAGMAaABpAHQAZQBj
AHQAdQByAGEAbAAgAHQAaQBwAHMALgBFAE0ATAAAAAsA9hAAAAAAQAAHMFEWkg8UCscBQAAIMIno
V0AUCscBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5
PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9O
VFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABT
eXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEA
AAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAA
ABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAA
HgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAe
ADNAAQAAABUAAABhbGJlcnRAY3NhaWwubWl0LmVkdQAAAAAeADhAAQAAABEAAABGUkVERVJJQy5E
QUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQMZtU
DgMABxB/AAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJQUxCRVJULEpVU1RDVVJJT1VT
LFdBU1NFVFZCVUYoRlAsTlVMTCxJT05CVUYsMClUT0RJU0FCTEVTT0NLRVRCVUZGRVJJTkdBTk9Q
VElPTj9XT1VMRFRISVNXT1JLT05BQkwAAAAAAgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5
M0RCNjUxRkRCQzFFRERFNEU2RUE5QGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAACcOA==

------_=_NextPart_001_01C70A14.404E5F29
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C70A14.404E5F29
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C70A14.404E5F29--
