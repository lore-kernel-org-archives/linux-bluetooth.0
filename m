Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4642EAA9.4060604@idlum.be>
Date: Thu, 10 May 2007 11:49:29 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4641DA61.8040709@tao-group.com>	<1178722356.8628.96.camel@aeonflux.holtmann.net>	<4641E662.6080303@tao-group.com>	<1178724426.8628.102.camel@aeonflux.holtmann.net>	<4641EA96.7070204@tao-group.com>	<1178726532.8628.107.camel@aeonflux.holtmann.net>	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>	<7D2A6046-AC66-4992-9875-28101C52FA20@gmail.com>
	<be976db60705092103r60702f19hbbafe4c5534777b4@mail.gmail.com>
In-Reply-To: <be976db60705092103r60702f19hbbafe4c5534777b4@mail.gmail.com>
Subject: Re: [Bluez-users] API documentation?
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

Hello,

I suppose your hcid is running as root, and you checked its output to 
ensure it can properly "grab" the org.bluez names for himself, and that 
there is no error at that point.

Regards,
Pierre-Yves



Mark S. Townsley wrote:
> Hi Johan:
> 
> If you have a DBUS client that is working making use of some Bluez-DBUS 
> API, can I take a look at it as example?
> 
> I am using C and just to confirm, I also went to the Python-Bluez 
> binding making use of the DBUS API.  And I got the same error message.
> 
> If it is a config issue, I would like to know what I should be putting 
> into my dbus.conf and hcid.conf? 
> Thanks
> 
> 
> On 5/9/07, *Johan Hedberg* <johan.hedberg@gmail.com 
> <mailto:johan.hedberg@gmail.com>> wrote:
> 
>     Hi Mark,
> 
>     On May 9, 2007, at 19:27, Mark S. Townsley wrote:
>      > I am trying to follow your advice and use the D-BUS API instead of
>      > the low-level HCI API.
>      > However, no matter which D-BUS method I issued, I got back this
>     error:
>      >
>      >    The name org.bluez was not provided by any .service files
>      >
>      > I tried to search online but could not find any answer.  I searched
>      > the archive, nothing comes up.   Can you provide your expertise on
>      > this one?  What are these .service files?  How can I make one for
>      > org.bluez?
> 
>     I'm kind of surprised you haven't figured this out already. All you
>     need is a running hcid process, and you need to use the system bus
>     (it's not clear from your description whether you used the session or
>     the system bus). hcid provides the D-Bus well known name org.bluez on
>     the system bus. Because your D-Bus client doesn't find org.bluez
>     (i.e. hcid is not running) it tries to see if it is activatable but
>     does not find any .service file which would describe how to activate
>     it (because hcid is not meant to be activated by D-Bus, but should
>     e.g. be run from an init script).
> 
>     Johan
> 
> 
>     -------------------------------------------------------------------------
>     This SF.net email is sponsored by DB2 Express
>     Download DB2 Express C - the FREE version of DB2 express and take
>     control of your XML. No limits. Just data. Click to get it now.
>     http://sourceforge.net/powerbar/db2/
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     <mailto:Bluez-users@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
