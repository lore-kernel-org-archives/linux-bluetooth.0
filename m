Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140321084928.GC5834@t440s.lan>
References: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
	<1395174391-27251-10-git-send-email-claudio.takahasi@openbossa.org>
	<20140321084928.GC5834@t440s.lan>
Date: Fri, 21 Mar 2014 11:29:28 -0300
Message-ID: <CAKT1EBcRCL8GX5FZyBxYuL9+YdGA1Z4ggD9s6CNtes0jVEVW4A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 09/16] gdbus: Add g_dbus_proxy_set_property_array
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Fri, Mar 21, 2014 at 5:49 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, Mar 18, 2014, Claudio Takahasi wrote:
>> This patch adds a new gdbus utility function to allow setting a property
>> of fixed, and non-fixed values array.
>> ---
>>  gdbus/client.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  gdbus/gdbus.h  |  5 ++++
>>  2 files changed, 90 insertions(+)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index 5193b6c..6fea3d9 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -727,6 +727,91 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
>>       return TRUE;
>>  }
>>
>> +gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
>> +                             const char *name, int type, const void *value,
>> +                             int size, GDBusResultFunction function,
>> +                             void *user_data, GDBusDestroyFunction destroy)
>
> Would size_t make more sense for the size parameter? Can it be negative
> (in which case maybe ssize_t)?
>
> Johan

Indeed, it doesn't make to use signed.

I will fix it.

Regards,
Claudio
