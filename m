Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F81FAF.8040002@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Installing Bluez
References: <41F81653.4030601@gmx.ch> <1106778292.28444.60.camel@pegasus>
In-Reply-To: <1106778292.28444.60.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 26 Jan 2005 23:54:39 +0100

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>I've to install bluez on an arm system with a 2.6.7 kernel.
>>So I've to activate bluez in the kernel, install bluez-libs and bluez-utils.
>>
>>How to activate bluez support in the kernel?
>>Is it enough to select (make menuconfig):
>>Networking Support -> Bluetooth subsystem support
>>USB Support -> USB Bluetooth TTY support
> 
> 
> you can't select both drivers. Read the help text of the config entries.
> 
> 
>>Or do I have to apply a patch from bluez.org/patches.html?
> 
> 
> You should use 2.6.10 and apply that patch. The patch for 2.6.7 is
> outdated.

Ok. I'll use the patch. (It's easier anyway :-))
Can I apply the 2.6.10 patch to my 2.6.7 kernel? Or do I have to use the 
2.6.10 kernel?


>>Is it possible to leave the kernel as it is and make a module for bluez?
> 
> 
> It is possible, but not supported.
> 
> 
>>Will there be any problems to compile the libs and utils on an arm processor?
> 
> 
> Not that I know of, but I don't have a ARM platform for testing.

I'll inform you as soon as i'm that far...


kind regards
Marco


> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
