Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0512211051i63f7e734jac900d5fd9ab70ca@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [gbluezconf] D-Bus client prototype
In-Reply-To: <1135120979.26233.40.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0512201427g43906c29g78a8ce4fcdc3c71a@mail.gmail.com>
	 <1135120979.26233.40.camel@localhost>
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
Date: Wed, 21 Dec 2005 16:51:13 -0200

Hi Marcel,

There is a new version available. The search problem was fixed. It was
related to wrong inquiry result signature checking.
http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.02.tar.gz


On 12/20/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > The first prototype is available at:
> > http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.01.tar.gz
>

> it needed some love to make it compile, but I got it somehow. It also
> depends on stuff that I haven't committed to the CVS so far. Especially
> the missing/uninstalled <bluetooth/dbus.h> header file is a little bit
> tricky.
>
> > Main features:
> > 1. D-Bus PIN client
>
> I was able to test the PIN dialog and I really like that feature,
> because the bluez-pin with D-Bus is basically unmaintained and I would
> be happy if it disappears and every desktop or window manager comes with
> its own PIN helper client.
>
> > 2. Search Dialog
>
> Wasn't able to get this working.
[Claudio Takahasi]
Bug fixed!

>
> > Read to RELEASE_NOTES file to see the TODO list.
>
> Let me give some comments on your TODO list.
>
> We should definitiv use libnotify and only display the PIN dialog when
> somebody clicked on the bubble. A flashing icon is nice, but I haven't
> seen any other Gnome application using flashing icons for that. Might be
> also against the HIG.
[Claudio Takahasi]
Ok. I will investigate the best approach.

>
> For the device icons you should contact the Tango team or the Gnome Art
> team. Maybe they will come up with some.
>
> The program should start even if no Bluetooth adapter would be found. In
> this case only "About" and "Quit" should be visible.
[Claudio Takahasi]
I think it's better disable the options instead of remove the menu
item from the popup menu.

>
> For the configuration dialog and multiple adapters we should maybe use
> the proposal from the bluetool screenshot (attached). I think it should
> include a page for default/common settings for all devices. And then
> some device specific parts that should have an extra check-box to
> activate their settings or use the common ones.
[Claudio Takahasi]
Ok I will analize the bluetool approach. Multiple adapter is not a
common scenario. Therefore we need avoid display unnecessary infos. I
try re-design the "Configuration" dialog to make it more
user-friendly.

> Don't forget to make the device name and class of device configurable.
[Claudio Takahasi]
Device name changes is already possible. However change the device
class is not possible at the momment. We can extend the D-Bus services
soon.

>
> I am also a big fan of Okay/Cancel/Apply style dialogs, but the Gnome
> standard is basically only Close (plus a help button) and we should
> follow that style. The settings will become immediately active.
>
[Claudio Takahasi]
Ok. I will try follow the Gnome style.

> The search dialog shouldn't always start with zero devices if a previous
> inquiry has already taken place. However I think for this we need to
> implement a device cache inside hcid that could be requested up-front.
[Claudio Takahasi]
When the kernel/userspace communication interface becomes available we
can improve this dialog. The remote name needs be improved too, we can
use the textfile_get function to  retrieve cached remote names.

>
> Besides the inactivity of the icon if no adapter is attached or if no
> adapter is up, we maybe should change the icon if we have an active ACL
> link. We can also use a different icon or animation if the device is
> running an inquiry.
[Claudio Takahasi]
I try suggest new icons for address these cases next year.

>
> Anyhow, good work, I really like it and keep on coding.
>
> What do you think about creating an own CVS repository for it.
[Claudio Takahasi]
Do you mean create a new CVS root in BlueZ CVS repository? If yes, go ahead=
.
Currently, I am storing in my internal subversion server, but it's
better provide a public access.

>
> Regards
>
> Marcel

[Claudio Takahasi]
I will be on vacation until jan/15th. For D-Bus issues you can contact Edua=
rdo.
For GBluezConf, I will return the activities in the next year only.

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
