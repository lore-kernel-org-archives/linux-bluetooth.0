Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection attempt timeout
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1140564558.22767.29.camel@localhost>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
	 <1140559259.11852.4.camel@localhost.localdomain>
	 <1140564558.22767.29.camel@localhost>
Content-Type: text/plain
Message-Id: <1140625019.3319.1.camel@localhost.localdomain>
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
Date: Wed, 22 Feb 2006 13:16:58 -0300

I've found the piece of code that does the trick (function _cmd_page_to
in file hciconfig.c). Thanks Marcel!


On Wed, 2006-02-22 at 00:29 +0100, Marcel Holtmann wrote:
> Hi Agustin,
> 
> > I'm developing an application using the bluetooth libraries provided by
> > Marcel. I'm working with rfcomm connections. After looking at the
> > function cmd_connect (in the file 'main.c',in the rfcomm directory of
> > the bluez-utils-2.25) I realized that (using this function) there's no
> > way to set the connection attempt timeout (the time the connection
> > attempt will last if the remote device is, for example, turned off).
> 
> what do you mean by connection attempt timeout. I think the correct term
> is page timeout and you can of course set it with hciconfig.
> 
> Regards
> 
> Marcel
> 
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



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
