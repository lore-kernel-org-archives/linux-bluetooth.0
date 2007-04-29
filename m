Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Klaus <projectu@gmail.com>
Date: Sun, 29 Apr 2007 12:34:38 +0000 (UTC)
Message-ID: <loom.20070429T141323-596@post.gmane.org>
References: <20070415095728.GA6212@ifup.org>
	<20070424184826.GD6853@torres.zugschlus.de>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	=?utf-8?q?Unable_to_set_number_of_SCO_buffers_=3A_p?=
	=?utf-8?q?lease=09upgrade_your_Kernel_!?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marc Haber <mh+bluez-devel <at> zugschlus.de> writes:
[...]
> I still have the same problem. Only that
> the "Unable to set number of SCO buffers" error message now has
> pcm_sco.c:277 as line number.

I have the same problem on 2.6.21 with the patch applied.

I looked a little into the problem and it appears that everything is actually
working as it is intended - but that doesn't help us much.

In plugz/../pcm_sco.c: sco_headset_hw_params(), 
   setsockopt(...,SOL_SCO,...) is called, but it fails with ENOPROTOOPT
"Protocol not available".

   setsockopt() for protocol level SOL_SCO is implemented in the kernel in
net/bluetooth/sco.c: sco_sock_setsockopt(), but this function only does one
thing - it returns ENOPROTOOPT:

...
        switch (optname) {
        default:
                err = -ENOPROTOOPT;
                break;
        }
...

I am a bit curious - how can this work for anybody?

BR, Klaus






-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
