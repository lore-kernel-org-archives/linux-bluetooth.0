Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Fri, 13 Feb 2004 09:17:46 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <1076631244.2671.16.camel@pegasus>
In-Reply-To: <1076631244.2671.16.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402130917.46561.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Thursday 12 February 2004 19:14, Marcel Holtmann wrote:
> Hi Jeff,
<snip>

> > /> hcitool info 00:0A:4F:00:09:5E
> > Requesting information ...
> > bcsp_timed_event: Timeout, retransmitting 1 pkts
> > Can't create connection: Input/output error
>
> This can mean many things. Try using l2ping or l2test. Can you run
> hcidump on the ColdFire board?

l2ping from either end works.  I didn't cross-compile hcidump for the ColdFire 
board, need to do some makefile wizardry in the parser subdir first.  l2test 
on both ends just sits there waiting for something, no doubt I'm not invoking 
it properly.  hcidump on the pc end shows the ping packets arriving from 
ColdFire.  I guess my connection is basically working.  On the ColdFire 
board:
/bin> hciconfig
hci0:   Type: UART
        BD Address: 00:0A:4F:00:13:5F ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:289 acl:0 sco:0 events:14 errors:0
        TX bytes:554 acl:0 sco:0 commands:14 errors:0

But invoking hcitool still yields:
/bin> hcitool info 00:0A:4F:00:09:5E
Requesting information ...
bcsp_timed_event: Timeout, retransmitting 1 pkts
Can't create connection: Input/output error
pid 54: failed 256

bcsp_timed_event: is a kernel error msg.  I should probably try to set up an 
l2test session properly next.  Any advice?

Thanks,
-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
