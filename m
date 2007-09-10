Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8c7950360709101256u4a62893dmcd4b342343088a73@mail.gmail.com>
Date: Mon, 10 Sep 2007 15:56:28 -0400
From: shanevolpe@gmail.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1189451433.687.59.camel@violet>
MIME-Version: 1.0
References: <8c7950360709061306w39a081f1od1c372dafabc5072@mail.gmail.com>
	<1189451433.687.59.camel@violet>
Subject: Re: [Bluez-users] devices always connect with out asking for PIN
	even with pairing enabled!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel,

I was not trying to do wild guessing with the hci.conf, I have read
the readme's and MAN files on the hcid.conf.   What I'm trying to
better understand is performing secure bluetooth however can't find
documentation on what type of security is available during the initial
paring process.  It seem to me that at the hci level is the correct
place to provide security.

At a minimum I want to provide a unique PIN so that only devices with
that PIN can pair to my unit but I also don't want someone using
hcidump to sit by two of my units that are pairing and get the PIN.

Ideally it would be great to have something similar to ssh were I
could only allow a certain encrypted key to pair to my device.  Then I
could distribute that private encrypted key to all devices that I want
to give connection privilege.   That is what I originally thought the
Auth/Encryption option was for in the hcid.conf but after reading the
MAN page I don't believe that is the case.

FYI:
The hcid.conf MAN page states that encryption in most cases should be
enabled however most default hcid.conf files has it disabled so that
would infer that a user should go in and change the hcid.conf.

I think what I'm finding out (after reading the MAN page again)  is
the best place to get a better understanding of bluetooth security
options is the Bluetooth standards so I will try next to get a copy of
them.

I understand your frustration with the same issues being posted time
and time again and I have tried to avoid doing that by googling the
bluez site and email list.  I will continue to search and try to find
what I have obviously missed!

Regards and sorry,
Shane

On 9/10/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Shane,
>
> > I have two embedded Linux devices that I'm running a network between
> > using PAN.  I have decided that I would like to enable pairing and
> > eventually encryption for security reasons.
> > Here is what I have done I'm starting pand master with the following:
> > pand --listen --master --role  NAP
> > and the slave with
> > pand --connect 00:A0:96:18:69:D8 --persist
> > were 00:A0:96:18:69:D8 is the masters address.
> >
> > Below are the hci.conf files for both my master and slave device..
>
> don't touch hcid.conf unless you know exactly what you are doing. Wild
> guessing doesn't help here and if you mess it up then it is your fault.
> I mentioned that multiple times, but people keep doing it anyway.
>
> If you wanna have authentication and encryption, then read the manual
> page of pand. It allows you to specify this for the server.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Registered Linux User: #293401

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
