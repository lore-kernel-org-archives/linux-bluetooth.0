Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f21e7dc80705240521p1118c709o881451afb39b73e0@mail.gmail.com>
Date: Thu, 24 May 2007 15:21:37 +0300
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1179996006.26519.15.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <4655449F.2080000@movilok.com>
	<1179996006.26519.15.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Concurrent hcitool commands
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Marcel

On 5/24/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > we are trying to use hcitool to retrieve some information about
> > several devices and we need to do it in parallel (several scripts
> > concurrently call "hcitool name XX:XX:XX:XX:XX" using the same local
> > device looking for the name of several remote devices).

> I would advise you to use the D-Bus interface since it does the name
> resolving in the background and automatically caches the resolved device
> names for you. No need to fiddle around with low-level commands.
>

Is there any example of d-bus usage in the sources somewhere
(maybe an example of a simple client that use this interface for a simple
task) ?

Thanks You!
choi

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
