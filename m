Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IA9BDQ$E5979E3A6C8D2962359721362D0B163D@libero.it>
Subject: Re: [Bluez-users] Piconet problems
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
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
Date: Thu, 13 Jan 2005 14:13:02 +0100

> Hi Jers,
> 
> > > > # Default link mode
> > > > #   none   - no spec=
ific policy
> > > > #   accept - always accept incoming connections
> >=
 > > #   master - become master on incoming connections,
> > > > #      =
      deny role switch on outgoing connections
> > > > #
> > > > lm acc=
ept,master;
> > > > #
> > > > #lm accept;
> > >
> > > you changed thi=
s. Why? There can't be two device with a master role in
> > > the same a=
 piconet.
> > 
> > I know that. Maybe I wasn't accurate in the descript=
ion of my problem. I'm
> > sorry...
> > The above script is the hcid.co=
nf file of the master. For slaves I have "lm
> > accept".
> 
> this is=
 not needed, because you use "pand --master ..." and this is
> enought t=
o force the role switch.
> 
> > I want to create a piconet with a singl=
e master and two slaves.
> > In a previous corrispondance, you suggested=
 me:
> > - to upgrade my bluez packages. I did that.
> > - to check the=
 limitation for firmware pre HCI 16.4. I did that.
> > 
> > - to check =
the link policy because the "hciconfig -a" command showed it no
> > set =
for any device. This is my current problem.
> > 
> > "hciconfig -a" sti=
ll shows me that there is no link policy set for any
> > device but, for=
 all dongles,  in the hcid.conf I have
> 
> Is hcid running?

Hi Marc=
el,
hcid was not running. I've solved the inconsistency but no my proble=
m.

Hi tried to create connection on slave1 side by
# hcitool cc <mast=
er_addr>
and so
# hcitool con
lists me the established connection.
=0D
=
After that, I tried to create the second connection on slave2 side by run=
ning the same command (hcitool cc <master_addr>) and I obtain the followi=
ng error:
# Can't create connectio: input/output error.

Besides, it's=
 impossible to  establish any other possible combinations of link among t=
he three device.
Can I hope to find a solution?
Thank you. Jers


=0D
=






=0A=0A=0A=0A_________________________________________________=
___________=0ALibero ADSL: 3 mesi gratis e navighi a 1.2 Mega. E poi hai =
l'Adsl senza limiti a meno di 1 euro al giorno. =0AAbbonati subito senza =
costi di attivazione su http://www.libero.it=0A=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
