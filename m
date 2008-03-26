Return-Path: <cyrus@holtmann.org>
Message-Id: <6F34AFC6-0E93-4CDD-BDFB-376BD964FCFB@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300803250739ga372a9fy6d1aa4eff033be0e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 26 Mar 2008 17:27:38 +0100
References: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
	<d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
	<8f5c4ad0803250600q4b36a962w27e57fc3210ebd09@mail.gmail.com>
	<d89ddf300803250739ga372a9fy6d1aa4eff033be0e@mail.gmail.com>
Subject: Re: [Bluez-users] ACL connection handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Brad,

>>   I am using the infineon.When I play through the uart, I will give  
>> -D
>> bluetooth option to aplay  and this  will create an acl as well as  
>> sco
>> connection and route audio through uart.But if I am  using the pcm  
>> interface
>> , I will  route  audio to the pcm interface  on the host connected  
>> to the bt
>> module and use aplay without the bluetooth option right?,So I have  
>> to create
>> an acl connection and then use the hcitool cmd to  switch the SCO  
>> interface
>> before I do aplay .So is that necessary to give the command from  
>> inside the
>> audio service ?How would I establish the acl connection? Can I use  
>> rfcomm
>> connect ?
>
> The bt alsa plugin does only make sense when getting audio over hci,
> but the audio service was designed so you could use d-bus to make it
> negotiate the connection and then get the audio through another route,
> eg the pcm.
>
> You could run the bluetooth negotiation yourself when going through
> pcm, but it would be better use of the infrastructure to patch the
> audio service so it can be used for both the pcm and hci cases. iirc,
> the audio service assumes you'll use one kind of routing the whole
> time you run it, so that would have to be changed to be a runtime
> setting set through d-bus.
>
> The audio service might be patched to, for example, invoke an external
> program between establishing the acl and sco connections. that could
> take an acl handle and do the infineon magic.
>
> I'm not sure there is a way to pull this off in a way that Marcel
> would accept upstream, but even if you have to do a custom patch to
> the audio service to make it work the way you need it I think you'll
> be able to pull it together more quickly.

shouldn't be a big problem, but in general this belongs into the  
kernel since userspace is not dealing with ACL and SCO/eSCO connection  
handling.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
