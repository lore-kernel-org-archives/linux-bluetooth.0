Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4069478B.2070401@sfires.net>
From: Dariusz Swiderski <sfires@sfires.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] cvs software issues
References: <40675F3B.5090704@sfires.net>	 <1080557069.2281.224.camel@pegasus>  <40680EB8.2070208@sfires.net> <1080561659.2281.236.camel@pegasus>
In-Reply-To: <1080561659.2281.236.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 30 Mar 2004 12:10:19 +0200

Marcel Holtmann wrote:
> Hi Dariusz,
> 
> 
>>>it should create it if it is missing.
>>
>>apparently it doeas not:
>>sfires@snoopy:/home/storage/software/cvs/bluez/libs2$ ./bootstrap
>>configure.in: installing `./install-sh'
>>configure.in: installing `./mkinstalldirs'
>>configure.in: installing `./missing'
>>configure.in:19: installing `./config.guess'
>>configure.in:19: installing `./config.sub'
>>configure.in:19: required file `./ltmain.sh' not found
>>compat/Makefile.am: installing `./depcomp'
>>
>>im not very goot with automake and autoconf sripts, but in utils and libs
>>this file, is pulled from cvs, and yes, i have seen the remark in attic ;)
> 
> 
> it says so, but does this mean that it is not created ;)

ok, i see you are trying to pull my leg..:
sfires@snoopy:/home/storage/software/cvs/bluez/libs2$ ls
AUTHORS      CVS/       Makefile.am  README           bootstrap*     config.h.in   debian/   install-sh*  mkinstalldirs*
COPYING      ChangeLog  Makefile.in  aclocal.m4       compat/        config.sub*   depcomp*  lib/         test/
COPYING.LIB  INSTALL    NEWS         autom4te.cache/  config.guess*  configure.in  include/  missing*

the mkinstalldir and so on are in place, but not the ltmain.sh

>>>There is no planned coexisting of both version and if libs2 and utils2
>>>are ready for rollout it will replace the old one.
>>
>>ok, i can live with this, but what about hcid? its not in utils2
> 
> I am not quite sure about the real future of hcid. We will have a
> replacement for it, but I want to redesign some parts of it.

ok, no problem, but there must be sth. to work with the pin-helper ;)

---snip---

> At the moment nobody. So feel free to take the code and clean it up and
> make it libs2 compatible.

so i will

greets
-- 
Maciej 'sfires' Swiderski
---------------------------------------------------
SysAdm | SecOff  | DS14145-RIPE        | DS11-6BONE
193.178.161.0/24 | 3ffe:8010:7:2a::/64 | AS16288
---------------------------------------------------
A mouse is a device used to point at the xterm you want to type in.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
