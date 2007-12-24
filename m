Return-Path: <cyrus@holtmann.org>
Message-ID: <951351190712240702x7b84c38j135735888bbd40d0@mail.gmail.com>
Date: Mon, 24 Dec 2007 15:02:58 +0000
From: "Jason Zhan" <zhan.jason@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] passkey-agent
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0255586828=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0255586828==
Content-Type: multipart/alternative;
	boundary="----=_Part_7906_7955281.1198508578802"

------=_Part_7906_7955281.1198508578802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, folks

This is maybe the final question for this year.

Currently, I am implementing a passkey-agent for my own application. The
principle is similar with the /daemon/passkey-agent.c. However, when I run
it, the system gives me some errors: "Can't regiter passeky agent, passkey
agnet already exists".

I am pretty sure this is not the problem of my program, since I run the
default passkey-agent daemon(/usr/bin/passkey-agent), it will jump out the
same errors.

Can anybody help me to sort it out? I think the solution should be quite
simple, set some configurations or block some functions in hcid daemon. But
I have no idea on how to achieve it.

I really would like to sort it out in 2007.

Merry Christmas and Happy new year.

Regards,
Jason

------=_Part_7906_7955281.1198508578802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, folks<br><br>This is maybe the final question for this year. <br><br>Currently, I am implementing a passkey-agent for my own application. The principle is similar with the /daemon/passkey-agent.c. However, when I run it, the system gives me some errors: &quot;Can&#39;t regiter passeky agent, passkey agnet already exists&quot;.
<br><br>I am pretty sure this is not the problem of my program, since I run the default passkey-agent daemon(/usr/bin/passkey-agent), it will jump out the same errors. <br><br>Can anybody help me to sort it out? I think the solution should be quite simple, set some configurations or block some functions in hcid daemon. But I have no idea on how to achieve it. 
<br><br>I really would like to sort it out in 2007.<br><br>Merry Christmas and Happy new year.<br><br>Regards,<br>Jason<br><br><br><br>

------=_Part_7906_7955281.1198508578802--


--===============0255586828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0255586828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0255586828==--
