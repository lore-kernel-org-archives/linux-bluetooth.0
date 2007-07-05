Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468CFC41.8090404@access-company.com>
Date: Thu, 05 Jul 2007 16:12:17 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>	<46892FEC.7000705@free.fr>	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>	<468A02F2.7030903@free.fr>	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>	<1183514223.6351.56.camel@aeonflux.holtmann.net>
	<468CE233.8000909@free.fr>
In-Reply-To: <468CE233.8000909@free.fr>
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

Hi,

>    - Either perform the audio routing at the system level (desktop PC 
> case), the best candidate today being a sound server like pulseaudio.
>   
In the smartphone scenario, there are some streams that are not handled 
by the processor. This is typically the case if you have a phone module 
wired to the bluetooth pcm. Today's smartphones even have a hardware 
routing chip capable of mixing and routing streams. Example inputs are 
radio and phone module, example outputs are speaker, loudspeaker, 
earphone and bluetooth.

The audio router should be able to take these streams into account. 
Having a separate global audio routing would be very flexible. This 
would allow to fit a large number of hardware platforms.

Last, there should be a way to distinguish between different streams 
natures : for example an alert should not interfere with a voip call .

BR,
Frederic



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
