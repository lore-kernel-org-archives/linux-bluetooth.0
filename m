Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468CE9AC.6020806@free.fr>
Date: Thu, 05 Jul 2007 14:53:00 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>	<46892FEC.7000705@free.fr>	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>	<468A02F2.7030903@free.fr>
	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
In-Reply-To: <2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Luiz Augusto von Dentz wrote:
> Hi Fabien,
> 
> Yep, you are right we cannot stop application using alsa plugin while in 
> PCM mode,
> Im not so familiar with alsa so I have no clue about slave pcm, but if 
> we can make
> it to just open/close the device (the only thing left in PCM mode) that 
> is the way
> to go.

Yes that's possible :-)
We just have to make the hardware pcm a slave of the headset pcm.
This basically mean that we would have to call the alsa API function 
inside each bluetooth PCM plugin function, except for open/close/start/stop.

In this case we can kiss Play()/Stop() byebye :-)

> 
> Another point I would like to discuss is about not having the 
> intermediate state when
> we are connected to the rfcomm but not yet to the sco socket, it seems 
> useless
> to have to Connect() and then Play(), the alsa plugin already goes 
> direct to Play the
> stream. Do you guys see any value in having a device connected but not 
> streaming?

Yes there is *great* value to this.
There are multiple uses to it:
  * Basically in the long term Connect() could be called by a GUI. That 
would trigger the bluetooth audio deamon to notify a sound routing 
daemon that rerouting the audio is now an option. Sound routing deamon 
would then call Play() or whatever else if it chooses to use the newly 
available device. [Note : this is just an option, i'm not saying here 
that's what's gonna be done :-)]
  * Another reason is that bluetooth audio daemon has to be able to 
accept incoming RFCOMM connection from the headset. In this case there 
is no need to call Connect(), but we can go straight to play mode.

So yes that's *very* important :-), RFCOMM connected but not SCO yet is 
a valid state.

Cheers,

Fabien


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
