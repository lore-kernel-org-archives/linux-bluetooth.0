Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <420504B8.1090903@gmx.ch>
References: <20050205124828.1758.qmail@web60903.mail.yahoo.com>
	 <4204C77D.1040207@gmx.ch> <1107611491.6921.133.camel@pegasus>
	 <4204D19B.1090108@gmx.ch> <1107612892.6921.152.camel@pegasus>
	 <420504B8.1090903@gmx.ch>
Content-Type: text/plain
Message-Id: <1107626911.6921.179.camel@pegasus>
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
Date: Sat, 05 Feb 2005 19:08:31 +0100

Hi Marco,

> thanks a lot for your comments and hints on my code.

you are welcome.

> unfortunately we only had 1 module about c/c++ programming in the 
> university and I'm programming java for over 3 years.
> Luckily, in comunication-technology, we've a subtopic about c 
> socket-programming in two weeks, this will be very helpfull.
> 
> Actually my project is in c++. Because of that I started already with the 
> c++ usage of comments and variable declarations. For c I usually use the 
> --ansii flag to ensure gcc backward compatibility.

Actually all my suggestions are based on my work inside the Linux
kernel. If you are at that point you see code a little bit different,
because you must deal with different things. People underestimate the
coding style and I think it is one of the important things to keep this
clean and to help and allow newbies to understand the code. And this is
another important thing, because if you don't understand the code you
end up copying stuff from one project to another. This does not increase
code quality and I have seen enough projects where something works, but
nobody knows why.

> I'll definitely check out the rctest.c example

The test programs still need some cleanups, because there are too many
global variables in that code.

> Regarding your price/hour: Do you know how many money you would earn if you 
> got paid for your email support in this list? Amazing! :-)

I don't know, but actually that is not so important. A project will only
make progress if the mailing list is activly maintained. If people don't
care about the problems of others, the project is already dead.

However feel free to make a donation if you like ;)

	http://www.bluez.org/sponsors.html

> It's always a pleasure if someone answers emails in mailinglists that fast 
> and precise as you do (The last one i've "met" spending so much time for a 
> mailinglist was Mattia Barbon in the wxPerl list.).

Thanks

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
