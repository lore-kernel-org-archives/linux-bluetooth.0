Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C82FB9.1030602@south-wing.com>
From: Southwing - Miquel Puchol <miquel.puchol@south-wing.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple headsets with one dongle
References: <43C66070.5010601@labri.fr> <43C80EBC.8040503@xmission.com>
In-Reply-To: <43C80EBC.8040503@xmission.com>
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
Date: Fri, 13 Jan 2006 23:54:49 +0100

Hi Brad,

Thanks for your reply!

 >> The rfcomm channel communication is not where interference
 >> happens. It's when both headsets try to build the sco
 >> connection at the same time.

OK, that gives me some point where to start looking.

 >> I'm not totally sure how to do this anyway. Marcel has hinted
 >> at it and apparently there's a boot-time parameter to set
 >> something to allow two sco connections. I tried to capture
 >> everything in the btsco bug for multiple headsets, but this
 >> is all I come up with there:

This would be boot-time for the dongle's boot, or the actual machine's boot?

 >> Marcel adds: "To get more than one SCO channel working the
 >> hci_usb driver must be fixed to dynamicaly change the
 >> alternate settting."

Also, fixed as in repaired, or as in set to something permanent? I'll 
take a look at the archives and bug log.

Best regards,

Mike




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
