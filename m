Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <437E04A9.7030600@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] strange results in a2dp alsa plugin
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
Date: Fri, 18 Nov 2005 09:43:21 -0700

Marcel

I am getting some really strange stuff happening in my attempt to do an
a2dp alsa plugin. About 90% of the time, the l2cap connection fails...
but then if it does work, I get a segfault inside the sbc library. When
I put a printf inside the library to figure out what was happening, the
segfault went away (but still no audio)! argh.

Would you have a look? Can you make sure rfcomm transport didn't get broken?

I'm basing my effort on your bluez/utils/alsa in the bluez cvs. My diffs
against it are in:

 http://bluetooth-alsa.sourceforge.net/avdtp.patch

I have made it default to a2dp but the rfcomm transport should work if
you have "use_rfcomm" as a true boolean option inside .asoundrc

My .asoundrc:

pcm.headphone {
        type a2dp
        bdaddr "00:0D:3C:30:32:AD"
}

invoked as:

aplay -B 1000000 -D pcm.headphone /usr/share/sounds/linphone/rings/rock.wav

(fwiw, /usr/share/sounds/linphone/rings/rock.wav is reported as signed
16 bit Little Endian, Rate 44100 Hz, Stereo)

Thanks


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
