Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 17 Jun 2007 06:33:46 -0700 (PDT)
From: Robert Schmidt <itsmy_emale@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1182064855.30934.53.camel@aeonflux>
MIME-Version: 1.0
Message-ID: <14519.73400.qm@web38507.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] HCI socket listen
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1925859582=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1925859582==
Content-Type: multipart/alternative; boundary="0-1574045289-1182087226=:73400"
Content-Transfer-Encoding: 8bit

--0-1574045289-1182087226=:73400
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,

Thanks for the reply. I have two questions for you :

1) How do I send ACL data between two devices using HCI socket ?

2) I tried sending a stream of bits using SCO connection. The program is similar to scotest. Eventhough, sending and receiving works  but the data received looks completely corrupted and different from data sent.

received data is like 
eg : *******&#65533;

hcidump:
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> SCO data: handle 44 dlen 48
> HCI Event: Disconn Complete (0x05) plen 4

Is there some data conversions to be done before sending or receiving data?

Note: I know that the best way to transfer data between devices is using l2cap but these question are part of my experiment to test different connections. So,please bear with me.

best regards,

robert.




Marcel Holtmann <marcel@holtmann.org> wrote: Hi Robert,

> Can a HCI socket listen for connections like l2cap and rfcomm ?? In my
> case it throws followiing warning and does not listen:
> 
> GLib-WARNING **: giounix.c:400Error while getting flags for FD: Bad
> file descriptor (9)
> 
> In my program I do the following:
> 
> I Open and Bind the HCI socket (using hci_open_dev)and listen for
> connections.

the HCI socket is not working this way. Use L2CAP if you wanna receive
incoming connections and data.

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
Luggage? GPS? Comic books? 
Check out fitting  gifts for grads at Yahoo! Search.
--0-1574045289-1182087226=:73400
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,<br><br>Thanks for the reply. I have two questions for you :<br><br>1) How do I send ACL data between two devices using HCI socket ?<br><br>2) I tried sending a stream of bits using SCO connection. The program is similar to scotest. Eventhough, sending and receiving works&nbsp; but the data received looks completely corrupted and different from data sent.<br><br>received data is like <br>eg : *******&#65533;<br><br>hcidump:<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; SCO data: handle 44 dlen 48<br>&gt; HCI Event: Disconn Complete
 (0x05) plen 4<br><br>Is there some data conversions to be done before sending or receiving data?<br><br>Note: I know that the best way to transfer data between devices is using l2cap but these question are part of my experiment to test different connections. So,please bear with me.<br><br>best regards,<br><br>robert.<br><br><br><br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Robert,<br><br>&gt; Can a HCI socket listen for connections like l2cap and rfcomm ?? In my<br>&gt; case it throws followiing warning and does not listen:<br>&gt; <br>&gt; GLib-WARNING **: giounix.c:400Error while getting flags for FD: Bad<br>&gt; file descriptor (9)<br>&gt; <br>&gt; In my program I do the following:<br>&gt; <br>&gt; I Open and Bind the HCI socket (using hci_open_dev)and listen for<br>&gt; connections.<br><br>the HCI socket is not working this way.
 Use L2CAP if you wanna receive<br>incoming connections and data.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
      <hr size=1>Luggage? GPS? Comic books? <br>
Check out fitting <a href="http://us.rd.yahoo.com/evt=48249/*http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz"> gifts for grads</a> at Yahoo! Search.
--0-1574045289-1182087226=:73400--


--===============1925859582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1925859582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1925859582==--
