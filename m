Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <26AF0D77A98E09478A577B2248F72338413FF2@sintefxch1-netapp.sintef.no>
From: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-devel] Inquiry result with rssi in bluez libs 2.7
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
Date: Tue, 11 May 2004 14:34:46 +0200


Hello,

I see that hci.h has

#define EVT_INQUIRY_RESULT_WITH_RSSI  0x02

The bluetooth 1.2 spec defines this event code as 0x22

Is this a typo, or is there a reason why it is set as 0x02 in hci.h?

Regards,
Dag K. W. Rognlien
M.Sc. Computer Engineering
SINTEF ICT
Communication Systems


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
