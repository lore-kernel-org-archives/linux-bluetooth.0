Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Tony Lindgren <tony@atomide.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040623031119.GA20367@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] AmbiCom BT2000C works with hciattach
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
Date: Tue, 22 Jun 2004 20:11:20 -0700

Hi all,

Just FYI, there was some discussion here a while back on the 
AmbiCom BT2000C, which is different from the earlier BT2000 
models.

Well turns out it works fine with serial_cs + hciattach:

hciattach /dev/ttyS1 csr -s 57600 57600
or
hciattach /dev/ttyS1 csr -s 57600 460800
hciconfig hci0 up
hcitool scan
...

Sorry if this was already old news :) Please CC me on any 
replies, I'm not subscribing.

Regards,

Tony



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
