Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <449980C6.5070004@xmission.com>
Date: Wed, 21 Jun 2006 11:24:22 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com>	<447C6598.6050107@xmission.com>	<447C69D4.9020504@palmsource.com>	<447C7330.9000303@xmission.com>	<44963723.4040807@xmission.com>
	<44965944.6090908@palmsource.com> <449978BC.8020202@palmsource.com>
In-Reply-To: <449978BC.8020202@palmsource.com>
Subject: Re: [Bluez-devel] A2DP Profile Certification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

> frequency without success. Why not use gettimeofday?

Yeah... I would like to change the rtc stuff to gettimeofday and usleep.

> I don't receive control commands when doing this. What model do you use?

I've only tried it with an itech r35. I have a bluetake iphono mini
kicking around somewhere that I intend to try.

I keep an avrecv running whenever I do stuff like this just in case the
set is trying to use that route.

> Last but not least, I receive the frame sent by the headset but it is a =

> 2 byte "0x00 0x01". Is does not look like a stream_cmd. And only one of =

> my heasets sends data.
> =

> plus the weather is bad, sad day...

So you wrote code to listen on psm 25?

I think the best way to test that part of things is to have a2play run
in a listen mode when it's executed without a bt addr.

Brad

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D107521&bid=3D248729&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
