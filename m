Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOOEGGCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1133958415.3752.14.camel@blade>
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
Date: Wed, 7 Dec 2005 12:24:44 -0000

Hi Brad, Marcel,

Any ideas on the hcidump output I am getting?

Thanks for your help Marcel.

Kind Regards

Khaled

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Marcel
> Holtmann
> Sent: 07 December 2005 12:27
> To: bluez-users@lists.sourceforge.net
> Subject: RE: [Bluez-users] Bluetooth Voice Setting
>
>
> Hi Khaled,
>
> > > > > if you wanna emulate a headset then you need to add
> Headset profile
> > > > > records and not Headset Audio Gateway records.
> > > >
> > > > I mean to use the handsfree profile, so that I can speak into
> > > my computer
> > > > through a headset (earphone and mic), sorry if I was
> unclear earlier.
> > >
> > > if you wanna use a headset with your computer you don't
> really need any
> > > additional service records.
> >
> > But why dont I get any sound at the computer? Is there
> something to do with
> > the sound settings on my computer? it uses alsa and is
> functional already -
> > do I need to do anything specific for this purpose?
> >
> > From the following I understand that once the SCO link is
> established (when
> > a phone call is made), HV3 SCO packets are transmitted with
> voice data, but
> > then what do the subsequent mean? I assume they are incoming
> HV3 packets?
> > Then the local host gives up the reserved bandwidth for sco and
> disconnects?
> > But then why does it the error 0x13 and remote user disconnects message?
> > Were there any packets transmitted at all? Why the "i....ERROR..>"?
>
> I have no idea. Maybe Brad can answer this.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep
> through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
