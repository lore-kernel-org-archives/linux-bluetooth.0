Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <48BEE75C.9050008@free.fr>
References: <48BEE75C.9050008@free.fr>
Date: Wed, 03 Sep 2008 21:49:37 +0200
Message-Id: <1220471377.6714.52.camel@californication>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding Sony Ericsson
	headsets: kernel	patch proposal.
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

Hi Fabien,

> Due to job requirement, I recently fined tuned a kernel to work well 
> with some Sony Erisson A2DP Headsets (namely Motorola HBH-DS970 and 
> HBH-DS980): this means making sure to force the other side to exit sniff 
> mode early on before the AVDTP signalling comes into play.
> 
> If i remember well we had a talk a while ago about the way the sniff 
> mode was handled by the kernel due to various issues with some bluetooth 
> keyboards. The conclusion we had at that time, the best way to handle 
> this issue was to add a socket option on an L2CAP channel to force the 
> other side to exit sniff mode even if it was the one who initially 
> entered the sniff mode.
> 
> I used this approach and wrote & tested a patch against 2.6.26-mh3. 
> Patch is attached and seems to solve the issue.
> 
> *but*
> 
> During validation testing we found yet another issue that seems to be 
> related to the way we handle the sniff mode.
> The syndrom is that if the user screws up at enterring the pin code 
> during pairing bluez fails to close the acl connection properly,
> which means subsequent attempts result in a "connection already exist" 
> error. From the user point of view it is impossible to try to pair again 
> to the same headset...which is quite annoying.

retest with 2.6.27-rc5 since that has full Simple Pairing support and is
the kernel version that counts.

Also this is not BlueZ screwing anything up. Where is written that we
have to get out of sniff mode before we can disconnect a link. What kind
of hardware are you using? Does BlueZ always have to cleanup after
broken hardware and f*cked up stacks?

> Conclusion: to have those bloody Sony Erisson headsets working we have 
> to change two things in the kernel:
>   1) Provide a way for a L2CAP socket user to alter sniff mode exit 
> behaviour
>   2) Make sure we exit sniff mode before to disconnect
> 
> Question 1: Are you interested in reviewing then merging my patches if i 
> try to fix thoses issues ?
> Question 2: I have the gut feeling that we should change default 
> behaviour to the behaviour required by those headsets, and provide a 
> socket option for the bluetooth HID, rather than the other way round. 
> What do you think ?
> 
> If we can come on an agreement on the proper way to fix this issue then 
> i should come with a patch in a 3-4 days timeframe.

Make it two separate patches. We can send the exit sniff mode command
that is not a problem. I still don't like it, because it is the job of
the Link Manager to do this.

For the sniff mode setting you have to use SOL_BLUETOOTH since I will
remove all the other SOL_* and consolidate them.

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
