Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346961700.21200.116.camel@aeonflux>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1345272662-2850-7-git-send-email-lucas.demarchi@profusion.mobi> <1346961700.21200.116.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 12 Sep 2012 00:34:49 -0300
Message-ID: <CAMOw1v4s0q+VNk62-AbikmbOEDHwBme4oFko75FeJFfoSO1iNA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 06/15] gdbus: Implement DBus.Properties.Set method
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Sep 6, 2012 at 5:01 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lucas,
>
>> Contrary to Get() and GetAll(), Set is asynchronous so we pass on the
>> DBusMessage so user is able to create the response. It's the only use of
>> this parameter.
>> ---
>>  gdbus/gdbus.h  |  7 +++++++
>>  gdbus/object.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 64 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>> index b2e78c4..3e4aa16 100644
>> --- a/gdbus/gdbus.h
>> +++ b/gdbus/gdbus.h
>> @@ -31,6 +31,8 @@ extern "C" {
>>  #include <dbus/dbus.h>
>>  #include <glib.h>
>>
>> +typedef enum GDBusPropertySetReturn GDBusPropertySetReturn;
>> +
>>  typedef enum GDBusMethodFlags GDBusMethodFlags;
>>  typedef enum GDBusSignalFlags GDBusSignalFlags;
>>  typedef enum GDBusPropertyFlags GDBusPropertyFlags;
>> @@ -69,6 +71,10 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
>>  typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
>>                                       DBusMessageIter *iter, void *data);
>>
>> +typedef DBusMessage *(*GDBusPropertySetter)(const GDBusPropertyTable *property,
>> +                                     DBusMessageIter *value,
>> +                                     DBusMessage *msg, void *data);
>> +
>
> I am not really happy with this. We just need a unique handle here since
> the return value is either success or an error. I rather don't send
> messages around for no other reason to create the error.
>
> Inside the authorization code I am using GDBusPendingReply as unique
> token. What about using the same approach?

Sounds reasonable... I'll send an update on the next days.

Thanks
Lucas De Marchi
