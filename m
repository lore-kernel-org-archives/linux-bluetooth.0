Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3E26DA7001815B7D@mel-rta8.wanadoo.fr> (added by postmaster@wanadoo.fr)
From: David LIBAULT <david.libault@inventel.fr>
Reply-To: david.libault@inventel.fr
To: <halam.rose@7layers-uk.com>, "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-devel] BlueZ Qualification  and 7 Layers UK
Cc: "Max Krasnyansky" <maxk@qualcomm.com>, "Daryl Van Vorst" <dvpub@telus.net>, "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <MGEGKHCLDAFHMAIHGKNCCEBHFIAA.halam.rose@7layers-uk.com>
In-Reply-To: <MGEGKHCLDAFHMAIHGKNCCEBHFIAA.halam.rose@7layers-uk.com>
MIME-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 28 Feb 2003 12:10:31 +0100
Content-Type: text/plain; CHARSET=iso-8859-15

Le Vendredi 28 F=E9vrier 2003 11:49, Halam Rose a =E9crit :
> Hello.
>
> I run the Bluetooth lab at 7 Layers UK and contacted Max offering to do
> qualification work for BlueZ in some not-obviously-commercial way.  A qui=
ck
> summery of who we are may help you understand where we are coming from.
>
> 7 Layers run numerous Bluetooth and GSM labs around the world, boast 4
> BQB's and also supply and support Bluetooth test labs for other
> organisations.
>
> 7 Layers UK are eagerly awaiting completion of our BQTF status (the audit
> was the hardest 2 days work I can remember...),  our BQB is nearly 1 year
> old :o)  We have a qualified RF and protocol test rig though some tests w=
e
> have done by 7 Layers in Germany.
>
> I want to get involved in BlueZ and am willing to devote some time and
> perhaps even money to it.  My Linux experience is limited and personally =
I
> know the bottom end of the Bluetooth stack much better than the top.
>
> It seems I am in a good position to assist or coordinate the qualificatio=
n
> of BlueZ.  Now I don't relay know who you are and what your involvement
> with BlueZ is, please could you drop me a few lines of introduction.  Als=
o
> I'd like to know how having a qualified BlueZ would help you so I can foc=
us
> on the value.

I work for Inventel (go to www.inventel.com for more information). Basicall=
y=20
we design and manufacture wireless access points. We already have one produ=
ct=20
qualified (BlueDSL) althouth it doesn't use Bluez.
Our next generation product uses Bluez, and we have already started=20
qualification tests/reports regarding the bluetooth stack. The profiles we=20
need to qualify are=20

LAN Access Profile
PAN

It would be an interest for us to have Bluez officially qualified, as we=20
wouldn't have to redo this part of the Bluetooth qualification for everyone=
=20
of our products...=20

Do you plan to have Bluez listed as a qualified stack ?
What "tester side" are you using to do the qualification ?

We can help by providing you with a Bluetooth access point with everything=20
you need to run the scripts, modify the stack etc...

Although we only need to qualify the access point side of the profiles, you=
=20
can use this platform to do anything with bluez including other profiles=20
qualification etc...

Regards,

David.
>
> Best Wishes
>
> Halam
>
> --------------------------------------------
> Halam Rose
> Bluetooth Specialist
> 7 layers UK Ltd
>
> Don't miss the 7 layers
> Update-seminar on testing & qualification
> 9 April 2003
> London Heathrow
> more details: www.7layers.com/news-room/news-room-events-2003.html
>
> Tel: +44 (0)1763 262524
> Fax: +44 (0)1763 261177
> Mob: +44 (0)7876 560922
> Halam.Rose@7layers-UK.com
> www.7layers-UK.com
>
> Melbourn Science Park
> Cambridge Road
> Melbourn
> Hertfordshire SG8 6HB
>
> --------------------------------------------
> The information contained in this message
> is confidential and should not be disclosed
> to any third party whether or not you are the
> intended addressee indicated in the message.
> Addressees of this email may exercise their
> rights under the 1988 Data Protection Act.
> --------------------------------------------
>
>
>
>
> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]
> Sent: 28 February 2003 09:39
> To: david.libault@inventel.fr
> Cc: Max Krasnyansky; Daryl Van Vorst; BlueZ Mailing List;
> Halam.Rose@7layers-UK.com; BlueZ Mailing List
> Subject: Re: [Bluez-devel] BlueZ Qualification
>
>
> Hi,
>
> > Max, can you "coordinate the efforts" for qualification ?
> > Who is going to write the test report ?
> > Is Bluez going to be listed as official Bluetooth qualified stack ?
> > Who is your contact at 7layers ?
>
> I have had a nice talk about this topic with Prof. Dr.-Ing. J=F6rg Woller=
t
> from the FH Bochum at the Bluetooth Kongress in Germany. They have done
> some work with 7 Layers Germany and if you like I can try to coordinate
> the efforts to get a Bluetooth qualification for BlueZ.
>
> Regards
>
> Marcel
>
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
