Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E85F57.10504@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] recording btsco traffic
References: <pan.2005.01.14.18.04.15.317521@yahoo.com>
In-Reply-To: <pan.2005.01.14.18.04.15.317521@yahoo.com>
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
Date: Fri, 14 Jan 2005 17:09:59 -0700

Paul

> Is it possible to record a phone conversation with btsco ?
> Like dumping all in and out traffic in a big stereo .wav file, where left
> channel should be incoming traffic and right channel should be outgoing
> traffic.
> I mean, btsco already sees this traffic, how hard would be to save it in
> also in a file ?
> 
> Or this can be done with some ALSA magic ? Some routing of both incoming
> and outgoing audio to a virtual alsa device from which one can record ?

is your phone conversation using a voip application on the computer?

currently you'd have to get your voip app to record the call.

if we get everything moved into userspace, you could modify the alsa 
driver to do stuff like that.

i don't know if there's an alsa trick. maybe one of their userspace 
drivers can act like a man-in-the-middle between your voip app and the 
btsco kernel driver.

Brad


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
