Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan Sass <jsass@magnifeye.com>
Subject: Re: [Bluez-users] Source sample custom Bluetooth
In-reply-to: <1104839435.8894.86.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <6653F70C-5ECD-11D9-8017-000D9348D4BE@magnifeye.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; format=flowed
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
 <4dfd570904122509237f2a2f48@mail.gmail.com> <1103995727.8758.31.camel@pegasus>
 <4dfd570904122509451e811d7a@mail.gmail.com> <1103996976.8758.34.camel@pegasus>
 <4dfd5709041225095410f71a46@mail.gmail.com> <1103997529.8758.36.camel@pegasus>
 <4dfd570904122510081a9bfa7@mail.gmail.com>
 <4dfd570904122510085371c17b@mail.gmail.com>
 <4dfd57090412251011705f52be@mail.gmail.com>
 <4dfd5709041225103246f6934c@mail.gmail.com> <1104000494.8758.46.camel@pegasus>
 <002601c4ebb8$4de24200$020ba8c0@heejune> <1104125195.9393.12.camel@pegasus>
 <BEB39C04-5B6A-11D9-8017-000D9348D4BE@magnifeye.com>
 <1104604846.4253.1.camel@pegasus>
 <FA69107A-5DAA-11D9-8017-000D9348D4BE@magnifeye.com>
 <1104776407.8894.53.camel@pegasus>
 <AFDBF1EE-5DB6-11D9-8017-000D9348D4BE@magnifeye.com>
 <1104778613.8894.62.camel@pegasus>
 <C17DB8CE-5E1A-11D9-8017-000D9348D4BE@magnifeye.com>
 <1104839435.8894.86.camel@pegasus>
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
Date: Tue, 04 Jan 2005 19:53:46 -0800

>
> the HCI raw socket doesn't support connect(). It is not meant for doing
> actual data transmission. You must do this all by yourself. Look at the
> source code of the hci*.c tools.
>
> Regards
>
> Marcel
>

I have looked at the hcitool.c program and I am stuck by my lack of 
understanding. The cmd_cmd seems like what I want to do to read data 
from my custom device. What I want to do is given a device address, I 
want to read bytes from it and occasionally write to it.  Is there a 
code fragment that you can point me to?

 From the person who wrote the stack on our device.

This is a connect device with a ACL DH5 packet type. The transfers are 
standard ACL L2CAP packets from the remote. The remote appears to the 
host as a master device, pushing down ACL packets when a button is 
pressed.

Thank you,

Jonathan



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
