Return-Path: <cyrus@holtmann.org>
Message-ID: <48382933.3030209@earthlink.net>
Date: Sat, 24 May 2008 09:41:55 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <mailman.308836.1211604429.29930.bluez-users@lists.sourceforge.net>
	<1211618718.4244.27.camel@goya.uc3m.es>
In-Reply-To: <1211618718.4244.27.camel@goya.uc3m.es>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 25, Issue 18
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 05/24/2008 03:45 AM, Javi F Gorostiza wrote:
> Hello,
> I've parched and compiled the kernel-2.6.23.17 to get headsetd working.
> And everything is allright BUT one detail. When I open an alsa pcm_sco
> device to capture the data form a BT headset, in the console a lot of
> DEBUG messages arises. They are so much that the functionality of my
> application decreases, and I cannot see the usefull information in the
> console...it's really horrible.
> I think that all those DEBUG messages are relationated with an option in
> the kernel (.config file) but I can find it at all.
> Does anybody know how to switch off these information, please?
> Thanks,
> J
> 

You can control what kernel messages get to the console by using the 
"dmesg" program. For example, try this:

dmesg -n4

By the way, your message was confusing because you replied to the digest 
message rather than to an individual message in the digest.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
