Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth Qualification - plan to make a plan
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: halam.rose@7layers-uk.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <MGEGKHCLDAFHMAIHGKNCAEEBFIAA.halam.rose@7layers-uk.com>
References: <MGEGKHCLDAFHMAIHGKNCAEEBFIAA.halam.rose@7layers-uk.com>
Message-Id: <1046865863.1823.55.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 05 Mar 2003 13:04:17 +0100
Content-Type: text/plain

Hi Halam,

> There is a general question I can usefully answer about Qualifying Bluetooth
> products now:
> The Qualified Product Listing can change,  this means that unless the whole
> thing is rewritten I cant imagine BlueZ needing to be requalified completely
> (and expensively with a new listing fee).  We can start with a basic listing
> because new profiles can be added and other changes can be made for whatever
> reason, they just need appropriate evidence to be approved by the BQB.  The
> Qualified Product listing for Widcoms stack for instance covers all versions
> of Windows and has a great long revision history.  You can view it at
> http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&D
> etails=Yes&ProductID=250.

this sounds very good.

> I will have to discuss with the BQB what limits of platform may be
> appropriate if the same source code is used.  My BQB has little knowledge of
> Linux so my advice will be a great help to him, but I need to know from you
> how different kernels and processors and even compilers affect BlueZ.

>From my knowledge and from the postings on the mailing list the BlueZ
stack have successful tested on

	- x86 (UP and SMP)
	- sparc (32bit and 64bit, UP and SMP)
	- arm (StrongARM, XScale)
	- PowerPC

The Motorola DragonBall is also listed as supported platfrom, but I
can't remember any posting about success on it (Max, please correct me).
And the new Intel HT technologie should also be supported, but I don't
have heard from any success.

The kernel requires a Gnu C compiler (gcc) 2.95.3. I use a 2.95.4, but
it should also compile with the 2.96 from RedHat and the new GCC 3.x (if
it dooesn't, we will fix it). For information about kernel compiler
requirements, please take a look at Documentation/Changes in the 2.4
kernel tree.

> BlueZ seems to be the sole copyright of Qualcomm - is this correct?
> 
> Would it be appropriate to make the listing in the name of Qualcomm with Max
> as the contact, or is there now some other kind of BlueZ organisation?

The copyright thing is not very easy. The core code (HCI and L2CAP) are
copyright of Qualcomm, the BNEP code contains copyright from Inventel
and Max, the RFCOMM code has copyright from Max and me. The HCI drivers
have much more different copyrights inside. For the user space part you
will also get some more names.

Maybe my idea with an own organization for BlueZ is a good one.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
