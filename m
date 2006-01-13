Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com
In-Reply-To: <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
	 <1137057244.3955.3.camel@localhost.localdomain>
	 <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
Content-Type: text/plain
Message-Id: <1137140826.3879.1.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: patch: problem with sco
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
Date: Fri, 13 Jan 2006 09:27:05 +0100

Hi Wolfgang,

> > send in the information from "hciconfig -a" for this device, because
> > this is a hardware bug and you can't be sure that you can have eight
> > outstanding SCO packets.

does anything changes if you load the hci_usb driver with reset=1 ?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
