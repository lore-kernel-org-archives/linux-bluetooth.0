Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <470B356F.1050805@silicom.fr>
Date: Tue, 09 Oct 2007 10:01:51 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>	<1191884194.12212.13.camel@aeonflux.holtmann.net>
	<d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>
In-Reply-To: <d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------020102060505090006010004"
Subject: Re: [Bluez-devel] Patch: inheritance problem in gsta2dpsink
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020102060505090006010004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Adding more pepper on this already spicy conversation. :-)
> Hey
> 
> I asked Marcel the same thing a while back.
> 
> It would make sense to factor the common stuff into unix.c or create
> an ipc.c for that. We can link these to each plugin without messing
> around with libraries.
> 
> Brad
> 
> On 10/8/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Luiz,
>>
>>> I guess we really need a tiny library for ipc, we dont want to
>>> duplicate code from
>>> pcm_bluetooth.c again in a2dpsink, it might happen that someone need this
>>> in another plugin or so.
>> no no and no. I don't care what other plugins (outside bluez-utils) need
>> and want at the moment. 

Well, *I do* care.
As i told you back in Montpellier, i need a way to plug an external 
(proprietary) hardware accelerated audio system onto the audio service.
In fact i could start working on such a library right away, provided 
that it is LGPL, so that i can link a proprietary stuff on top of it.
Even if it is not packaged as an external library at first, provided i 
can somehow copy the code out of bluez tree and rebuild a LGPL library 
out of it would be acceptable as a first step. :-)
If that can't be done then i'm gonna go grumble in a corner and we will
have missed an opportunity to move the bluez audio system forward. :-(
And remembering what Marcel told us during the meeting, the IPC API is 
not public because "we don't really know what we're doing".
My answer to that is:
  - having worked on audio stuff for some time now, i think i know what 
i would be doing if i was to work on this API : which mean it would be 
made stable pretty quickly.
  - We'd better start stabilizing the API before too much effort has 
been put on the gstreamer plugin or any other plugin, otherwise we will 
have to fix them all afterwards.

A last thing : this is likely to be a one time offer, because i need to 
start working on this stuff as soon as today. If we miss the window i 
won't be able to spent company time on this library, which mean i will 
only be able to get involved on my spare time, which i kind of lack
these days...

As always : comments are welcomed !!


>> It is perfectly fine to link an object file more
>> than once. 
Sure it is, we just loose some disk space.

Cheers,

Fabien

--------------020102060505090006010004
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet; RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------020102060505090006010004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------020102060505090006010004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020102060505090006010004--
