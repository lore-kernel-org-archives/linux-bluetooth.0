Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan Sass <jsass@magnifeye.com>
Subject: Re: [Bluez-users] Source sample custom Bluetooth
In-reply-to: <1104604846.4253.1.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <FA69107A-5DAA-11D9-8017-000D9348D4BE@magnifeye.com>
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
Date: Mon, 03 Jan 2005 09:14:51 -0800

Thank you for your response.

The custom device I am talking to does not support a sdp server. I can 
see it with a hcitool scan. The call to sdptool fails to connect due to 
a timeout.

Is there a sample that shows sending bytes at a higher level?

I am sure that eventually I will figure it out, but just in case is 
there a make file or command to build rctest?

Jonathan


On Jan 1, 2005, at 10:40 AM, Marcel Holtmann wrote:

> Hi Jonathan,
>
>> I am writing code to talk to a custom bluetooth device that I need two
>> way communication with.  (I sent it commands and it sends characters).
>> Can you please point me to some sample linux (fc2 ideally) source 
>> code.
>
> the best thing is using a serial profile based communication at RFCOMM
> protocol level. See rctest or attest for examples.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
