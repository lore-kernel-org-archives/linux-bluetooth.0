Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <HCEOIFALKKLBLJPENPNOCEGGCAAA.khaled@ipbill.com>
References: <HCEOIFALKKLBLJPENPNOCEGGCAAA.khaled@ipbill.com>
Content-Type: text/plain
Message-Id: <1133957382.3752.12.camel@blade>
Mime-Version: 1.0
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
Date: Wed, 07 Dec 2005 13:09:42 +0100

Hi Kahled,

> > > > > Would you not expect to see '> SCO' lines in the hcidump output
> > > > given that I
> > > > > am (trying to) use SCO for voice transfer? Like you said in
> > one of the
> > > > > archives, hcidump shows payload of the SCO packets over hci?
> > > >
> > > > The Headset and Headfree profiles specify when the SCO
> > channel has to be
> > > > opened. Maybe your connection is not in that state. Post the output of
> > > > hcidump, so we can see what's going on.
> > >
> > > This is when the bluetooth phone is initialised:
> >
> > if you wanna emulate a headset then you need to add Headset profile
> > records and not Headset Audio Gateway records.
> 
> I mean to use the handsfree profile, so that I can speak into my computer
> through a headset (earphone and mic), sorry if I was unclear earlier.

if you wanna use a headset with your computer you don't really need any
additional service records.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
