Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with compiling Bluez-Package version  1.2
From: Marcel Holtmann <marcel@holtmann.org>
To: Ashok <ashokg@iap-online.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1081418089.5046.7.camel@ashokg>
References: <1081418089.5046.7.camel@ashokg>
Content-Type: text/plain
Message-Id: <1082159784.4489.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 17 Apr 2004 01:56:24 +0200

Hi Ashok,

>         I have a problem in compiling the bluez source code and
> installing it. Can any body please tell me how to do the compilation and
> installation of the bluez module.

use a fairly new Linux kernel with Bluetooth support enabled and run

	./configure && make && make install

to compile, build and install the userspace packages from the BlueZ
download page.

> 	It will be helpful if some one would help me to give their valuable
> suggestions to port bluez to a different operating system

A different operation system than Linux? Actually it would be better to
start the Bluetooth stack from scratch ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
