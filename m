Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0808190422s310551c1w6d25608076d2d9c1@mail.gmail.com>
Date: Tue, 19 Aug 2008 13:22:15 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Cross-Compiling issue - missing define
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1391545609=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1391545609==
Content-Type: multipart/alternative;
	boundary="----=_Part_38024_13622565.1219144935422"

------=_Part_38024_13622565.1219144935422
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Cross compiling latest lib-utils (3.36) I had following problems:
the compiler options :
-funswitch-loops -fgcse-after-reload
had to be removed from makefile since my gcc arm cross compiler (gcc 3.3.3)
doenst support it.

And:
ENOKEY, used in sbc/storage.c and sbc/input.c is undeclared
#define ENOKEY EACCES
helped.

Anyway with this work out i was able to compile the utils.



-- 
Regards,
--Codefritz

------=_Part_38024_13622565.1219144935422
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Cross compiling latest lib-utils (3.36) I had following problems:<br>the compiler options :<br>-funswitch-loops -fgcse-after-reload<br>had to be removed from makefile since my gcc arm cross compiler (gcc 3.3.3) doenst support it.<br>
<br>And:<br>ENOKEY, used in sbc/storage.c and sbc/input.c is undeclared <br>#define ENOKEY EACCES<br>helped.<br><br>Anyway with this work out i was able to compile the utils.<br><br><br clear="all"><br>-- <br>Regards,<br>
--Codefritz<br><br><br><br><br>
</div>

------=_Part_38024_13622565.1219144935422--


--===============1391545609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1391545609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1391545609==--
