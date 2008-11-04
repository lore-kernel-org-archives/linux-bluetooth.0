Return-Path: <cyrus@holtmann.org>
Message-ID: <490FCEFE.50302@slackdot.org>
Date: Mon, 03 Nov 2008 23:26:38 -0500
From: deker <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Multiple simultaneous audio streams?
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

 I am working on a project where it would be desirable to have audio 
streams going to more than one SCO audio device at a time. My quick test 
today of playing a WAV file with mplayer to two different devices didn't 
work and bluetoothd was reporting "connection refused" when I tried to 
get the second stream going. Once the first playback finished, I was 
able to then play to the second device.

So, I suppose m question is if BlueZ supports audio to multiple SCO 
devices at the same time? If not, what might be involved in making it work?

Thanks,

-d

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
