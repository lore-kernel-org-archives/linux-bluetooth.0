Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050211223950.23217.qmail@web50203.mail.yahoo.com>
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [Bluez-users] btsco and headsets questions
To: Brad Midgley <bmidgley@xmission.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <420CE4EA.8060409@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 11 Feb 2005 14:39:49 -0800 (PST)


--- Brad Midgley <bmidgley@xmission.com> wrote:

> Paul
> 
> > I was playing with btsco and my bt headset, and I noticed that as long as
> > btsco is connected, the headset is active and there is SCO traffic even
> > if the alsa device is not used by anything.
> > This means that the headset has no chance to enter idle mode in order to
> > save power. 
> > Is this the intended behavior or is my setup flawed ?
> > Otherwise the headset is working ok.
> 
> our server should time out the connection when not busy. I will add this 
> to the bug list now.

I did some hacks on btsco2 and now I can press connect button on my HS and it disconnects the SCO
channel. Then I press it again twice, and it connects the SCO channel again. All this time the ACL
link is up, but no SCO packets are flowing.
I did this by interpreting AT+CHUP to disconnect and reconnect the SCO channel.
In the long run, I was thinking at something better:
When there is a client connected to alsa ( meaning when we need to send or receive audio data),
then send some AT commands to the HS to start the SCO link, and when there are no more alsa
clients, send some AT commands to the HS to disconnect the SCO link.


> > Another question is how to set up my linux to automatically connect to the
> > headset when I press the button on it ?
> > I think of something like inetd for tcp/ip, which should listen for bt
> > connections and route them to the appropriate programs.
> > I need something to listen for my headset, and when I press the button on
> > it and it tries to connect to my computer (last paired device), then it
> > will launch btsco MAC-ADDR-OF-REQUESTER.
> > Is this possible without writing a new program ?
> 
> This is in our bug list already. Yes, it needs to be written [by someone].
> 
> Brad

I think we need something like inetd is for tcpip.
There is a kbluetoothd that does this, but it depends on kde.
I managed to modify a little bit the btsco2 in order to use it with kbluetoothd.
So now, I can press my connect button on HS and it connects to my laptop.
But I would prefer a small inetd like daemon, something in core bluez (which is not yet written).

If you want, I can send my modified btsco2.c program to play with it.

Best regards,
Paul


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
