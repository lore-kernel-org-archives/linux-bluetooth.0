Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <312616200.24329@bjut.edu.cn>
From: "Jin Pu" <jpu@emails.bjpu.edu.cn>
To: "bluez-users@lists.sourceforge.ne" <bluez-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Subject: [Bluez-users] bluetooth clock and security manager
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 4 Apr 2005 20:20:53 +0800

  Hi,
  I want to read local bluetooth clock with hcitool. But when I=
 use the command "hcitool clock XX:XX:XX:XX:XX:XX=A3=A8local=
 bd_addr)",the return message is "not connected",and I am sure=
 that I have created one ACL link.
  So, I use "hcitool clock  XX:XX:XX:XX:XX:XX=A3=A8remote=
 bd_addr)",the reture message is "read failed,Input/output=
 error",but the command "hcitool clkoff" works good.
  Now,I have to read the local device clock or the remote=
 clock,what shall I do?
  There is another question about security mananger within=
 BlueZ.
  I have paired my pda with BlueZ successfully,but I want to make=
 it clearly that how to add authenticated device into the=
 security manager in programming ,and where do these=
 authenticated device go?
  Thanks.  

=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D6=C2
=C0=F1=A3=A1
 =09=09=09=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1Jin Pu
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1jpu@emails.bjpu.edu.cn
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12005-04-04




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
