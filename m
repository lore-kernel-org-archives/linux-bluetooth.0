Return-Path: <i_p_a_u_l@yahoo.com>
Message-ID: <20040816115340.49814.qmail@web50206.mail.yahoo.com>
Date: Mon, 16 Aug 2004 04:53:40 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092645247.4375.86.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

I tried without --role and --master parameters and the
same result (pand -s -n on one side and pand -n -c
MAC)
And in /etc/bluetooth/hcid.conf I have
lp hold,sniff,park,rswitch;


--- Marcel Holtmann <marcel@holtmann.org> wrote:
> > On one I launch 
> > pand --listen --role NAP -n --master
> > and on the other
> > pand -c 00:20:E0:73:EB:F7 -n --role PANU
> > 
> > and after some messages in hcidump on both sides,
> I receive:
> > pand[1431]: Bluetooth PAN daemon
> > pand[1431]: Connecting to 00:20:E0:73:EB:F7
> > pand[1431]: Connect to 00:20:E0:73:EB:F7 failed.
> Function not implemented(38)
> 
> try it without the --master and --role parameters. I
> think you forgot to
> enable the role switch (rswitch) on both sides.
> 
> Regards
> 
> Marcel



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
