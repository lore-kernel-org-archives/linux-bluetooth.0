Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d86405060522324f968fdc@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Mouse and sound in parallel
In-Reply-To: <200506051936.38116.pieczy@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200506051936.38116.pieczy@web.de>
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
Date: Mon, 6 Jun 2005 11:02:01 +0530

Dear Frank,

Whether there is a readymade solutions with CSR which supports 7
connections or is it your custom development?

We also working on a similar setup with SPP+Headset BT device.  We
face similar problems like data slowness/loss when we just connect the
BT device for the sco connection(btsco -f <bdaddr> <channel no.>).
Eventhough we are not playing any audio, just connecting using btsco
make the data transfer slow/data loss.

Please anyone advice.

Thanks & Regards,
Benny

On 6/5/05, Frank Pieczynski <pieczy@web.de> wrote:
> Hello,
> as far as I know a CSR chip (BlueCore4 in my case) supports 7 connections=
 in
> parallel and it works.
> But: If I use btsco to transfer sound to my headset the bluetooth mouse i=
s
> damn slow then. It still moves but it's hard to hit something.
> It comes back to fast movement, if the sound ends.
> Are there any configuartion hints to get a better quality of service?
> Thanks
> Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
