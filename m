Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C75722.F43950D0"
Date: Fri, 23 Feb 2007 09:16:44 +0100
Message-ID: <7FEBB30F0CE41B419B38295024A58EE3A10D47@oxygen.mail.telnet.tunis>
From: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RE :  RE : modprobe snd-bt-sco
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75722.F43950D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,=20

I still have the same problem, I cannot modprobe snd-bt-sco. Here what =
I've got when compiling the btsco-0.5 :


[root@ws12 btsco-0.5]# cd kernel/

[root@ws12 kernel]# make
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
  Building modules, stage 2.
  MODPOST
*** Warning: "snd_hidden_kmalloc" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
*** Warning: "snd_verbose_printk" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
*** Warning: "snd_hidden_kfree" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'

[root@ws12 kernel]# make install
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
  INSTALL /root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'

[root@ws12 kernel]# depmod -eav | grep snd-bt-sco
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_add": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_register": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.g
z
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_free": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_new1": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_lib_ioctl": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.
ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_hwdep_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-hwdep.ko
.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_notify": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_malloc_pages": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-
alloc.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_set_ops": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko
.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
"snd_pcm_period_elapsed": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd
-pcm.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_free_pages": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-al
loc.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
"snd_pcm_format_width": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-p
cm.ko.gz

[root@ws12 kernel]# modprobe snd-bt-sco
FATAL: Error inserting snd-bt-sco =
(/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko): Invalid module format

Even when I make make modules under /usr/src/linux/ I got no error :

[root@ws12 linux]# make modules
  CHK     include/linux/version.h
make[1]: =AB arch/i386/kernel/asm-offsets.s =BB est =E0 jour.
  CHK     include/asm-i386/asm_offsets.h
  Building modules, stage 2.
  MODPOST

Can anyone help me to got the btsco working?? :(=20

Thanks a lot.

------_=_NextPart_001_01C75722.F43950D0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ii0IAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALAAAAFJFIDogW0JsdWV6LXVzZXJz
XSBSRSA6IG1vZHByb2JlIHNuZC1idC1zY28AjQ4BBYADAA4AAADXBwIAFwAJABAALAAFAEEBASCA
AwAOAAAA1wcCABcACQAQACwABQBBAQEJgAEAIQAAAEIxMjYyRUIzNjRCRTNENEY4Rjg5NUEwRUY2
RDg2MzExAEYHAQOQBgCADAAAOAAAAAMAJgAAAAAAAwA2AAAAAABAADkA0FA59CJXxwEeAD0AAQAA
AAEAAAAAAAAAAgFHAAEAAAA2AAAAYz1GUjthPSA7cD1Hcm91cGUgVGVsbmV0O2w9T1hZR0VOLTA3
MDIyMzA4MTY0NFotMTIyODYAAAAeAEkAAQAAACsAAABSZTogW0JsdWV6LXVzZXJzXSBSRSA6IG1v
ZHByb2JlIHNuZC1idC1zY28AAEAATgCAVcXPf1bHAR4AWgABAAAAKgAAAGJsdWV6LXVzZXJzLWJv
dW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAAYmx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABi
bHVlei11c2Vycy1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABT
TVRQOkJMVUVaLVVTRVJTLUJPVU5DRVNATElTVFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAABAA
AABQYXVsbyBHb27nYWx2ZXMAAgFeAAEAAABFAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAUGF1
bG8gR29u52FsdmVzAFNNVFAAcGFmLmdvbmNhbHZlc0BnbWFpbC5jb20AAAAAAgFfAAEAAAAdAAAA
U01UUDpQQUYuR09OQ0FMVkVTQEdNQUlMLkNPTQAAAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwAB
AAAAKgAAAGJsdWV6LXVzZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBoAAEA
AAAFAAAAU01UUAAAAAAeAGkAAQAAABgAAABwYWYuZ29uY2FsdmVzQGdtYWlsLmNvbQAeAHAAAQAA
ACwAAABSRSA6IFtCbHVlei11c2Vyc10gUkUgOiBtb2Rwcm9iZSBzbmQtYnQtc2NvAAIBcQABAAAA
GwAAAAHHVn/ra/Alhp3H90rRm0tpsV/mbb0AKD8M/AAeAHQAAQAAAAwAAABCbHVlWiB1c2VycwAe
ABoMAQAAAA0AAABBc21hIFRlYmVzc2kAAAAAHgAdDgEAAAAsAAAAUkUgOiBbQmx1ZXotdXNlcnNd
IFJFIDogbW9kcHJvYmUgc25kLWJ0LXNjbwACAQkQAQAAAPUEAADxBAAAqg4AAExaRnXDdtS/AwAK
AHJjcGcxMjXiMgNDdGV4BUEBAwH3TwqAAqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRWCFUHshHF
DlEDARDHMvcGAAbDEcUzBEYQyRLbEdPbCO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVALppAgSGkg
B0BsLArjwwqECoBJIHN0AxADIEEQ8HZlIHRoH4BzMmEHgCBwA2ACYGVtyx3wHtBjAHBubwVABGED
IDIfwW5kLWJ0LbkE8G8uHYAEkB+AdxDw6QVASScfcWchISLwCfDbINADcHADEAuAZx+TIiCBIlEt
MC41IDoeGo0eFFsDYCEgQHdzDiCJJPhdIyDQZCBrBJH4ZWwvJh8nJCh0KBEAwAcocB4UKuJbMV06
IE5FAjAGcSSRZGkYwGMCdAWweSBgL3VzJHIvLXBjLyRxdXigLTIuNi4OIC0OIBBtZGsnHhQgIEJe
dQMQLKAkkQRhdSBwc3Md8B7wYWcfgC5ALxZNQE9EUE9TVB4UKnkygCBXCsADACSQK/AiISHhX2hp
ZAEAbl8GawDAHdBvYyIgW8ovJuIvBaBuZhDwIfDWcwNQCeAvJQcvKHUh6eBrb10gdSHwARALgN0J
gCEyLzM1H3ByBuARIOZfIDALgHRrNI81nzav/ze/OM8zajwSOv88Dz0fPi/5K1pMZR9gLG8tfy6N
KU/9KlsgC4AwsR3QKy8sP0dvE0h/L2FJTjIAQUxM/iBBf0KPQ55FX0ZvTi9PP5dJnypXAQBwBGEg
LVUB7CB8I4AYwHAh2R4UVqFUYi8wJS9XGi8OwXL6YUO8ICigCYAEIDNTVbDobF9hM8AiTMBcH10n
f1LGCGAh8FExGMBDskRhLjxnelu/XM9d317qcGN0bV8ooHdgH2EvYj4tf2eBYz9of2VfZm9fkAsR
X/0YwGcEAE0BZ/9pD2I/a2LfHhRrr2y/bc9u319BA3CP/3Gfcq9rf3l/dj93T1+xZ8H+MXjfee96
/3wPgV9+L38//2+jZ8+Br4K/g8+JH4Xvhv/zZ1WMoV9pNGBfsIi/ic9/ah9rIh4Ui++Rj44Pjx9o
/ndZ4Yh/kc+S3yHimQNT13+U75pPlw9/X4BhISAGkHn/mZ+ar4rflM+i/5+voL80JHs6gDDRc6Jv
o3+bv6pCLf8eFDQzpY+rH6evqL9ncxEh+F9vcKqPq5+sr2sVnU9vtB+wv7HPZ0ZwBnEEcF/9KLBh
s6AJgLPPtN+kjh4U/2sfvT+5b7p/M1NR0qo/wf//vr+taQdAHhSun8X/wq/Dv7tnRgIQcgDAs3AD
8GQfoPfFr8a/x89wHhTAnFhPKlizIW9T9UZBUJFMwXIDYD8FwEuBBJAfACSRIeggKBfPX8uvQ+kp
TMBJbna3B0AzsDAVIM5kHhpFH3D/A6Aj0x7QSzPe1DA0RKMFwN1WLC8gsSOSIRAgBJDXYj8lqybZ
VrNLBjAlLxZDSO5LL3DlsQuAYwpAAQDg1Sc6EQCQAiAuaEv9XCcHAaAdsFaAaC9pMziCNlK2YXNt
LW8BIMkRIXMuBCEnYuiQB5DlBUEnCmAgaghhMSfljv/pwukD6cGzgOoV52UvfzCP2zGdHhRDA5EA
cHkCIB+A/R+wbFrwIAFVwCODJMci4KUFsGskgT8/JZAoHgvqVFGBawQgYeOwISDwxQJ995AAAAAe
ADUQAQAAAEIAAAA8N0ZFQkIzMEYwQ0U0MUI0MTlCMzgyOTUwMjRBNThFRTNBMTBENDdAb3h5Z2Vu
Lm1haWwudGVsbmV0LnR1bmlzPgAAAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAA
AB8A8xABAAAAaAAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQB1AHMAZQByAHMAXQAgAFIA
RQAgACUAMwBBACAAbQBvAGQAcAByAG8AYgBlACAAcwBuAGQALQBiAHQALQBzAGMAbwAuAEUATQBM
AAAACwD2EAAAAABAAAcw8r6Z5yBXxwFAAAgwVChR9CJXxwEDAN4/r28AAAMA8T8MBAAAHgD4PwEA
AAANAAAAQXNtYSBUZWJlc3NpAAAAAAIB+T8BAAAAbgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAA
AAAAAAAvTz1HUk9VUEUgVEVMTkVUL09VPVBSRU1JRVIgR1JPVVBFIEQnQURNSU5JU1RSQVRJT04v
Q049UkVDSVBJRU5UUy9DTj1BU01BLlRFQkVTU0kAAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5p
c3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA
/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAAA0AAABBU01BLlRF
QkVTU0kAAAAAHgAxQAEAAAANAAAAQVNNQS5URUJFU1NJAAAAAB4AMkABAAAAKgAAAGJsdWV6LXVz
ZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgAzQAEAAAAYAAAAcGFmLmdvbmNh
bHZlc0BnbWFpbC5jb20AHgA4QAEAAAANAAAAQVNNQS5URUJFU1NJAAAAAB4AOUABAAAAAgAAAC4A
AAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQekHClgMABxCxCgAAAwAQEAAAAAADABEQAQAA
AB4ACBABAAAAZQAAAEhJQUxMLElTVElMTEhBVkVUSEVTQU1FUFJPQkxFTSxJQ0FOTk9UTU9EUFJP
QkVTTkQtQlQtU0NPSEVSRVdIQVRJVkVHT1RXSEVOQ09NUElMSU5HVEhFQlRTQ08tMDU6Uk9PVEAA
AAAAAgF/AAEAAABCAAAAPDdGRUJCMzBGMENFNDFCNDE5QjM4Mjk1MDI0QTU4RUUzQTEwRDQ3QG94
eWdlbi5tYWlsLnRlbG5ldC50dW5pcz4AAAANnw==

------_=_NextPart_001_01C75722.F43950D0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C75722.F43950D0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C75722.F43950D0--
