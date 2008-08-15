Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Fri, 15 Aug 2008 18:50:43 +0000 (UTC)
Message-ID: <loom.20080815T184330-967@post.gmane.org>
References: <loom.20080815T133352-774@post.gmane.org>
	<4A619A8D-9BE8-4082-B28E-4F3EC19A6546@holtmann.org>
Mime-Version: 1.0
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

Hi, Marcel
> 
> SCO are voice connections and they are CVSD encoded. It is not a  
> reliable data transport. Use L2CAP or RFCOMM for that.
> 
> Regards
> 
> Marcel

I think you are right.
My original purpose is to test the voice quality when 12 SCO server-client pairs
are running in the same room (which means 12 small piconets contending the
channel, although each pair has its own frequency hopping pattern).

Is there any good way to gather the voice quality information? (actually I don't
know how to tell a voice qualify is "acceptable" to human ears. is there any
good references?)

Thanks,
Jui-Hao


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
