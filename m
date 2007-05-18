Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60705181036h32b7ed31ge7009a3ccc0a22a4@mail.gmail.com>
Date: Fri, 18 May 2007 10:36:53 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] hcid cannot connect to dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1740576249=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1740576249==
Content-Type: multipart/alternative;
	boundary="----=_Part_65163_8860082.1179509813099"

------=_Part_65163_8860082.1179509813099
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

 When I fire up my hcid, I got this error message:

     Can't connect to system message bus: Failed to connect to socket
/var/run/dbus/system_bus_socket: Connection refused

My DBUS is running and there is /var/run/dbus/system_bus_socket.  I have a
generic server/client and talks via the system bus and they work just fine.
My DBUS config also loads the system.d/bluetooth.conf as well.

Is there a reason why hcid would print out the "Connection refused" message?

Mark

------=_Part_65163_8860082.1179509813099
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi<br><br>&nbsp;When I fire up my hcid, I got this error message:<br><br>&nbsp; &nbsp;&nbsp; Can&#39;t connect to system message bus: Failed to connect to socket /var/run/dbus/system_bus_socket: Connection refused<br><br>My DBUS is running and there is /var/run/dbus/system_bus_socket.&nbsp; I have a generic server/client and talks via the system bus and they work just fine.
<br>My DBUS config also loads the system.d/bluetooth.conf as well.&nbsp; <br><br>Is there a reason why hcid would print out the &quot;Connection refused&quot; message?<br><br>Mark<br><br><br>

------=_Part_65163_8860082.1179509813099--


--===============1740576249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1740576249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1740576249==--
