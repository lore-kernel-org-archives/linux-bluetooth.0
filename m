Return-Path: <sfires@sfires.net>
Message-ID: <40680EB8.2070208@sfires.net>
Date: Mon, 29 Mar 2004 13:55:36 +0200
From: Dariusz Swiderski <sfires@sfires.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] cvs software issues
References: <40675F3B.5090704@sfires.net> <1080557069.2281.224.camel@pegasus>
In-Reply-To: <1080557069.2281.224.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:

>>i just did a cvs co of libs libs2 utils utils2 on a clean system
>>and i have faced following problems:
>>
>>libs2 subdir is missinf the ltmain.sh script which is required by the
>>bootstrap script
> 
> it should create it if it is missing.

apparently it doeas not:
sfires@snoopy:/home/storage/software/cvs/bluez/libs2$ ./bootstrap
configure.in: installing `./install-sh'
configure.in: installing `./mkinstalldirs'
configure.in: installing `./missing'
configure.in:19: installing `./config.guess'
configure.in:19: installing `./config.sub'
configure.in:19: required file `./ltmain.sh' not found
compat/Makefile.am: installing `./depcomp'

im not very goot with automake and autoconf sripts, but in utils and libs
this file, is pulled from cvs, and yes, i have seen the remark in attic ;)

----snip---

> There is no planned coexisting of both version and if libs2 and utils2
> are ready for rollout it will replace the old one.

ok, i can live with this, but what about hcid? its not in utils2

----snip----


> Every program that uses the old library must rewritten to use the new
> one. Especially sdptool, pand and dund. The other big project is writing
> a new sdpd.

so who is doing what, and where can i help?:)

greets
-- 
Maciej 'sfires' Swiderski
---------------------------------------------------
SysAdm | SecOff  | DS14145-RIPE        | DS11-6BONE
193.178.161.0/24 | 3ffe:8010:7:2a::/64 | AS16288
---------------------------------------------------
A mouse is a device used to point at the xterm you want to type in.
