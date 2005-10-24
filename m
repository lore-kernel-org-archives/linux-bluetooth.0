Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <435D604A.2050606@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] fixed-point sbc decoder
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
Date: Mon, 24 Oct 2005 16:29:30 -0600

Victor,

I was working on the fixed point decoder. I also found and reorganized
the inner loop around another optimization... the code I've written
works when using floating point but something is not right in the fixed
point. Can you have a quick look?

What I do is

btsco$ make && ./sbc/sbcdec t1.sbc

I suspect I'm not be doing the 64 to 32 bit conversions right...

http://bluetooth-alsa.sf.net/fixed/fixed-decode.patch
http://bluetooth-alsa.sf.net/fixed/t1.sbc

The latter is just an audio file, but as a bonus it's a friend's band
(and probably too noisy to be a good test :)

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
