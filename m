Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN and kernel 2.4.26
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastian Ballmann <Crazydj@chaostal.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088423529.2513.15.camel@espy.crazydj.de>
References: <1088271695.29447.5.camel@espy.crazydj.de>
	 <1088364052.3774.67.camel@pegasus>
	 <1088372482.2430.4.camel@espy.crazydj.de>
	 <1088406110.3774.91.camel@pegasus>
	 <1088413956.2508.3.camel@espy.crazydj.de>
	 <1088414347.3774.170.camel@pegasus>
	 <1088418472.2513.6.camel@espy.crazydj.de>
	 <1088419003.3774.179.camel@pegasus>
	 <1088423529.2513.15.camel@espy.crazydj.de>
Content-Type: text/plain
Message-Id: <1088427485.3774.203.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Jun 2004 14:58:05 +0200

Hi Bastian,

> > remove the security patch and try again.
> 
> Same effect.

I don't think so, because I looked at the patch and this seems to
introducing the problem:

diff -urPX nopatch linux-2.4.26/net/socket.c linux/net/socket.c
--- linux-2.4.26/net/socket.c   Fri Feb 20 10:07:45 2004
+++ linux/net/socket.c  Sat Apr 17 02:13:55 2004
@@ -1307,10 +1307,18 @@
 asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
 {
        int err;
+       int len;
        struct socket *sock;
 
        if ((sock = sockfd_lookup(fd, &err))!=NULL)
        {
+               /* XXX: insufficient for SMP, but should be redundant anyway */
+               if (get_user(len, optlen))
+                       err = -EFAULT;
+               else
+               if (len < 0)
+                       err = -EINVAL;
+               else
                if (level == SOL_SOCKET)
                        err=sock_getsockopt(sock,level,optname,optval,optlen);
                else

And here is the fix for pand to also work with the patch:

diff -u -r1.4 main.c
--- main.c      31 May 2004 22:21:42 -0000      1.4
+++ main.c      28 Jun 2004 10:56:35 -0000
@@ -136,6 +136,7 @@
        }
 
        /* Setup L2CAP options according to BNEP spec */
+       olen = sizeof(l2o);
        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &olen) < 0) {
                syslog(LOG_ERR, "Failed to get L2CAP options. %s(%d)",
                                strerror(errno), errno);
@@ -257,6 +258,7 @@
        }
 
        /* Setup L2CAP options according to BNEP spec */
+       olen = sizeof(l2o);
        getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &olen);
        l2o.imtu = l2o.omtu = BNEP_MTU;
        setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o));

I committed this one already to CVS, because it is an obvious fix.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
