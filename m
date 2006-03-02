Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0603021302h2ffbcd80y1a9c46bf93e51278@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] The new D-Bus API specification
In-Reply-To: <1140807942.7264.44.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1140652705.4519.71.camel@localhost>
	 <1140807942.7264.44.camel@localhost>
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
Date: Thu, 2 Mar 2006 18:02:48 -0300

Hi Marcel,

I tested the latest bluez-utils CVS version with the recent D-Bus
changes and I have some comments:

* Policy
I'm not sure, but I think some linux distributions use pam_console
instead of at_console. We sould investigate more to avoid future
problems. Another thing are the rules. at_console aims provide a way
to refer to users that are not physically sitting in front of the
computer. I tested send D-Bus messages from the local host or
connected through ssh and I didn't noticed differences. I mean, the
behaviour is the same. Remote users still able to send D-Bus messages.

* Device->Adapter
Maybe should be better if we rename the function names and constants
too. Or remove the prefix "dev" and "DEV". These prefixes were added
to avoid confusion when all functions were in the same file.

* Error
  I noticed that there are different handling of hci_open_dev result.
I found bluez_new_failure_msg and error_no_such_device calls to handle
the same error. I will send a patch to use the same approach.

Regards,
Claudio.

On 2/24/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
> > there have been rumors about a written API specification for the D-Bus
> > interface of hcid (and bluetoothd in the future) and all of them is
> > actually true. You will find the current version under hcid/dbus-api.tx=
t
> > inside the bluez-utils CVS. This isn't the final version, but it really
> > looks good and something about 90% has been implemented in the last few
> > weeks. Most of the work has been done by Claudio, Eduardo and Johan. So
> > thank these guys for their work.
> >
> > I like to see the rest 10% implemented and after that my plan is to
> > release the next version of bluez-utils and open it for wider testing,
> > but any feedback at this point is highly welcome. And I also like to se=
e
> > sample programs in various languages that we can include for reference.
>
> there has been some more progress and a small update to the D-Bus API
> document. The current CVS contains the latest version which includes
> also a dbus-test script written in Python. The local device name and
> minor device class are now stored on the filesystem and remembered after
> reboot.
>
> Please review the API document and send in comments. We also need a more
> secure D-Bus service config file.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
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
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
