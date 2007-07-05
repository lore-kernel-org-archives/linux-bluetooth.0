Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <468D12BB.8080104@free.fr>
Date: Thu, 05 Jul 2007 17:48:11 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46852386.8050608@free.fr>	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>	<46892FEC.7000705@free.fr>	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>	<468A02F2.7030903@free.fr>	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>	<1183514223.6351.56.camel@aeonflux.holtmann.net>	<468CE233.8000909@free.fr>
	<2d5a2c100707050653u46deeeacq7e417b2c9240de6d@mail.gmail.com>
In-Reply-To: <2d5a2c100707050653u46deeeacq7e417b2c9240de6d@mail.gmail.com>
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
> On 7/5/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
>> I think we need:
>>    - Either to let the application perform routing operations (that
>> would make sense in Linux Smartphone style devices, where you have a
>> very reduced set of applications : phone application, media player)
>>    - Either perform the audio routing at the system level (desktop PC
>> case), the best candidate today being a sound server like pulseaudio.
>>
>> What do you guys think of that ?
>> (+1 for pulseaudio for Luiz i think ;-) )
> 
> I imagine that even the smartphone has some kind of audio server on them.
> 
Then maybe your imagination is too powerfull :-)
It's not uncommon for telephony applications to manage directly the 
audio path... how they will be implemented on Linux is still to be seen 
though :-)

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
