Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42292687.5080204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Interference between btsco and hidd
References: <Pine.LNX.4.62.0503032051240.10779@block>
In-Reply-To: <Pine.LNX.4.62.0503032051240.10779@block>
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
Date: Fri, 04 Mar 2005 20:24:55 -0700

Florian

> 1. While btsco works fine, I've just noticed that when it's running
>    and a connection is established to my headset, my other Bluetooth
>    devices (MS Optical Desktop) can't establish a connection by them-
>    selves anymore. After keyboard or mouse go to sleep mode with 
>    btsco running, they can only be reconnected with hidd --connect
>    or by killing btsco first.. Has anyone got an idea how to fix this?

I remember Lars Grunewaldt bringing this up a while ago. Marcel told him 
something like changing how hidd runs? master? Anyway, check the 
bluez-devel (possibly bluez-users) list archives.

> 2. I had a look at the hcid source code, as I was thinking about
>    implementing a little function to call some script when a
>    connection request arrives. However, my understanding of BT
>    is still limited, so can somebody give me a hint where to start?
>    What kind of event is received when a connection request comes in?

Yes, it appears as an AT string on the command channel. See the way 
btsco examines AT strings.

> 3. Again concerning btsco: has anybody tried to disconnect the SCO
>    channel while not in use? Maybe that would fix the problem with
>    hidd, too..

Yes, we would all love it. As far as I know, no one has done it.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
