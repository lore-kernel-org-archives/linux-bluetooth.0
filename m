Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced05042822097559adc4@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to test the mic functionality in Bluez?
In-Reply-To: <200504281734.06880.pavouk@pavouk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7aa80ced05042807167abd7376@mail.gmail.com>
	 <200504281734.06880.pavouk@pavouk.org>
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
Date: Fri, 29 Apr 2005 10:39:23 +0530

Hi Pavel,
           Thanks for your valuable clue. I have tested the mic
functionality using "gnomemeeting". Now the mic is working.
           Though it is working with gnomemeeting, i can't able to
record the voice using gnome recorder under linux. Could u please tell
me how to do this?

Once again thanks a lot for your valuable clue, Pavel.

Thanks & Regards,
Mohan

On 4/28/05, Pavel Ruzicka <pavouk@pavouk.org> wrote:
> Hi,
>=20
> >        I want test the working of headset mic over bluetooth. Can
> > anybody tell me how to test this on the linux side?
>=20
> I use this simle shell command:
> "cat </dev/dsp1 >/dev/dsp0"
>=20
> My normal sound card is on /dev/dsp0 and BT headset on /dev/dsp1.
>=20
> Best regards,
>=20
> Pavel Ruzicka
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=3D105hix
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
