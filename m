Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <396736060508031219119970cf@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] broadcom SCO questions
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
Date: Wed, 3 Aug 2005 15:19:57 -0400

This is mainly directed at Marcel...

As the proud owner of a new Broadcom-based
dongle, I'd really like to get it working with btsco.

Brad had mentioned that only CSR chipsets are
supported for SCO right now.  I'm interested
in taking up the charge and would like to know
what has been tried already so I don't repeat=20
it.

Is the thinking that the broadcom chip needs some special
commands to enable SCO?  Has broadcom been
contacted and refused to provide details?  Has
reverse engineering of the Windows USB traffic
been attempted?

I looked at the Bluetooth H:2 spec for USB=20
and it seemed pretty light on details.  I also
looked at the broadcom-specific bluez driver code
and it seemed to be for uploading firmware and
causing the dongle to reattach as a standard H:2
device.

I've recently "rediscovered" my WinXP partition
on my laptop, so I may try to test the Windows
driver that came with my dongle and see if I can
get the headset working.

Thanks for any info.

-Rob
--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
