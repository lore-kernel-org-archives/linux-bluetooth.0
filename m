Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420504B8.1090903@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050205124828.1758.qmail@web60903.mail.yahoo.com>	 <4204C77D.1040207@gmx.ch> <1107611491.6921.133.camel@pegasus>	 <4204D19B.1090108@gmx.ch> <1107612892.6921.152.camel@pegasus>
In-Reply-To: <1107612892.6921.152.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sat, 05 Feb 2005 18:39:04 +0100

Hello Marcel

thanks a lot for your comments and hints on my code.

unfortunately we only had 1 module about c/c++ programming in the 
university and I'm programming java for over 3 years.
Luckily, in comunication-technology, we've a subtopic about c 
socket-programming in two weeks, this will be very helpfull.

Actually my project is in c++. Because of that I started already with the 
c++ usage of comments and variable declarations. For c I usually use the 
--ansii flag to ensure gcc backward compatibility.

I'll definitely check out the rctest.c example


Regarding your price/hour: Do you know how many money you would earn if you 
got paid for your email support in this list? Amazing! :-)
It's always a pleasure if someone answers emails in mailinglists that fast 
and precise as you do (The last one i've "met" spending so much time for a 
mailinglist was Mattia Barbon in the wxPerl list.).

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>Thanks a lot. I hoped someone more c experienced will take a quick look at 
>>my code. It's the result of a example I found (the mistake comes from 
>>there) and a socket programming howto I read.
>>
>>I now changed it to
>>addr.rc_channel = 4;
>>
>>Actually I do not need to #define it for the whole file.
> 
> 
> the code is fine so far. However the best example is still in rctest.c
> besides that it uses fork() and this is sometimes hard to understand by
> beginners. I cleaned the rctest.c stuff lately and removed some cruft
> things.
> 
> In your code I would only criticize the coding style and the naming of
> the variables.
> 
> Coding style:
> 	- Use /* */ for comments
> 	- if(bind...) ==> if (bind...) {
> 	- (struct sockaddr *)&addr ==> (struct sockaddr *) &addr
> 
> Variable names:
> 	- sock ==> sk
> 	- client ==> nsk (stands for new socket)
> 	- noReadChars ==> len or num (this is not C++ or Java)
> 
> When you do accept() you should do the "alen = sizeof(addr);" again,
> because the value of alen could be overwritten. And a memset() of the
> addr variable before filling it with values is a good idea. It can
> happens that the size between the kernel and the userspace differs and
> so you make sure that it is filled with zeros.
> 
> And don't declare new variables inside the code. Do it at the top of a
> function or a the top of a block. Old compilers like GCC 2.95 don't like
> this and remember this is not Java.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
