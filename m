Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.14.17.57.33.66150@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] btsco and headsets questions
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
Date: Fri, 14 Jan 2005 18:57:33 +0100

Hi,

I was playing with btsco and my bt headset, and I noticed that as long as
btsco is connected, the headset is active and there is SCO traffic even
if the alsa device is not used by anything.
This means that the headset has no chance to enter idle mode in order to
save power. 
Is this the intended behavior or is my setup flawed ?
Otherwise the headset is working ok.

Another question is how to set up my linux to automatically connect to the
headset when I press the button on it ?
I think of something like inetd for tcp/ip, which should listen for bt
connections and route them to the appropriate programs.
I need something to listen for my headset, and when I press the button on
it and it tries to connect to my computer (last paired device), then it
will launch btsco MAC-ADDR-OF-REQUESTER.
Is this possible without writing a new program ?

Thanks,
Paul





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
