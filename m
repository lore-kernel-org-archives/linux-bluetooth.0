Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach patch: make the device string longer
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <439060DA.4000401@anymore.nl>
References: <439060DA.4000401@anymore.nl>
Content-Type: text/plain
Message-Id: <1133535797.20834.78.camel@blade>
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
Date: Fri, 02 Dec 2005 16:03:17 +0100

Hi Arjan,

> For our port on the HP Ipaq 1940, we want to use Bluez as the bluetooth 
> library.
> Our work is mostly based at handhelds.org, we want to have the Familiar 
> distribution on our devices too.
> We were having some problems with hciattach not working as it should, 
> and finally pinpointed it on one specific line.
> At the top of main() in hciattach.c, the device node is put in a 
> variable 'dev', which is only 20 bytes long. The problem is that our 
> device is (with null-termination character) exactly 21 bytes long.
> So that's why I propose the patch at the bottom of this mail, it's 
> actually a 1-character patch.
> Excuse me if I break into existing conversations, or this has already 
> been fixed in CVS. (I only checked the latest release)
> Thanks in advance for your comments!

I don't get why a device node name is longer than 20 characters, but I
fixed it in the CVS. However I preferred to use PATH_MAX instead of only
30 bytes.

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
