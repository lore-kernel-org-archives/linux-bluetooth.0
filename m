Return-Path: <cyrus@holtmann.org>
Message-ID: <18b477210712110334m421078c1w3e806c4de9590ac7@mail.gmail.com>
Date: Tue, 11 Dec 2007 11:34:39 +0000
From: "=?UTF-8?Q?Paulo_K=C3=B6ch?=" <paulo.koch@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <951351190712101634r5de429c0u6a95fa2a727f20a3@mail.gmail.com>
MIME-Version: 1.0
References: <951351190712101634r5de429c0u6a95fa2a727f20a3@mail.gmail.com>
Subject: Re: [Bluez-devel] how to create a stable l2cap
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I had a similar problem. Do you keep the programs on both ends running?

On Dec 11, 2007 12:34 AM, Jason Zhan <zhan.jason@gmail.com> wrote:
> Hey, folks
>
> I am afraid this is a very old topic, but when I read through the whole mail
> list. I cannot find a suitable solution.
>
> In my case, I intend to build only l2cap connection between PC and mobile
> phone for testing purpose.
>
> The part of code is as follows:
>
>     // allocate a socket
>     s = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
>
>     // set the connection parameters (who to connect to)
>     addr.l2_family = AF_BLUETOOTH;
>
>     //set psm port and MAC of remote device
>     psm = atoi(argv[2]);
>     addr.l2_psm = htobs(psm);
>     str2ba(argv[1], &addr.l2_bdaddr);
>
>     // connect to server
>     /* Set link mode */
>     //struct linger l = { .l_onoff = 1, .l_linger = 20000 };
>     //status = setsockopt(s, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
>
>      /* Set link manage mode */
>     opt = L2CAP_LM_RELIABLE;
>     status = setsockopt(s, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt));
>
>     if (status < 0)
>       printf("Can't set L2CAP link mode\n)");
>
>     status = connect(s, (struct sockaddr *)&addr, sizeof(addr));
>
>
> Most of the source codes is followed l2test.c.  As usual, the connection can
> be created, however after only few seconds, from hcidump, I can find a HCI
> disconnect command is sent and the connection is automatically disconnected.
>
> Some previous discussion mentioned:
> "The kernel will create the needed ACL link for you and take fully care of
> it."
> "If you try to mess around with connection reference counting of the ACL the
> kernel will always win and simply disconnect the link if it thinks it is no
> longer needed."
>
> It seems whatever I do, I cannot keep the l2cap connection stable, since the
> kernel will disconnect the l2cap connection if it thinks it is not needed.
>
> I am not familiar with the bluez kernel mechanism, so could anybody provide
> me a clear solution to sort it out.
>
> Thank you for all your help,
> Jason
>
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
