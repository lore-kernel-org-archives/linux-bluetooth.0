Return-Path: <cyrus@holtmann.org>
From: "Phil Endecott" <spam_from_bluez_users@chezphil.org>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 24 Apr 2008 16:49:32 +0100
Message-ID: <1209052172510@dmwebmail.dmwebmail.chezphil.org>
In-Reply-To: <2D804CC1-0304-47A8-B67F-00814B3BE516@gmail.com>
References: <2D804CC1-0304-47A8-B67F-00814B3BE516@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Apple wireless keyboard
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

Hi Johan,

Johan Hedberg wrote:
>> - Installing a kernel with the bluetooth modules.
>> - Installing bluez-utils.
>> - Starting hidd and hcid (enabling them in /etc/default/bluetooth on
>> this Debian box)
>
> This might have been the first step that went wrong. hidd has been  
> superseded by the input service already some time ago.

I'm using the Debian package of bluez-utils version 3.30-3, following 
their instructions in /usr/share/doc/bluez-utils/README.Debian.gz.  
I've already submitted some suggested changes to this document, so if 
there are some more things that they need to update, let me know and 
I'll file a report.

> You can check  
> whether it's enabled e.g. with the bluetooth-properties app that comes  
> with bluez-gnome (assuming you use Gnome).

I'm not using Gnome.

> You will need to tell the  
> input service about your keyboard using the CreateDevice D-Bus method  
> call (maybe bluetooth-properties even supports doing this through its  
> GUI). Some python examples can nevertheless be found in the BlueZ  
> wiki: http://wiki.bluez.org/wiki/HOWTO/InputDevices

>> - Running hcitool scan to get the keyboard address (which I've now
>> written on the back)
>> - Running hidd --connect <addr> and typing 1234RET on the keyboard
>
> Both of these are fine but instead of using hidd you'd use the Connect  
> method that the input service provides (I think there's an example of  
> that too in the wiki).

Hmm.  So rather than running "hcitool scan" and "hidd --conect <addr>", 
I have to write a few lines of python (a language I've never used) to 
communicate over dbus (a protocol that I've never used) to this "input 
service" thing?  If that's the case, then I can't say this looks like 
an improvement in usability.

>> So
>> after I reboot the keyboard should be able to connect without user
>> interaction.  But so far I have failed to make this happen.
>
> Probably because you don't have a HID server to accept the incoming  
> connection request.

hidd --master --server is started by the Debian init.d script.

See my other messages for my further thoughts about why this is not 
working; I think it's a lower-level problem.


Regards, Phil.





-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
