Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple connection problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3ac394050602160549v2e7b7ebds2690192c067e3b2c@mail.gmail.com>
References: <3ac394050602160549v2e7b7ebds2690192c067e3b2c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140198105.4850.44.camel@aeonflux.holtmann.net>
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
Date: Fri, 17 Feb 2006 18:41:45 +0100

Hi Irfan,

> Thank you for ur feed back and help. I had stated in my previous mail
> that these dongles are working fine with other bluez
> functions/commands, but gives an error when a unit becomes slave of
> multiple masters. So is it just because of the hardware or it has some
> other reasons as well?

it is basically a limitation of the hardware. BlueZ has no limitations
in these area.

> Secondly I had a question about piconets. As slaves in piconet cannot
> directly communicate with each other and the master will act as a
> bridge for their communication. Now is this bridging facility provided
> by bluez libs? or do we have to implement it in our program (using
> Berkley Socket Interface) meant for piconet communication? 

No. You have to implement this by yourself.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
