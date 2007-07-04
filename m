Return-Path: <ralferoo@gmail.com>
Message-ID: <18a15270707040005r1ae84072xecbb0b841e00a8aa@mail.gmail.com>
Date: Wed, 4 Jul 2007 08:05:34 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Cbe-oss-dev] [Bluez-devel] [PATCH] bluetooth: reset unexpected connections
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        cbe-oss-dev@ozlabs.org
In-Reply-To: <1183514113.6351.53.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_111963_28954608.1183532734333"
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
	 <1183433306.6351.19.camel@aeonflux.holtmann.net>
	 <18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
	 <1183514113.6351.53.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_111963_28954608.1183532734333
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again

> > I'm pretty new to both bluetooth and HID in general, [...]

> That you don't see no packets on HCI doesn't mean that no packets are
> sent from the remote device anymore.

That appears to be a critical point I haven't yet figured out.

I've been trying to understand the minimum of bluetooth stack, HCI, USB,
HID, protocol descriptors, etc to try to figure out how to get the blu-ray
remote working (another issue) but I'm still getting my head around how all
the bits fit together as, for instance, it took a while to figure out how
the PS3 controller seemed to "just work"... :)

This was just a problem I discovered along the way, which seemed to have a
simple fix. If it's wrong, I'm happy to leave it to someone who knows
better! Geoff knows about the issue now, so I guess when he revisits the
bluetooth stuff, he might find a better solution to the problem.

> And there is no way to send a reset to a remote device. Period.

I'd like to figure out what's going on though, as the lights stop flashing
on the device when we do this local reset. Maybe it changes some lower level
state so packets are NAK'd instead, but I'd like to understand that process
in that case.

> > Additionally, because the linux subsystem hasn't connected with them
> > at this point, there's no way of initiating a connection with them or
> > stopping them:
> That makes no sense. The HID devices can re-connect. However they have
> to indicate this via requesting a ACL connection. Otherwise we can't
> know what to do with the data packets.

My understanding is that the controller believes it is already connected and
so it never tries to reconnect and instead just keeps sending data.

Maybe a reconnection does occur at some layer below ACL that I don't
understand yet, but I thought ACL was the lowest layer, so I've not been
looking for that.

>It is not a DoS, because you have to connect it first. And obviously you
> told your PS3 remote controller to user your system.

Looking back at the logs, I see that the messages do start around the time
hcid is loaded (which is set to autoconnect without authentication), so
maybe it has actually established a channel by that point.

There's nothing in the logs about a connection and hcitool doesn't list
anything, but I've not enough experience with other devices to know what's
actually going on.

Thanks for your input - I suspect I've got a lot of learning about bluetooth
to come...

Cheers,
   Ralf.

------=_Part_111963_28954608.1183532734333
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again<br><br><div><span class="gmail_quote">&gt; </span>&gt; I&#39;m pretty new to both bluetooth and HID in general, [...]<br><div><br>&gt; That you don&#39;t see no packets on HCI doesn&#39;t mean that no packets are
<br>&gt; sent from the remote device anymore. <br><br>That appears to be a critical point I haven&#39;t yet figured out. <br><br>I&#39;ve been trying to understand the minimum of bluetooth stack, HCI, USB, HID, protocol descriptors, etc to try to figure out how to get the blu-ray remote working (another issue) but I&#39;m still getting my head around how all the bits fit together as, for instance, it took a while to figure out how the PS3 controller seemed to &quot;just work&quot;... :)
<br><br>This was just a problem I discovered along the way, which seemed to have a simple fix. If it&#39;s wrong, I&#39;m happy to leave it to someone who knows better! Geoff knows about the issue now, so I guess when he revisits the bluetooth stuff, he might find a better solution to the problem.
<br><br>&gt; And there is no way to send a reset to a remote device. Period.<br></div><div><br>I&#39;d like to figure out what&#39;s going on though, as the lights stop flashing on the device when we do this local reset. Maybe it changes some lower level state so packets are NAK&#39;d instead, but I&#39;d like to understand that process in that case. 
<br><br>&gt; &gt; Additionally, because the linux subsystem hasn&#39;t connected with them<br>&gt; &gt; at this point, there&#39;s no way of initiating a connection with them or<br>&gt; &gt; stopping them:<br>&gt; That makes no sense. The HID devices can re-connect. However they have
<br>&gt; to indicate this via requesting a ACL connection. Otherwise we can&#39;t<br>&gt; know what to do with the data packets.</div><div><br>My understanding is that the controller believes it is already connected and so it never tries to reconnect and instead just keeps sending data. 
<br><br>Maybe a reconnection does occur at some layer below ACL that I don&#39;t understand yet, but I thought ACL was the lowest layer, so I&#39;ve not been looking for that.<br>&nbsp;<br>&gt;It is not a DoS, because you have to connect it first. And obviously you
<br>&gt; told your PS3 remote controller to user your system.<br><br>Looking back at the logs, I see that the messages do start around the time hcid is loaded (which is set to autoconnect without authentication), so maybe it has actually established a channel by that point. 
<br><br>There&#39;s nothing in the logs about a connection and hcitool doesn&#39;t list anything, but I&#39;ve not enough experience with other devices to know what&#39;s actually going on.<br></div></div><br>Thanks for your input - I suspect I&#39;ve got a lot of learning about bluetooth to come...
<br><br>Cheers,<br>&nbsp;&nbsp; Ralf.<br>

------=_Part_111963_28954608.1183532734333--
