Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434C2B19.5040909@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: hcid patch (remote name and connections)
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>	 <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>	 <434C16C4.3040009@csr.com> <e1effdeb0510111307r3bf0822aya57f5003efd8f655@mail.gmail.com>
In-Reply-To: <e1effdeb0510111307r3bf0822aya57f5003efd8f655@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 11 Oct 2005 22:14:01 +0100

Claudio Takahasi wrote:
> It's from hcitool code :)

:-)

Still, that's no reason to propagate the error. Fix it and port the fix
back to hcitool (and wherever else it's escaped from).

> I will replace by "7", the maximum number of connections. Is it ok?

It wasn't the value I was concerned about. It was the free-floating 10
in the code twice.

A #define should allay my immediate concerns, however, a better solution
would be to avoid the use of hard-coded constant limits. Is there any way
to retrieve the current number of connections?

Strictly, 7 isn't the maximum number of connections - it's the maximum
number of active slaves a master can have. In theory the number of
simultaneous connections a device can have is limited only by the number
of ACL handles (about 4000). In practice, it's limited by the amount of
memory on the device and the need to service all the connections.

If you have more than one HCI dongle then you can have even more
connections.

In practice, 10 is probably sufficient for today, but by making it a
#define with a self-documenting name, it's easy for someone to change it
in the future.

If the kernel has some limit on the maximum number of connections then
use that (and get it from the kernel or a #include, don't copy the number
into your code).

If you can't get the number of connections from the kernel then that
suggests that there's a kernel API missing.

You may be able to work round the missing API depending on the behaviour
of HCIGETCONNLIST when the array size (N) is too small to hold all the
connections (M).

  * If it causes a segmentation fault and terminates your program then
    you may be in trouble.

  * If it copies the first N connections and returns with conn_num
    set to N then test for conn_num being set to N on return and
    if it is, double N and try again.

  * If it copies the first N connections and returns with conn_num
    set to M then make two calls: the first with N = 0 and the second
    with N = M.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
