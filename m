Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <006501c4bcd8$ab2e1ba0$af00a8c0@wivd10>
From: "Wiebe Baron" <Wiebe.Baron@Wirelessvalue.nl>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <006201c4ba6b$d39682e0$a900a8c0@wivd10> <1098693859.24932.18.camel@pegasus>
Subject: Re: [Bluez-users] Embedded bluetooth recommendations
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 28 Oct 2004 12:27:04 +0200

Hi Marcel,

> > I have a question about embedded Bluetooth. I'm working on a feedback
> > control project which involves 8 devices. Up till now a module has
> > been used with integrated stack but this is unable to support an
> > RFCOMM link with seven slaves and the response time of a scatternet is
> > unacceptable so I'm now looking for a multiprocessor solution with a
> > separate stack.
>
> are you talking about seven RFCOMM links on the same ACL link or about
> seven different ACL links. If you really wanna work with piconet where
> the master controls 7 slaves you should use a CSR chip, because all
> other Bluetooth chips are acting somekind weird. However even with the
> CSR stuff you must make sure that at least a HCI 18.2 firmware is used.

Yes the idea is to use seven ACL links. Luckily the current design uses a
sharp process in combination with a CSR chip.

>
> > I'm currently experimenting with a sharp LH79520 with embedded Linux
> > from metrowerks and Bluez but this seems to be overkill because the
> > application requirements themselves are minimal (7 way cable
> > replacement).
>
> The Sharp uses an ARM7TDMI. Actually this is really overkill and then
> you should better buy a Bluetooth chip that itself uses this ARM chip
> like Zeevo etc. However then the above point comes in ...

I took a look at the Zeevo but it only seems to support 4 simultaneous ACK
links which is a bit worrying given that it's based on the same ARM chip.
>
> > Does anyone have a suggestion of a combination of stack, operating
> > system and microprocessor that is known to work together and has
> > minimum requirements in terms of RAM, ROM and processor speed (cost)?
>
> I am not a microprocessor expert, but actually every processor with
> Linux support should be useable and BlueZ is of course the best choice
> for a Bluetooth stack.

Thanks for the advice. This is the route I'm going to be taking.

Cheers,
Wiebe.

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
