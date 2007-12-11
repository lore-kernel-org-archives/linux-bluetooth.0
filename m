Return-Path: <cyrus@holtmann.org>
Message-ID: <951351190712101634r5de429c0u6a95fa2a727f20a3@mail.gmail.com>
Date: Tue, 11 Dec 2007 00:34:15 +0000
From: "Jason Zhan" <zhan.jason@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] how to create a stable l2cap
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0329380559=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============0329380559==
Content-Type: multipart/alternative;
	boundary="----=_Part_33362_22566810.1197333255549"

------=_Part_33362_22566810.1197333255549
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey, folks

I am afraid this is a very old topic, but when I read through the whole mail
list. I cannot find a suitable solution.

In my case, I intend to build only l2cap connection between PC and mobile
phone for testing purpose.

The part of code is as follows:

    // allocate a socket
    s = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

    // set the connection parameters (who to connect to)
    addr.l2_family = AF_BLUETOOTH;

    //set psm port and MAC of remote device
    psm = atoi(argv[2]);
    addr.l2_psm = htobs(psm);
    str2ba(argv[1], &addr.l2_bdaddr);

    // connect to server
    /* Set link mode */
    //struct linger l = { .l_onoff = 1, .l_linger = 20000 };
    //status = setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l));

     /* Set link manage mode */
    opt = L2CAP_LM_RELIABLE;
    status = setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt));

    if (status < 0)
      printf("Can't set L2CAP link mode\n)");

    status = connect(s, (struct sockaddr *)&addr, sizeof(addr));


Most of the source codes is followed l2test.c.  As usual, the connection can
be created, however after only few seconds, from hcidump, I can find a HCI
disconnect command is sent and the connection is automatically disconnected.

Some previous discussion mentioned:
"The kernel will create the needed ACL link for you and take fully care of
it."
"If you try to mess around with connection reference counting of the ACL the
kernel will always win and simply disconnect the link if it thinks it is no
longer needed."

It seems whatever I do, I cannot keep the l2cap connection stable, since the
kernel will disconnect the l2cap connection if it thinks it is not needed.

I am not familiar with the bluez kernel mechanism, so could anybody provide
me a clear solution to sort it out.

Thank you for all your help,
Jason

------=_Part_33362_22566810.1197333255549
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey, folks<br><br>I am afraid this is a very old topic, but when I read through the whole mail list. I cannot find a suitable solution.<br><br>In my case, I intend to build only l2cap connection between PC and mobile phone for testing purpose.
<br><br>The part of code is as follows:<br><br>&nbsp;&nbsp;&nbsp; // allocate a socket<br>&nbsp;&nbsp;&nbsp; s = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);<br><br>&nbsp;&nbsp;&nbsp; // set the connection parameters (who to connect to)<br>&nbsp;&nbsp;&nbsp; addr.l2_family
 = AF_BLUETOOTH;<br><br>&nbsp;&nbsp;&nbsp; //set psm port and MAC of remote device<br>&nbsp;&nbsp;&nbsp; psm = atoi(argv[2]);<br>&nbsp;&nbsp;&nbsp; addr.l2_psm = htobs(psm);<br>&nbsp;&nbsp;&nbsp; str2ba(argv[1], &amp;addr.l2_bdaddr);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; // connect to server<br>&nbsp;&nbsp;&nbsp; /* Set link mode */
<br>&nbsp;&nbsp;&nbsp; //struct linger l = { .l_onoff = 1, .l_linger = 20000 };<br>&nbsp;&nbsp;&nbsp; //status = setsockopt(s, SOL_SOCKET, SO_LINGER, &amp;l, sizeof(l)); <br><br>&nbsp;&nbsp;&nbsp;&nbsp; /* Set link manage mode */<br>&nbsp;&nbsp;&nbsp; opt = L2CAP_LM_RELIABLE;<br>&nbsp;&nbsp;&nbsp; status = setsockopt(s, SOL_L2CAP, L2CAP_LM, &amp;opt, sizeof(opt));
<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (status &lt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Can&#39;t set L2CAP link mode\n)&quot;);<br><br>&nbsp;&nbsp;&nbsp; status = connect(s, (struct sockaddr *)&amp;addr, sizeof(addr));<br><br><br>Most of the source codes is followed 
l2test.c.&nbsp; As usual, the connection can be created, however after only few seconds, from hcidump, I can find a HCI disconnect command is sent and the connection is automatically disconnected.<br><br>Some previous discussion mentioned:
<br>&quot;The kernel will create the needed ACL link for you and take fully care of it.&quot;<br>&quot;If you try to mess around with connection reference counting of the ACL the kernel will always win and simply disconnect the link if it thinks it is no longer needed.&quot;
<br><br>It seems whatever I do, I cannot keep the l2cap connection stable, since the kernel will disconnect the l2cap connection if it thinks it is not needed. <br><br>I am not familiar with the bluez kernel mechanism, so could anybody provide me a clear solution to sort it out.
<br><br>Thank you for all your help,<br>Jason<br><br><br>

------=_Part_33362_22566810.1197333255549--


--===============0329380559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0329380559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0329380559==--
