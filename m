Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mattias Arrelid <matar390@student.liu.se>
To: bluez-users@lists.sourceforge.net
Message-ID: <906f7190caa2.90caa2906f71@liu.se>
MIME-Version: 1.0
Subject: Re: [Bluez-users] DiNovo and bluetooth-hub functionality
Content-Type: multipart/mixed; boundary="--114159f1e1a29b4"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 18 Mar 2005 20:53:02 +0100

This is a multi-part message in MIME format.

----114159f1e1a29b4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Well, I't seems the bluetooth services is up and running since I can access my computer through the mobile (able to send pictures to it).

The main problem is still that my keyboard, mouse and mediapad are unusable until I log in, start a terminal and run "hidd --search". And as if it wasn't enough; this doesn't find any devices until i press the connect-buttons on each of them (the mouse, the keyboard and the mediapad). Then they are found by "hidd --search".

Is there a way to solve this you think?

> Hi Marcel,
> 
> Thanks for your fast reply.
> 
> Now, I have logged in as root instead and tried to run all those
> commands. Still, everything works, but I sure would like to find out
> where that init script is. Is there a way I can do find it 
> manually? And
> then install it manually?
> 
> I'm going to try to remove all Bluez-stuff with apt-get as root, and
> then reinstalling them again, just to make sure that the script wasn't
> included from the beginning (maybe it couldn't be created?).
> 
> Thanks in advance / Mattias
> 
> > Hi Mattias,
> > 
> > > Let me start with saying that I only have been on a Linux 
> system for
> > > about 2 days, so please forgive me if I have made clumpsy 
> assumptions or
> > > similar.
> > > 
> > > However, I'm running Ubuntu Linux 5.04 (Hoary Hedgehog). I also 
> got a
> > > DiNovo set from Logitech that has been running fine since 
> install. Now
> > > I'd like to connect my phone to the computer for file 
> exchange/sync and
> > > it doesn't seem to be anything else to do than manually 
> adjusting things
> > > to get everything up and running.
> > > 
> > > I've installed all BlueZ-packages for Ubuntu using apt-get 
> (graphical> > version).
> > > 
> > > I can now, after having logged in at my computer using an extra 
> keyboard> > (connected on ps/2) do the following commands (sudo 
> because of my using
> > > of Ubuntu, won't have priviligies else);
> > > 
> > > 1. sudo hid2hci
> > > 2. hcid
> > > 3. sdpd
> > > 4. hidd --server
> > > 5. sudo hidd --search
> > 
> > you should run all of them as root. The "hidd --search" should 
> btw only
> > be needed once.
> > 
> > > Now, my mouse, keyboard and mediapad gets connected and 
> everything works
> > > ok. My problem is that I would like this to be done 
> automatically when I
> > > start up my computer (in other words; start up bluetooth 
> functionality> > and let me use my bluetooth devices). Maybe the 
> above can be done in
> > > another way, I'm really a newbie trying to get it all together. 
> It would
> > > also be nice if I in Nautilus could view my bluetooth 
> neighborhood using
> > > "bluetooth:///" or something.
> > 
> > You should talk to the Ubuntu package maintainer of the bluez-utils
> > package, because it includes a boot script for this task.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real 
> users.> Discover which products truly live up to the hype. Start 
> reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real 
> users.Discover which products truly live up to the hype. Start 
> reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

----114159f1e1a29b4
Content-Type: text/x-vcard; name="matar390.vcf"; charset="windows-1252"
Content-Disposition: attachment; filename="matar390.vcf"
Content-Description: Card for Mattias Arrelid <matar390@student.liu.se>
Content-Transfer-Encoding: quoted-printable

begin=3Avcard
n=3AArrelid=3BMattias
fn=3AMattias Arrelid
tel=3Bwork=3A+46 (0)70 333 6996
version=3A2=2E1
email=3Binternet=3Amatar390=40student=2Eliu=2Ese
end=3Avcard


----114159f1e1a29b4--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
