Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <424B007F.3090200@tomtom.com>
From: Dimitry Andric <dimitry.andric@tomtom.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hidp kernel panic on 2.4.25 mh15
References: <20050329182351.GA18688@externe.net> <1112129994.9016.115.camel@pegasus> <20050330163950.GA15198@externe.net>
In-Reply-To: <20050330163950.GA15198@externe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 30 Mar 2005 21:39:43 +0200

Guylhem Aznar wrote:

>>This is a NULL pointer dereference, but I am not quite good in decoding
>>the trace backs of ARM.

Try enabling CONFIG_DEBUG_USER, CONFIG_DEBUG_KERNEL and
CONFIG_DEBUG_ERRORS in your kernel configuration file (you can find
these options under the Kernel Hacking menuconfig item), and then
reproducing the crash.  This should give a complete stack trace with
function names, making it a lot easier to see what goes wrong.


> # modprobe hidp
> Using /lib/modules/2.4.29-guylhem/kernel/drivers/input/input.o
> Using /lib/modules/2.4.29-guylhem/kernel/net/bluetooth/hidp/hidp.o

Why is the subject about 2.4.25, when this indicates 2.4.29?


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
