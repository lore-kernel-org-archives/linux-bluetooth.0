Return-Path: <cyrus@holtmann.org>
Message-Id: <4A619A8D-9BE8-4082-B28E-4F3EC19A6546@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20080815T133352-774@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Date: Fri, 15 Aug 2008 19:26:39 +0200
References: <loom.20080815T133352-774@post.gmane.org>
Subject: Re: [Bluez-devel] How to know the packet loss ratio of SCO socket
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

Hi Jui-Hao,

> as the title said, I am writing a simple server-client socket  
> program for SCO
> connection. While client is sending the SCO packet to server, it  
> attaches a
> sequence number to it. Then I want server to estimate the packet loss.
> [Client program is as the following]
> for (i = 0; i < 48, i++) buf[i] = 0x7f;
> while (1) {
>  *(uint32_t *)buf = htobl(seq);
>  *(uint32_t *)(buf+4) = htobs(48);
>  if (send(sockfd, buf, 48, 0) < 0) break;
>  seq++;
>  usleep(1)
> }
>
> However, on the server side, the data is total different, and I am  
> not able to
> get the sequence number (the hcidump -x also shows different data  
> content as I
> expect. Also, it's weird that the content is repeated)
>
> Is this data encoded? or is there anyway to know the packet loss  
> ratio of the
> SCO connection?

SCO are voice connections and they are CVSD encoded. It is not a  
reliable data transport. Use L2CAP or RFCOMM for that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
