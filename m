Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jul 2008 09:11:17 -0400 (EDT)
From: Paul Waldo <paul@waldoware.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <15206328.4111217509877341.JavaMail.root@mercury.waldo.home>
In-Reply-To: <5238820.3721217360924997.JavaMail.root@mercury.waldo.home>
Subject: Re: Trouble Connecting to NAP on Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, 

Apparently no takers :-(  If there is any more information that would be helpful, I'd be happy to provide it.  Unfortunately, I am unaware of any tools that will help me debug this problem.  I tried "strace" on the pand command, but it didn't yield anything useful.  Any tips on debugging the connection?

If I am inquiring in the wrong forum, I welcome suggestions on a better one.  Thanks in advance!

Paul

----- "Paul Waldo" wrote: 
Hi all, 

I'm new to bluetooth, and got in over my head. I have a Windows box that is acting as a Network Access Point as well as a PAN Server. I have a laptop that I want to connect to the access point via bluetooth so it can access the Internet. The laptop can connect to the NAP and the GN just fine when running Windows, but when the laptop is running linux, I get errors. It can connect to the GN, but not the NAP: 

************Start transcript*************************** 
root@paul-laptop:~# pand --killall 
root@paul-laptop:~# pand --connect 11:11:11:11:11:11 --service GN -n 
pand[17097]: Bluetooth PAN daemon version 3.26 
pand[17097]: Connecting to 11:11:11:11:11:11 
pand[17097]: bnep0 connected 
root@paul-laptop:~# pand --killall 
root@paul-laptop:~# pand --connect 11:11:11:11:11:11 --service NAP -n 
pand[17123]: Bluetooth PAN daemon version 3.26 
pand[17123]: Connecting to 11:11:11:11:11:11 
pand[17123]: Connect to 11:11:11:11:11:11 failed. Protocol error(71) 


[turn off GN service on server] 


root@paul-laptop:~# pand --connect 11:11:11:11:11:11 --service NAP -n 
pand[17797]: Bluetooth PAN daemon version 3.26 
pand[17797]: Connecting to 11:11:11:11:11:11 
pand[17797]: Connect to 11:11:11:11:11:11 failed. Connection refused(111) 
************End transcript*************************** 

Here are the specifics of the Machines: 
SERVER 
Windows XP 
BlueSoleil 1.6.1.4 
All security turned off 

CLIENT 
Linux (Kubuntu 8.04 Hardy, AMD64) 
bluez 3.26 

I've googled everything I can think of. Any help would be greatly appreciated. Thanks in advance! 

Paul 
