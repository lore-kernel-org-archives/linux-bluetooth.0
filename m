Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 4 Oct 2006 21:29:55 -0300
From: Cris <ml133@netpole.com.br>
To: bb.bluez@magitech.org, BlueZ users <bluez-users@lists.sourceforge.net>
Message-Id: <20061004212955.cc67bc36.ml133@netpole.com.br>
In-Reply-To: <4910207664.20061004141916@magitech.org>
References: <4910207664.20061004141916@magitech.org>
Mime-Version: 1.0
Cc: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Automatic Object Pushing when Devices Enter Range
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, 4 Oct 2006 14:19:16 -0700
bb.bluez@magitech.org wrote:

> Hello all!
> 
> I'd really like is a way to register or specify a script to be called
> whenever a device comes within range.  I'd expect the script to be passed the
> address of the device, allowing me to interrogate it regarding it's
> capabilities, and so forth.
> 
> The alternative is, of course, to call "hcitool scan" every few seconds,
> compare with a log of the known or seen ID's, and process from there, but as
> we were all taught in grammar school CS, polling is bad mm'kay.

The way bluetooth allows to discover nearby devices will not allow to
avoid some sort of polling: One device needs to be in inquiry scan
mode, the other needs to do an inquiry; one needs to be trying to
receive an inquiry signal, the other must send it.

It depends a bit on the volume of traffic you expect here. If you
don't expect ever more than a few devices per hour and can accept not
to send the file to more than one device at the same time, you can use
the 'inq' command to hcitool. At least the last time I checked, the
'scan' command to hcitool is misnamed. It's reall only an inquiry with
a subsequent request for the remote name (more work to do for
bluetooth and thus more time lost for data traffic); hcitool 'scan'
has nothing to do with a `scan' in bluetooth terminology, which is the
listening of the device for inquiry or page attempts. Anyway, unless
you want to log those `userfriendly' names, it's useless in an
unattended situation. In this case of very low and limited traffic,
you could write this using as a script, but you are likely to run into
problems in the area of authentication (pin codes) for the way bluez
handles things.

As volume of traffic grows, the bluez becomes inappropriate:
Bluetooth's basic concepts are event-oriented and designed for small
and/or embedded devices. Both are defeated by bluez: The library locks
in a select loop while waiting for the answering event (rather than
let the application do this, which could handle other things in the
meanwhile), and the use of dbus is certainly not for small devices
(just look at the huge amount of libraries pulled in for installing
dbus). You can get around the lock by forking each command, but then,
you need to do some IPC which is much more complicated than really
needed. In the end, a solution for some a bit more serious traffic
will require you to write this in a language like C. Either you use
the lower level functions in the bluetooth library, avoiding that
loop, or you write it all by yourself from scratch (my choice). But in
this situation, you still might want to consider using two (or more)
bluetooth radios, using one only in periodic inquiry mode, as you can
not detect a nearby device while transmitting the file.

HTH

-- 
Cris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
