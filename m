Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: ipaq 1945
From: Marcel Holtmann <marcel@holtmann.org>
To: O Plameras <oscarp@acay.com.au>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <415CB21A.5060307@acay.com.au>
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <003001c4a3ba$d064fba0$8696a8c0@marcy>
	 <320075ff0409270050bbaf228@mail.gmail.com>
	 <1096371841.4950.5.camel@notepaq>
	 <320075ff04092805251ce925e6@mail.gmail.com>
	 <200409281319.i8SDJkQt011868@news01.csr.com>
	 <320075ff040928064645f3c7b0@mail.gmail.com>  <415CB21A.5060307@acay.com.au>
Content-Type: text/plain
Message-Id: <1096617306.5403.5.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 01 Oct 2004 09:55:07 +0200

Hi,

> > Debug: sleeping function called from invalid context ad
> > include/asm/semaphore.h:119
> > in_atomic():1, irqs_disabled():0
> >  __night_sleep+
> >  sysfs_hash_and_remove
> >  br_sysfs_removeif
> >  br_del_if
> >  br_device_event
> >  notifier_call_chain
> >  unregister_netdevice+0x170/0x2ac
> >  unregister_netdev+0x18/0x30
> >  bnep_session+0x7ab/0x860 [bnep]
> >  schedule_tail+0x1e/0x70
> >  ret_from_fork+0x6/0x14
> >  default_wake_function+0x0/0x20
> >  bnep_session+0x0/0x860 [bnep]
> >  kernel_thread_helper+0x5/0x14
> > 
> > I suspect it's a problem with the bnep module rather than anything
> > specific to the BlueZ stack..
> 
> I have exactly the same problem and displays exactly the
> above Debug messages:
> 
> 1. My Linux Server hosting BlueZ NAP crashes with blank console
> and frozen keyboard when a client BlueZ disconnects, reboots,
> or becomes out-of-range. This happens for clients with Linux or
> with Windows XP Pro. My server config is similar, namely:
> 
> a. bridge-router-firewall-bluez.
> b. Linux 2.6.8.1-mm4-mh1 or
> c. Linux 2.6.8.1-mm4-mh2 or
> d. Linux 2.6.8.1-mh1 or
> e. Linux 2.6.8.1-mh2 or
> f. Linux 2.6.5 combo
> 
> Incidentally, this setup works very well other than this
> problem. I started running this setup 3 weeks ago with
> only this problem. My users can surf the net, use email,
> etc, with no other problem.
> 
> I tried using a Linux Server with nobridge-router-nofirewall-bluez
> and this problem of crashes disappears. But network admin is
> a bit more tedious without bridging.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
