Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN pboblems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1Cf95k-0000r1-SE@sc8-sf-mx1.sourceforge.net>
References: <E1Cf95k-0000r1-SE@sc8-sf-mx1.sourceforge.net>
Content-Type: text/plain
Message-Id: <1103293739.28046.102.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 17 Dec 2004 15:28:59 +0100

Hi,

>     I have several questions.
>     First ,a bluetooth device was expected to act as GN with the command "pand  --listen --role GN".But the GN could be connected by only two PANUs.The third PANU cannot conect to the GN any more. Why? And how to set the maximal user numbers of a GN?
>     Second ,I used some bluetooth devices to form a simple adhoc network based on BNEP protocol, which can be shown as the following figure:
>      PANU1--->GN<---PANU2

sounds like a chip limitation. Add --master on the GN to force the role
switch.

>     When GN was only conncted by PANU1,the data transmitting rate could reach about 50kbps.However ,when the GN is connected by both PANU1 and PANU2 ,the data rate reduced to about 8kbps.Why? What can I do to solve this problem?

The --master option should also help, because it will combine all three
devices into one piconet and thus the GN not longer have to follow more
than one hopping sequence.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
