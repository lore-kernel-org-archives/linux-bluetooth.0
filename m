Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E853A9.5030304@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco and Jabra BT 110 experience
References: <pan.2005.01.14.17.46.40.72959@yahoo.com>
In-Reply-To: <pan.2005.01.14.17.46.40.72959@yahoo.com>
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
Date: Fri, 14 Jan 2005 16:20:09 -0700

Paul,

> So, here is some feedback about using btsco with this headset:
> To connect btsco to the device, i have to press the talk/answer button on
> the headset, and fire btsco on channel 2 which is headset profile, because
> it seems that by default it connects to channel 1 which is handsfree
> profile and does not work too reliably (sometime it just disconnects).

it sounds like you're saying the automatic channel detection incorrectly 
chooses channel 1 instead of 2. can you tell me what btsco prints out 
when it's launched without the channel specified?

Brad


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
