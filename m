Return-Path: <cyrus@holtmann.org>
Message-ID: <47F3AEBC.9010407@idlum.be>
Date: Wed, 02 Apr 2008 18:05:16 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>	<47F05CEF.8040300@aircable.net>
	<200803311404.06902.denis.kenzior@trolltech.com>
In-Reply-To: <200803311404.06902.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] CreateProxy usage?
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

>>>From our experience using RFCOMM ttys is not a good idea.  The bluetooth 
> rfcomm tty driver in the kernel is too unreliable in certain situations.  We 
> actually have to patch our device kernels in order to get it working somewhat 
> correctly.  

I've observed the same thing: rfcomm ttys are not reliable. I've 
reported several time Oopses related to them, and so far each time one 
Oops/Warning/Bug is fixed, another one happens. Basically, I know no 
kernel version which is robust regarding rfcomm ttys.

At the moment I'm looking for a reliable alternative to the ttys. From 
what I understand, using an rfcomm socket instead of the ttys would be a 
solution, as they are reputed more reliable. But going the socket's way 
  would mean abandonning the DBus API and linking against the bluetooth 
lib, or am I mistaken? My application is currently only accessing BlueZ 
through this DBus API, and it is indeed a great API. It would be sad to 
have to abandon that to get reliable rfcomm functionnality.

I've no experience at all with the rfcomm sockets from the Bluetooth 
library (so take what I say with the required amount of salt). Wouldn't 
a solution be to allow opening sockets through the DBus serial service, 
instead of the current rfcomm ttys-only approach? I'm talking mostly 
about the ConnectService and ConnectServiceFromAdapter in the serial 
manager hierarchy.

Denis, could you also expand further about the kind of patching you 
perform on your kernels, regarding rfcomm tty's reliability?

Regards,
Pierre-Yves






-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
