Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4657DD73.4030501@internode.on.net>
Date: Sat, 26 May 2007 17:10:43 +1000
From: Marcus Brown <marcusbrutus@internode.on.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------010207080100060307020302"
Subject: [Bluez-devel] ring_and_wait_for_button patch for headsetd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010207080100060307020302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Further to Brad's suggestion on #, I've had a go at
creating a patch for my mods to headsetd.

Please forgive the hackery, and the diff format, as I've
never played with C(*) on this level, or with diffs.
Hopefully somebody will find it of use.

The purpose of the patch is to add an extra ringing
state in the chain, and fork a ringer process. If the
headset button is pushed within the timeout (ringout)
then the connection state advances to the next level.

The idea being that I can have my headset (clip) in my
pocket, and use it for (spoken) alerts from my server.
When the server attempts to contact the headset, the
headset rings and will only send audio if the button is
pushed.

The timeout in ~/.asound needs to suit the maximum ring
time + connection delay ... I used 10000 (10 secs).

It does need cleaning up (in general), and has some
minor problems (button vs ring timing?), but works well
for me at the moment.

I wasn't able to figure out how to (properly) use dbus,
so I've used lock files in tmp. It would also be better
to use environment vars(?) to set things like ringout,
ring_enable, wait_for_button, etc ... but I guess that
will have to wait until I have need for it ;)

I'd like to be able to add vibrate support if possible,
but I'm not sure if the method I used to send RING is
also a good way to send +CVIB (or CVIB=1). Not sure if
it's my method or the headset at this stage, so advice
appreciated.


Marcus.

--------------010207080100060307020302
Content-Type: application/x-gzip;
 name="ring_and_wait_for_button.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ring_and_wait_for_button.patch.gz"

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
--------------010207080100060307020302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------010207080100060307020302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010207080100060307020302--
