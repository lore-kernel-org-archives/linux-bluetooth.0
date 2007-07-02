Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46892FEC.7000705@free.fr>
Date: Mon, 02 Jul 2007 19:03:40 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
In-Reply-To: <2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
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

Hi Luiz Augusto,
Thanks for your answers !!

Please find some more comments below.
> Hello Fabien,
> 
> The API is not properly design for audio over hci that's why you are 
> confused.

Oh you're damn right. I knew about this sco over PCM way of doing 
things, i just completely forgot about it when i read the interface, 
sorry about that :-(


> Those methods make no sense as you had mentioned the commands always
> come from/goes to alsa plugin (we have just one plugin for pcm that should
> handle any kind of audio device) via unix socket. So a normal scenarios when
> sco over hci is to CreateHeadset in the very first time, this will salve 
> the device
> in the storage so it is no longer necessary to create it anymore. This 
> mean we
> don't need any method call to the API to get audio working while in hci 
> mode,

Oh that's nice :-)

> the plugin already works on demand and I currently fixing the concurrent
> connections when an application want to open the device for playback and
> capture at same time.
> The current API is only useful for audio over PCM, in that case I guess 
> we need
> the API methods to be able to control the streams.

Yes and no. The issue with this approach is that applications need to be 
modified to work with sco-over-pcm, which is not very nice :-(
I guess it could be possible to have the pcm_bluetooth ALSA plugin to be 
used even in sco over PCM case, using the ALSA device as slave pcm.
What do you think of thus idea ?


> We could disable those concurrent method while in hci mode as they 
> probably break
> the plugin stream, actually they normally affects only the rfcomm socket 
> because
> sco socket got duped in the process so plugin got its own reference that 
> is not
> affected by API calls, but anyway this is a not common behavior for a 
> headset.

Indeed, and according to HSP/HFP specs, the sco channel is supposed to 
be closed before the RFCOMM one...

Btw, sorry to ask again : has anybody an explanation on the reason for 
the Gain management signals&functions ?

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
