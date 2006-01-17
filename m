Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43CD5A8F.3080802@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't find device
References: <43CBB6AE.4020007@cs.bgu.ac.il> <43CC4968.6070003@cs.bgu.ac.il>
In-Reply-To: <43CC4968.6070003@cs.bgu.ac.il>
Content-Type: text/plain; charset=UTF-8
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
Date: Tue, 17 Jan 2006 13:58:55 -0700

Niv

> OK I am certain now. bluetooth-alsa cant work when using alsa-driver.
> Even when SND_HWDEP is included.

fwiw, the nokia 770 guys came up with a cleaner way to get the hwdep
stuff built.

> I cant use BT-alsa when I compile alsa as modules in the kernel.

explain what you mean here. as opposed to compiling everything directly
into the kernel?

> 
> I dont understand the difference.
> 
> Is it to do with new alsa-driver ?

you mean the new alsa driver inside btsco? it's not working yet and it
shouldn't be causing any problems.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
