Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42814C59.7070200@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <003c01c555b5$31b193d0$8300a8c0@priveiqvfluhp9>
In-Reply-To: <003c01c555b5$31b193d0$8300a8c0@priveiqvfluhp9>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-users] rfcomm - multiple connections to 1 pocketPC from
 2 seperate bluetooth-dongles
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
Date: Tue, 10 May 2005 18:05:45 -0600

Pieter,

It may be that you need to force a role change from the ppc. Some radios 
can connect to multiple *slave* devices only. By default, the host 
initiating the connection is the master.

If that is it, how you make the role change happen is probably a 
question of how to do it from pocketpc.

Brad

Pieter De Mil wrote:
> Hello,
> 
> I'm using rfcomm 2.15 to make a connection from Linux to a 
> PocketPc(00:04:3E:68:3C:6B). I can do this for one connection. But when 
> I plug in a second bluetooth-dongle in my linuxPC, I can't establish a 
> second rfcomm connection with the same PocketPc.
> 
> Scenario 1:
> BT1 ------- PocketPC  : ok
> channel0
> 
> Scenario 2:
> BT2 ------- PocketPC   : ok
> channel1
> 
> Scenario 3: not ok
> 
> channel0
> BT1 ----------|
>                       |
>                    PocketPC
>                       |
> BT2 ----------|
> channel1
> 
> Someone tried this?
> 
> Regards,
> Pieter
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
