Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fwd: reduce hci connect time
From: Marcel Holtmann <marcel@holtmann.org>
To: murdok <murdok@tiscali.it>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200409031858.24241.murdok@tiscali.it>
References: <200409031858.24241.murdok@tiscali.it>
Content-Type: text/plain
Message-Id: <1094459376.5145.17.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 06 Sep 2004 10:29:36 +0200

Hi Murdok,

> I'm trying to reduce the time of HCI connect using the clock offset in the
> hcitool create connection command.
> So I modified hcitool.c (present in attach) adding the clkoffset parameter
> on hci_create_connection:
> 
>  if (hci_create_connection(dd, &bdaddr, htobs(ptype), clkoffset , role,
> &handle, 25000) < 0)
>                 perror("Can't create connection");
> 
> and change the code for insert that in the command with this syntax:
> 
> hcitool cc --clkos <clkoffset-in-decimal> <BDADDR>;
> 
> then I add a printf into hcitool inq for print the clkoffset in decimal
> and try to insert this in the connection command, b
> ut the time of connect do not change!
> 
> Later, during other test I take a mistake using a wrong clockoffset in the
> connect command and the time of the connection w
> as redused under 100 ms (with the slave in continuos page scan mode).
> 
> So I write a little bash script for test and I find a stange class of value
> to reduce this time of connection, but I can't
> understanding the logic.
> 
> Where I mistake?
> Why if I insert the same value returned from hci inqiry the connection do
> not reduce its time?
> There is a bug in the code or I wrong using some function?
> 
> In attach you can find:
> the hcitool.c code (modified)
> a dump with a hci inquiry, and an hci connect with the same value of
>  clokoffset bash script for trying a lot value of clkoffset

check the specification on how to modify the clock offset for making it
a valid value for the create connection command.

Your patch is not really needed, because there is no need to use the
"hcitool cc ..." command. I wrote it many times that this is only a
command for debugging and not for normal use. The kernel has its own
inquiry cache and it uses the clock offset for every connection created
through by the kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
