Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4204D19B.1090108@gmx.ch>
References: <20050205124828.1758.qmail@web60903.mail.yahoo.com>
	 <4204C77D.1040207@gmx.ch> <1107611491.6921.133.camel@pegasus>
	 <4204D19B.1090108@gmx.ch>
Content-Type: text/plain
Message-Id: <1107612892.6921.152.camel@pegasus>
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
Date: Sat, 05 Feb 2005 15:14:52 +0100

Hi Marco,

> Thanks a lot. I hoped someone more c experienced will take a quick look at 
> my code. It's the result of a example I found (the mistake comes from 
> there) and a socket programming howto I read.
> 
> I now changed it to
> addr.rc_channel = 4;
> 
> Actually I do not need to #define it for the whole file.

the code is fine so far. However the best example is still in rctest.c
besides that it uses fork() and this is sometimes hard to understand by
beginners. I cleaned the rctest.c stuff lately and removed some cruft
things.

In your code I would only criticize the coding style and the naming of
the variables.

Coding style:
	- Use /* */ for comments
	- if(bind...) ==> if (bind...) {
	- (struct sockaddr *)&addr ==> (struct sockaddr *) &addr

Variable names:
	- sock ==> sk
	- client ==> nsk (stands for new socket)
	- noReadChars ==> len or num (this is not C++ or Java)

When you do accept() you should do the "alen = sizeof(addr);" again,
because the value of alen could be overwritten. And a memset() of the
addr variable before filling it with values is a good idea. It can
happens that the size between the kernel and the userspace differs and
so you make sure that it is filled with zeros.

And don't declare new variables inside the code. Do it at the top of a
function or a the top of a block. Old compilers like GCC 2.95 don't like
this and remember this is not Java.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
