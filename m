Return-Path: <cyrus@holtmann.org>
Message-ID: <b7bab9650808101623h1b9ca61fhe4725368c4987e0d@mail.gmail.com>
Date: Sun, 10 Aug 2008 16:23:53 -0700
From: "Jared Kidd" <junkxamindar@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth tethering to at&t phone issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1850341133=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1850341133==
Content-Type: multipart/alternative;
	boundary="----=_Part_32398_10034688.1218410633889"

------=_Part_32398_10034688.1218410633889
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been tethering internet through my at&t cell phone for over a year
using bluetooth PAN (old daemon way as I can't find ANY documentation on how
to do it the new way). Recently it started acting a little flaky. any
streaming videos would stop after the first few seconds, emerge sync would
either take forever to get started or stop halfway, and downloading any
larger files would fail. I recently renewed my contract and got a new phone
(blackjack ii), thinking it was the old phone as it would get very hot. The
issue persists and has gotten worse to the point that it is unusable. Now,
browsing/email still works fine. Streaming videos and it seems any sustained
download fails. If I attempt to start an emerge sync it will seem to halt
ALL internet traffic, same thing with other high traffic things - ALL
internet traffic halts. and I either have to wait a few minutes or reboot
the phone and connect all over again to get it working again.

I have noticed that when this all stops working, I can still ping the phones
ip address just fine, I just can't get anywhere past it. So it seems the
bluetooth connection between the phone and computer still works just fine.

I then started thinking that it may be some blocking technique at&t has
implemented to stop people from torrenting/downloading lots of stuff on
their 3g network and am about to cancel the internet plan as it is unusable.


Then a coworker of mine told me he has no problems with tethering at all.
Youtube works, downloading works, and he can even torrent.

So I decided to do something I hardly ever do - boot into windows XP and
connect through my phone the same exact way. And guess what.....IT WORKS
FINE!

Can anyone offer any explaination? I'll have to try my wifes ubuntu box and
see if it has the same issues as mine. It just seems very odd that it works
fine in windows but not in linux, and that in linux when internet stops
working I can still ping my phone.

Is it possible that at&t has some way to see if I am using a non-windows OS
and then screw up the connection? Or could it be a bluetooth PAN issue in
linux?

------=_Part_32398_10034688.1218410633889
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><span class="postbody">I have been tethering internet through my
at&amp;t cell phone for over a year using bluetooth PAN (old daemon way as I can&#39;t find ANY documentation on how to do it the new way). Recently it
started acting a little flaky. any streaming videos would stop after
the first few seconds, emerge sync would either take forever to get
started or stop halfway, and downloading any larger files would fail. I
recently renewed my contract and got a new phone (blackjack ii),
thinking it was the old phone as it would get very hot. The issue
persists and has gotten worse to the point that it is unusable. Now,
browsing/email still works fine. Streaming videos and it seems any
sustained download fails. If I attempt to start an emerge sync it will
seem to halt ALL internet traffic, same thing with other high traffic
things - ALL internet traffic halts. and I either have to wait a few
minutes or reboot the phone and connect all over again to get it
working again.
<br>

<br>I have noticed that when this all stops working, I can still ping
the phones ip address just fine, I just can&#39;t get anywhere past it. So
it seems the bluetooth connection between the phone and computer still
works just fine. <br>

<br>
I then started thinking that it may be some blocking technique at&amp;t
has implemented to stop people from torrenting/downloading lots of
stuff on their 3g network and am about to cancel the internet plan as
it is unusable.
<br>

<br>Then a coworker of mine told me he has no problems with tethering
at all. Youtube works, downloading works, and he can even torrent. <br>

<br>
So I decided to do something I hardly ever do - boot into windows XP
and connect through my phone the same exact way. And guess what.....IT
WORKS FINE!
<br>

<br>Can anyone offer any explaination? I&#39;ll have to try my wifes ubuntu
box and see if it has the same issues as mine. It just seems very odd
that it works fine in windows but not in linux, and that in linux when
internet stops working I can still ping my phone.
<br>

<br>Is it possible that at&amp;t has some way to see if I am using a
non-windows OS and then screw up the connection? Or could it be a
bluetooth PAN issue in linux?</span></div>

------=_Part_32398_10034688.1218410633889--


--===============1850341133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1850341133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1850341133==--
