Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601261259h7eb14f95wc315f53a2c0baa14@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [gbluezconf] D-Bus client prototype
In-Reply-To: <1135192627.25328.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0512201427g43906c29g78a8ce4fcdc3c71a@mail.gmail.com>
	 <1135120979.26233.40.camel@localhost>
	 <e1effdeb0512211051i63f7e734jac900d5fd9ab70ca@mail.gmail.com>
	 <1135192627.25328.8.camel@localhost>
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
Date: Thu, 26 Jan 2006 18:59:25 -0200

Hi Marcel,

A new prototype version is available at:
http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.04.tar.gz

Main features, enhancements and bug fixes:
1. Search dialog: devices are displayed based on "InquiryResult"
signal. The remote name is retrieved later.
2. Added gnome animation to indicate "inquiry in progress".
3. Changed buttons/menu according to Gnome UI guideline
4. Added internationalization
5. New icons based on gnome theme. (According to gnome art team, pango
project icons should not be used.)
6. When there isn't adapter available, menu options("Search" and
"Advanced Configuration" ) are disabled.
7. Added libnotify
8. Multiple search dialog double memory free fixed
9. UI glade file spplited to make the code mantainance easier

This code is compliant with bluez-utils-2.25
Suggestions are welcome!


Next planned actions:
1. Active connection dialog
2. Local Name
3. Set Connectable/Discoverable
4. Se Device class
5. Multiple adapter configuration


Regards,
Claudio.

On 12/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > > For the device icons you should contact the Tango team or the Gnome A=
rt
> > > team. Maybe they will come up with some.
> > >
> > > The program should start even if no Bluetooth adapter would be found.=
 In
> > > this case only "About" and "Quit" should be visible.
> >
> > I think it's better disable the options instead of remove the menu
> > item from the popup menu.
>
> I would prefer to switch the visibility off, but you might check the
> Gnome HIG guidelines for this.
>
> > > For the configuration dialog and multiple adapters we should maybe us=
e
> > > the proposal from the bluetool screenshot (attached). I think it shou=
ld
> > > include a page for default/common settings for all devices. And then
> > > some device specific parts that should have an extra check-box to
> > > activate their settings or use the common ones.
> >
> > Ok I will analize the bluetool approach. Multiple adapter is not a
> > common scenario. Therefore we need avoid display unnecessary infos. I
> > try re-design the "Configuration" dialog to make it more
> > user-friendly.
>
> I think that I gave this comment already. Having multiple adapters is
> the normal situation. The special case is only one adapter. You can't
> view it other way around.
>
> > > Don't forget to make the device name and class of device configurable=
.
> >
> > Device name changes is already possible. However change the device
> > class is not possible at the momment. We can extend the D-Bus services
> > soon.
>
> We should extend, but only major and minor class. Not the services
> classes, because they will depend on the registered services. Feel free
> to send me a patch for it.
>
> > > The search dialog shouldn't always start with zero devices if a previ=
ous
> > > inquiry has already taken place. However I think for this we need to
> > > implement a device cache inside hcid that could be requested up-front=
.
> >
> > When the kernel/userspace communication interface becomes available we
> > can improve this dialog. The remote name needs be improved too, we can
> > use the textfile_get function to  retrieve cached remote names.
>
> We can do already now if we know what is needed. Getting access to the
> cached devices names must go also through D-Bus and actually I prefer to
> make the name part of the device information. Proposals are welcome.
>
> > > Besides the inactivity of the icon if no adapter is attached or if no
> > > adapter is up, we maybe should change the icon if we have an active A=
CL
> > > link. We can also use a different icon or animation if the device is
> > > running an inquiry.
> >
> > I try suggest new icons for address these cases next year.
>
> Anyone from the Tango or Gnome Art team reading this mailing list?
>
> > > What do you think about creating an own CVS repository for it.
> >
> > Do you mean create a new CVS root in BlueZ CVS repository? If yes, go a=
head.
> > Currently, I am storing in my internal subversion server, but it's
> > better provide a public access.
>
> I will try to setup a repository for it next week, but be aware of that
> the directory layout would be changed a lot ;)
>
> > I will be on vacation until jan/15th. For D-Bus issues you can contact =
Eduardo.
> > For GBluezConf, I will return the activities in the next year only.
>
> Happy vacation.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
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
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
