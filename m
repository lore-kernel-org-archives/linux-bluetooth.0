Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c0509200605212255a9@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_46733_1906634.1127221529953"
Subject: [Bluez-devel] How inquiry to a custo IAC code ?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Sep 2005 15:05:29 +0200

------=_Part_46733_1906634.1127221529953
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
i ve set a bluetooth dongle to a custom iac code via:
"hciconfig hci0 iac 0x9e8b17"
,and correctly it is not detected anymore by standard inquiry.

My question is: how can i ask another dongle to inquiry to that iac ?
I ve tried setting this dongle with the same "hciconfig hci0 iac 0x9e8b17"
but it still inquiries to the standard IAC.

can someone help me ?

thanks a lot

------=_Part_46733_1906634.1127221529953
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br>
i ve set a bluetooth dongle to a custom iac code via:<br>
&quot;hciconfig hci0 iac 0x9e8b17&quot;<br>
,and correctly it is not detected anymore by standard inquiry.<br>
<br>
My question is: how can i ask another dongle to inquiry to that iac ?<br>
I ve tried setting this dongle with the same &quot;hciconfig hci0 iac 0x9e8=
b17&quot;<br>
but it still inquiries to the standard IAC.<br>
<br>
can someone help me ?<br>
<br>
thanks a lot<br>

------=_Part_46733_1906634.1127221529953--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
