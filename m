Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60705081715y19411c8fkc30d34c819acf1fd@mail.gmail.com>
Date: Tue, 8 May 2007 17:15:40 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] DBus API: HasBonding() error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0121783407=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0121783407==
Content-Type: multipart/alternative;
	boundary="----=_Part_55864_1514693.1178669740178"

------=_Part_55864_1514693.1178669740178
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

I am trying to make use of the Bluez-DBUS function HasBonding to see if a
linkkey has been issued for the given Bluetooth address.  When I call that
method, I got back a reply saying:

   The name org.bluez was not provided by any .service files

I checked and I see proper config files under /etc/dbus-1/system.d.
I do not, however, have any .service files under /etc/bluetooth.  Is that
the problem?  If so, where can I find some examples of .service files,
particuarly one that can provide org.bluez?
Or am I not interpreting that error message right?

thanks

Mark

------=_Part_55864_1514693.1178669740178
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi:<br><br>I am trying to make use of the Bluez-DBUS function HasBonding to see if a linkkey has been issued for the given Bluetooth address.&nbsp; When I call that method, I got back a reply saying:<br><br>&nbsp;&nbsp; The name org.bluez
 was not provided by any .service files<br><br>I checked and I see proper config files under /etc/dbus-1/system.d.
<br>I do not, however, have any .service files under /etc/bluetooth.&nbsp;
Is that the problem?&nbsp; If so, where can I find some examples of .service
files, particuarly one that can provide org.bluez?<br>Or am I not interpreting that error message right?<br><br>thanks<span class="sg"><span><br><br>Mark<br><br></span></span>

------=_Part_55864_1514693.1178669740178--


--===============0121783407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0121783407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0121783407==--
