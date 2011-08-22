Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110822072228.GA31063@dell>
References: <CAPGrrxU2otU=wmvtsq=xdcc35FOA5p02h=stg-h4WV-u=dJb7g@mail.gmail.com>
	<1313133349-4215-1-git-send-email-bulislaw@linux.com>
	<20110822072228.GA31063@dell>
Date: Mon, 22 Aug 2011 10:12:11 +0200
Message-ID: <CAPGrrxUDgQOzX7zgHy28dxux3LkRy4Ap=dtuGZJSYPovNqELBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Add SetRemoteProperties method for OOB COD setting
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 22, 2011 at 9:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bartosz,
>
> On Fri, Aug 12, 2011, Bartosz Szatkowski wrote:
>> +struct oob_remote_parameters {
>> +     bdaddr_t local;
>> +     bdaddr_t peer;
>> +     const char *address;
>> +     uint32_t class;
>> +};
>
> Could you add a "gboolean device_found;" to this struct and then use it
> as follows:

OK

>
>> +static DBusMessage *parse_class(DBusMessageIter *value,
>> +                     struct oob_remote_parameters *params, DBusMessage *msg)
>> +{
>> +     if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
>> +             return btd_error_invalid_args(msg);
>> +
>> +     dbus_message_iter_get_basic(value, &params->class);
>
>        params->device_found = TRUE;

I would move (above) line to set_class function (and same for other
patches) as there is no point of emiting device_found in case of some
error when trying to set it, it would look something like:

static void set_class(struct oob_remote_parameters *params)
+{
+	if (write_remote_class(&params->local, &params->peer,
+							params->class) < 0) {
+		error("Setting device class failed");
+
+		return;
+	}

        params->device_found = TRUE;
+}


-- 
Pozdrowienia,
Bartosz Szatkowski
