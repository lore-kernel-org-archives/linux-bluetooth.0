Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2008 03:51:50 -0700 (PDT)
From: panca sorin <psihozefir@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-23190225-1219056710=:32389"
Message-ID: <78086.32389.qm@web33610.mail.mud.yahoo.com>
Subject: [Bluez-users] How to make bluez create the bnep0 device?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--0-23190225-1219056710=:32389
Content-Type: multipart/alternative; boundary="0-1244684813-1219056710=:32389"

--0-1244684813-1219056710=:32389
Content-Type: text/plain; charset=us-ascii

I'm trying to connect my laptop to the Internet through my Sony-Ericsson K800i. The USB Internet connection is working and now I want to set my laptop up to use the bluetooth connection.
I was searching the Internet for a good howto for using bluez as PANU using the new configuration files without daemons, to no avail. Using pand I was able to get bnep0 created. A while back I found a statement saying something like "PANU is not supported, use NAP and/or GN." Is this still the case?
My phone insists on paying the NAP role.

Here is my current setup from relevant files:
sorin.p@sputnik ~ $ cut -d\# -f1 /etc/bluetooth/network.* | grep -v ^$
[General]
Disable=Server
[PANU Role]
Interface=bnep0
Script=dhcpcd
[Bluetooth Service]
Identifier=network
Name=Network service
Description=Bluetooth Personal Area Network service
Autostart=true

My laptop is running Gentoo Linux, with bluez-libs-3.36, bluez-utils-3.36 from portage on amd64.
In the attached file are the records found by sdptool for my phone.

Any ideas on how to make it work (create the interface)?
Sorin.



      
--0-1244684813-1219056710=:32389
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>I'm trying to connect my laptop to the Internet through my Sony-Ericsson K800i. The USB Internet connection is working and now I want to set my laptop up to use the bluetooth connection.<br>I was searching the Internet for a good howto for using bluez as PANU using the new configuration files without daemons, to no avail. Using pand I was able to get bnep0 created. A while back I found a statement saying something like "PANU is not supported, use NAP and/or GN." Is this still the case?<br>My phone insists on paying the NAP role.<br><br>Here is my current setup from relevant files:<br>sorin.p@sputnik ~ $ cut -d\# -f1 /etc/bluetooth/network.* | grep -v ^$<br>[General]<br>Disable=Server<br>[PANU Role]<br>Interface=bnep0<br>Script=dhcpcd<br>[Bluetooth
 Service]<br>Identifier=network<br>Name=Network service<br>Description=Bluetooth Personal Area Network service<br>Autostart=true<br><br>My laptop is running Gentoo Linux, with bluez-libs-3.36, bluez-utils-3.36 from portage on amd64.<br>In the attached file are the records found by sdptool for my phone.<br><br>Any ideas on how to make it work (create the interface)?<br>Sorin.<br></div></div><br>

      </body></html>
--0-1244684813-1219056710=:32389--

--0-23190225-1219056710=:32389
Content-Type: text/plain; name="records.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="records.txt"

U2VydmljZSBEZXNjcmlwdGlvbjogU29ueSBFcmljc3NvbiBLODAwClNlcnZp
Y2UgUmVjSGFuZGxlOiAweDEwMDAwClNlcnZpY2UgQ2xhc3MgSUQgTGlzdDoK
ICAiUG5QIEluZm9ybWF0aW9uIiAoMHgxMjAwKQoKU2VydmljZSBOYW1lOiBP
QkVYIFN5bmNNTCBDbGllbnQKU2VydmljZSBSZWNIYW5kbGU6IDB4MTAwMDEK
U2VydmljZSBDbGFzcyBJRCBMaXN0OgogIFVVSUQgMTI4OiAwMDAwMDAwMi0w
MDAwLTEwMDAtODAwMC0wMDAyZWUwMDAwMDIKUHJvdG9jb2wgRGVzY3JpcHRv
ciBMaXN0OgogICJMMkNBUCIgKDB4MDEwMCkKICAiUkZDT01NIiAoMHgwMDAz
KQogICAgQ2hhbm5lbDogMQogICJPQkVYIiAoMHgwMDA4KQoKU2VydmljZSBO
YW1lOiBEaWFsLXVwIE5ldHdvcmtpbmcKU2VydmljZSBSZWNIYW5kbGU6IDB4
MTAwMDIKU2VydmljZSBDbGFzcyBJRCBMaXN0OgogICJEaWFsdXAgTmV0d29y
a2luZyIgKDB4MTEwMykKICAiR2VuZXJpYyBOZXR3b3JraW5nIiAoMHgxMjAx
KQpQcm90b2NvbCBEZXNjcmlwdG9yIExpc3Q6CiAgIkwyQ0FQIiAoMHgwMTAw
KQogICJSRkNPTU0iICgweDAwMDMpCiAgICBDaGFubmVsOiAyClByb2ZpbGUg
RGVzY3JpcHRvciBMaXN0OgogICJEaWFsdXAgTmV0d29ya2luZyIgKDB4MTEw
MykKICAgIFZlcnNpb246IDB4MDEwMAoKU2VydmljZSBOYW1lOiBTZXJpYWwg
UG9ydApTZXJ2aWNlIFJlY0hhbmRsZTogMHgxMDAwMwpTZXJ2aWNlIENsYXNz
IElEIExpc3Q6CiAgIlNlcmlhbCBQb3J0IiAoMHgxMTAxKQpQcm90b2NvbCBE
ZXNjcmlwdG9yIExpc3Q6CiAgIkwyQ0FQIiAoMHgwMTAwKQogICJSRkNPTU0i
ICgweDAwMDMpCiAgICBDaGFubmVsOiAzCgpTZXJ2aWNlIE5hbWU6IE11c2lj
IFN0cmVhbWluZyBTZXJ2aWNlClNlcnZpY2UgUHJvdmlkZXI6IFNvbnkgRXJp
Y3Nzb24KU2VydmljZSBSZWNIYW5kbGU6IDB4MTAwMDQKU2VydmljZSBDbGFz
cyBJRCBMaXN0OgogICJBdWRpbyBTb3VyY2UiICgweDExMGEpClByb3RvY29s
IERlc2NyaXB0b3IgTGlzdDoKICAiTDJDQVAiICgweDAxMDApCiAgICBQU006
IDI1CiAgIkFWRFRQIiAoMHgwMDE5KQogICAgdWludDE2OiAweDEwMApQcm9m
aWxlIERlc2NyaXB0b3IgTGlzdDoKICAiQWR2YW5jZWQgQXVkaW8iICgweDEx
MGQpCiAgICBWZXJzaW9uOiAweDEwMDAKClNlcnZpY2UgTmFtZTogUmVtb3Rl
IENvbnRyb2wgVEcgU2VydmljZQpTZXJ2aWNlIFByb3ZpZGVyOiBTb255IEVy
aWNzc29uClNlcnZpY2UgUmVjSGFuZGxlOiAweDEwMDA1ClNlcnZpY2UgQ2xh
c3MgSUQgTGlzdDoKICAiQVYgUmVtb3RlIFRhcmdldCIgKDB4MTEwYykKUHJv
dG9jb2wgRGVzY3JpcHRvciBMaXN0OgogICJMMkNBUCIgKDB4MDEwMCkKICAg
IFBTTTogMjMKICAiQVZDVFAiICgweDAwMTcpCiAgICB1aW50MTY6IDB4MTAw
ClByb2ZpbGUgRGVzY3JpcHRvciBMaXN0OgogICJBViBSZW1vdGUiICgweDEx
MGUpCiAgICBWZXJzaW9uOiAweDAxMDAKClNlcnZpY2UgTmFtZTogUmVtb3Rl
IENvbnRyb2wgU2VydmljZQpTZXJ2aWNlIFByb3ZpZGVyOiBTb255IEVyaWNz
c29uClNlcnZpY2UgUmVjSGFuZGxlOiAweDEwMDA2ClNlcnZpY2UgQ2xhc3Mg
SUQgTGlzdDoKICAiQVYgUmVtb3RlIiAoMHgxMTBlKQpQcm90b2NvbCBEZXNj
cmlwdG9yIExpc3Q6CiAgIkwyQ0FQIiAoMHgwMTAwKQogICAgUFNNOiAyMwog
ICJBVkNUUCIgKDB4MDAxNykKICAgIHVpbnQxNjogMHgxMDAKUHJvZmlsZSBE
ZXNjcmlwdG9yIExpc3Q6CiAgIkFWIFJlbW90ZSIgKDB4MTEwZSkKICAgIFZl
cnNpb246IDB4MDEwMAoKU2VydmljZSBOYW1lOiBTRU1DIFdhdGNoIFBob25l
ClNlcnZpY2UgUmVjSGFuZGxlOiAweDEwMDA3ClNlcnZpY2UgQ2xhc3MgSUQg
TGlzdDoKICBVVUlEIDEyODogOGU3NzE0MDEtMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiCgpTZXJ2aWNlIE5hbWU6IFBBTiBOZXR3b3JrIEFjY2VzcyBQ
b2ludApTZXJ2aWNlIERlc2NyaXB0aW9uOiBOQVAgcHJvdmlkZXMgYWNjZXNz
IHRvIGludGVybmV0IGZvciBvbmUgY29ubmVjdGluZyBQQU51ClNlcnZpY2Ug
UmVjSGFuZGxlOiAweDEwMDA4ClNlcnZpY2UgQ2xhc3MgSUQgTGlzdDoKICAi
TmV0d29yayBBY2Nlc3MgUG9pbnQiICgweDExMTYpClByb3RvY29sIERlc2Ny
aXB0b3IgTGlzdDoKICAiTDJDQVAiICgweDAxMDApCiAgICBQU006IDE1CiAg
IkJORVAiICgweDAwMGYpCiAgICBWZXJzaW9uOiAweDAxMDAKICAgIFNFUTg6
IDAgNiBkZApMYW5ndWFnZSBCYXNlIEF0dHIgTGlzdDoKICBjb2RlX0lTTzYz
OTogMHg2NTZlCiAgZW5jb2Rpbmc6ICAgIDB4NmEKICBiYXNlX29mZnNldDog
MHgxMDAKUHJvZmlsZSBEZXNjcmlwdG9yIExpc3Q6CiAgIk5ldHdvcmsgQWNj
ZXNzIFBvaW50IiAoMHgxMTE2KQogICAgVmVyc2lvbjogMHgwMTAwCgpTZXJ2
aWNlIE5hbWU6IEhhbmRzLUZyZWUgR2F0ZXdheQpTZXJ2aWNlIFJlY0hhbmRs
ZTogMHgxMDAwOQpTZXJ2aWNlIENsYXNzIElEIExpc3Q6CiAgIkhhbmRzZnJl
ZSBBdWRpbyBHYXRld2F5IiAoMHgxMTFmKQogICJHZW5lcmljIEF1ZGlvIiAo
MHgxMjAzKQpQcm90b2NvbCBEZXNjcmlwdG9yIExpc3Q6CiAgIkwyQ0FQIiAo
MHgwMTAwKQogICJSRkNPTU0iICgweDAwMDMpCiAgICBDaGFubmVsOiA0ClBy
b2ZpbGUgRGVzY3JpcHRvciBMaXN0OgogICJIYW5kc2ZyZWUiICgweDExMWUp
CiAgICBWZXJzaW9uOiAweDAxMDUKClNlcnZpY2UgTmFtZTogSGVhZHNldCBH
YXRld2F5ClNlcnZpY2UgUmVjSGFuZGxlOiAweDEwMDBhClNlcnZpY2UgQ2xh
c3MgSUQgTGlzdDoKICAiSGVhZHNldCBBdWRpbyBHYXRld2F5IiAoMHgxMTEy
KQogICJHZW5lcmljIEF1ZGlvIiAoMHgxMjAzKQpQcm90b2NvbCBEZXNjcmlw
dG9yIExpc3Q6CiAgIkwyQ0FQIiAoMHgwMTAwKQogICJSRkNPTU0iICgweDAw
MDMpCiAgICBDaGFubmVsOiA1ClByb2ZpbGUgRGVzY3JpcHRvciBMaXN0Ogog
ICJIZWFkc2V0IiAoMHgxMTA4KQogICAgVmVyc2lvbjogMHgwMTAwCgpTZXJ2
aWNlIE5hbWU6IE9CRVggT2JqZWN0IFB1c2gKU2VydmljZSBSZWNIYW5kbGU6
IDB4MTAwMGIKU2VydmljZSBDbGFzcyBJRCBMaXN0OgogICJPQkVYIE9iamVj
dCBQdXNoIiAoMHgxMTA1KQpQcm90b2NvbCBEZXNjcmlwdG9yIExpc3Q6CiAg
IkwyQ0FQIiAoMHgwMTAwKQogICJSRkNPTU0iICgweDAwMDMpCiAgICBDaGFu
bmVsOiA2CiAgIk9CRVgiICgweDAwMDgpClByb2ZpbGUgRGVzY3JpcHRvciBM
aXN0OgogICJPQkVYIE9iamVjdCBQdXNoIiAoMHgxMTA1KQogICAgVmVyc2lv
bjogMHgwMTAwCgpTZXJ2aWNlIE5hbWU6IE9CRVggRmlsZSBUcmFuc2ZlcgpT
ZXJ2aWNlIFJlY0hhbmRsZTogMHgxMDAwYwpTZXJ2aWNlIENsYXNzIElEIExp
c3Q6CiAgIk9CRVggRmlsZSBUcmFuc2ZlciIgKDB4MTEwNikKUHJvdG9jb2wg
RGVzY3JpcHRvciBMaXN0OgogICJMMkNBUCIgKDB4MDEwMCkKICAiUkZDT01N
IiAoMHgwMDAzKQogICAgQ2hhbm5lbDogNwogICJPQkVYIiAoMHgwMDA4KQpQ
cm9maWxlIERlc2NyaXB0b3IgTGlzdDoKICAiT0JFWCBGaWxlIFRyYW5zZmVy
IiAoMHgxMTA2KQogICAgVmVyc2lvbjogMHgwMTAwCgpTZXJ2aWNlIE5hbWU6
IE9CRVggSXJNQyBTeW5jIFNlcnZlcgpTZXJ2aWNlIFJlY0hhbmRsZTogMHgx
MDAwZApTZXJ2aWNlIENsYXNzIElEIExpc3Q6CiAgIklyTUMgU3luYyIgKDB4
MTEwNCkKUHJvdG9jb2wgRGVzY3JpcHRvciBMaXN0OgogICJMMkNBUCIgKDB4
MDEwMCkKICAiUkZDT01NIiAoMHgwMDAzKQogICAgQ2hhbm5lbDogOAogICJP
QkVYIiAoMHgwMDA4KQpQcm9maWxlIERlc2NyaXB0b3IgTGlzdDoKICAiSXJN
QyBTeW5jIiAoMHgxMTA0KQogICAgVmVyc2lvbjogMHgwMTAwCgpTZXJ2aWNl
IE5hbWU6IEhJRCBNb3VzZSAmIEtleWJvYXJkClNlcnZpY2UgRGVzY3JpcHRp
b246IFJlbW90ZSBDb250cm9sIG9mIFBDIGFwcGxpY2F0aW9ucyBhbmQgb3Ro
ZXIgZGV2aWNlcwpTZXJ2aWNlIFByb3ZpZGVyOiBTb255IEVyaWNzc29uClNl
cnZpY2UgUmVjSGFuZGxlOiAweDEwMDBlClNlcnZpY2UgQ2xhc3MgSUQgTGlz
dDoKICAiSHVtYW4gSW50ZXJmYWNlIERldmljZSIgKDB4MTEyNCkKUHJvdG9j
b2wgRGVzY3JpcHRvciBMaXN0OgogICJMMkNBUCIgKDB4MDEwMCkKICAgIFBT
TTogMTcKICAiSElEUCIgKDB4MDAxMSkKTGFuZ3VhZ2UgQmFzZSBBdHRyIExp
c3Q6CiAgY29kZV9JU082Mzk6IDB4NjU2ZQogIGVuY29kaW5nOiAgICAweDZh
CiAgYmFzZV9vZmZzZXQ6IDB4MTAwClByb2ZpbGUgRGVzY3JpcHRvciBMaXN0
OgogICJIdW1hbiBJbnRlcmZhY2UgRGV2aWNlIiAoMHgxMTI0KQogICAgVmVy
c2lvbjogMHgwMTAwCgpTZXJ2aWNlIE5hbWU6IApTZXJ2aWNlIFJlY0hhbmRs
ZTogMHgxMDAwZgpTZXJ2aWNlIENsYXNzIElEIExpc3Q6CiAgVVVJRCAxMjg6
IDhlNzcxMzAxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpQcm90b2Nv
bCBEZXNjcmlwdG9yIExpc3Q6CiAgIkwyQ0FQIiAoMHgwMTAwKQogICAgUFNN
OiA2MTY4OQogICIiICgweDhlNzcwMzAwKQpQcm9maWxlIERlc2NyaXB0b3Ig
TGlzdDoKClNlcnZpY2UgTmFtZTogT0JFWCBQaG9uZWJvb2sgU2VydmVyClNl
cnZpY2UgUmVjSGFuZGxlOiAweDEwMDEwClNlcnZpY2UgQ2xhc3MgSUQgTGlz
dDoKICAiUGhvbmVib29rIEFjY2VzcyAtIFBTRSIgKDB4MTEyZikKUHJvdG9j
b2wgRGVzY3JpcHRvciBMaXN0OgogICJMMkNBUCIgKDB4MDEwMCkKICAiUkZD
T01NIiAoMHgwMDAzKQogICAgQ2hhbm5lbDogOQogICJPQkVYIiAoMHgwMDA4
KQpQcm9maWxlIERlc2NyaXB0b3IgTGlzdDoKICAiUGhvbmVib29rIEFjY2Vz
cyAtIFBTRSIgKDB4MTEyZikKICAgIFZlcnNpb246IDB4MDEwMAoK

--0-23190225-1219056710=:32389
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--0-23190225-1219056710=:32389
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--0-23190225-1219056710=:32389--
