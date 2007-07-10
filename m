Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60707101202x7d6b8e99x161ab3cab64af9e7@mail.gmail.com>
Date: Tue, 10 Jul 2007 12:02:58 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] hcidump question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0880325830=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0880325830==
Content-Type: multipart/alternative;
	boundary="----=_Part_154246_10411738.1184094178019"

------=_Part_154246_10411738.1184094178019
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

When I tried to issue hcidump as a non-root user, I get permission denied.
Short from doing a setuid on hcidump,
I traced the code that found this line to be denying non-root user in
executing the binary:

     ioctl(dd, HCISETRAW, opt);

What is HCISETRAW?  And is root the only user that can fire off hcidump?

Thanks

Mark

------=_Part_154246_10411738.1184094178019
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:<br><br>When I tried to issue hcidump as a non-root user, I get permission denied.&nbsp; Short from doing a setuid on hcidump,<br>I traced the code that found this line to be denying non-root user in executing the binary:<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp; ioctl(dd, HCISETRAW, opt);<br><br>What is HCISETRAW?&nbsp; And is root the only user that can fire off hcidump?<br><br>Thanks<br><br>Mark<br>

------=_Part_154246_10411738.1184094178019--


--===============0880325830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0880325830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0880325830==--
