Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Big rename for the D-Bus API
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060227091006.GA17360@localhost.localdomain>
References: <1141022379.823.2.camel@localhost>
	 <20060227073835.GA16640@localhost.localdomain>
	 <1141026481.823.14.camel@localhost>
	 <20060227091006.GA17360@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1141031975.823.25.camel@localhost>
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
Date: Mon, 27 Feb 2006 10:19:35 +0100

Hi Johan,

> > Did you had a chance to look at the current code inside the CVS? Besides
> > two or three missing methods, everything has been implemented.
> 
> I haven't really had time to look at the new code, mostly because I have
> been working with an obex server implementation lately (you'll get yet
> another patch for openobex from me today or tomorrow ;)

go ahead. I have plans for another OpenOBEX release this week.

> However, I took a quick look at the code and made two small fixes to the
> first issues that I found (attached). The first patch cleans up
> sys.stdout.write() ugliness in dbus-test (however the change is not
> tested since my python version doesn't like the
> "@dbus.decorators.explicitly_pass_message" stuff).
> 
> The second patch fixes the code path where hci_open_dev fails in the
> hcid_dbus_setname_complete function (othervice strncpy(name, pname,
> sizeof(name) - 1)) will try to access uninitialized memory).

both patches have been applied. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
