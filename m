Return-Path: <cyrus@holtmann.org>
Message-ID: <4837F637.9060904@wurmsdobler.org>
Date: Sat, 24 May 2008 12:04:23 +0100
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20844183.487421211530034467.JavaMail.coremail@bj163app76.163.com>
In-Reply-To: <20844183.487421211530034467.JavaMail.coremail@bj163app76.163.com>
Subject: Re: [Bluez-users] CSR bluecore initial problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1527784600=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1527784600==
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

a few months back I encountered a similar problem. hciattach did not 
(and still does not) always succeed, and bccmd seems to have a problem 
using the BlueCore serial protocol (bcsp), possibly a race condition. 
That's why I have to use:

      /usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow
      /usr/sbin/hciconfig hci0 up
      /usr/sbin/bccmd -t hci psload -r /usr/etc/bluetooth/apm6628BT-UART.psr
      killall hciattach
      /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow
      /usr/sbin/hciconfig hci0 up

Notice the bccmd -t hci, so you have to attach first using bcsp, then 
use bccmd with this hci in order to download the psr file (which will 
reset the BlueCore), then kill the hci and re-attach.

Hope this helps,
peter



--===============1527784600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1527784600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1527784600==--
