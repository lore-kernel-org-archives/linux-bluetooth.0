Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806111109u340a2274w341166829588b133@mail.gmail.com>
Date: Wed, 11 Jun 2008 20:09:35 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Difference hidp Version 1.1 vs. 1.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0494587110=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0494587110==
Content-Type: multipart/alternative;
	boundary="----=_Part_14633_23508583.1213207775484"

------=_Part_14633_23508583.1213207775484
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi folks,

taking a look at hidp.c I think one difference between the hid kernel module
hidp is that 1.2 also can use the generic USB hid input system.
In contrary v 1.1 only uses the traditional input system of linux
(input/input.c)

the difference is in hidp_process_data(), "if (session->hid)" is missing in
v1.1

Is this all right so far?
What are the other differences?

I'm wondering to port hidd and hidp to Kernel 2.4.21 (yes I have to since Im
using an embedded system with a very customized kernel), with version 1.1 it
shouldn't be too hard right? Since the traditional input system is used or
might there also be some other problems?

Thanks,

-- 
Regards,
--Codefritz

------=_Part_14633_23508583.1213207775484
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi folks,<br><br>taking a look at hidp.c I think one difference between the hid kernel module hidp is that 1.2 also can use the generic USB hid input system.<br>In contrary v 1.1 only uses the traditional input system of linux (input/input.c)<br>
<br>the difference is in hidp_process_data(), &quot;if (session-&gt;hid)&quot; is missing in v1.1<br><br>Is this all right so far?<br>What are the other differences?<br><br>I&#39;m wondering to port hidd and hidp to Kernel 2.4.21 (yes I have to since Im using an embedded system with a very customized kernel), with version 1.1 it shouldn&#39;t be too hard right? Since the traditional input system is used or might there also be some other problems?<br>
<br>Thanks,<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_14633_23508583.1213207775484--


--===============0494587110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0494587110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0494587110==--
