Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Przemek <aquamala@o2.pl>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20040506204859.GA2483@reynevan>
Reply-To: aquamala@o2.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Subject: [Bluez-users] l2test: Send failed. Invalid argument(22)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 6 May 2004 22:48:59 +0200

Hi!

I'm trying to test (almost) my implementation of L2CAP.
This is what i do:

$ ./l2test -s -N 20 -S 00:0A:3A:53:12:4A 00:80:37:16:30:8B

Unfortunetly, I get:

l2test[2445]: Connected [imtu 672, omtu 512, flush_to 65535]
l2test[2445]: Sending ...
l2test[2445]: Send failed. Invalid argument(22)

No data is send. Just after L2CAP connection is established my 
module is receiving Disconnection Request packet.

Please, tell me, what does that "Invalid argument(22)" mean.

Best regards, 
Przemek 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
