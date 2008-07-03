Return-Path: <cyrus@holtmann.org>
Message-ID: <059601c8dca4$cedd8370$0132a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>,
	"Ram kumar" <ramkumar.research@gmail.com>
References: <6306c640807021140r4ea69652p24e4dcbbf5376db7@mail.gmail.com>
Date: Thu, 3 Jul 2008 08:36:17 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez utils Cross compiling steps
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


>hi,
>      I am trying to cross compile bluez utils.After researching through 
> the web i found out that it has lot of dependencies like dbus,expat 
> etc..............

Hi , Ram, Yes , It depends on a lot of things, If you want to found out what 
it need , just using ./configure --enable-all and see the output message.
If will checking for something it need, if it passed, it's ok. If not, build 
them.

Actually , even if something the configure complain not found, as long as 
the configure can pass, you can still build the program, just that some 
features will be missing I guess.

And , you might also want to try ./configure --help to check out what kind 
of flag you want to pass to configure.

> Please let me know what are the dependencies for cross compiling bluez 
> utils and bluez-libs....???? Do i have to cross compile the bluetooth 
> bluez-stack also in order to compile bluez-libs and 
> bluez-utils.......?????

Bluez-libs should be needed by bluez-utils, there are not something else 
called bluez-stack need to be built before hand.

> Any guide how to configure the bluez-libs and bluez-utils to cross 
> compile....based on the kernel 2.6.24.............will be helpful to 
> me................

> Regards,
> Ram

Raymond




-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
