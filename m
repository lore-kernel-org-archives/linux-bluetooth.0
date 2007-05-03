Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60705031450u6c22eebfj50ffe8d91d8b6f88@mail.gmail.com>
Date: Thu, 3 May 2007 14:50:45 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] hciconfig delkey question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1681205585=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1681205585==
Content-Type: multipart/alternative;
	boundary="----=_Part_35746_7503305.1178229045928"

------=_Part_35746_7503305.1178229045928
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

I am trying to delete a linkkey by way of 'hciconfig delkey <btaddr>' where
<btaddr> is the bluetooth address linkkey that I want to remove.  I can see
that there is a directory under /var/lib/bluetooth in the same name as
<btaddr>.   I execute the command and hciconfig returns the same lines as if
I run it with no argument (returning info about my only hci interface,
hci0).  And I can still see <btaddr> directory under /var/lib/bluetooth.

Am I missing something about how this command should behave?  I was
expecting that after the command, the directory under
/var/lib/bluetooth/<btaddr> would be removed.

Thanks for any tip/pointer.


Mark

------=_Part_35746_7503305.1178229045928
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:<br><br>I am trying to delete a linkkey by way of &#39;hciconfig delkey &lt;btaddr&gt;&#39; where &lt;btaddr&gt; is the bluetooth address linkkey that I want to remove.&nbsp; I can see that there is a directory under /var/lib/bluetooth in the same name as &lt;btaddr&gt;.&nbsp;&nbsp; I execute the command and hciconfig returns the same lines as if I run it with no argument (returning info about my only hci interface, hci0).&nbsp; And I can still see &lt;btaddr&gt; directory under /var/lib/bluetooth.
<br><br>Am I missing something about how this command should behave?&nbsp; I was expecting that after the command, the directory under /var/lib/bluetooth/&lt;btaddr&gt; would be removed.<br><br>Thanks for any tip/pointer.<br><br>
<br>Mark<br>

------=_Part_35746_7503305.1178229045928--


--===============1681205585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1681205585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1681205585==--
