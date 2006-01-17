Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus tasks planning
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <9307f5f20601171158ke41d974l29149adc20d8cd6c@mail.gmail.com>
References: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
	 <1137505788.28239.18.camel@localhost>
	 <9307f5f20601171158ke41d974l29149adc20d8cd6c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1137538397.27630.1.camel@localhost>
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
Date: Tue, 17 Jan 2006 23:53:17 +0100

Hi Paul,

> I'm happy to see the DBus issue again on the list.
> Even if I've already been told you don't like c++, I've got some code
> which does exactly what you're looking for so maybe it may be of some
> use, unfortunately I'm a student and
> this leaves me with little for fun activities (like coding) so the
> code hasn't been touched for a while(=months), I've started a complete
> rewrite but I don't know how long this is going to take, in the
> meantime I hope the old version will be useful, at least to grab some
> ideas

using C++ for hcid or bluetoothd is no option, but for the clients that
communicate over D-Bus, I don't care. Make them use C++, Mono/C# or
whatever language binding is supported by D-Bus.

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
