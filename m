Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] conceptronic CBT100U with scala-500 headset pairing problem!
Message-ID: <20060205071057.GA11171@163.com>
References: <1139079892.13219.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1139079892.13219.11.camel@localhost>
From: Amateur <ztl.post@gmail.com>
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
Date: Sun, 5 Feb 2006 15:10:57 +0800

On Sat, Feb 04, 2006 at 07:04:52PM +0000, Tamer Higazi wrote:
> 
> Hi! 
> I am trying to pair myheadset with my USB bluetooth dongle on Linux!
> 
> About my device: 
> #hcitool dev
> Devices:
>         hci0    00:80:5A:30:BC:7D
> 
> If I run the command: 
> 
> #hcitool cc 00:0A:9B:6C:65:A0
> 
> I receive this result: 
> Can't create connection: Input/output error
> 
> If I'd love to request info from the device: 
> 
> #hcitool info 00:0A:9B:6C:65:A0
> 
> I receive this result: 
> 
> Requesting information ...
> Can't create connection: Input/output error
You must enable authenticate in /etc/bluetooth/hcid.conf, restart hcid
whereafter. The default PIN code of your headset could be 0000, which
you must put into /etc/bluetooth/pin, or enter manually. The
communication between your computer and headset is encrypted enforced
by the headset.

> 
> On Windows I can make easily a connection to that bluetooth device. I
> want to make the same on Linux with the BTSCO package to make VoIP with
> Skype. 
> 
> If there is anybody who has experiences... 
> 
> Thank you in advance
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
-------------------------

-- 
Nothing so needs reforming as other people's habits.
		-- Mark Twain


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
