Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] adding sdp service record attributes
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050316012142.60063.qmail@web60906.mail.yahoo.com>
References: <20050316012142.60063.qmail@web60906.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1110965856.9818.90.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 16 Mar 2005 10:37:36 +0100

Hi Michael,

>     Sorry for that. Maybe I rephrase the question like this.
>     Now, I'm still struggling about how to add sdp service profiles in
> my Linux PC. And the most important thing is to let my computer to act
> as headset so that T610 can connect to it. I know that to add the
> service, using add_headset function is the way. But I find that only
> using this function is not enough, and I also find that there is a
> command called "setattr" that sets or adds the attributes to SDP
> record. Then I wish to know that if the setattr command, or set_attrib
> function in sdptool.c is necessary. If so, in the setattr command,
> there are two parameters that I've to enter, attrib_id and
> attrib_value. I wish to know what are the corresponding values of
> these two parameters from the following after I've typed "sdptool get
> --tree <recordhandle>"?
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x10002
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1108 - Headset
>     UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0x5
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1108 - Headset
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>      Lastly, I wish to konw that if I can let my PC to act as headset
> for T610, after I've added the profile in it, is there any program
> needed to install in T610 so that it can connect to the PC?
>      Hope that this can be clearer to you. Thank you very much.

now I get what you want. In general adding SDP records with sdptool is
only for testing purpose. You should include you own code for it, like
we do for pand or dund. However if you think that the add_headset() in
sdptool misses an attribute then fix this and send in a patch for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
