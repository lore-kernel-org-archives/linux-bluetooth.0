Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <423B4969.1080607@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A2DP support, when?
References: <906f7190caa2.90caa2906f71@liu.se> <1111176683.9600.39.camel@pegasus> <1111179050.8427.5.camel@localhost.localdomain> <200503181613.27635.mh@intellinetservices.net>
In-Reply-To: <200503181613.27635.mh@intellinetservices.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 18 Mar 2005 14:34:33 -0700

Manuel

See bluetooth-alsa.sf.net

The HP headset seems to have trouble with what we've done so far for 
a2dp. Guylhem Aznar is looking into it.

Try it out.

Brad

> I was wondering how far the A2DP / alsa support is? I have a HP A2DP headset 
> and would love to be able to use that with my PC rather than just with my 
> PDA... is simple SCO audio streaming possible yet? And what would I need to 
> test that?
> 
> Manuel
> 
> 
> On Friday 18 March 2005 03:50 pm, Mattias Arrelid wrote:
> 
>>Hi again,
>>
>>
>>>Hi Mattias,
>>>
>>>
>>>>Well, I't seems the bluetooth services is up and running since I can
>>>>access my computer through the mobile (able to send pictures to it).
>>>>
>>>>The main problem is still that my keyboard, mouse and mediapad are
>>>>unusable until I log in, start a terminal and run "hidd --search". And
>>>>as if it wasn't enough; this doesn't find any devices until i press the
>>>>connect-buttons on each of them (the mouse, the keyboard and the
>>>>mediapad). Then they are found by "hidd --search".
>>>
>>>you need a running "hidd --server". They will reconnect to this server
>>>after a keypress.
>>
>>Well, how can I get that? Remember that I've only been on a Linux-system
>>for two days now, and I really don't know that much =)
>>
>>I actually tried starting up the computer, logging into GNOME and then
>>directly logging of. Then the system says "shutting down Bluetooth
>>services" so they must indeed be running.
>>
>>But... when I disconnect my spare keyboard and start up the computer
>>again, and Gnome shows the login screen, the is NO result from the
>>diNovo keyboard / mouse / mediapad. Tried pushing the connect buttons on
>>both them AND the hub - won't do it.
>>
>>Is it really possible to get the system to recognize my keyboard at
>>startup. Has anyone had success with that?
>>
>>I'd tried running "hidd --server" directly after logging in, but that
>>won't do it. I still have to press the connect buttons, do "hidd
>>--search" or alternatively "hidd --connect ADRESS" for each device.
>>
>>I didn't think it would be this hard... =/
>>
>>Suggestions?
>>
>>Thanks again / Mattias
>>
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now.
>>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
