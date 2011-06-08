Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Bastien Nocera <hadess@hadess.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Date: Wed, 08 Jun 2011 18:43:57 +0100
In-Reply-To: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
References: <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
	 <1307440992-11087-1-git-send-email-hadess@hadess.net>
	 <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1307555040.2669.192.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2011-06-08 at 12:13 -0400, Anderson Lizardo wrote:
> Hi Bastien,
> 
> On Tue, Jun 7, 2011 at 6:03 AM, Bastien Nocera <hadess@hadess.net> wrote:
<snip>
> > +
> > +       if (g_file_get_contents(MACHINE_INFO_DIR MACHINE_INFO_FILE,
> 
> I wonder if it would be better to use the autoconf variable for
> "/etc/" instead of MACHINE_INFO_DIR.

I'm not sure that'd be any help. Even if bluez is installed in /opt/usr/
or something, the /etc/machine-info is still the canonical location of
that file.

<snip>
> Maybe it is also good to strip whitespaces before/after the string as
> well (there is a glib function for that).

We already strip the whitespaces when setting the adapter name, but I'll
gladly add that if you think it's important.

<snip>
> > @@ -938,38 +884,29 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
> >                                                DBUS_TYPE_STRING, &name_ptr);
> >        }
> >
> > +       if (adapter->up) {
> > +               int err = adapter_ops->set_name(adapter->dev_id, name);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               adapter->name_stored = TRUE;
> 
> This looks incorrect. If the if() is entered, adapter->name_stored is
> set to TRUE and right after to FALSE.

I think I fixed this, otherwise it's me not understanding what
adapter->name_stored is supposed to flag. If it's whether the adapter
name was written to /var/lib/bluetooth/.../config, then we could
probably simplify this code.
<snip>
> > -       if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
> > -               expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
> > -                                                       adapter->dev_id);
> > -
> > -       if (main_opts.attrib_server)
> > -               attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
> > -                       (const uint8_t *) adapter->name, strlen(adapter->name));
> 
> I can't find where you moved the attrib_gap_set() call to. This is
> necessary for GATT attribute server.

Check the code instead of the patch, it's already done in
adapter_update_local_name().
<snip>
> > diff --git a/src/manager.c b/src/manager.c
> > index e805e0c..dedec8b 100644
> > --- a/src/manager.c
> > +++ b/src/manager.c
> > @@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
> >                btd_start_exit_timer();
> >  }
> >
> > +int manager_get_default_adapter (void)
> 
> Unnecessary whitespace before "(". Also I've seem a patch sent to this
> list a while ago with this change.

That's Antonio's patch, but it returns the adapter struct, not the ID. I
changed the function name, so both can coexist (as both are needed).

Updated patch sent.

Cheers

