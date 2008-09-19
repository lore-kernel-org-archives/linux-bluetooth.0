Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0809190118h1b85dcd7y9fc7dcf89fab09ee@mail.gmail.com>
Date: Fri, 19 Sep 2008 10:18:55 +0200
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4f9823290809182356x2ad1386bn3de0ebb6ada66789@mail.gmail.com>
MIME-Version: 1.0
References: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
	<1221757910.6782.17.camel@californication>
	<4f9823290809182356x2ad1386bn3de0ebb6ada66789@mail.gmail.com>
Subject: Re: [Bluez-devel] What happens with bluetooth when connection is
	interrupted
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

On Fri, Sep 19, 2008 at 8:56 AM, Reto Bachmann <reto.bachmann@gmail.com> wrote:
> So I need to connect the D-Bus signal RemoteDeviceDisconnected to find out
> that I am not connected anymore?
>
> Why shouldn't I poll for a status? Is it just because a signal is sent
> either way or is the status i ask for not the true status?

Because polling is the worst strategy both CPU- and power-wise. It
causes frequent wakeups that waste power and prevent CPUs from
entering a deep idle state. They also generate unnecessary traffic for
the IPC mechanism so if every program decided to poll for something
once a second, services like DBus would likely get hosed.

-- 
Patryk Zawadzki

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
