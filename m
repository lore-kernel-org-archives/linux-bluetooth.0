Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C75385.0E872F03"
Date: Sun, 18 Feb 2007 18:48:54 +0100
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF473@mplex01.mpl.access-company.com>
References: <45D7173C.6090108@yahoo.com.au><CE5216C10C83944D9FD37B65CD33F3970CF472@mplex01.mpl.access-company.com>
	<45D873BC.2050305@yahoo.com.au>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  bluetooth-alsa: ALSA doesn't recognise a2dpd?
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

------_=_NextPart_001_01C75385.0E872F03
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > Hi, just type it manually a2dpd
> This doesn't work for me either.  I typed "a2dpd" and selected =
software
> mixer.  When I press play, the frequency band thing shows a solid
> horizontal black line, so it looks like it's just unable to write any
> data out.

Download and build latest xmms from their site.
or try another player.
aplay -Dpcm.a2dpd
or use pcm.!default instead of pcm.a2dpd.


------_=_NextPart_001_01C75385.0E872F03
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjcRAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAQQAAAFJFIDogW0JsdWV6LWRldmVs
XSBibHVldG9vdGgtYWxzYTogQUxTQSBkb2Vzbid0IHJlY29nbmlzZSBhMmRwZD8AJBYBBYADAA4A
AADXBwIAEgASADAANgAAAGoBASCAAwAOAAAA1wcCABIAEgAwADYAAABqAQEJgAEAIQAAAEQ2Njkx
MkM4NjRCRUI3NEY4NEE0N0FDODJCOUYxODdBAFMHAQOQBgDMCgAAOQAAAAMAJgAAAAAAAwA2AAAA
AABAADkAAy+HDoVTxwEeAD0AAQAAAAEAAAAAAAAAAgFHAAEAAAA3AAAAYz1VUzthPSA7cD1BY2Nl
c3MtQ29tcGFueTtsPU1QTEVYMDEtMDcwMjE4MTc0ODU0Wi05MzM4AAAeAEkAAQAAAEAAAABSZTog
W0JsdWV6LWRldmVsXSBibHVldG9vdGgtYWxzYTogQUxTQSBkb2Vzbid0IHJlY29nbmlzZSBhMmRw
ZD8AQABOAACG6ExzU8cBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1k
ZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5j
ZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwt
Qk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAAHAAAAGJsdWV6Lm1leG9uQHNw
YW1nb3VybWV0LmNvbQACAV4AAQAAAFUAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei5t
ZXhvbkBzcGFtZ291cm1ldC5jb20AU01UUABibHVlei5tZXhvbkBzcGFtZ291cm1ldC5jb20AAAAA
AgFfAAEAAAAhAAAAU01UUDpCTFVFWi5NRVhPTkBTUEFNR09VUk1FVC5DT00AAAAAHgBmAAEAAAAF
AAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAAcAAAAYmx1ZXoubWV4b25Ac3Bh
bWdvdXJtZXQuY29tAB4AcAABAAAAQQAAAFJFIDogW0JsdWV6LWRldmVsXSBibHVldG9vdGgtYWxz
YTogQUxTQSBkb2Vzbid0IHJlY29nbmlzZSBhMmRwZD8AAAAAAgFxAAEAAAAbAAAAAcdTc3OE5zGU
dEtvRbq+yzilglzCDAAEOE5UAB4AdAABAAAAIgAAAGJsdWV6LWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAdDgEAAABBAAAAUkUg
OiBbQmx1ZXotZGV2ZWxdIGJsdWV0b290aC1hbHNhOiBBTFNBIGRvZXNuJ3QgcmVjb2duaXNlIGEy
ZHBkPwAAAAACAQkQAQAAAO8BAADrAQAAwwIAAExaRnVhzAb8AwAKAHJjcGcxMjXiMgNDdGV4BUEB
AwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIs
ETMI7wn3tjsYHw4wNREiDGBjAFAzCwkBZDM2FlALpiA+ARzhSGksIGp1c4EFQHR5cGUgaQVABQOB
dQdAbHkgYTI8ZHALMQrACoAc8FRokQQAIGRvB5BuJwVAcncFsGsgAhAFwAeAIAplHhBoBJAuICBJ
UR2zZCAiHtMiHsBuuyIgFBBsBZAOsCLhbwGAincKwGUfJm1peCFz7lchYAOgIcBwGCAEEQtRXnkd
UCFRILAYIHEKUG66Yx6wYiLCIVALgGci8Chob3cEIGEjgWxp9x8XJ+AFEHoCIQdAJxALYOZjIKAo
cG5lHVAjkB4CWRewb2sEIChwax3yJ/MEIB1zdW4BoCMgHbAqoC53BRAOsCKxeR8mZGFlAZAgCGB0
Lh8kHyRENSfwbhewYSIgIsJidR8DECIgC2AOsB2ReG1t9wQgA1ImMmkFwACQDrAudckFsXRyHrFu
byFSJdMLIXEfJGEl4iAtRHD4Y20uHtkFsR2AHfA00uIhAQFhdWwFQAuAHZC+ZS+hI6A2Ix7TLnt9
OSAAHgA1EAEAAABIAAAAPENFNTIxNkMxMEM4Mzk0NEQ5RkQzN0I2NUNEMzNGMzk3MENGNDczQG1w
bGV4MDEubXBsLmFjY2Vzcy1jb21wYW55LmNvbT4AHgA5EAEAAACHAAAAPDQ1RDcxNzNDLjYwOTAx
MDhAeWFob28uY29tLmF1PjxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ3MkBt
cGxleDAxLm1wbC5hY2Nlc3MtY29tcGFueS5jb20+IDw0NUQ4NzNCQy4yMDUwMzA1QHlhaG9vLmNv
bS5hdT4AAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAlgAAAFIA
RQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAGIAbAB1AGUAdABvAG8AdABo
AC0AYQBsAHMAYQAlADMAQQAgAEEATABTAEEAIABkAG8AZQBzAG4AJwB0ACAAcgBlAGMAbwBnAG4A
aQBzAGUAIABhADIAZABwAGQAJQAzAEYALgBFAE0ATAAAAAAACwD2EAAAAABAAAcw97+/VIRTxwFA
AAgwZ7iQDoVTxwEDAN4/r28AAAMA8T8MBAAAHgD4PwEAAAARAAAARnJlZGVyaWMgRGFsbGVhdQAA
AAACAfk/AQAAAF8AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089QUNDRVNTLUNPTVBB
TlkvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/
AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0
uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAA
AAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRB
TExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQAAAAeADNAAQAAABwAAABibHVlei5tZXhvbkBzcGFtZ291cm1ldC5jb20AHgA4QAEAAAAR
AAAARlJFREVSSUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsA
IwAAAAAAAwAGEIA04fADAAcQLgEAAAMAEBACAAAAAwAREAEAAAAeAAgQAQAAAGUAAABISSxKVVNU
VFlQRUlUTUFOVUFMTFlBMkRQRFRISVNET0VTTlRXT1JLRk9STUVFSVRIRVJJVFlQRUQiQTJEUEQi
QU5EU0VMRUNURURTT0ZUV0FSRU1JWEVSV0hFTklQUkVTU1BMAAAAAAIBfwABAAAASAAAADxDRTUy
MTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ3M0BtcGxleDAxLm1wbC5hY2Nlc3MtY29t
cGFueS5jb20+ANS0

------_=_NextPart_001_01C75385.0E872F03
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C75385.0E872F03
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C75385.0E872F03--
