Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4166A8D8.3080707@uni-paderborn.de>
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Stefan Mischke <survivor@uni-paderborn.de>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <41668ADE.7010004@uni-paderborn.de>
In-Reply-To: <41668ADE.7010004@uni-paderborn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Re: read_RSSI and others not thread-safe?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 08 Oct 2004 16:48:56 +0200

I looked into the code and I think the problem is somewhere inside of 
bluez-libs' "hci_send_req()". The connection handle field of the events 
are not compared to the one from the request. Actually, this should be 
no problem since there shold be some kind of pre-filtering inside the 
kernel by the hci socket. I don't know. It doesn't seem to happen with 
l2cap and so I'll use the "synchronized" workaround (which costs a 
little performance). But if someone finds the problem, I'm interested in it.

Regards
Stefan


Stefan Mischke schrieb:

> Hello!
>
> I've written a small JBlueZ-like JNI-Library which gives Java access 
> to BlueZ. My demo application has one threads for each connection (two 
> at the moment) which concurrently do read_RSSI, 
> read_Transmit_Power_Level and read_Link_Quality. If by random two 
> threads do one, two or all three of these calls at the same time, the 
> result values are equal (although they can't be since one connection 
> is really bad). This doesn't happen if I declace the three functions 
> "synchronized" in the Java part of the JNI. But this should not be 
> necessary, should it? Since my functions only use by-value parameters 
> and local variables, they should be thread-safe. I also figured out 
> that the BlueZ sockets in these calls are unequal, but the result 
> (RSSI value) is equal. Why can this happen?
>
> I wonder if this could also occour on one of the other, more important 
> functions like l2cap_read/write. Any idea? Thanks!
>
> Regards
> Stefan
>
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
