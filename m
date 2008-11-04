Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2008 15:24:03 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20081104132403.GA22659@localhost>
References: <490FCEFE.50302@slackdot.org>
MIME-Version: 1.0
In-Reply-To: <490FCEFE.50302@slackdot.org>
Subject: Re: [Bluez-devel] Multiple simultaneous audio streams?
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

On Mon, Nov 03, 2008, deker wrote:
>  I am working on a project where it would be desirable to have audio 
> streams going to more than one SCO audio device at a time. My quick test 
> today of playing a WAV file with mplayer to two different devices didn't 
> work and bluetoothd was reporting "connection refused" when I tried to 
> get the second stream going. Once the first playback finished, I was 
> able to then play to the second device.
> 
> So, I suppose m question is if BlueZ supports audio to multiple SCO 
> devices at the same time? If not, what might be involved in making it work?

If you're using BlueZ 4.17 or later you'll need to add something like
MaxConnections=2
to the [Headset] section in /etc/bluetooth/audio.conf to be able to
create a service level connection to more than 1 device.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
