Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.02.14.10.41.509677@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] btsco questions
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
Date: Sun, 02 Jan 2005 16:10:41 +0200

Hi all,

I am trying to play with btsco from CVS.
I have kernel 2.6.10 and bluez-libs-2.10, bluez-utils-2.10.
I don't have a headset device, so I am trying to connect it the other way
around, to a NOKIA 6310i phone with support for AudioGateway and Headset
profile.

btsco is connecting fine to the phone, the phone shows the headset icon
on the screen, so it senses a headset connection, then when the phone
rings, I can see a lot of SCO packets in hcidump, but arecord does not
record anything.
I tried to aplay some wav file, but it does not seem to work as I don't
see any SCO packets in hcidump when I try it.
I even tried to activate the loopback option in alsa mixer, in order to
send back the same echo, but still nothing.

Is btsco supposed to work in this scenario ?

Any thoughts ?

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
