Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <a0580c51050317055564fe7f55@mail.gmail.com>
From: Eduardo Bezerra <edubezval@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A PAN newbie
In-Reply-To: <1111012139.11792.46.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a0580c510503160953311ea8e2@mail.gmail.com>
	 <1111012139.11792.46.camel@pegasus>
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
Date: Thu, 17 Mar 2005 09:55:52 -0400

Hi all,

  Thanks for the quick response. It's truth that I get a second bnep
in the GN, the bnep1. But
I tried to continue the configuration with a "ifconfig bnep1 10.0.0.4"
and the problem kept.
I thinked that at this point (with the two PANU connected and
configured), I could ping
the bnep0 with the old PANU and ping the bnep1 with the new PANU, even
without the
bridge configuration in the GN.
  Ok, and how can I do a bridge configuration in the master ??
  Is it just creating statics routes between the two bnep's?


Thanks a lot,



Eduardo Bezerra Valentin

On Wed, 16 Mar 2005 23:28:59 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
> 
> >    I'm starting to use Bluez to create a PAN. I'm using the 2.6.x linux kernel.
> > I did the following:
> >
> > ####
> > GN:
> > ####
> >
> > Edited the file /etc/bluetooth/hci.conf and enabled the "lm accept,
> > master" option.
> >
> > # hcid -f /etc/bluetooth/hci.conf
> > # sdpd
> > # sdptool add GN
> > # modprobe bnep
> > # pand --listen --role GN -n
> >
> >
> > ####
> > PANU:
> > ####
> >
> > # hcid -f /etc/bluetooth/hci.conf
> > # sdpd
> > # modprobe bnep
> > # pand --connect BT_ADDRESS
> >
> >
> >   After the connection establishment I configured a LAN with the 10.0.0.0/24 IP
> > configuration. So:
> >
> > ####
> > GN:
> > ####
> >
> > # ifconfig bnep0 10.0.0.1 netmask 255.255.255.0
> >
> > ####
> > PANU:
> > ####
> >
> > # ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
> >
> >
> >   At this point I could ping the two host:
> >
> > ####
> > GN:
> > ####
> >
> > # ping 10.0.0.2 # that's ok
> >
> > ####
> > PANU:
> > ####
> >
> > # ping 10.0.0.1 # that's ok
> >
> >       So, I tried to add a second PANU with:
> >
> > # hcid -f /etc/bluetooth/hci.conf
> > # sdpd
> > # modprobe bnep
> > # pand --connect BT_ADDRESS
> >
> >       It connected with the GN, but when I tried:
> > # ifconfig bnep0 10.0.0.3 netmask 255.255.255.0
> > # ping 10.0.0.1
> >
> >       The ping could not reach the GN host even the other
> > PANU (ping 10.0.0.2). I tried to do a ping from the GN to
> > the new PANU and from the old PANU to the new PANU
> > and the problem kept.
> 
> you will get a second (bnep1) interface on the master machine and thus a
> bridge is needed to connect these.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
