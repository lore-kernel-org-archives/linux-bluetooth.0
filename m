Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
Date: Mon, 13 Sep 2004 13:48:55 -0700
Message-ID: <002101c499d3$15ea43c0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0022_01C49998.698B6BC0"
In-Reply-To: <000e01c499c4$bd4482c0$1a01010a@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0022_01C49998.698B6BC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Marcel,

Turned on debugging in af_bluetooth.c, and it may reveal the issue...

This time the socket left in /proc is: c39bb6a0
The syslog messages are attached.

Snippet from /var/log/messages (I added a debug line in rfcomm_sock_accept
to print the error code):
May 28 11:26:06 jack-00000000 syslog.info klogd:
bluez_accept_dequeue_R6c5dc344: parent c3a81060
May 28 11:26:06 jack-00000000 syslog.info klogd: bluez_accept_unlink: sk
c39bb6a0 state 9
May 28 11:26:06 jack-00000000 syslog.info klogd: rfcomm_sock_sendmsg: sock
c399c910, sk c3ad43e0
May 28 11:26:06 jack-00000000 syslog.info klogd: rfcomm_sock_accept: error
-512

So bluez_accept_unlink() is getting called. But if the socket was really
unlinked, it wouldn't be in /proc, would it?

Could the problem be the order of release_sock() and bluez_accept_unlink()
in the second if() in the code snippet from af_bluetooth.c below?
Specifically, does bluez_accept_unlink() need to be called on an unlocked
socket?

Thanks,

-Daryl.

struct sock *bluez_accept_dequeue(struct sock *parent, struct socket
*newsock)
{
	struct list_head *p, *n;
	struct bluez_pinfo *pi;
	struct sock *sk;
	
	BT_DBG("parent %p", parent);

	list_for_each_safe(p, n, &bluez_pi(parent)->accept_q) {
		pi = list_entry(p, struct bluez_pinfo, accept_q);
		sk = bluez_sk(pi);
		
		lock_sock(sk);
		if (sk->state == BT_CLOSED) {
			release_sock(sk);
			bluez_accept_unlink(sk);
			continue;
		}
		
		if (sk->state == BT_CONNECTED || !newsock) {
			bluez_accept_unlink(sk);
			if (newsock)
				sock_graft(sk, newsock);
			release_sock(sk);
			return sk;
		}
		release_sock(sk);
	}
	return NULL;
}


> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Daryl Van Vorst
> Sent: September 13, 2004 12:06 PM
> To: 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Rfcomm use count
> 
> 
> Hi Marcel,
> 
> I have attached a log for you to look at if you have some 
> time. If not,
> maybe just answer my question below. :)
> 
> Here's what I see:
> 
> One stray socket. I added the socket pointer to the proc output.
> Proc/bluetooth/rfcomm:
> sk  2C:02:5F:16:05:00 3A:A4:58:16:05:00 9 1 c3b69340
> 
> I have a setup where I kill my app after a random time interval while
> several devices are connecting, disconnecting, and 
> transfering data, etc.
> 
> Here's a brief version of the log:
> 
> 1. Program gets kill signal (time 15:09:30)
> 2. HCI devices get shut down
> 3. Some data remaining for transmission is sent.
> 4. One listen socket is closed (I think this is the one which 
> is not being
> used)
> 5. Some sockets/dlcs get closed
> 6. An incomming connection is received (rfcomm_connect_ind is 
> called, and a
> socket is created which matches the one in proc)
> 7. Some more sockets/dlcs get closed
> 8. The listen (probably the one which is being used) gets closed
> 
> I don't see any lines from rfcomm_sock_accept after the 
> rfcomm_connect_ind
> line. And rfcomm_sock_release is never called for the new connection.
> 
> My knowledge here is limited, and I may be mis-interpreting 
> the log. But it
> appears that a socket is allocated for the new connection as 
> long as there
> is room in the wait queue. And if that connection is never 
> accepted, is it
> the job of rfcomm_sock_cleanup_listen() to deal with it? That 
> is, it is not
> the kernel's duty (outside of the rfcomm module) to deal with 
> the allocated
> socket?
> 
> So, I think, it appears that rfcomm_sock_cleanup_listen isn't 
> working right.
> 
> Not sure if rfcomm_sock_accept is still looping or not while 
> this is going
> on.
> 
> More digging needed...
> 
> Thanks,
> 
> -Daryl.
> 
> > -----Original Message-----
> > From: Daryl Van Vorst [mailto:daryl@wideray.com] 
> > Sent: September 13, 2004 9:37 AM
> > To: 'Marcel Holtmann'
> > Subject: RE: [Bluez-devel] Rfcomm use count
> > 
> > 
> > Hi Marcel,
> > 
> > > I haven't had time to look at your problem in the last 
> two weeks and
> > > dealing with ARM related stuff still not fits into my left 
> > > free time for
> > > the next weeks. Is this behaviour reproduceable on x86 
> > machines and do
> > > you have a small text program to trigger this effect? And 
> > > what I really
> > > care about, is this problem also available with a 2.6 kernel?
> > 
> > Thanks for the response.
> > 
> > I have not yet tried to reproduce it on an x86. And 
> > unfortunately I don't have a good way to trigger the effect. 
> > I have spent quite a lot of time trying to come up with a 
> > simple way (or any way) to reliably reproduce the problem. 
> > Depending on how the next while plays out, I may try to 
> > reproduce it on an x86.
> > 
> > I would like to be working with a 2.6 kernel, but time 
> > constraints have prevented moving to it (would require 
> > porting drivers). Maybe on an x86 if time permits.
> > 
> > I'm currently sifting through RFCOMM debug output. When I get 
> > something interesting I'll send it along. I should have 
> > something shortly.
> > 
> > -Daryl.
> > 
> > 
> 

------=_NextPart_000_0022_01C49998.698B6BC0
Content-Type: application/x-gzip;
	name="messages.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="messages.gz"

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

------=_NextPart_000_0022_01C49998.698B6BC0--
