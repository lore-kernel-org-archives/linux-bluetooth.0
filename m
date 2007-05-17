Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 17 May 2007 02:54:49 -0700 (PDT)
From: Bluezapper <enigma_enu@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1179244795.10069.28.camel@violet>
MIME-Version: 1.0
Message-ID: <274820.74622.qm@web43135.mail.sp1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1106138959=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1106138959==
Content-Type: multipart/alternative; boundary="0-797680705-1179395689=:74622"
Content-Transfer-Encoding: 8bit

--0-797680705-1179395689=:74622
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,

Thanks for the reply, but if I use a L2cap connection I cannot specify whether I want to use HCI_DM1 or HCI_DM3 packets in my program ??

final goal is to test each packet type using any connection ??


regards,

Marco.

Marcel Holtmann <marcel@holtmann.org> wrote: Hi Marco,

>  I wrote a program to create a bluetooth connection using
> hci_create_connection  and the devices get connected but how do I send
> and recieve packets using this connections. My aim is to test the
> communication link between the devices using different packet
> types(DM1,DM3,DM5...)
> 
> Can someone please give me a hint on how this can be done. I have been
> struggling a lot as I am new to Bluez and C programming.

don't do that. Use a L2CAP socket.

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
Looking for earth-friendly autos? 
 Browse Top Cars by "Green Rating" at Yahoo! Autos' Green Center.  
--0-797680705-1179395689=:74622
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,<br><br>Thanks for the reply, but if I use a L2cap connection I cannot specify whether I want to use HCI_DM1 or HCI_DM3 packets in my program ??<br><br>final goal is to test each packet type using any connection ??<br><br><br>regards,<br><br>Marco.<br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Marco,<br><br>&gt;  I wrote a program to create a bluetooth connection using<br>&gt; hci_create_connection  and the devices get connected but how do I send<br>&gt; and recieve packets using this connections. My aim is to test the<br>&gt; communication link between the devices using different packet<br>&gt; types(DM1,DM3,DM5...)<br>&gt; <br>&gt; Can someone please give me a hint on how this can be done. I have been<br>&gt; struggling a lot as I am new to Bluez and C programming.<br><br>don't do that. Use a L2CAP
 socket.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;


 <hr size=1>Looking for earth-friendly autos? <br> <a href="http://autos.yahoo.com/green_center/;_ylc=X3oDMTE4MGw4Z2hlBF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDZ3JlZW5jZW50ZXI-">Browse Top Cars by "Green Rating"</a> at Yahoo! Autos' Green Center.  
--0-797680705-1179395689=:74622--


--===============1106138959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1106138959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1106138959==--
