Return-Path: <cyrus@holtmann.org>
Message-ID: <48BFFB8D.8030009@free.fr>
Date: Thu, 04 Sep 2008 17:15:25 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] Sniff mode issues regarding	Sony	Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr>	<1220471377.6714.52.camel@californication> <48BFBBED.5010504@free.fr>	<48BFDB04.3060003@free.fr> <1220536304.6714.71.camel@californication>
In-Reply-To: <1220536304.6714.71.camel@californication>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel
> 
>>>> retest with 2.6.27-rc5 since that has full Simple Pairing support and is
>>>> the kernel version that counts.
>>> I'm gonna rebase on this one then.
>> The issue with sniff mode & disconnect has vanished with 2.6.27-rc5 :-)
> 
> are you sure? I am not recalling that I fixed anything in this area. The
> ACL link setup has changed to do proper features retrieval before
> allowing L2CAP do get into it. However it cools down the phase for the
> first L2CAP package.

See previous e-mail, i screwed up, issue seems to come from ST chip. :-(

> 
> Btw. report this bug to your hardware manufacturer, because they are not
> working according to the HCI specification. It is a bug if disconnect
> fails when they are in sniff mode.
> 

Yep, i would definately report this... however don't have any support 
anymore from ST :-(

Fabien
