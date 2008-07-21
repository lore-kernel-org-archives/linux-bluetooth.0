Return-Path: <cyrus@holtmann.org>
Message-ID: <001f01c8eb58$d65ede10$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Mon, 21 Jul 2008 12:40:14 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Quick question about org.bluez.Device and .audio.*
	Properties
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

Gents,

In the near-future 4.x, I understand that the org.bluez.audio.* 
interfaces will be attached to the existing Device, such that the object 
path (e.g.) /hci0/dev_* will have/export multiple DBus interfaces, not 
only org.bluez.Device but also org.bluez.audio.Control (could be 
multiple interfaces of the org.bluez.audio family).  I also understand 
that the org.bluez.audio.* interfaces will be set up based on the SDP 
records in the host and remote when the connection/pairing is completed.

Is my understanding of this accurate?

Second question: org.bluez.Device has a number of properties (e.g., 
Connected) which are also valuable in the context of org.bluez.audio.*; 
should we duplicate the appropriate properties (and code) into the 
audio.* interface as well, or just require that anyone using wishing to 
access these properties address org.bluez.Device?  Similarly, when a 
property changes, would we want to send the signal to a callback 
listening to .Device and .audio.*, or only to .Device?

I think I have sensible answers (not to duplicate code/functionality), 
but because I have not been to the meetings in Helsinki and elsewhere, 
wanted to get your opinions and guidance.

FWIW, having resolved my other connection issues (to my satiafaction, at 
least), I am now diving into audio.Control (/audio/control.c), with an 
eye to providing a reasonable level of Metadata compliance/support.

David Stockwell
Frequency One 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
