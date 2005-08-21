Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Looking for a Palm with Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <E1E6KUf-0000w8-5I@smtpauth08.mail.atl.earthlink.net>
References: <E1E6KUf-0000w8-5I@smtpauth08.mail.atl.earthlink.net>
Content-Type: text/plain
Message-Id: <1124614283.7598.4.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 Aug 2005 10:51:23 +0200

Hi Tom,

> Did you also observe the other "glitch"?
> 
> o)Palm does an SDP request for a service
> 
> o)The other side doesn't have the service and responds with an empty
> response
> 
> o) The Palm then does an attribute search on handle 0

not really, because I had some hard time to play around with the SDP
records itself to present a correct record with all needed information.
However this should be investigated.

> I have reported this issue in the Bluetooth Forum on the PalmOS developers
> website.

I got the impression from previous comments on some mailing list and
boards that the PalmOS developers don't really fix Bluetooth bugs.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
