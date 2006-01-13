Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Problems with smart phones when using a
	"silent"kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <C70061B183DE09419568AB2060C52A9501750C74@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A9501750C74@arion.intra.local>
Content-Type: text/plain
Message-Id: <1137154398.3879.7.camel@localhost.localdomain>
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
Date: Fri, 13 Jan 2006 13:13:18 +0100

Hi Victor,

> Small update. I've tried to connect with rfcomm tool - the same
> behaviour. With the silent kernel it does not connect to Windows Mobile
> phones. The logs show attempts to connect to the phone with "normal"
> kernel (connection successful) and "silent" one (fails). PSM Not
> Supported is something that probably goes wrong...

these stupid Microsoft devices. Everytime they get a connection, they
connect back to the SDP server of that device and this fails. So it
seems to me that the SDP daemon is not running or have problems with the
console redirected to /dev/null. Check in the log files for errors from
sdpd. Or you might need to use strace to track it.

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
