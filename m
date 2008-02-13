Return-Path: <cyrus@holtmann.org>
From: Jesus Hinojosa <jhr0771@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 13 Feb 2008 12:44:47 -0600
Message-Id: <1202928287.29698.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] want to use more than one profile
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

I have a MBT-S120 headset that works fine with skype using the the voice
profile.

.asoundrc

defaults.pcm.dmix_max_periods -1 
pcm.bluetooth {
   type bluetooth
   device 00:0D:1A:40:0C:9E
   profile "voice"   
}

But the headset works great for listening to music with the hifi
profile. but If i switch to the hifi profile ( or use "auto" ), the
headset stops working for skype. 
Is there a way to make it work for applications without having to edit
the file everything i want to switch?
Is it possible to have 2 configurations pointing to the same device ?

defaults.pcm.dmix_max_periods -1 
pcm.headset {
   type bluetooth
   device 00:0D:1A:40:0C:9E
   profile "voice"   
}
pcm.headphones {
   type bluetooth
   device 00:0D:1A:40:0C:9E
   profile "hifi"   
}

Any help will be appreciated.

I have bluez 3.25 
kernel: gentoo-sources 2.6.20 

Thanks


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
