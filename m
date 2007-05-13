Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50705121732gaf8fff3mf54146ca78f7bd99@mail.gmail.com>
Date: Sat, 12 May 2007 21:32:52 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] how to know whether a l2cap connection is unreliable
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1854791678=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1854791678==
Content-Type: multipart/alternative;
	boundary="----=_Part_149455_10711013.1179016372518"

------=_Part_149455_10711013.1179016372518
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

does anyone knows how to check whether a l2cap connection is reliable? I
would like to stream multimedia through BT and I am trying to open a
unreliable connection between two devices.

I am using this function (
http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi-l2cap-unreliable)
for changing the flush timeout. My attempt to check changes was to record
the output of hcidump (hcidump -V -a) when I call the same function setting
the timeout and leaving it untouched. Both outputs were identical.

Does anyone knows how can I check this, or even whether the function I am
using is correct??

Regards,

Loreno

------=_Part_149455_10711013.1179016372518
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list, <br><br>does anyone knows how to check whether a l2cap connection is reliable? I would like to stream multimedia through BT and I am trying to open a unreliable connection between two devices. <br><br>I am using this function (
<a href="http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi-l2cap-unreliable">http://people.csail.mit.edu/albert/bluez-intro/x556.html#bzi-l2cap-unreliable</a>) for changing the flush timeout. My attempt to check changes was to record the output of hcidump (hcidump -V -a) when I call the same function setting the timeout and leaving it untouched. Both outputs were identical.
<br><br>Does anyone knows how can I check this, or even whether the function I am using is correct??<br><br>Regards,<br><br>Loreno<br>

------=_Part_149455_10711013.1179016372518--


--===============1854791678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1854791678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1854791678==--
