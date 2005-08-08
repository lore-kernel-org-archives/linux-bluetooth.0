Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050808184309.GD12641@elmicha.333200002251-0001.dialin.t-online.de>
References: <9772C290CD0BDF4B91356C9102BA886A019BAE20@ftrdmel1.rd.francetelecom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9772C290CD0BDF4B91356C9102BA886A019BAE20@ftrdmel1.rd.francetelecom.fr>
Subject: [Bluez-users] Re: How to etablish a Bluetooth communication between a pocket PC (windows) and a linux station?
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
Date: Mon, 8 Aug 2005 20:43:10 +0200

zze-CONCEPT-PHONE CHABOUD-CROUSAZ B ext RD-TECH-GRE wrote:

> I'm wondering if someone has already etablished a bluetooth
> communication between a pocket PC (windows) and the Bluez stack running
> on a Linux station.

Yes.

> The pocket PC send data through a serial port. I don't know how it
> really works, but my problem it that I was unable to receive these data
> on my linux station with the Bluez stack. (My linux  uses a USB
> bluetooth dongle that works file - bluetooth communication between 2
> linux works fine).
> 
> Has someone some ideas to receive the data send by the pocketPC on my
> linux?

You need an obexftp server. I'm using KDE Bluetooth
<http://kde-bluetooth.sourceforge.net/> which comes with its own obexftp
server. Perhaps your distribution has a package for it.

Another possibility is Synce-KDE <http://synce.sourceforge.net/synce/kde/>, 
which works with Bluez as well.

Regards...
		Michael


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
