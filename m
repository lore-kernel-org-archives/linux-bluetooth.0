Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <39417DF3286A66428FA558987839F44F152D99@SINTEFXCH01.sintef.no>
From: "Rognlien Dag Kristian" <Dag.K.Rognlien@sintef.no>
To: <Bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] tcsendbreak and flow control on hciattach (csr chip)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 8 Oct 2004 11:14:47 +0200


Hello,

If I enable both flow control and send break with hciattach:
hciattach -b ttyS1 csr 921600 flow

The unit fails to initialize. This does not happen if I disable flow
control, or send break.
The problem is also solved by setting a sleep of 0.5 seconds after the
tcsendbreak command in the hciattach.c code.

This is on an Intel XScale platform.

I use bluez libs and bluez utils 2.9 on a 2.4.21 kernel with the mh9
patch.

Any ideas for another solution than the usleep, or is this the best
solution?

Regards,
Dag K. W. Rognlien
Research Scientist
SINTEF ICT
Communication Systems


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
