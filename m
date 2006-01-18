Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm connect error Too many links(31)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060118144029.GA60664@rucus.ru.ac.za>
References: <20060118123739.GA39259@rucus.ru.ac.za>
	 <1137588481.21191.5.camel@localhost>
	 <20060118144029.GA60664@rucus.ru.ac.za>
Content-Type: text/plain
Message-Id: <1137595604.4776.5.camel@localhost>
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
Date: Wed, 18 Jan 2006 15:46:44 +0100

Hi David,

> > but maybe not multiple ACL connections and this is what you need in your
> > case. So you need at least a CSR chip with HCI 18.x firmware or you
> > might wanna simply use another dongle. One for the incoming data and one
> > for the outgoing data.
> 
> Thanks Marcel for the quick answer. Though you are the messenger with the
> bad news... It had not crossed my mind that this could be a problem. Do
> you know where I can find some reference to this online?

you can look at my page for the CSR chips and their firmware. Besides
this I don't think that you will find any further details. Use a second
dongle and this problem goes away.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
