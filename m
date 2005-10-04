Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49A63@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49A63@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1128424578.5226.18.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 04 Oct 2005 13:16:18 +0200

Hi Robert,

please stop using HTML emails and especially don't use colors. The good
old plain ASCII is enough.

> I'm cross-compiling for an Arm processor using a Debian 2.6.10 kernel
> with bluez-utils/lib 2.21, and bluez-hcidump 2.25 w/ a brainbox usb
> adapter for rs-232 replacement (CSR chipset)
>  
> I'm having a problem communicating through the /dev/rfcomm0 device.  I
> thought that once the device was connected it would be have like a
> serial device and I could do this ...
>  
> cat /dev/rfcomm0 > myfile.dat
> echo AT > /dev/rfcomm0
>  
> Am I assuming correctly?  If not what am I missing?  Do I need to use
> the pppd or the dund to communicate?  Am I in the wrong mode (master
> vs slave).  
>  
> If this should work please look at my log files, I'm executing
> these commands ... 
>  
> hcid
> sdpd
> sdptool add SP
> rfcomm bind 0 XX:XX ...

I think you made a big mistake in understanding how Bluetooth and Linux
are working. Describe what kind of communication you try to achieve and
then we might be able to help you.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
