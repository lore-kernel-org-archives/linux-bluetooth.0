Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510706200347t561a21cbo67e5d47a98660fe@mail.gmail.com>
Date: Wed, 20 Jun 2007 18:47:11 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: bluez-devel@lists.sf.net
MIME-Version: 1.0
Subject: [Bluez-devel] authentication inconsistency for sony ericsson p990i
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1370143961=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1370143961==
Content-Type: multipart/alternative;
	boundary="----=_Part_122207_30623018.1182336431787"

------=_Part_122207_30623018.1182336431787
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'd developed an OBEX server application using OpenOBEX and Bluez. My
application can perform single file transfer successfully to quite a number
of different phones without requesting for passkey. But recently I'd
discovered that whenever I try to transfer content to a Sony Ericsson p990i,
the phone would automatically request for a passkey. At first I'd assumed
that the phone's security feature was the cause of the problem (like how
Windows Mobile phone has an option to turn on/off the passkey feature for
OBEX file transfer), but I discovered later from the phone's manual that by
default passkey is not required for single file transfer and this option
cannot be tweaked.

Later, I used another proprietary OBEX application to send content to the
same p990i phone, and it can work without requesting for a passkey. I'd
tested my application with numerous different Sony Ericsson, Asus, HP,
Motorola and Nokia phones without this problem. Can anyone please suggest
what's wrong with either the phone or my OBEX application? Thanks

Regards,
Ben

------=_Part_122207_30623018.1182336431787
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I&#39;d developed an OBEX server application&nbsp;using OpenOBEX and Bluez. My application can perform single file transfer successfully to quite a number of different phones without requesting for passkey. But recently I&#39;d discovered that whenever I try to transfer content to a Sony Ericsson p990i, the phone would automatically request for a passkey. At first I&#39;d assumed that the phone&#39;s security feature was the cause of the problem (like how Windows Mobile phone has an option to turn on/off the passkey&nbsp;feature&nbsp;for OBEX file transfer), but I discovered later from the phone&#39;s manual that by default passkey is not required for single file transfer and this option cannot be tweaked.
</div>
<div>&nbsp;</div>
<div>Later, I used another proprietary OBEX application to send content to the same p990i phone, and it can work without requesting for a passkey. I&#39;d tested my application with numerous different Sony Ericsson, Asus, HP, Motorola and Nokia phones without this problem. Can anyone please suggest what&#39;s wrong with either the phone or my OBEX application? Thanks
</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div>

------=_Part_122207_30623018.1182336431787--


--===============1370143961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1370143961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1370143961==--
