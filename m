Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Fri, 13 Feb 2004 10:23:03 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402130917.46561.jeffs@fairwayacademy.org> <1076682121.2671.53.camel@pegasus>
In-Reply-To: <1076682121.2671.53.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402131023.03974.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Friday 13 February 2004 09:22, Marcel Holtmann wrote:
> > /bin> hcitool info 00:0A:4F:00:09:5E
> > Requesting information ...
> > bcsp_timed_event: Timeout, retransmitting 1 pkts
> > Can't create connection: Input/output error
> > pid 54: failed 256
> >
> > bcsp_timed_event: is a kernel error msg.  I should probably try to set up
> > an l2test session properly next.  Any advice?
>
> with the next update of the BCSP driver I will turn this into a debug
> message.
>
> Using l2test is easy and with -h you see all the options ;)
>
> 	One side:	l2test -r	/* listen and receive */
> 	Other side:	l2test -s	/* connect and send */

Hmmm...
[root@Arwen test]# ./l2test -w
l2test[29184]: Waiting for connection on psm 10 ...

/bin> l2test -r
l2test[79]: Waiting for connection on psm 10 ...

and there they sit, nothing happening.  The SCO test works fine going either 
way, however.  It seems that on the ColdFire board most of the hcitool 
commands fail with some kind of 'HCI...timeout' error.

Note that from ColdFire, this fails:
/bin> hcitool cc --role=s 00:0A:4F:00:09:5E
bcsp_timed_event: Timeout, retransmitting 1 pkts
Can't create connection: Input/output error

/bin> hcitool con
Connections:

But from the pc, I get this:
[root@Arwen test]# hcitool cc --role=m 00:0A:4F:00:13:5F
Can't create connection: Connection timed out

But now running 'hcitool con' on Coldfire gives this:
/bin> hcitool con
Connections:
        > ACL 00:0A:4F:00:09:5E handle 40 state 1 lm SLAVE

and from the pc:
[root@Arwen test]# hcitool con
Connections:
        < ACL 00:0A:4F:00:13:5F handle 41 state 1 lm MASTER

So it seems that hcitool <> hcid, or userland <> kernel is messed up on 
ColdFire, is that correct?  Remember I'm still a newbie at this...

Regards,
-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
