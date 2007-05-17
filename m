Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 17 May 2007 05:20:38 -0700 (PDT)
From: Bluezapper <enigma_enu@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1179402870.10069.126.camel@violet>
MIME-Version: 1.0
Message-ID: <579888.18236.qm@web43142.mail.sp1.yahoo.com>
Subject: Re: [Bluez-users] Packet type
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1439262806=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1439262806==
Content-Type: multipart/alternative; boundary="0-588310414-1179404438=:18236"
Content-Transfer-Encoding: 8bit

--0-588310414-1179404438=:18236
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,

 Final aim is to provide an estimate of the expected frame error rate (FER) per channel of a series of Bluetooth links using six different types of packets (DM1, DM3, DM5, DH1, DH3, DH5).

thanks,

Marco.


Marcel Holtmann <marcel@holtmann.org> wrote: Hi Marco,

> Thanks for the reply, but if I use a L2cap connection I cannot specify
> whether I want to use HCI_DM1 or HCI_DM3 packets in my program ??
> 
> final goal is to test each packet type using any connection ??

and what do you expect as result out of it. First of all HCI_DM1 is
always available and second let the link manager do its jobs and allows
it to use all available packets.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


       
---------------------------------
Pinpoint customers who are looking for what you sell. 
--0-588310414-1179404438=:18236
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,<br><br>&nbsp;Final aim is to provide an estimate of the expected frame error rate (FER) per channel of a series of Bluetooth links using six different types of packets (DM1, DM3, DM5, DH1, DH3, DH5).<br><br>thanks,<br><br>Marco.<br><br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Marco,<br><br>&gt; Thanks for the reply, but if I use a L2cap connection I cannot specify<br>&gt; whether I want to use HCI_DM1 or HCI_DM3 packets in my program ??<br>&gt; <br>&gt; final goal is to test each packet type using any connection ??<br><br>and what do you expect as result out of it. First of all HCI_DM1 is<br>always available and second let the link manager do its jobs and allows<br>it to use all available packets.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This
 SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
      <hr size=1><a href="http://us.rd.yahoo.com/evt=48250/*http://searchmarketing.yahoo.com/arp/sponsoredsearch_v9.php?o=US2226&cmp=Yahoo&ctv=AprNI&s=Y&s2=EM&b=50">Pinpoint customers </a>who are looking for what you sell. 


--0-588310414-1179404438=:18236--


--===============1439262806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1439262806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1439262806==--
