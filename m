Return-Path: <skronenberger@web.de>
Date: Fri, 13 Aug 2004 22:00:51 +0200
From: Sigrid Kronenberger <skronenberger@web.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
Message-Id: <20040813220051.6826c6d1@localhost>
In-Reply-To: <1092426697.4501.41.camel@pegasus>
References: <20040811231204.18574a27@localhost>
	<1092262417.4564.259.camel@pegasus>
	<20040812194818.7d3d1ce6@localhost>
	<1092334021.28711.169.camel@pegasus>
	<20040812203428.0bd25290@localhost>
	<1092336801.28711.172.camel@pegasus>
	<20040813210346.6c40aed3@localhost>
	<1092424207.4501.27.camel@pegasus>
	<20040813212742.404662f2@localhost>
	<1092425535.4501.34.camel@pegasus>
	<20040813214754.2a937199@localhost>
	<1092426697.4501.41.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: skronenberger@web.de
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 13 Aug 2004 21:51:37 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

Hi Marcel, 

> > [root@localhost sigrid]# ls -la /usr/lib/hotplug/firmware
> > insgesamt 424
> > drwxr-xr-x  2 root   root     4096 Aug  9 22:13 ./
> > drwxr-xr-x  6 root   root     4096 Aug  6 20:31 ../
> > -rw-------  1 sigrid sigrid 418352 Aug 13 21:28 bfubase.frm
> 
> this looks weird make it owned by root:root and mode 644.

I've changed it to: 

[root@localhost sigrid]# ls -la /usr/lib/hotplug/firmware
insgesamt 424
drwxr-xr-x  2 root root   4096 Aug  9 22:13 ./
drwxr-xr-x  6 root root   4096 Aug  6 20:31 ../
-rw-r--r--  1 root root 418352 Aug 13 21:28 bfubase.frm
[root@localhost sigrid]#


Greetings

Sigrid
