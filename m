Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple BT Keyboard?
From: Marcel Holtmann <marcel@holtmann.org>
To: Mykel <Mykel@mWare.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E241EF.7000607@mWare.ca>
References: <40E241EF.7000607@mWare.ca>
Content-Type: text/plain
Message-Id: <1088586741.22940.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 30 Jun 2004 11:12:21 +0200

Hi Mykel,

> I've been flagging the discussions about it in the past few weeks, but 
> I'm not up with the whole process of what I'm supposed to do, and I 
> haven't been able to piece it together from what I've seen.
> 
> I have my MX900 working in 2.4.26 using bthid & hcid.... I don't seem to 
> have hidd... (I have to press the Connect button and do a bthid -c $ADDR 
> after leaving the mouse 20min or the first time I use it.)

the hidd is in bluez-utils-2.7 and needs a 2.6.7-mh1 kernel with
activated HIDP kernel module.

Pressing the connect button is only needed for the initial connection
and after that the mouse will reconnect to you. For that you must run
"hidd --server".

> What do I need to get the keyboard working? Is it worthwhile attempting 
> this with 2.4? Slackware 10 is out and I'm playing with it in 2.6, but I 
> have many other requirements (I'm an on site network tech, lots of fancy 
> stuff in my kernel) so I'm not stable in 2.6 yet.

I propose that you install 2.6.7-mh1 with hidp.ko and use hidd.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
