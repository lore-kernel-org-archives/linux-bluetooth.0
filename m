Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309231409.47300.justin-qt@affinix.com>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309230508.07932.justin-qt@affinix.com>
	<1064319593.1619.10.camel@pegasus>
	<200309231409.47300.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1064353054.1620.40.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 23 Sep 2003 23:37:28 +0200

Hi Justin,

> This is unfortunate, as it pretty much rules out this ever being fixed on the 
> Zaurus.  Do you think this problem is really a bug in the PCMCIA subsystem?
> 
> From my work the other day, it appears that the card is not properly being 
> reset.  In fact, you can break the driver by running 'cardctl reset'.  This 
> used to leave bluez in a funny state: hci0 still considered UP, but 'hcitool 
> scan' would hang or return odd results.
> 
> One thing I tried was unregistering / registering the hci dev in response to a 
> pcmcia reset event.  This would clean things out on the bluez end, such that 
> 'hcitool scan' would exit immediately saying there is no device.  This is 
> correct, as 'hciconfig' would report the device as DOWN.  Issuing 'hciconfig 
> hci0 up' would timeout.  Interestingly, it seems bluez tries to bring the 
> card up automatically, which is kind of cool (when I 'hciconfig' shortly 
> after 'cardctl reset', I would see the state as "DOWN INIT RUNNING" or some 
> such, and then moments later just "DOWN").
> 
> So it seems what needs to be done is for the card to be reset completely.  I 
> don't know what kind of state 'cardctl reset' leaves the card in.  It looks 
> like it is a serial-based interface to the card, so even being off by one 
> byte could be a problem.  Perhaps the card still considers itself to be 
> active and in mid-use, and so reregistering the hci dev causes bluez and the 
> card to become out of sync.  Unlike other hardware, such as memory cards, a 
> bluetooth card is pretty much unusable after a suspend, so I think a full 
> reset (of both bluez and the card itself) is in order.
> 
> To reset the card, I tried calling: dtl1_release, dtl1_config.  This didn't 
> appear to solve anything.  Then I tried putting that into the insertion event 
> code, so it became "config, release, config".  This failed also, making the 
> driver unusable even upon card insert.  This seems to imply that your code is 
> not doing proper cleanup or resetting.  Shouldn't it be safe to call "config, 
> release, config, release, config, release, etc" any number of times?

the main problem is the reset of the card itself. I actually don't know
how to do this and I don't have the specs for this card. If you suspend
you also have to suspend the HCI device and resume it have resume. In
general a up/down toggle should work here. You can use hci_suspend_dev()
and hci_resume_dev() in conjunction with hotplug (bluetooth.agent) for
this job. But as you already noticed, you have to bring the UART on the
card in the correct state so that can it be reinit after resume.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
