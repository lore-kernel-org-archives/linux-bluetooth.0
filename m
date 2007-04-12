Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <1176368621.4287.1184217917@webmail.messagingengine.com>
From: "Kenneth Liew Jau Tze" <kenliew@kenliew.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Thu, 12 Apr 2007 17:03:41 +0800
Subject: Re: [Bluez-users] using class 1 dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

  Just curious, in this case, the class 2 BT cannot transmit 
power to class 1 BT as the distance is way out of range, but
can class 1 BT transmit files to class 2 BT?  since to class
1 BT the class 2 phone is in range?

--ken

Message: 2
Date: Wed, 11 Apr 2007 08:47:53 +1200
From: Thomas Kear <thomas.kear@gmail.com>
Subject: Re: [Bluez-users] using class 1 dongle
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <200704110847.58296.thomas.kear@gmail.com>
Content-Type: text/plain; charset="iso-8859-15"

On Wed, 11 Apr 2007, siddhant tewari wrote:
>                  Really great to get a answer ... i think my mobile phone
> has class 2 bt adapter ... but this issue is a real shock for me ... i
> thought if any of the devices has a good range , communication channel will
> be established and data transfer will take place , but all this theory goes
> in vain .
The problem is as simple as transmit power.  As wikipedia helpfully
shows 
(http://en.wikipedia.org/wiki/Bluetooth#Uses), class 1 devices can have
40 
times the transmit power of class 2 devices, the class 1 connecting to
class 
2 problem comes down to that past a certain range, the class 2 device
does 
not have a high enough transmit power for its signal to reach the
reciever 
(2.4GHz signals are eaten particularly fast by everything in their path, 
including air).

As i outlined before, the higher transmit power in a class 1 device will
come 
coupled to a higher sensitivity reciever, but that's not going to get
you 
100m.  If you had got the 30-40 metres you were attempting in your
original 
email you would have been extremely lucky.

The problem is there are very few phones that come with class 1
bluetooth, 
100mW transmit power is a little hard on battery life.  If you want a 
challenge though, find a class1 bluetooth adapter that has a dipole
aerial 
rather than the usual circuit board trace and attach a bigger one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available

------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
