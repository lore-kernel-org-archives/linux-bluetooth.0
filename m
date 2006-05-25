Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4475CE30.7080109@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] report on new bluez headset
References: <446CDD43.3050604@free.fr> <446F383A.1040605@ens.fr> <4470B491.7040004@free.fr> <4470C77A.2080006@ens.fr> <4475C22B.9080908@free.fr>
In-Reply-To: <4475C22B.9080908@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 25 May 2006 09:33:04 -0600

Fabien

>> Yes, exactly. If I close the headset during a conversation then ekiga
>> completely freezes.
> 
> 
> For now this is not supported :-)
> 
> In the long run it should be possible to tell ekiga that the headset has
> closed, however this would require some king of communication between
> headsetd and ekiga -- i'm not there yet :-(

this is only going to work if egika will listen for dbus events to that
effect. alsa provides nothing for signaling.

>> But the sound is not perfect. I hear some frying sound (un petit
>> gresillement), not very disturbing though but it is absent when I use
>> it with Ekiga.
> 
> I noticed that. It's not perfect yet.
> I'm currently working on improving voice quality in general, but i looks
> it will end up with a kernel patch.

We've had quality problems that might be attributed to improperly pacing
the data sent through sco. I am not sure what the kernel provides--if
anything--in terms of timing.

What kind of kernel patch you are looking into?

>>>> - the device does not appear in the alsa mixer

alsa has two ways to look for devices. plugins do not show up using the
api everyone is used to unfortunately.

Brad


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
