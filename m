Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5B56A.3EA3A242"
Subject: RE: [Bluez-devel] sbc decoder unrolled
Message-ID: <C70061B183DE09419568AB2060C52A950E449C@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
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
Date: Fri, 9 Sep 2005 20:13:57 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5B56A.3EA3A242
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Brad,

But why is it a problem? The result of encoding/decoding is save to a =
file - we compare files... So we run reference encoder under windows (or =
using wine under linux) and then run our stuff under linux, and compare =
the results obtained using windows reference ebcoder/decoder?

Regards,
     Victor.


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad Midgley
Sent: Fri 9/9/2005 7:59 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc decoder unrolled
=20
Steven

>   output of reference encoder + your decoder (spec requires K > 14)
>   output of your encoder + reference decoder
>   output of your encoder + your decoder

There is a little gotcha here in that we only have a windows binary for=20
a reference encoder/decoder. I haven't tried to build our stuff in=20
cygwin or windows dev tools and there are probably things to fix...

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle =
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C5B56A.3EA3A242
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjoSAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAJwAAAFJFOiBbQmx1ZXotZGV2ZWxd
IHNiYyBkZWNvZGVyIHVucm9sbGVkALsNAQWAAwAOAAAA1QcJAAkAFAANADkABQBNAQEggAMADgAA
ANUHCQAJABQADQA5AAUATQEBCYABACEAAABEMzNGRDY1RkMyRjgyODQ0OUY5ODZDRkY4QzQ0RjQ4
RAB4BwEDkAYAaAsAADgAAAADACYAAAAAAAMANgAAAAAAQAA5AEKioz5qtcUBHgA9AAEAAAAFAAAA
UkU6IAAAAAACAUcAAQAAACUAAABjPU5MO2E9IDtsPUFSSU9OLTA1MDkwOTE4MTM1N1otNzc2MjMA
AAAAHgBJAAEAAAAnAAAAUmU6IFtCbHVlei1kZXZlbF0gc2JjIGRlY29kZXIgdW5yb2xsZWQAAEAA
TgAAJEAqaLXFAR4AWgABAAAAKAAAAGJsdWV6LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldAACAVsAAQAAAG0AAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1hZG1p
bkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAtAAAAU01UUDpCTFVFWi1ERVZFTC1BRE1JTkBMSVNUUy5T
T1VSQ0VGT1JHRS5ORVQAAAAAHgBdAAEAAAANAAAAQnJhZCBNaWRnbGV5AAAAAAIBXgABAAAAQAAA
AAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAEJyYWQgTWlkZ2xleQBTTVRQAGJtaWRnbGV5QHhtaXNz
aW9uLmNvbQACAV8AAQAAABsAAABTTVRQOkJNSURHTEVZQFhNSVNTSU9OLkNPTQAAHgBmAAEAAAAF
AAAAU01UUAAAAAAeAGcAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5j
b20AAAAeAHAAAQAAACMAAABbQmx1ZXotZGV2ZWxdIHNiYyBkZWNvZGVyIHVucm9sbGVkAAACAXEA
AQAAABsAAAABxbVoIBS/3Cr9pY5LZYfziycvYKhzAABPFoIAHgB0AAEAAAAiAAAAYmx1ZXotZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgAaDAEAAAAUAAAAVmljdG9yIFNoY2hlcmJhdHl1
awAeAB0OAQAAACMAAABbQmx1ZXotZGV2ZWxdIHNiYyBkZWNvZGVyIHVucm9sbGVkAAACAQkQAQAA
AEQEAABABAAARwcAAExaRnUOCxJfAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP
8wBQBFY/CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREi
DGBjAFAzCwkBZDM2FlALpiBCcHJhZCwKogqECoBCwnUFQHdoeSAEAB5wMQVAYSBwA2ACYGVtQD8g
VGhlIBggc8R1bAVAb2YgCfAFoHJkC4BnLwWCILIecnOkYXYfsHRvHtFmAxDdH7AtHjAfsAWgbQqx
H7B5ImJzLiPQBgAiICLRcvZ1A6AYIGYEkCBxH7Agc58SgSSAJZID8CXgb3cEIPooBbF1AJAhYSYx
H7Al1OJsC4B1eCke0CXgIgCfH6AkkSSBCGEhsHR1ASD9J5osKGMjBiixH8UEIB8gvwGQJ2EokCb3
JmMkuWIlc4sg9ASQPx1KUmVnCxFqcx01IDDiVg3gIhByVi4dSh1ELTLCTwUQZ58LgAdABdAHkCHA
Z2UywyUdREYDYTogCjJ6LVMBACHgbC0dEG0LgEB3KAApgCPAcwhhJSACEHKdM/AuJ3AgIQOgYmUT
4B5sIFAgQRzyBdBpZGd9H0B5HUQGYAIwNQA0wGkYIDkvOjAB0DA1IIA3OjU5IFBNHUQ8VG81CzY/
N0M5NXVinmoFkDnBMAA1AFtCNTh2XSGwLlAgLsUlwQNgbP8fQAsxMKM5NQ6wIeALkB1Z5j4w4Qhg
dHAeESBBJL8wICsgeSlCQDYoc0ZwBZAfwXF1aR/RIMRLIEMgMTQpQs8gQf9FQ0SoRAguxUd/SI9F
Ox1Kfx+RI1EegR7gKAACQCKBZ3RvdBPRIE50A6AosGH3HiEfsAIgbB5gE+Ah4R7g9SY2YjNRch5g
NwFBlR7gl0QPLrYj8ElRM24nBUCudAiBKJEiIGJGoGwokMcpSFBBHURjeWcmMSAw/yYYNYEiAQbw
TtEohCNRI0L/HwIBoFERKLAgwQQgIhEiYP54I9EdSx0BMa8ytF5vX3/zYI45NUYuB8AFQB9QC3Dz
AyAegVNwAiA2oBghNRD7WuIfsEIUIA6wBcAkEAGAFncjQghQbiTWJiBF+FhQTzk2BTAfUDfQBcBg
MTktMjIqkDpzKncGAjnhAHBjBAAFoCqQQ8pBZ8FENZJvcAeAAjBMIEwGkAWQeWMigVDfHQAxUA3g
B5AdREEzQCKBxWWwUAtgbi1EBRBCMXtpK2fQTQBwM+AhUmqQb4c+cgQgZbBUZWFtBCCfZ9Bu4CmA
IVJlsFFBOTb6YwhxdB5gZ9BuMWrxBCB+SSMgA2Ah4GmjZbAzoGEXH/AYIG01aAJAcDovbC93c+A2
kHE3QCMBL0JiBPBlNXNmHURf33V/do93Wh2lNTggYnIhUt88knhvPI89mXNyc3Oxe2//N1J9hH2D
C4ACEHSQNTgdSgJ9gWAeADUQAQAAADsAAAA8QzcwMDYxQjE4M0RFMDk0MTk1NjhBQjIwNjBDNTJB
OTUwRTQ0OUNAYXJpb24uaW50cmEubG9jYWw+AAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAA
CwDyEAEAAAAfAPMQAQAAAFoAAABSAEUAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABd
ACAAcwBiAGMAIABkAGUAYwBvAGQAZQByACAAdQBuAHIAbwBsAGwAZQBkAC4ARQBNAEwAAAAAAAsA
9hAAAAAAQAAHMMtBb1xptcUBQAAIMPq0tj5qtcUBAwDeP69vAAADAPE/CQQAAB4A+D8BAAAAFAAA
AFZpY3RvciBTaGNoZXJiYXR5dWsAAgH5PwEAAABoAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAA
AAAAAC9PPUVYQ0hBTkdFIE9SR0FOSVpBVElPTi9PVT1GSVJTVCBBRE1JTklTVFJBVElWRSBHUk9V
UC9DTj1SRUNJUElFTlRTL0NOPVZTSAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAA
AAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZ
QAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAAAQAAABWU0gAHgAxQAEAAAAEAAAA
VlNIAB4AMkABAAAAKAAAAGJsdWV6LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAe
ADNAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5jb20AAAAeADhAAQAAAAQAAABWU0gAHgA5QAEA
AAACAAAALgAAAAMAdkD/////CwApAAAAAAALACMAAAAAAAMABhAZzbV5AwAHEGwEAAADABAQAAAA
AAMAERAAAAAAHgAIEAEAAABlAAAAQlJBRCxCVVRXSFlJU0lUQVBST0JMRU0/VEhFUkVTVUxUT0ZF
TkNPRElORy9ERUNPRElOR0lTU0FWRVRPQUZJTEUtV0VDT01QQVJFRklMRVNTT1dFUlVOUkVGRVJF
TkNFRU5DTwAAAAACAX8AAQAAADsAAAA8QzcwMDYxQjE4M0RFMDk0MTk1NjhBQjIwNjBDNTJBOTUw
RTQ0OUNAYXJpb24uaW50cmEubG9jYWw+AABgAA==

------_=_NextPart_001_01C5B56A.3EA3A242--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
