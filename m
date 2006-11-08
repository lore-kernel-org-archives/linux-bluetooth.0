Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4551A608.2030806@evision.de>
Date: Wed, 08 Nov 2006 10:40:24 +0100
From: Tobias Wolf <tobias.wolf@evision.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45504DFF.1000101@evision.de> <45512CE3.9030305@xmission.com>
In-Reply-To: <45512CE3.9030305@xmission.com>
Subject: Re: [Bluez-users] 2-way audio for telephony
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Brad,

Brad Midgley schrieb:
> Tobias
> 

>>
>> Any input will be greatly appreciated ...
> 
> You have to just set the alsa device to
>  headset
> manually, ie it won't appear in a dropdown. Some apps won't let you type
> in the name of the device and they don't use the extended api for
> listing output plugins. That would be a bug in the app.
> 

Thanks, for your answer. I really never thougt of typing the device name
myself because there was a drop down box. Silly me ;) But i have just
tried it out with xmms and it worked with headsetd.

So, now i have to search for an SIP-Client that uses ALSA and let me
type in the device name.

Have a nice day

Tobias

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
