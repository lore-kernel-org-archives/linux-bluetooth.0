Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <37f261b0601090736w6d7157d6x6ea876ecafb3572e@mail.gmail.com>
From: Hugo van der Merwe <hugovdm@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_25621_16309475.1136820978376"
Subject: [Bluez-users] Two "identical" laptops, same phone, one works, one doesn't
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
Date: Mon, 9 Jan 2006 17:36:18 +0200

------=_Part_25621_16309475.1136820978376
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This is driving me nuts. I have two Compaq nx6110 laptops here, I've got on=
e
working fine, the other isn't working. I try:

rfcomm connect 0 00:12:47:1E:90:AE 3

For the one it works great, the other I get

Can't connect RFCOMM socket: Connection refused

How can I debug this problem? Will a hcidump help? (Should I attach the two
"hcidump -V" outputs to an email?)

Confused and frustrated after a day of struggling,
Hugo van der Merwe

------=_Part_25621_16309475.1136820978376
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This is driving me nuts. I have two Compaq nx6110 laptops here, I've got on=
e working fine, the other isn't working. I try:<br>
<br>
rfcomm connect 0 00:12:47:1E:90:AE 3<br>
<br>
For the one it works great, the other I get<br>
<br>
Can't connect RFCOMM socket: Connection refused<br>
<br>
How can I debug this problem? Will a hcidump help? (Should I attach the two=
 &quot;hcidump -V&quot; outputs to an email?)<br>
<br>
Confused and frustrated after a day of struggling,<br>
Hugo van der Merwe<br>

------=_Part_25621_16309475.1136820978376--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
