Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4247EF8F.5050205@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] paging/inquiry during inquiry
References: <30791.1111942436@www59.gmx.net>	 <1111943377.9195.253.camel@pegasus>  <4247EC03.9040709@gmx.ch> <1112010070.9016.23.camel@pegasus>
In-Reply-To: <1112010070.9016.23.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 28 Mar 2005 13:50:39 +0200

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>as far as I know, you can't page when you run an inquiry. But when a
>>>connection is established you can hold this and then page and inquire
>>>again.
>>
>>my question goes in the other direction:
>>My dongle is doing an inquiry, can others during this inquiry do a page 
>>scan on my dongle or can they inquire me?
> 
> 
> you mean "page me" and not "page scan me". Reverse your thinking of what
> this means.

you're right... sorry

> However if you run an inquiry you can't be paged or inquired as far as I
> know.

ok...


>>What are the requirements for this?
> 
> 
> I think you need massive changes inside the Bluetooth radio/baseband
> specification to allow this. However let someone with deep knowledge in
> this area explain it to you.

then i better do other changes to reach what i'm trying to do...


thanks a lot

regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
