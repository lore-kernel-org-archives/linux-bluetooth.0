Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 23 Apr 2007 09:49:30 -0700 (PDT)
From: Bluezapper <enigma_enu@yahoo.com>
To: Bluez Users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <419284.19431.qm@web43138.mail.sp1.yahoo.com>
Subject: [Bluez-users] Bluez source code doubt
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2014446660=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2014446660==
Content-Type: multipart/alternative; boundary="0-321732730-1177346970=:19431"
Content-Transfer-Encoding: 8bit

--0-321732730-1177346970=:19431
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I am sorry if this question is silly. I am new to Bluez and C socket programming. I was going through the bluez source code but did not understand the following statements from hcitool.c:

if (hci_read_remote_version(dd, handle, &version, 20000) == 0)

if (hci_read_remote_name(dd, &bdaddr, sizeof(name), name, 25000)== 0)


What are the numbers "25000" or "20000" in these statements and I see that they are different for different statments sometimes compared to less than zero or equal to zero ??


thanks in advance for your replies,

Marco.

       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-321732730-1177346970=:19431
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I am sorry if this question is silly. I am new to Bluez and C socket programming. I was going through the bluez source code but did not understand the following statements from hcitool.c:<br><br>if (hci_read_remote_version(dd, handle, &amp;version, 20000) == 0)<br><br>if (hci_read_remote_name(dd, &amp;bdaddr, sizeof(name), name, 25000)== 0)<br><br><br>What are the numbers "25000" or "20000" in these statements and I see that they are different for different statments sometimes compared to less than zero or equal to zero ??<br><br><br>thanks in advance for your replies,<br><br>Marco.<br><p>&#32;



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-321732730-1177346970=:19431--


--===============2014446660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2014446660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2014446660==--
