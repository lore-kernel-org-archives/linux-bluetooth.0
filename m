Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3eef79ed04100219111bcee37d@mail.gmail.com>
From: Sven Ehret <sven.ehret@gmail.com>
Reply-To: Sven Ehret <sven.ehret@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Gentoo compile error: `HANDSFREE_SVCLASS_ID' undeclared (first use in this function)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 3 Oct 2004 04:11:15 +0200

I am unable to compile any version of bluez-utils I could get my hand on.

Using Gentoo, compiling portage-versions 2.7, 2.10, 2.10-r1 and newest
version from sf.net breaks with:

     [some lines]
sdptool.c: In Funktion =BBadd_handsfree=AB:
sdptool.c:1130: error: `HANDSFREE_SVCLASS_ID' undeclared (first use in
this function)
sdptool.c:1130: error: (Each undeclared identifier is reported only once
sdptool.c:1130: error: for each function it appears in.)
sdptool.c:1136: error: `HANDSFREE_PROFILE_ID' undeclared (first use in
this function)
sdptool.c:1152: error: `SDP_SUPPORTED_FEATURES' undeclared (first use
in this function)
sdptool.c: In Funktion =BBadd_audio_source=AB:
sdptool.c:1583: error: `AUDIO_SOURCE_SVCLASS_ID' undeclared (first use
in this function)
sdptool.c:1587: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
use in this function)
sdptool.c:1598: error: `AVDTP_UUID' undeclared (first use in this function)
sdptool.c: In Funktion =BBadd_audio_sink=AB:
sdptool.c:1642: error: `AUDIO_SINK_SVCLASS_ID' undeclared (first use
in this function)
sdptool.c:1646: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
use in this function)
sdptool.c:1657: error: `AVDTP_UUID' undeclared (first use in this function)
     [and so on]

Can anybody shed some light?

--=20
Sven Ehret


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
