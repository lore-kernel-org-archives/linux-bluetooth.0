Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E0E1E4.2040602@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco kernel make (simple error I'm sure)
References: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com>	 <1105222194.27527.12.camel@linux.site>  <41E0AA3D.5010107@xmission.com> <1105256377.14750.7.camel@linux.site>
In-Reply-To: <1105256377.14750.7.camel@linux.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Sun, 09 Jan 2005 00:48:52 -0700

Christopher,

Build the kernel first. Make sure you select at least one alsa driver 
inside the kernel so you'll have all the necessary support for the btsco 
driver.

Brad

Christopher Bergström wrote:
> After ./bootstrap && ./configure
> 
> I cd into the /kernel directory..
> 
> and running make gives this error..
> 
> 
> username@linux:~/btsco> cd kernel/
> username@linux:~/btsco/kernel> make
> make[1]: Entering directory `/usr/src/linux-2.6.8-24.10'
> Makefile:465: .config: No such file or directory
> 
> WARNING: Symbol version dump /usr/src/linux-2.6.8-24.10/Module.symvers 
> is  missing, modules will have CONFIG_MODVERSIONS disabled.
> 
>   CC [M]  /home/username/btsco/kernel/btsco.o
> /bin/sh: scripts/basic/fixdep: No such file or directory
> make[2]: *** [/home/username/btsco/kernel/btsco.o] Error 1
> make[1]: *** [_module_/home/cusernamem/btsco/kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.8-24.10'
> make: *** [default] Error 2
> 
> 
> (I've read the README, all links referring to the README and a quick 
> tutorial on rebuilding kernel and kernel modules.)  Nothing really jumps 
> out as the answer unless I should have this stuff in a different 
> directory?  (There are a couple fixdep on my computer, but I'm not sure 
> if I should ln -s it somewhere..)  Sorry for the newbie question..


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
