Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c52bcaf0711301015w4eb90a5cr9c3b545bf1dbc6f6@mail.gmail.com>
Date: Fri, 30 Nov 2007 10:15:07 -0800
From: "Adam Bliss" <abliss@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Bug: a2dpd cannot use avrcp unless run as root [
	bluetooth-alsa-Bugs-1841837 ]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I just filed this bug on the SF issue tracker, but in accordance with
http://bluetooth-alsa.sourceforge.net/contact.html I'm shooting off
this email in the hopes of catching the right person's attention.

I will go ahead and try out the new audio in bluez-utils-3.16, but it
would be great if this could be fixed in plugz too.

Thanks,
--Adam

---------- Forwarded message ----------
I just checked out and rebuilt the latest a2dpd.  If I run it as root,
it works perfectly.  If I run as a user, I get these errors:

> a2dpd -o --debug

...

A2DPD[08:30:24.064]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot bind socket 6 for psm 25
A2DPD[08:30:24.064]: main_loop: *** Cannot get AVDTP socket, incoming
AVDTP connections are impossible ***

...

A2DPD[08:30:24.075]: main_loop: Bluetooth Device Settings [44100 hz, 2
channels, 16 bits]
A2DPD[08:30:24.081]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot bind socket 8 for psm 23
A2DPD[08:30:24.081]: avrcp_new: Listening for AVRCP on socket -1


And then a2dp works, but avrcp does not (I'm using a BlueAnt X5 Stereo headset).


----------------------------------------------------------------------

You can respond by visiting:
https://sourceforge.net/tracker/?func=detail&atid=678258&aid=1841837&group_id=116589

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
