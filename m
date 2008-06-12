Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
Date: Thu, 12 Jun 2008 12:09:07 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] implement hcitool cc call with dbus interface
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0520611855=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0520611855==
Content-Type: multipart/alternative;
	boundary="----=_Part_16168_4772615.1213265347115"

------=_Part_16168_4772615.1213265347115
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

hcitool cc --role=s <bdaddr>
establishes a low level ACL connection.

I have to do that in a self-written tool with error-handling etc.
How can this be done through the dbus-interface, I've actually found no
method in the interfaces listed here http://wiki.bluez.org/wiki

Thanks a lot!

-- 
Regards,
--Codefritz

------=_Part_16168_4772615.1213265347115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>hcitool cc --role=s &lt;bdaddr&gt; <br>establishes a low level ACL connection.<br><br>I have to do that in a self-written tool with error-handling etc.<br>How can this be done through the dbus-interface, I&#39;ve actually found no method in the interfaces listed here <a href="http://wiki.bluez.org/wiki">http://wiki.bluez.org/wiki</a><br>
<br>Thanks a lot!<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_16168_4772615.1213265347115--


--===============0520611855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0520611855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0520611855==--
