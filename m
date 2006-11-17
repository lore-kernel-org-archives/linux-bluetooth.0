Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70A13.F40CE889"
Date: Fri, 17 Nov 2006 07:45:21 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>
References: <455CCAF4.8020007@silicom.fr>
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

------_=_NextPart_001_01C70A13.F40CE889
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Fabien,

> However, due to the fact a2dp is not supposed to be used for delay =
sensitive
> streams, it is possible to use this architecture for a2dp. :-)

A2DP data are certainly not sensitive, but having the sound of your =
movie playing
with delay is really unpleasant. So in the end the need for low latency =
is probably
the same in SCO and A2DP.

>>From my point of vue, having the SCO socket inside application is not =
needed.
The benefit is one single unix socket transfer. In a typical video =
conferencing
application used on the internet, the delay used for transmitting data =
will probably
be by far more important than the delay induced by this transfer. So any =
gain
on the SCO side would be made negligible against what is lost during =
transmission.

Frederic

------_=_NextPart_001_01C70A13.F40CE889
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhYGAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAOgAAAFJFIDogW0JsdWV6LWRldmVs
XSBTQ08gb24gYmx1ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwDlEwEFgAMADgAAANYHCwAR
AAcALQAVAAUARwEBIIADAA4AAADWBwsAEQAHAC0AFQAFAEcBAQmAAQAhAAAARDg1N0FBMDU4NzI1
NzQ0NUJDOEQ0NUVGNTY4QzFERTYARAcBA5AGAOAKAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQCJ
6Az0EwrHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADYAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7
bD1FVU1PTkVYMDEtMDYxMTE3MDY0NTIxWi0xMzM2MwAAAB4ASQABAAAANQAAAFtCbHVlei1kZXZl
bF0gU0NPIG9uIGJsdWV6IDogc29tZSBhcmNoaXRlY3R1cmFsIHRpcHMAAAAAQABOAADybmO+CccB
HgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAC
AVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNl
Zm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5T
T1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAAEQAAAEZhYmllbiBDaGV2YWxpZXIAAAAAAgFeAAEAAABE
AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAARmFiaWVuIENoZXZhbGllcgBTTVRQAGZjaGV2YWxp
ZXJAc2lsaWNvbS5mcgACAV8AAQAAABsAAABTTVRQOkZDSEVWQUxJRVJAU0lMSUNPTS5GUgAAHgBm
AAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAAWAAAAZmNoZXZhbGll
ckBzaWxpY29tLmZyAAAAHgBwAAEAAAA6AAAAUkUgOiBbQmx1ZXotZGV2ZWxdIFNDTyBvbiBibHVl
eiA6IHNvbWUgYXJjaGl0ZWN0dXJhbCB0aXBzAAAAAgFxAAEAAAAbAAAAAccJvohHB6PliZjzTRK9
0o141vbtGgAULFahAB4AdAABAAAAEgAAAEJsdWVaIGRldmVsb3BtZW50AAAAHgAaDAEAAAARAAAA
RnJlZGVyaWMgRGFsbGVhdQAAAAAeAB0OAQAAADoAAABSRSA6IFtCbHVlei1kZXZlbF0gU0NPIG9u
IGJsdWV6IDogc29tZSBhcmNoaXRlY3R1cmFsIHRpcHMAAAACAQkQAQAAAN4CAADaAgAATQQAAExa
RnXmBJ+hAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshElDlED
AQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREiDGBjAFAzCwkBZDM2FlAL
piBImGkgRgGgCJBuLAqiCwqECoA+HOBvd2V2EQSQLCBkClAgdG81HzBoHyBmANAFQGEyiGRwIAQA
IG5vBUCgc3VwcG8UEGQfMvpiHyB1IRICEAXAAQALYM55ILAJ8ACQdGkesB32xHN0GCBhbXMe4CLg
/yBCIPEAkAJgHyMhsR9hIFHvCsAT0CLgBZB0CHAfkQWxQSACLiA6LSkdmkHoMkRQHvBhAZAl4R8g
7mMEkAGQC4BsIoAggyK2WR7gYnUFQBPgdguAZxUfY3MIYG4hMG9mIHp5CGEgBGArIB8gC1F5fysx
HZQD8B9wIjUgUSPRbK8poSvQC1Aj4HMAcHQnQH5TH1ALgB9jCfAhMR+Bbj8J4CHkF7AH4AtgDrBu
Y/UuU3ADYGIBoCmgHZQrc8cj8B8gMAFTQ08f8Cvh9ShSLh2aRgNhLIAigCDw9wuABUAsEXYKUB7g
Kwk0EvkrsGNrFCAv8QCQAQAf8O0g4GwN4CiwaQIgIEYw8rsJgDTVVB+BIYAw8GYkRJ8CICuRKzEl
ASvQaXg35tsjwABxZgSQJ0BJA6Ao0Ph0eXA5EQMgKyABAB9Q/QWgbj2BMfEtNzjaIbM5Yf8fcjZB
BJEUIB7gH3IiRCG3/T0zbSLgIvArQSijA/Au0PsybSGBYiKAH7AsciaRB3D/IPApUTZRH3ADkUJI
C4AfAP8pMCEwRfEloz04L9EAcCKAvmcLch2jQTU3sziSdwhgfmxIoR8gAMA4oTDwPDBp+mck42FK
UiOwRIAT4CRT/xewTdEfAAUQK0JDhCTBAiBfNN06IQUQAOAdo31RwAAAHgA1EAEAAABCAAAAPDdB
NkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUE3QGV1bW9uZXgwMS5wYWxtc291cmNl
LmNvbT4AAAAeADkQAQAAAB4AAAA8NDU1Q0NBRjQuODAyMDAwN0BzaWxpY29tLmZyPgAAAB4ARxAB
AAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAhAAAAFIARQAgACUAMwBBACAA
WwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAFMAQwBPACAAbwBuACAAYgBsAHUAZQB6ACAAJQAz
AEEAIABzAG8AbQBlACAAYQByAGMAaABpAHQAZQBjAHQAdQByAGEAbAAgAHQAaQBwAHMALgBFAE0A
TAAAAAsA9hAAAAAAQAAHMFk/oDkPCscBQAAIMOlxFvQTCscBAwDeP69vAAADAPE/DAQAAB4A+D8B
AAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv
4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1G
UkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/
AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAAD
ABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4A
MUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91
bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABYAAABmY2hldmFsaWVyQHNpbGlj
b20uZnIAAAAeADhAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAAD
AHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQ/s0CFAMABxBnAgAAAwAQEAAAAAADABEQAAAAAB4A
CBABAAAAZQAAAEhJRkFCSUVOLEhPV0VWRVIsRFVFVE9USEVGQUNUQTJEUElTTk9UU1VQUE9TRURU
T0JFVVNFREZPUkRFTEFZU0VOU0lUSVZFU1RSRUFNUyxJVElTUE9TU0lCTEVUT1VTRVRISVMAAAAA
AgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUE3QGV1bW9u
ZXgwMS5wYWxtc291cmNlLmNvbT4AAACqyg==

------_=_NextPart_001_01C70A13.F40CE889
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C70A13.F40CE889
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C70A13.F40CE889--
