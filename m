Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>
Date: Mon, 30 Apr 2007 14:34:58 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] finding the least busy hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1675308394=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1675308394==
Content-Type: multipart/alternative;
	boundary="----=_Part_39065_1600212.1177914898783"

------=_Part_39065_1600212.1177914898783
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm trying to write an OBEX application which will be deployed in an
environment with multiple attached Bluetooth USB dongles. Since each
bluetooth dongle can support only 7 ACL active connection simultaneously,
can anyone please suggest a method to efficiently perform load balancing on
all the available bluetooth dongles? Is there a function which I can use to
seek out the least busy/connected hci device? Thanks

Regards,
Ben

------=_Part_39065_1600212.1177914898783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I&#39;m trying to write an OBEX application which will be deployed in an environment with multiple attached Bluetooth USB dongles. Since each bluetooth dongle can support only 7 ACL active connection simultaneously, can anyone please suggest a method to efficiently perform load balancing on all the available bluetooth dongles? Is there a function which I can use to seek out the least busy/connected hci device? Thanks
</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div>

------=_Part_39065_1600212.1177914898783--


--===============1675308394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1675308394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1675308394==--
