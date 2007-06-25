Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706250914v6e5f67c1qea6165186c33c7d3@mail.gmail.com>
Date: Mon, 25 Jun 2007 10:14:14 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <467FD4DF.9090108@free.fr>
MIME-Version: 1.0
References: <467FD4DF.9090108@free.fr>
Subject: Re: [Bluez-devel] Kernel vs Userland AVDTP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1496648700=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1496648700==
Content-Type: multipart/alternative;
	boundary="----=_Part_2591_8744975.1182788054417"

------=_Part_2591_8744975.1182788054417
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fabien

What are the multiplexing issues? Something like two apps trying to use the
same remote device?

Having avdtp sockets offered by the os would enforce better separation
between the layers and it would change the landscape for
bluetooth.orgvalidation of the stack. It does feel sort of funny to
write code to
assemble packets in userspace... maybe once we have something other than
a2dp running on top of avdtp it will be even more compelling to change
things.

Brad

------=_Part_2591_8744975.1182788054417
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fabien<br><br>What are the multiplexing issues? Something like two apps trying to use the same remote device?<br><br>Having avdtp sockets offered by the os would enforce better separation between the layers and it would change the landscape for 
<a href="http://bluetooth.org">bluetooth.org</a> validation of the stack. It does feel sort of funny to write code to assemble packets in userspace... maybe once we have something other than a2dp running on top of avdtp it will be even more compelling to change things.
<br><br>Brad<br>

------=_Part_2591_8744975.1182788054417--


--===============1496648700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1496648700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1496648700==--
