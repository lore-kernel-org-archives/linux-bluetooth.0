Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.14.17.46.40.72959@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] btsco and Jabra BT 110 experience
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
Date: Fri, 14 Jan 2005 18:46:42 +0100

Hi,

I just bought a Jabra BT 110 headset device, and I wanted to play with
btsco. 
The product link is:
http://www.jabra.com/JabraCMS/NA/EN/MainMenu/Products/WirelessHeadsets/JabraBT110/JabraBT110.htm

What I liked about this product was 15 hours talk time, and working with
1xAAA battery.
Unfortunately to achieve 15 hours talk time they do some tricks like using
low power radio (so the signal quality is not so good) and what is more
important, the device does not have idle time mode, instead it just
disconnects from the phone/computer if there is no active call.
And it also supports only one pairing device. 
To pair with another device you have to take out the battery and insert it
again.
It supports handsfree and headset profile.

So, here is some feedback about using btsco with this headset:
To connect btsco to the device, i have to press the talk/answer button on
the headset, and fire btsco on channel 2 which is headset profile, because
it seems that by default it connects to channel 1 which is handsfree
profile and does not work too reliably (sometime it just disconnects).
After connecting with btsco, the link is active and I can use it without
problems.
Also, I think that the volume for mic and speaker cannot be modified from
alsa, but only from the headset's button and only for speaker.

I think you can include this as working device on the btsco page.

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
