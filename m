Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sf.net
In-Reply-To: <1084100350.9269.13.camel@pegasus>
References: <1084100350.9269.13.camel@pegasus>
Message-Id: <1084397995.15254.71.camel@saag>
Mime-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-users] Re: [BlueZ-Announce] Release of bluez-libs-2.7 and bluez-utils-2.7
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 22:39:55 +0100

On Sun, 2004-05-09 at 12:59 +0200, Marcel Holtmann wrote:
> Hi Folks,
> 
> this is one of the bigger updates, because I included the dund and pand
> programs into the BlueZ utilities. This means of course that the BlueZ
> PAN package is now deprecated. The CUPS printing backend is also part of
> this BlueZ utils package, but not installed by default.

Marcel,

It would be great to include pkg-config .pc files in bluez-libs, to make
it easier for people coding against BlueZ with auto* tools.  At the
moment I'm relying on hacky .m4 stuff which doesn't work very well.

-- Edd




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
