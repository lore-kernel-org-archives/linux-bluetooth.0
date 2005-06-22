Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Andrew Jones" <andrewjones@acselection.co.uk>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw
Message-ID: <009901c57742$1ad746b0$3202010a@acselection.local>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
In-Reply-To: <1119452070.26772.174.camel@pegasus>
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
Date: Wed, 22 Jun 2005 16:50:24 +0100

Marcus,
The directories within firmware.agent are different for Debian based
OS's, as soon as I put the firmware in one of the listed dir's, reloaded
the module it works fine.
Thankyou for your help.
Andy

Andrew Jones
AC Selection 
01905 732 772
www.acselection.co.uk


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: 22 June 2005 15:55
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw


Hi Andy,

> Hotplug has always been installed, the firmware is in /lib/firmware 
> and I'm still getting the below error. I think it's looking at the 
> wrong directory for the firmware, are there any ways to debug what's 
> happening? If you have any other suggestions they would be really 
> appreciated.

since Ubuntu is Debian based there should no problem unless they changed
something in the hotplug package. Check if /etc/hotplug/firmware.agent
exists and in what directories it expects the firmware file. Also check
that your firmware file is really present and is not a zero size file.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


--------------------------------------------------------------------------------------------
This message contains confidential information and is intended only for the individual named.
If you are not the named addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately by e-mail if you have received this e-mail by mistake and
delete this e-mail from your system. E-Mail transmission cannot be guaranteed to be secure or
error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or 
incomplete, or contain viruses. The sender therefore does not accept liability for any errors
or omissions in the contents of this message, which arise as a result of e-mail transmission.
If verification is required please request a hard-copy version.
AC Selection Ltd. The Avenue, The Cross, Worcester, WR1 3QA. www.acselection.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
