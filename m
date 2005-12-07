Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOCEGJCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4397087E.2070508@csr.com>
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
Date: Wed, 7 Dec 2005 16:27:41 -0000

Hi Steven, Brad,

Thanks for your help Steven; Brad do you have any ideas?

I am using asterisk and Theo Zourzouvillys' chan_bluetooth module to
integrate voip and gsm. I understand that Theo's code may not be fully
functioning but there are people out there (most of whom are/have been on
the bluez-users list) who have managed at least one-way audio transfer in
this setup. I haven't achieved this yet and so my efforts continue.
I believe there are seniors out there who have actually fully implemented
theo's project to the extent that it works occassionally!
If what you are saying Steven is correct then it would seem the
chan_bluetooth module is at fault - BUT even then, why do I not get even
unidirectional sound? There is more to it...

I would be grateful for any help from you guys.

Kind Regards

Khaled

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Steven
> Singer
> Sent: 07 December 2005 16:06
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Bluetooth Voice Setting
>
>
> Khaled wrote:
> > I have just checked hcidump again: when in an active call there
> is no output
> > on hcidump -X -V, the last trace is:
> >
> > > ..+CIEV: 3,3..
> > > ..+CIEV: 1,1..
> > > ..+CIEV: 3,0..
> >
> > The trace holds on this for as long as the call is active, then once the
> > destination (dialled phone) is hung up, still nothing happens
> untill about 5
> > seconds later when the call on the mobile phone dissappears, at
> which point
> > the next line in the trace (ERROR) appears:
> >
> > > ..ERROR..
> > > ..+CIEV: 1,0..
>
> Right. This looks like a perfectly normal connection and a perfectly
> normal disconnection (in response to a remote hangup). As far as all
> the signalling is concerned at all protocol levels on both sides, the
> SCO link was up and running normally in the bit in the middle.
>
> The problem is therefore something to do with getting the SCO data out
> of the module and into your app. You haven't said which app and which
> version of that app you're using.
>
> Anyway, this all looks more like Brad's department than mine :-) Maybe
> you have to run some command to get the USB subsystem to start polling
> the isochronous endpoints.
>
> > Output from hciconfig -a:
> [...]
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1)
> LMP Subver: 0x175
> >         Manufacturer: Cambridge Silicon Radio (10)
> [...]
> > Output from hciconfig hcio revision:
> [...]
> >         HCI 14.7
>
> That's very old firmware. You might want to consider upgrading to version
> 16.4 or later. I don't think SCO over USB is completely broken in 14.7,
> it's just that there were a set of bug fixes between 14.7 and 16.4. I
> suspect 14.7 works sufficiently well to get some noises out of the
> system.
>
> Brad might know if anyone has successfully got SCO over USB working with
> BlueZ and 14.7 CSR firmware.
>
> You might also want to check the output of /proc/bus/usb/devices and make
> sure the device has registered its isochronous endpoints correctly.
>
> > Any thoughts? I was wondering why then in the trace, is there
> references to
> > SCO? see below:
> [...]
> >> HCI Event: Connect Complete (0x03) plen 11
> >     status 0x00 handle 43 bdaddr 00:0E:6D:34:BD:B1 type SCO encrypt 0x01
>
> This means that a SCO connection was formed at the baseband. It says
> nothing about where the SCO data is going (or even whether there's any
> SCO data flowing across the link).
>
> Specifically, it does not say whether the USB isochronous endpoints are
> even being polled.
>
> 	- Steven
> --
>
>
> This message has been scanned for viruses by BlackSpider
> MailControl - www.blackspider.com
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
