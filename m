Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030228122906.023b3ca8@mail1.qualcomm.com>
To: david.libault@inventel.fr, "Daryl Van Vorst" <dvpub@telus.net>, <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Cc: Halam.Rose@7layers-UK.com
In-Reply-To: <3E26CE210187508B@mel-rta6.wanadoo.fr> (added by
	postmaster@wanadoo.fr)
References: <5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
	<5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 28 Feb 2003 12:46:21 -0800

At 01:01 AM 2/28/2003, David LIBAULT wrote:
>Max, can you "coordinate the efforts" for qualification ?
I probably could. But I don't want to because I won't be very effective at it. 
Mostly because of lack of time. When I do get free time I'd rather 
fix bugs and implement missing features.
So I'd prefer if somebody else will lead and coordinate the efforts.

>Who is going to write the test report ?
>Is Bluez going to be listed as official Bluetooth qualified stack ?
I don't know. That's what we need to discuss.
There are many questions (at least in my mind) like 
- Does it make sense to have qualified stack in the official kernel ?
Like I mentioned before I don't want to add things that simply don't make 
sense for general stack operation only because we want to pass qualification
(I'm talking mostly about kernel stuff here).
In which case a separate qualified kernel package with the same API as mainstream
kernel make sense.

- What happens when we make changes to the stack ? Have to qualify again ?

etc

Max



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
