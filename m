Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c669a7c70708292333n60a7e87wa20840012cd444c@mail.gmail.com>
References: <c669a7c70708290023ia617125rda5bc9e7547fe9f6@mail.gmail.com>
	<c669a7c70708292333n60a7e87wa20840012cd444c@mail.gmail.com>
Date: Thu, 30 Aug 2007 12:52:37 +0200
Message-Id: <1188471157.13373.4.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcidump output problem
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

Hi Mahin,

> > >  below is output of my hciconfig hci0 -a 
> > >  [root <at> vmware-fc6 bluez-hcidump-1.40]# hciconfig hci0 -a
> > > hci0:   Type: USB
> > >         BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
> > >         UP RUNNING PSCAN ISCAN 
> > >         RX bytes:387498 acl:0 sco:7357 events:9 errors:0 
> > >         TX bytes:34 acl:0 sco:0 commands:9 errors:0
> > >         Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
> > >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> > >         Link policy:
> > >         Link mode: SLAVE ACCEPT 
> > >         Name: ''
> > >         Class: 0x000104
> > >         Service Classes: Unspecified
> > >         Device Class: Computer, Desktop workstation 
> > >         HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP
> > > Subver: 0x1f4 
> > >         Manufacturer: CONWISE Technology Corporation Ltd (66)
> > 
> > another broken dongle. What brand is it. It seems I need one of
> these 
> > for testing at home.
>  
> It is of billionton
>  On the back side of it : P/N:USBBTC1A-B
>                                  S/N:05022500457
>  so I think my most of the problems are due to this broken dongle. 

can you show me a picture of it.

>  Should I change this ?

Yes.

>  Can u recommend one ?

Get a CSR BlueCore4 based one. They at least work properly.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
