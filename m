Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf0510050701n2a3b6057md6803ff4c1ac432f@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Profile porting
In-Reply-To: <1128424346.5226.13.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf0510032315i46206dbfnc599fc704d1d65a7@mail.gmail.com>
	 <1128424346.5226.13.camel@blade>
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
Date: Wed, 5 Oct 2005 19:31:15 +0530

Hello all,
If SPP profile support is present, please advise us to how to
implement and test it

Hariharan.V.

On 10/4/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hariharan,
>
> > Presently we are working in porting of Profile with Bluez stack.
> > Anyone please advise whether the Bluez stack contains the
> >
> > Serial Port Profile, Head set profile.
> >
> > If yes, Advise us regarding the documents location of Profile porting
>
> the serial port profile is supported, because we implement the RFCOMM
> protocol. For the headset profile you should take a look at the ALSA
> Bluetooth project.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
