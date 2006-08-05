Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Anselm Martin Hoffmeister <anselm@hoffmeister-online.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060804133201.95997.qmail@web27910.mail.ukl.yahoo.com>
References: <20060804133201.95997.qmail@web27910.mail.ukl.yahoo.com>
Date: Sat, 05 Aug 2006 14:39:26 +0200
Message-Id: <1154781567.6425.16.camel@anselm.venusberg.augustinnetz.de>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez on debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Freitag, den 04.08.2006, 15:32 +0200 schrieb j b:
> Hi @ll 
>  
> I'm trying to get something working and have some problems on my
> search for infos: 
>  
>  
> idea: 
> PDA to PDA text and voice communication 
>  
> how? 
> PDA-bluetooth-PC-elthernet/inet-PC-bluetooth-PDA 
>  
> at moment: 
> PDA-bluetooth-PC
>  
> problem: 
> don't know a lot about bluetooth and bluez
> just few weeks experiencie with debian
> can't find any info/tutorial about bluez, their functions,
> explanations, applications, examples 
>  
> steps: 
> connect PDA - PC (i believed is reached) 
> text an voice communication PDA - PC 
>  
> i got some examples how to set it up but any explanation about what it
> means, how it works, why it works etc 
>  
> goal: 
> study project, going to be diploma proyect for engineering study
> (finishing) and i haven't any more much time, just a few days. 

Dear xen,

it seems as if you do not know what exactly you want to achieve in your
project, neither have the technical background to describe that.

If you want to have a kind of Messenger app between two PDAs, or
something like a VoiceOverIP-speech solution, then the easiest would be
to take the software that is already available, install it and use it.

I will give you a scenario, to outline what is involved in having two
PDAs with a SIP (VoIP) client contact each other:

Each PDA runs the VoIP software (there are few, but look for MS Portrait
or SJphone). That software communicates over IP based networks, so the
PDA will connect to a kind of "access point" via bluetooth to get IP
connectivity. There are two common ways of doing this: Either via the
proper BNEP (bluetooth networking, emulates an ethernet connection over
which IP packets can travel) or DUN (dialup networking, emulates a
serial modem, running PPP over bluetooth). Windows CE seems to only
support the latter, so you will need an "access point" for your PDA.

The SIP phone software registers with a SIP server (for example,
asterisk). Note this is not strictly necessary, but once setup makes
scaling up to multiple devices easy, and it cares for all those
NAT/routing/dynamic IP problems that you would run into when trying to
communicate directly between two sip phones behind a firewall.

The most complicated part (besides setting up asterisk, but there are
howtos that explain it quite well, and prepackaged DEBs) is to get your
Linux box act as a DUN access point.

This does not require any low-level bluetooth programming, or no
programming at all. Just get your Linux box setup as a DUN server.

No, I cannot help at that detail because I tried and did not manage: My
PDA's windows CE plainly refuses to do any networking over Bluetooth.
Generally that seems to be possible though, I have seen howtos that
would just not work on my PDA. Try those, ask google.

If you have precise questions, then ask. Try to give as much details of
what exactly you try and what does not work, as possible and reasonable.

My 2 cents,
Anselm


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
