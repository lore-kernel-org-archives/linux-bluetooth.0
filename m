Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4aaa2e1c04121406315ecf8659@mail.gmail.com>
From: Wartan Hachaturow <wartan.hachaturow@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] HSP and audio -- "right thing" to look at?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 14 Dec 2004 17:31:20 +0300

Hello.

First of all, thanks for a great job.

Second, a question. 
As far as I see, most development on audio transmission is happening
at bluetooth-alsa, which is a separate project from bluez (right?).
Having read the mailing list, I didn't quite understand the
development direction that bluez would like to follow "mainstream"
implementing audio and headset profiles, and if things now being
implemented by bluetooth-alsa are "Right Way".

I would be really thankful if someone would summarize the TODOs for
bluez on that matter (like what should be a kernel module, what should
be a userland application, what is good about current snd_bt_sco, and
what is bad), so that I could prepare myself for development on those
subjects in a more "clever" way -- since now I'm pretty lost in the
code and ideas..

-- 
Thanks in advance, Wartan.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
