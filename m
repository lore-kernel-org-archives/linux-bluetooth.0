Return-Path: <dwmw2@infradead.org>
Subject: Re: [Bluez-devel] Re: [BUG] BlueTooth socket busted in 2.6.0-test5
From: David Woodhouse <dwmw2@infradead.org>
To: jt@hpl.hp.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063344094.7869.396.camel@imladris.demon.co.uk>
References: <20030910225810.GA7712@bougret.hpl.hp.com>
	 <1063237174.28890.6.camel@pegasus>
	 <20030911203249.GA15575@bougret.hpl.hp.com>
	 <1063344094.7869.396.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1063354754.23778.380.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 12 Sep 2003 09:19:15 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2003-09-12 at 06:21 +0100, David Woodhouse wrote:
> Er, if we're actually _running_ code from the bnep module, how can it
> have a zero refcount? This bug is elsewhere, surely?

Please confirm this fixes it...

===== net/bluetooth/bnep/sock.c 1.11 vs edited =====
--- 1.11/net/bluetooth/bnep/sock.c	Thu Jun  5 01:57:08 2003
+++ edited/net/bluetooth/bnep/sock.c	Fri Sep 12 09:16:17 2003
@@ -186,7 +189,8 @@
 
 static struct net_proto_family bnep_sock_family_ops = {
 	.family = PF_BLUETOOTH,
-	.create = bnep_sock_create
+	.create = bnep_sock_create,
+	.owner = THIS_MODULE
 };
 
 int __init bnep_sock_init(void)


-- 
dwmw2
