Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: Henryk =?iso-8859-1?Q?Pl=F6tz?= <henryk@ploetzli.ch>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
Message-ID: <20041125105615.GA19821@snoopy.src.ricoh.co.jp>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp> <20041125112509.75347786.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20041125112509.75347786.henryk@ploetzli.ch>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 Nov 2004 19:56:15 +0900

Hi Henryk,

actually I was just about to send a new mail to the mailing list.
Just looking at the BlueZ page, I saw that there is a new hcidump=20
package so after updating I clearly saw the bitpool thing. I just
replaced the two hardcoded bitpool min and max by the one supported
by my headset and I got .....

hum ... weird sound :-(

well I can recognize my music but sometimes it's going faster, slower
then faster again ....=20

seems also right and left channel are not same ... well can't be sure
about that because the sound is very weird ...=20

I don't know what I can do else ... just let me know.

did you made any other modification to the CVS ? Just got it few hours ag=
o=20
so I think except this min/max thing nothing has changed.

Alain


* Henryk Pl=F6tz [Thu, 25 Nov 2004 at 11:25 +0100]
<quote>
> Moin,
>=20
> Am Thu, 25 Nov 2004 18:11:24 +0900 schrieb Alain Volmat:
>=20
> > Well, it didn't work well, it seems to fail during the
> > connection/configuration phase. Since I never heared you speaking
> > about this headset I think you might be interested in the several log
> > I took (just ask me if you want some other info).
>=20
> Oh yes, we are. Seems your headset even is the first I've seen that
> supports more than only media transport plus sbc codec: It announces a
> Content Protection capability, namely SCMS-T (whatever that may be).
>=20
> > got capabilities response
> > sent set_config
>=20
> Try again now. a2play is still very crude with regards to the
> configuration setup and it seems you found a hard coded value: Your
> headset only supports a bitpool size between 0x04 and 0x40 while the
> others can do 0x02 to 0xFA and that was what a2play was trying to
> configure. I made a trivial modification to simply mirror the values th=
e
> headsets sends back.=20
>=20
> --=20
> Henryk Pl=F6tz
> Gr=FC=DFe aus Berlin
> ~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
> ~ Help Microsoft fight software piracy: Give Linux to a friend today! ~


</quote>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
