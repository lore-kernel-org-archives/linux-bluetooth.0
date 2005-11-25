Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidd says: Can't open HIDP control socket: No
	such file or directory
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4387654D.7080800@ketil.froyn.name>
References: <4387654D.7080800@ketil.froyn.name>
Content-Type: text/plain
Message-Id: <1132944130.5577.30.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 25 Nov 2005 19:42:10 +0100

Hi Ketil,

> I am running a Debian 3.1 system with bluez-utils 2.15-1.1 and kernel 
> 2.4.27-2-686. I have a billionton bluetooth USB adapter (Vendor=0a5c 
> ProdID=200a Rev= 0.01), and it seems to work fine.
> 
> However, when I run hidd, I get the following error message:
> 
> Can't open HIDP control socket: No such file or directory
> 
> I straced hidd, and it seems to be caused by this operation:
> 
> socket(PF_BLUETOOTH, SOCK_RAW, 6) = -1 ENOENT (No such file or directory)
> 
> Any suggestions on what I'm doing wrong, or how I can fix this?

load the hidp kernel module if it is available. Otherwise switch to a
recent 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
