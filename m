Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
Date: Mon, 13 Sep 2004 16:54:59 -0700
Message-ID: <002a01c499ed$143282d0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <002101c499d3$15ea43c0$1a01010a@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

I just noticed that bluez_accept_unlink() was called with a socked that was
in state BT_CLOSED, so it can't be the second if(). It would have been
called from the first if().

Clearly, I'm on glue.

Still, does the order of bluez_accept_unlink() and sock_release() matter?

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Daryl Van Vorst
> Sent: September 13, 2004 1:49 PM
> To: 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Rfcomm use count
> 
> 
> Marcel,
> 
> Turned on debugging in af_bluetooth.c, and it may reveal the issue...
> 
> This time the socket left in /proc is: c39bb6a0
> The syslog messages are attached.
> 
> Snippet from /var/log/messages (I added a debug line in 
> rfcomm_sock_accept
> to print the error code):
> May 28 11:26:06 jack-00000000 syslog.info klogd:
> bluez_accept_dequeue_R6c5dc344: parent c3a81060
> May 28 11:26:06 jack-00000000 syslog.info klogd: 
> bluez_accept_unlink: sk
> c39bb6a0 state 9
> May 28 11:26:06 jack-00000000 syslog.info klogd: 
> rfcomm_sock_sendmsg: sock
> c399c910, sk c3ad43e0
> May 28 11:26:06 jack-00000000 syslog.info klogd: 
> rfcomm_sock_accept: error
> -512
> 
> So bluez_accept_unlink() is getting called. But if the socket 
> was really
> unlinked, it wouldn't be in /proc, would it?
> 
> Could the problem be the order of release_sock() and 
> bluez_accept_unlink()
> in the second if() in the code snippet from af_bluetooth.c below?
> Specifically, does bluez_accept_unlink() need to be called on 
> an unlocked
> socket?
> 
> Thanks,
> 
> -Daryl.
> 
> struct sock *bluez_accept_dequeue(struct sock *parent, struct socket
> *newsock)
> {
> 	struct list_head *p, *n;
> 	struct bluez_pinfo *pi;
> 	struct sock *sk;
> 	
> 	BT_DBG("parent %p", parent);
> 
> 	list_for_each_safe(p, n, &bluez_pi(parent)->accept_q) {
> 		pi = list_entry(p, struct bluez_pinfo, accept_q);
> 		sk = bluez_sk(pi);
> 		
> 		lock_sock(sk);
> 		if (sk->state == BT_CLOSED) {
> 			release_sock(sk);
> 			bluez_accept_unlink(sk);
> 			continue;
> 		}
> 		
> 		if (sk->state == BT_CONNECTED || !newsock) {
> 			bluez_accept_unlink(sk);
> 			if (newsock)
> 				sock_graft(sk, newsock);
> 			release_sock(sk);
> 			return sk;
> 		}
> 		release_sock(sk);
> 	}
> 	return NULL;
> }
> 
> 
> > -----Original Message-----
> > From: bluez-devel-admin@lists.sourceforge.net 
> > [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> > Daryl Van Vorst
> > Sent: September 13, 2004 12:06 PM
> > To: 'Marcel Holtmann'
> > Cc: 'BlueZ Mailing List'
> > Subject: RE: [Bluez-devel] Rfcomm use count
> > 
> > 
> > Hi Marcel,
> > 
> > I have attached a log for you to look at if you have some 
> > time. If not,
> > maybe just answer my question below. :)
> > 
> > Here's what I see:
> > 
> > One stray socket. I added the socket pointer to the proc output.
> > Proc/bluetooth/rfcomm:
> > sk  2C:02:5F:16:05:00 3A:A4:58:16:05:00 9 1 c3b69340
> > 
> > I have a setup where I kill my app after a random time 
> interval while
> > several devices are connecting, disconnecting, and 
> > transfering data, etc.
> > 
> > Here's a brief version of the log:
> > 
> > 1. Program gets kill signal (time 15:09:30)
> > 2. HCI devices get shut down
> > 3. Some data remaining for transmission is sent.
> > 4. One listen socket is closed (I think this is the one which 
> > is not being
> > used)
> > 5. Some sockets/dlcs get closed
> > 6. An incomming connection is received (rfcomm_connect_ind is 
> > called, and a
> > socket is created which matches the one in proc)
> > 7. Some more sockets/dlcs get closed
> > 8. The listen (probably the one which is being used) gets closed
> > 
> > I don't see any lines from rfcomm_sock_accept after the 
> > rfcomm_connect_ind
> > line. And rfcomm_sock_release is never called for the new 
> connection.
> > 
> > My knowledge here is limited, and I may be mis-interpreting 
> > the log. But it
> > appears that a socket is allocated for the new connection as 
> > long as there
> > is room in the wait queue. And if that connection is never 
> > accepted, is it
> > the job of rfcomm_sock_cleanup_listen() to deal with it? That 
> > is, it is not
> > the kernel's duty (outside of the rfcomm module) to deal with 
> > the allocated
> > socket?
> > 
> > So, I think, it appears that rfcomm_sock_cleanup_listen isn't 
> > working right.
> > 
> > Not sure if rfcomm_sock_accept is still looping or not while 
> > this is going
> > on.
> > 
> > More digging needed...
> > 
> > Thanks,
> > 
> > -Daryl.
> > 
> > > -----Original Message-----
> > > From: Daryl Van Vorst [mailto:daryl@wideray.com] 
> > > Sent: September 13, 2004 9:37 AM
> > > To: 'Marcel Holtmann'
> > > Subject: RE: [Bluez-devel] Rfcomm use count
> > > 
> > > 
> > > Hi Marcel,
> > > 
> > > > I haven't had time to look at your problem in the last 
> > two weeks and
> > > > dealing with ARM related stuff still not fits into my left 
> > > > free time for
> > > > the next weeks. Is this behaviour reproduceable on x86 
> > > machines and do
> > > > you have a small text program to trigger this effect? And 
> > > > what I really
> > > > care about, is this problem also available with a 2.6 kernel?
> > > 
> > > Thanks for the response.
> > > 
> > > I have not yet tried to reproduce it on an x86. And 
> > > unfortunately I don't have a good way to trigger the effect. 
> > > I have spent quite a lot of time trying to come up with a 
> > > simple way (or any way) to reliably reproduce the problem. 
> > > Depending on how the next while plays out, I may try to 
> > > reproduce it on an x86.
> > > 
> > > I would like to be working with a 2.6 kernel, but time 
> > > constraints have prevented moving to it (would require 
> > > porting drivers). Maybe on an x86 if time permits.
> > > 
> > > I'm currently sifting through RFCOMM debug output. When I get 
> > > something interesting I'll send it along. I should have 
> > > something shortly.
> > > 
> > > -Daryl.
> > > 
> > > 
> > 
> 
