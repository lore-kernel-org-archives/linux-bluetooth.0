Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455C95AB.8030800@xmission.com>
Date: Thu, 16 Nov 2006 09:45:31 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>
	<455C8857.9050008@xmission.com>
	<1163692996.5169.67.camel@localhost>
In-Reply-To: <1163692996.5169.67.camel@localhost>
Subject: Re: [Bluez-devel] audio & dbus
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

Marcel

> This will be up to ALSA or GStreamer. It is not the job of the audio
> daemon to handle non-Bluetooth stuff.

Ok.

>> 		void RingHeadset()
>>
>> 			Indicate a single RING to the connected headset.
> 
> No need to do this. This should be handled automatically via Play or
> some other method.

Play will always open the sco channel without waiting for the user to 
hit the button so it can't be overloaded to do ringing.

Would you like it better if we used a ringing state instead of sending a 
single ring? Should custom ring (open sco, send ring sound, wait for 
button press) and HSP ring (send RING on rfcomm channel) be combined 
together somehow?

>> 		void PressHeadsetButton()
>>
>> 			Indicate a button press to the connected audio
>> 			gateway.
> 
> Unneeded. We are not in the role of a headset.

right. I will save this for org.bluez.AudioGateway or whatever we call it.

That brings up another question. Do you want one interface to do 
handsfree  and headset or do we have one interface for each? I was 
imagining combining them but I need to read through HFP to be sure.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
