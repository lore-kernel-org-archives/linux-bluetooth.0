Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net, Reza Naima <reza@reza.net>
Subject: Re: [Bluez-devel] voice (SCO) applications
References: <20040610223231.GB17706@boom.net>
In-Reply-To: <20040610223231.GB17706@boom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406110202.33918.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Jun 2004 02:02:33 +0200

On Friday 11 June 2004 00:32, Reza Naima wrote:
> I was looking for, and couldn't find, any application for linux that
> supported voice -- as in using your computer as a handsfree for a mobile
> phone.  I know this is possible with the drivers that came with the
> dbt-120 and windows.  And from my understanding, there is kernel driver
> support for it, but does anyone know of an application that exists that
> is able to act as a handsfree device?

I started with a handsfree applications as a part of the KDE Bluetooth 
Framework (kde-bluetooth.sf.net) a while ago, but it's not working too well 
at the moment. It uses arts as a sound backend, which turned out to be no 
good idea.  Maybe using alsa directly would give better results, but that 
would be harder to configure (remember, we are targeting KDE users ;) I also 
had rather mixed results depending on the kernel and bluetooth dongle I used. 
Since I don't have too much time at the moment and not too many people were 
complaining about kbthandsfree, it is basically on hold and waiting for me or 
someone else to continue the work.

regards
Fred


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
