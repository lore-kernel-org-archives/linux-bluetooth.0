Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Embedded bluetooth recommendations
From: Marcel Holtmann <marcel@holtmann.org>
To: Wiebe Baron <Wiebe.Baron@Wirelessvalue.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <006201c4ba6b$d39682e0$a900a8c0@wivd10>
References: <006201c4ba6b$d39682e0$a900a8c0@wivd10>
Content-Type: text/plain
Message-Id: <1098693859.24932.18.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 25 Oct 2004 10:44:19 +0200

Hi Wiebe,

> I have a question about embedded Bluetooth. I'm working on a feedback
> control project which involves 8 devices. Up till now a module has
> been used with integrated stack but this is unable to support an
> RFCOMM link with seven slaves and the response time of a scatternet is
> unacceptable so I'm now looking for a multiprocessor solution with a
> separate stack. 

are you talking about seven RFCOMM links on the same ACL link or about
seven different ACL links. If you really wanna work with piconet where
the master controls 7 slaves you should use a CSR chip, because all
other Bluetooth chips are acting somekind weird. However even with the
CSR stuff you must make sure that at least a HCI 18.2 firmware is used.

> I'm currently experimenting with a sharp LH79520 with embedded Linux
> from metrowerks and Bluez but this seems to be overkill because the
> application requirements themselves are minimal (7 way cable
> replacement).

The Sharp uses an ARM7TDMI. Actually this is really overkill and then
you should better buy a Bluetooth chip that itself uses this ARM chip
like Zeevo etc. However then the above point comes in ...

> Does anyone have a suggestion of a combination of stack, operating
> system and microprocessor that is known to work together and has
> minimum requirements in terms of RAM, ROM and processor speed (cost)?

I am not a microprocessor expert, but actually every processor with
Linux support should be useable and BlueZ is of course the best choice
for a Bluetooth stack.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
