Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42D2B7FA.4000305@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] btsco and PCM routing
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
Date: Mon, 11 Jul 2005 12:18:34 -0600

Hey

We have depended on audio routing through HCI but if anyone is going to 
embed btsco, they will likely want to use PCM routing.

Right now your app will have to open an audio device that you know won't 
produce any audio and while it's open, the daemon would keep the SCO 
audio flowing through the PCM interface. It seems pretty gross. If the 
daemon could get open/close messages through some other means, it could 
do the right thing without the fake audio device or any kernel 
entanglements. Is that good enough? How should it get those messages?

Just to make sure HCI routing actually works ok on arm, I am trying to 
get my embedded setup to have an HCI-routed audio adapter. I'm a little 
stuck on the wiring stuff :(

See http://bluetooth-alsa.sourceforge.net/embed.html

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
