Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511010521x6dfff470o9580b22bebd1c75d@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
In-Reply-To: <1130850674.31561.65.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <1130760726.17124.17.camel@blade>
	 <e1effdeb0510310547m51a457f2m19f00ec5cf194289@mail.gmail.com>
	 <1130850674.31561.65.camel@blade>
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
Date: Tue, 1 Nov 2005 11:21:37 -0200

Hi Marcel,

I will wait the D-Bus path changes before submit this changes.

Regarding the error.c file it's just organization, I would like move
all error related function to other file.

Regards,
Claudio


On 11/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Probably in the future when we start develop another features(rfcomm,
> > pan, ...) we will find more shared functions. I will put the find_conn
> > to a lib.c(inside de hcid) directory first according with your
> > suggestion. In the future we can discuss it later again.
> > Another file that I want create is the error.c
>
> send me a separate patch for the move to the lib.c file.
>
> What do you wanna put into the error.c file. Explain me your idea behind
> it and the benefits.
>
> > When the dbus-daemon exits, the hcid will receive a "Disconnect"
> > signal. The hcid can start a task to re-establish the bus connection
> > each X seconds or it can exit.
> > Currently, hcid catches the signal, but there is no action associated
> > with this signal.
>
> I see and it seems we need a patch to deal with the dbus-daemon exits in
> case of restarts or errors in it. Please come up with a patch for it.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
