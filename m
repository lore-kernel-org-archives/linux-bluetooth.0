Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5b9417770705141102w6282efbl6bba1ec14a65591c@mail.gmail.com>
Date: Mon, 14 May 2007 13:02:12 -0500
From: "John H." <mistamaila@gmail.com>
To: "BlueZ development" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
MIME-Version: 1.0
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
Subject: Re: [Bluez-devel] skype and bluetooth
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

Here's the output of headsetd, which "connects" after i hit button on
headset, but the rest is what outputs when I try to use skype with it.


headsetd -n
headsetd[20485]: Bluetooth headset daemon version 0.5
headsetd[20485]: Incoming RFCOMM hs connection from 00:16:8F:F9:97:BB accepted
headsetd[20485]: Changing state: Idle-->Connected
headsetd[20485]: Changing state: Connected-->Ready
headsetd[20485]: Changing state: Ready-->Opening
headsetd[20485]: SCO channel opened handle=0x0031 mtu=64
headsetd[20485]: Changing state: Opening-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Changing state: Zombie-->Streaming
headsetd[20485]: Appli closed socket
headsetd[20485]: Changing state: Streaming-->Zombie
headsetd[20485]: Nobody uses SCO channel anymore, closing it.
headsetd[20485]: Changing state: Zombie-->Connected


On 5/14/07, John H. <mistamaila@gmail.com> wrote:
> Hi,
>
> Motorola h700.
>
> I have plugz installed, and the corresponding asound.conf from it.
>
> fc6 and headset paired.
>
> I tell new alpha skype 1.4 to use headset for in, out and ring(as
> headsetd is running)
>
> When i try test call, it says problem with audio playback?  However,
> the headset beeps at this time, so there's definitely some kind of
> communication.
>
> What to do?  Am I supposed to be using hijacker?
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
