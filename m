Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C59F1F.D33308BA"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A88@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Fri, 12 Aug 2005 17:25:48 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C59F1F.D33308BA
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,=20
=20
      Thanks for reply.
=20
     1. kernel version is 2.4.20.
=20
     2. I don't really change Makefile. Just make sure all
         BlueZ are enabled and force them to be compiled=20
        with kernel. Somehow the original package=20
         can't find bluetooth support using make menuconfig.
=20
     3. Basic networking support is enabled for sure.
=20
     4. I compiled bluetooth USB driver. My email program seems
         to misplace the message.
=20
    5. I just think making BlueZ to be part of kernel instead of modules
        should be easier for my embedded platform. (So I don't need=20
       commands like modprobe in romdisk, it saves space)
        Can I do this (part of kernel instead of modules)=20
        without changing the source codes?
=20
regards,
=20
Al
=20


	Hi AL,
=09
	first question : what kernel version you are using ??
=09
	Second: why you change the Makefile ??? Simply do a make menuconfig or
	what ever you prefer and configure that Bluetooth is compiled build in =
and
	not as a module.
=09
	Make sure you have basic networking support enabled for your kernel.
=09
	I can't see that you compiled in the bluetooth USB driver. So this is
	required when you use a USB adapter. But you don't need the *_cs =
drivers.
=09
	Why do you think an embedded system can't support modules ????
=09
	Ciao,
=09
	Peter
=09
=09
=09


------_=_NextPart_001_01C59F1F.D33308BA
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjIJAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAAMABEAGQAw
AAUATwEBIIADAA4AAADVBwgADAARABkAMAAFAE8BAQmAAQAhAAAANzlDOUJGNjU1Mzc4OUI0MTkw
ODA1QkQ1Qzg0QkFBQ0UAUgcBA5AGADwTAAA2AAAAAwA2AAAAAABAADkAuggz0x+fxQEeAD0AAQAA
AAUAAABSRTogAAAAAAIBRwABAAAALgAAAGM9dXM7YT0gO3A9dW5pbWlzO2w9TkVUQkUwMS0wNTA4
MTIwOTI1NDhaLTk3OQAAAB4ASQABAAAANAAAAFJlOiBbQmx1ZXotZGV2ZWxdIFBvcnRpbmcgQmx1
ZVogb24gZW1iZWRkZWQgdUNsaW51eABAAE4AgAO0fByfxQEeAFoAAQAAACgAAABibHVlei1kZXZl
bC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1
ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6
QkxVRVotREVWRUwtQURNSU5ATElTVFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAADgAAAFBl
dGVyIFdpcHBpY2gAAAACAV4AAQAAAEIAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABQZXRlciBX
aXBwaWNoAFNNVFAAcGV3aUBndy1pbnN0cnVtZW50cy5kZQAAAAIBXwABAAAAHAAAAFNNVFA6UEVX
SUBHVy1JTlNUUlVNRU5UUy5ERQAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKAAAAGJsdWV6
LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAeAGgAAQAAAAUAAABTTVRQAAAAAB4A
aQABAAAAFwAAAHBld2lAZ3ctaW5zdHJ1bWVudHMuZGUAAB4AcAABAAAAMAAAAFtCbHVlei1kZXZl
bF0gUG9ydGluZyBCbHVlWiBvbiBlbWJlZGRlZCB1Q2xpbnV4AAIBcQABAAAAGwAAAAHFnxyp1RzB
EuTnC0EdoWDz7NYfpHAAABz3LwAeAHQAAQAAACIAAABibHVlei1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQAAAAeABoMAQAAAAMAAABBbAAAHgAdDgEAAAAwAAAAW0JsdWV6LWRldmVsXSBQb3J0
aW5nIEJsdWVaIG9uIGVtYmVkZGVkIHVDbGludXgAAgEJEAEAAAD6CwAA9gsAACc1AABMWkZ1sVg2
Y4MACgByY3BnOTUC0cEDYWh0bWwxAzABAy8B9wqAAqQD5E0LgGdMfGl1AoAP8wBQBFYQ3DITAuMC
AGNoCsBzZXRuMgYABsMRRTMERhOXMH4gCFUHsgKAEVMI7wn3O7EX/zI1NRFCDGBjAFAzCwkBZDM2
FjALpTQg2Q/yKlwOogGQZxQgCqMLEVMdGDQUIDwhRE8AQ1RZUEUgSFQATUwgUFVCTEkAQyAiLS8v
VzMiQyCwRFREH8QzLsIyILBFTiI+Hh0dv/ki8TE4HyAf0iI/I08lwMYzHLAkoEVBRCT9DuEXJh8o
nyQkNg7gPE1FFFRBB7BBK5A9IkdTCfAEkGF0BbAiFkBPNE5UIgBULCAF4UV46xOxEPBlBlJ2FqEu
cQCQAQIgIDYuMC42NHA4Ny4xIi4p/yQzN4I3HyBUSVRMRST+AjQO4FJlOiBbQpkKQXotAQAucGxd
IBBLF6EQ4SA0QlogLwFlBwbQCYABAGQgdUNsqQuAdXgjnjUfIC8yf/8wryV1M8E4QCd/Jc88FA4w
AR8gQk9EWSBkafRyPTwwcjuAO/MAIQMwOT6RZG8A4D6RCrFccf8X4D6RE7ADMD71FjA7qxwhizyv
DhA2HyBESVY+yT8AAEEHO8kvcEQ/QVJIaf4sRXoBwD7XCqI+1wpxI6z+MCdBIRBEC0mIQY9Cn0Ov
L0S/Rc9QKzurOBywJm44YnNwAoBR2RUBJ2H+MExZR+9I/0oPSx9ML00//05PT19Vv1F/Wt9Tn1Sv
YO//Yf9jD2QfZS9mP2dPaF9pb09qf2uPbJ9tpyBULeFrnwQgAhAFwBgAC1B5LlZP/1dfWG9Zf1qP
W59cr12/Xs//X993H26/b897D3MPdB91L/92P31feF95b3yfe4+I332v/36/f8+MD40fji+PP5BP
kV8Pkm+Tf5SPcVAxLiBrDwSRNNAupwQAIDIuNP8hwC9QgO+B/4MPhB+FL4Y//4dPiF+Jb4p/nz+W
L5c/oy//my+cP51Pnl+lf6B/oY+kv/+jr7D/pc+m36fvtC+1P7ZP/7dfuG+5f7qPu5+8r72/vs+z
v9+aISBJPkACICcFQJcYAAdAclAgLdVNYZkQimYDEGWY8Ep1cwVA3wDAmRAczBywrxRzCHAuIP/E
8akPqh+rL6w/rU+uX69v/7B/sY+yn81fwX/Cj9Nv1H//1Y/Wn9ev2L/Zz9rf2+/c///eD98f4C/h
P+JP41/kb+V//+aP55/or3DYNZQKwC4gCfD/AaDGEDaQAHA2kMb/zvJx4TJjLiB0aDYg8IBvINc2
QMUwA3BwxgFk6k/rX//sb8jPyd/K78v/zQ/OH88v/9A/9G/SX/mP8k/zX/+fAK//Ab8CzwPfBO8F
/wcPCB8JL/8KPwtPDF8Nbw5/D48QnxGv2XDYd2nwkJkFLhNPFF+FFW9T8VBlaG938IJn7t/7E3Hw
aWc1UMTwIPn2YGNr+sAuIPT/9g/3H//4L/k/+k/7X/xv/X/+jyIv/xfPGN8oPylPKl8rbyx/LY//
Lp8vrzC/Mc8y3zPvNP82D/83HzgvOT86TztfPG89f3DY/mPuoMShxfDuse5Q7aDw4M5vFqEbP8gE
cHBx8MaAm8ZgHMBnxpQakG518UD6bsXwZ5qfHp8fryC/Ic//It8j7yT/Jg8nH0tfP49An/9PT0dP
SF9Jb0p/UZ9Mn02v/1DfT89dH1HvUv9UD2BPYV//Ym9jf2SPZZ9mr2e/aM9p35dq72v/WjAzmPBC
YZmwpGMgmUB0d/BAa0WS/0T2mgHuJvAxQ5/H90bPVj//V09YX1lvWn9bj1yfXa9ev/95L22fbq99
H3Ufdi93P3hP/39vem97f36vfZ+K73+/gM//gd+OH48vkD+RT5Jfk2+Uf3eVj5afQiE0xDLxRkL5
VWxTQsRgHJB2FuDEME07xSDwsGHGAHL/iSNwcpBvZ3Jh8MBzZfCw/nODD4QfhS+GP4dPiF+Jb/+K
f4uPjJ+kj5hPmV+qn6uv/6y/rc+u36/vsP+yD7MftC//tT+2T7dfuG+5f7qPu5+8r1+9v77Pv99B
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
AAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089VU5JTUlTL09VPUZJUlNUIEFETUlOSVNU
UkFUSVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049QUwuSVNTQwAAAAAeAPo/AQAAABUAAABTeXN0
ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAA
AAAALgAAAAMA/T+2AwAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAAAgA
AABBTC5JU1NDAB4AMUABAAAACAAAAEFMLklTU0MAHgAyQAEAAAAoAAAAYmx1ZXotZGV2ZWwtYWRt
aW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AM0ABAAAAFwAAAHBld2lAZ3ctaW5zdHJ1bWVudHMu
ZGUAAB4AOEABAAAACAAAAEFMLklTU0MAHgA5QAEAAAACAAAALgAAAAsAKQAAAAAACwAjAAAAAAAD
AAYQ/VtrtAMABxCmAwAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLFRIQU5LU0ZPUlJF
UExZMUtFUk5FTFZFUlNJT05JUzI0MjAySURPTlRSRUFMTFlDSEFOR0VNQUtFRklMRUpVU1RNQUtF
U1VSRUFMTEJMVUVaQVJFRU5BQkxFREFOREZPUkMAAAAAAgF/AAEAAAA8AAAAPEU2NEJBRDVBOEFE
NDY3NDA4MjgwNjlBNjc4RDlERDczMDExQTg4QG5ldGJlMDEubmV0LnVuaW1pcz4A1TU=

------_=_NextPart_001_01C59F1F.D33308BA--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
