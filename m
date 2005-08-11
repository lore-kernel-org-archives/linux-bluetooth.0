Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Marcus Better <marcus@better.se>
Message-ID: <ddf2qc$eps$1@sea.gmane.org>
References: <AF23A417-8600-4F53-87AC-359586BD2AB1@pepper.com> <8B0AF3C0-969B-4843-94E8-92E7ECA4BD20@pepper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: btsco with 2.6.12
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
Date: Thu, 11 Aug 2005 10:38:36 +0200

Michael Frey wrote:

> However when I play a wav file using aplay I just get static on the
> headset.

I have a similar problem. When I play any sound through the headset, I just
get a continuous beep tone. It stops when I kill btsco.

The connection to the headset seems normal, only the sound fails. The
headset is a Motorola HS-801.

I use the latest CVS version (as of a few days ago) and Debian kernel 2.6.11
or 2.6.12.

This worked very well last time I tested, which was a couple of months ago.
Perhaps something broke in between?




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
