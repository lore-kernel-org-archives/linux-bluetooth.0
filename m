Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030306143116.02354298@mail1.qualcomm.com>
To: <halam.rose@7layers-uk.com>, "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Bluetooth Qualification - plan to make a plan
In-Reply-To: <MGEGKHCLDAFHMAIHGKNCAEEBFIAA.halam.rose@7layers-uk.com>
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
Date: Thu, 06 Mar 2003 14:47:00 -0800
Content-Type: text/plain; CHARSET=us-ascii

At 09:24 AM 3/3/2003, Halam Rose wrote:
>There is a general question I can usefully answer about Qualifying Bluetooth
>products now:
>The Qualified Product Listing can change,  this means that unless the whole
>thing is rewritten I cant imagine BlueZ needing to be requalified completely
>(and expensively with a new listing fee).  We can start with a basic listing
>because new profiles can be added and other changes can be made for whatever
>reason, they just need appropriate evidence to be approved by the BQB.  The
>Qualified Product listing for Widcoms stack for instance covers all versions
>of Windows and has a great long revision history.  You can view it at
>http://qualweb.opengroup.org/Template2.cfm?LinkQualified=QualifiedProducts&D
>etails=Yes&ProductID=250.
Good. Thanks for clarifying that.

>I will have to discuss with the BQB what limits of platform may be
>appropriate if the same source code is used.  
Yeah, that'd be interesting.

>My BQB has little knowledge of Linux so my advice will be a great help to him, 
>but I need to know from you how different kernels and processors and even compilers 
>affect BlueZ.
Processors shouldn't really affect all endianess and memory access issues have been
fixed long time ago. 
The only compile that we support is GCC. Intel C compiler might be able to compile 
Linux kernel in which case it will work with Bluetooth code also.

>Also I need your questions and pointers to any problems you can see arising,
>such as non-conformances with the BT specification.
>
>Could someone tell me the best way of posting the Qualification FAQ ?
This mailing list. You could send updates periodically.

>BlueZ seems to be the sole copyright of Qualcomm - is this correct?
No. Several people (including me) have personal copyrights. And other 
companies too.

>Would it be appropriate to make the listing in the name of Qualcomm with Max
>as the contact, 
No. These days Qualcomm has pretty much nothing to do with it. Other than the 
fact that I work for this excellent company.

>or is there now some other kind of BlueZ organisation?
Not that I know of :). 

Can it be listed as something like

        Linux Bluetooth protocol stack. 
        Organization:
                BlueZ project. 
        Contacts:
                bluez-user@lists.sf.net

?

Max





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
