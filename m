Return-Path: <cyrus@holtmann.org>
Message-Id: <412771EB-41DB-40BA-969F-D7E3F0E77CE3@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <247899.25747.qm@web94003.mail.in2.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 7 Feb 2008 10:39:15 +0200
References: <247899.25747.qm@web94003.mail.in2.yahoo.com>
Subject: Re: [Bluez-devel] problem in audio service
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

Hi Andrew,

On Feb 7, 2008, at 7:42, Andrew William wrote:
> XYZ@localhost sbc]$ dbus-send --system --type=method_call --print- 
> reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService  
> string:audio
> method return sender=:1.56 -> dest=:1.59
>    string ":1.60"
>
> XYZ@localhost sbc]$ dbus-send --system --type=method_call --print- 
> reply --dest=":1.59" /org/bluez/audio  
> org.bluez.audio.Manager.CreateHeadset string:00:0F:DE:B1:02:42
> Error org.freedesktop.DBus.Error.ServiceUnknown: The name :1.59 was  
> not provided by any .service files
>
> What is this error? Can someone tell me what is being missed here?

The value of the string parameter in the reply was ":1.60" if you look  
closely. That's what you should have used. The "dest=:1.59" is just  
debug output from dbus-send telling properties of the method return  
message that it got (i.e. "1:59" being the unique name that dbus-send  
had during the short time that it was connected to the bus, which also  
explains the error you got in the second command since the first dbus- 
send process didn't exist anymore).

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
