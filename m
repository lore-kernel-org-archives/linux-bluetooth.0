Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Tom Allebrandi" <tom@ytram.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Looking for a Palm with Bluetooth
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1124467416.6398.24.camel@notepaq>
Message-ID: <E1E6KUf-0000w8-5I@smtpauth08.mail.atl.earthlink.net>
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
Date: Fri, 19 Aug 2005 23:57:49 -0400

Marcel -

Did you also observe the other "glitch"?

o)Palm does an SDP request for a service

o)The other side doesn't have the service and responds with an empty
response

o) The Palm then does an attribute search on handle 0

I have reported this issue in the Bluetooth Forum on the PalmOS developers
website.

--- tom
tom allebrandi
tom@ytram.com
 
-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, August 19, 2005 12:04 PM
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Looking for a Palm with Bluetooth

Hi,

I just played a little bit with a Palm Tungsten T3 and found there
secret 128-bit UUIDs for specific services like HotSync. I added support
for them to sdptool and now I like to fully add Bluetooth support to the
pilot-link library and its utils. The way with using PPP in between is
ugly and not really needed. Is there anyone out there that has an old T3
and don't need it anymore? I am really happy if someone sends me such a
device, so I can add native synchronization support over Bluetooth for
the PalmOS devices.

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




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
