Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <HCEOIFALKKLBLJPENPNOGEGFCAAA.khaled@ipbill.com>
References: <HCEOIFALKKLBLJPENPNOGEGFCAAA.khaled@ipbill.com>
Content-Type: text/plain
Message-Id: <1133955376.3752.7.camel@blade>
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
Date: Wed, 07 Dec 2005 12:36:16 +0100

Hi Khaled,

> > > I was curious because I am not getting any sound through my machine
> > > (configured as a headset - 0x200404 device class).
> > > Also there are no service classes defined when I do hciconfig
> > -a (as shown
> > > below).
> >
> > this is now the class of device. You are mixing things up here.
> 
> I understand but should there not be some services defined also - I dont
> remember any of the example hciconfig -a outputs on the net without service
> classes

it is not a requirement. However maybe the decoding code in hciconfig is
incomplete.

> > > Although a headset icon appears on my 6310i and I get no sound
> > at the actual
> > > mobile phone (because the headset is connected), I still cannot
> > hear or say
> > > anything that can be heard from my computer.
> > > Therefore, I am trying to study the hcidump output but its
> > almost impossible
> > > to interpret.
> >
> > No it is not. Use "hcidump -X -V" as stated almost everywhere in the
> > mailing list archives.
> 
> Apologies Marcel - I should have told you before: I am using -X -V and as
> the list archives suggest, I am in the process of reviewing the BT
> specifications to help interpret the output. At first sight it is very
> confusing.
> 
> Would you not expect to see '> SCO' lines in the hcidump output given that I
> am (trying to) use SCO for voice transfer? Like you said in one of the
> archives, hcidump shows payload of the SCO packets over hci?

The Headset and Headfree profiles specify when the SCO channel has to be
opened. Maybe your connection is not in that state. Post the output of
hcidump, so we can see what's going on.

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
