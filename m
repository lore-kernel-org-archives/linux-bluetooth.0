Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cs044v$o6q$1@sea.gmane.org>
References: <cruhvs$fj5$1@sea.gmane.org> <1105388822.8652.53.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1105388822.8652.53.camel@pegasus>
Subject: [Bluez-devel] Re: baswap neccesity
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
Date: Tue, 11 Jan 2005 09:52:07 +0100

Hello Marcel,

Marcel Holtmann wrote:
> Hi,
> 
> 
>>I'm reading rctest.c:
>>In do_connect function, a call to bswap is used just before the connect 
>>call:
>>	baswap(&rem_addr.rc_bdaddr, strtoba(svr));
>>
>>In the server, baswap is again called just after the accept call
>>
>>Why is it neccesary? Why does the server listening at the other side 
>>expect addresses in such byte ordering?
> 
> 
> this is part of the specification. The textual representation and the
> over-air BD_ADDR is swapped.
> 
> However the code above has a memory leak. Where do you found it?
this piece of code is from the 'bluez-utils-2.13.tar.gz' package which 
is downloadable now at the web site. Precisely in function 'int 
do_connect(char *svr)' of rctest.c.
It's curious, I'm sure you'd see memory leaks where I only see flowers!

thanks Marcel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
