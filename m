Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7951D.498B3FD0"
Date: Sun, 13 May 2007 07:08:41 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4D2@mplex01.mpl.access-company.com>
References: <4646071D.6020303@gentoo.org>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : a2dpd getting into an endless loop when it fails
	to get a socket and not dying on CTRL+c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7951D.498B3FD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Basically it seems to go into an endless loop when it can't get the
> socket and I must then kill it with kill -9 <pid>.

Try to run it as root to get the sockets.
 You'll need to run your player as root too.
 It can't figure why these sockets are failing until I get a computer =
doing it.

Regards,
Frederic



------_=_NextPart_001_01C7951D.498B3FD0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhcFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAbAAAAFJFIDogW0JsdWV6LWRldmVs
XSBhMmRwZCBnZXR0aW5nIGludG8gYW4gZW5kbGVzcyBsb29wIHdoZW4gaXQgZmFpbHMgdG8gZ2V0
IGEgc29ja2V0IGFuZCBub3QgZHlpbmcgb24gQ1RSTCtjACAlAQWAAwAOAAAA1wcFAA0ABwAIACkA
AAAoAQEggAMADgAAANcHBQANAAcADAAWAAAAGQEBCYABACEAAAA3NEM3RDhFN0VGNUJBNzQ1OUIy
NUVCRkYxQzVCMTA0MQBmBwEDkAYAmAoAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AIVjysUclccB
HgA9AAEAAAABAAAAAAAAAAIBRwABAAAAOAAAAGM9VVM7YT0gO3A9QWNjZXNzLUNvbXBhbnk7bD1N
UExFWDAxLTA3MDUxMzA1MTIyMlotNDE2ODYAHgBJAAEAAABnAAAAW0JsdWV6LWRldmVsXSBhMmRw
ZCBnZXR0aW5nIGludG8gYW4gZW5kbGVzcyBsb29wIHdoZW4gaXQgZmFpbHMgdG8gZ2V0IGEgc29j
a2V0IGFuZCBub3QgZHlpbmcgb24gQ1RSTCtjAABAAE4AgAylOcOUxwEeAFoAAQAAACoAAABibHVl
ei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAIBWwABAAAAcQAAAAAAAACB
Kx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0AFNNVFAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFc
AAEAAAAvAAAAU01UUDpCTFVFWi1ERVZFTC1CT1VOQ0VTQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAA
HgBdAAEAAAANAAAAUGV0dGVyaSBS5HR5AAAAAAIBXgABAAAAQAAAAAAAAACBKx+kvqMQGZ1uAN0B
D1QCAAAAAFBldHRlcmkgUuR0eQBTTVRQAGJldGVsZ2V1c2VAZ2VudG9vLm9yZwACAV8AAQAAABsA
AABTTVRQOkJFVEVMR0VVU0VAR0VOVE9PLk9SRwAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAA
ACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AaAABAAAA
BQAAAFNNVFAAAAAAHgBpAAEAAAAWAAAAYmV0ZWxnZXVzZUBnZW50b28ub3JnAAAAHgBwAAEAAABs
AAAAUkUgOiBbQmx1ZXotZGV2ZWxdIGEyZHBkIGdldHRpbmcgaW50byBhbiBlbmRsZXNzIGxvb3Ag
d2hlbiBpdCBmYWlscyB0byBnZXQgYSBzb2NrZXQgYW5kIG5vdCBkeWluZyBvbiBDVFJMK2MAAgFx
AAEAAAAbAAAAAceUw0fOA0bInU4jRhC1Sb3VByI1cgAWX39zAB4AdAABAAAAIgAAAGJsdWV6LWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUA
AAAAHgAdDgEAAABsAAAAUkUgOiBbQmx1ZXotZGV2ZWxdIGEyZHBkIGdldHRpbmcgaW50byBhbiBl
bmRsZXNzIGxvb3Agd2hlbiBpdCBmYWlscyB0byBnZXQgYSBzb2NrZXQgYW5kIG5vdCBkeWluZyBv
biBDVFJMK2MAAgEJEAEAAACQAQAAjAEAAHACAABMWkZ1NAt6igMACgByY3BnMTI14jIDQ3RleAVB
AQMB9/8KgAKkA+QHEwKAD/MAUARWPwhVB7IRJQ5RAwECAGNo4QrAc2V0MgYABsMRJfYzBEYTtzAS
LBEzCO8J97Y7GB8OMDURIgxgYwBQMwsJAWQzNhZQC6YgPhggQmEN0QdAbHkgJmkFQBQQZW0EIHRv
fCBnHlALgB5BA5EJ8GQObAeQBCAXsG9wIHdOaAnwHaIdUG4nBUBnPxQgHjAgAAqiCoAc8HNvDGNr
IOEAcGQgSSDYbXVzIPMDoGsDEAMgDx2xA/AhECMkLTkgPGBwaWQ+LiFEIURU5nIdkB5BcnUgIx0g
JgBfH7Ag8R5RIOQhtXMk1SDqWQhgJyNRbgngIlAl5Wp5CGEgC1F5EoEmiG/FKCZJIFZmaWcIcCeQ
fx/wJcEgABQQJ6Ye4CyRZqULcGwLgGcgJiB0AxGbInAg0mEgYANwcHUOsDkFwGRvLmIdsCTbUmXS
ZwsRcywhREYYIQZxFwDgJPkhRH0z8B4ANRABAAAASAAAADxDRTUyMTZDMTBDODM5NDREOUZEMzdC
NjVDRDMzRjM5NzBDRjREMkBtcGxleDAxLm1wbC5hY2Nlc3MtY29tcGFueS5jb20+AB4AORABAAAA
HgAAADw0NjQ2MDcxRC42MDIwMzAzQGdlbnRvby5vcmc+AAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9y
ZmM4MjIAAAsA8hABAAAAHwDzEAEAAADoAAAAUgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQA
ZQB2AGUAbABdACAAYQAyAGQAcABkACAAZwBlAHQAdABpAG4AZwAgAGkAbgB0AG8AIABhAG4AIABl
AG4AZABsAGUAcwBzACAAbABvAG8AcAAgAHcAaABlAG4AIABpAHQAIABmAGEAaQBsAHMAIAB0AG8A
IABnAGUAdAAgAGEAIABzAG8AYwBrAGUAdAAgAGEAbgBkACAAbgBvAHQAIABkAHkAaQBuAGcAIABv
AG4AIABDAFQAUgBMACUAMgBCAGMALgBFAE0ATAAAAAsA9hAAAAAAQAAHMCwByMUclccBQAAIMI0r
l0kdlccBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5
PwEAAABfAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPUFDQ0VTUy1DT01QQU5ZL09V
PU1PTlRQRUxMSUVSL0NOPVJFQ0lQSUVOVFMvQ049RlJFREVSSUMuREFMTEVBVQAAHgD6PwEAAAAV
AAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv
4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAw
QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADFAAQAAABEAAABGUkVERVJJQy5EQUxMRUFV
AAAAAB4AMkABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0
AAAAHgAzQAEAAAAWAAAAYmV0ZWxnZXVzZUBnZW50b28ub3JnAAAAHgA4QAEAAAARAAAARlJFREVS
SUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAG
EGgyaLgDAAcQ6QAAAAMAEBABAAAAAwAREAAAAAAeAAgQAQAAAGUAAABCQVNJQ0FMTFlJVFNFRU1T
VE9HT0lOVE9BTkVORExFU1NMT09QV0hFTklUQ0FOVEdFVFRIRVNPQ0tFVEFORElNVVNUVEhFTktJ
TExJVFdJVEhLSUxMLTk8UElEVFJZVE9SVU5JAAAAAAIBfwABAAAASAAAADxDRTUyMTZDMTBDODM5
NDREOUZEMzdCNjVDRDMzRjM5NzBDRjREMkBtcGxleDAxLm1wbC5hY2Nlc3MtY29tcGFueS5jb20+
AIac

------_=_NextPart_001_01C7951D.498B3FD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C7951D.498B3FD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C7951D.498B3FD0--
