Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bearcat@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607251240.03201.Bearcat@feline-soul.com>
References: <200607251240.03201.Bearcat@feline-soul.com>
Date: Fri, 28 Jul 2006 16:18:10 +0200
Message-Id: <1154096290.2298.37.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Page timeout on Logetech cordless elite
	keyboard	but mouse works
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Bearcat,

> I am running sourcemage gnu/linux. My kernel is 2.6.17 and blues-libs and 
> bluez-utils are versions 3.1. I have a Logitech cordless elite set (keyboard 
> and MX 900 mouse).
> 
> The basis for my work on it so far is here: 
> http://www.bueche.ch/comp/mx900/mx900.html
> 
> The logitech hub switches over to hci just fine and the mouse is successfully 
> connected via blue tooth. (Note, both mouse and kb work in pure hid mode with 
> no bluetooth). I need the bluetooth hub working as i will be getting a 
> headset this week, that i need to have operational
> 
> However, i can not get the keyboard to connect. When i enter a "hidd --connect 
> 00:07:61:1d:29:32" i get "Can't get device information: Host is down" from 
> the terminal  and "Problem connecting with 00:07:61:1d:29:32: Page Timeout" 
> on a kdebluetooth tool tip.
> 
> I have hit the connect button on the keyboard repeatedly and even taken out a 
> battery for a few seconds. I have verified that i am using the correct MAC 
> address via the printing on the bottom of the keyboard.

I think that I mentioned "hcidump -X -V" before. Please send its output.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
