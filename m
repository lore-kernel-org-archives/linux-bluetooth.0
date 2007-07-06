Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100707060612g6ed3a543g9f36b6db49a97a95@mail.gmail.com>
Date: Fri, 6 Jul 2007 10:12:01 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <468DF298.5010205@free.fr>
MIME-Version: 1.0
References: <46852386.8050608@free.fr> <46892FEC.7000705@free.fr>
	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>
	<468A02F2.7030903@free.fr>
	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
	<1183514223.6351.56.camel@aeonflux.holtmann.net>
	<468CE233.8000909@free.fr>
	<d89ddf300707050940n7ffece6cs2ec5836def9e3ae9@mail.gmail.com>
	<468DF298.5010205@free.fr>
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

Hi all,

On 7/6/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> I even have the feeling that with a properly defined unix IPC interface
> between the bt audio daemon and the plugin it would be possible to
> replace the plugin with gstreamer bt element/or even whatever other
> proprietary sound server smartphone designers would like to use :-)

It is already possible to use the plugin with gstreamer, you just need
to set the device property to "bluetooth". So my guess it that alsa
already fulfill our need of system wide mechanism to access bt audio.

This is the command line I use to play mp3 with gstreamer:
gst-launch -v filesrc location="path_to.mp3" ! decodebin !
audioconvert ! audioresample ! alsasink device=bluetooth sync=false

ps: replace "bluetooth" with "a2dpd" or "headset" to use plugins from plugz.
I also discribe how to use the plugin in other players here:
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
