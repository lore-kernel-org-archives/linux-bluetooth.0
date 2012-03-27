Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix crash when HDP first reliable channel is nil
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <20120327113651.GF14481@x220>
Date: Tue, 27 Mar 2012 08:59:53 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3F2966DC-88F7-4852-930F-4FC312BC0087@signove.com>
References: <1331938389-4856-1-git-send-email-epx@signove.com> <20120327113651.GF14481@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>, sancane@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mar 27, 2012, at 8:36 AM, Johan Hedberg wrote:

> Hi Elvis,
> 
> On Fri, Mar 16, 2012, Elvis Pfützenreuter wrote:
>> Congruent to health_channel_destroy(), the "/" path is returned by MainChannel
>> property of HealthDevice when the first reliable channel is nil.
>> 
>> An empty path provokes the following error:
>> 
>> process xxxs: arguments to dbus_message_iter_append_basic() were incorrect,
>> assertion "_dbus_check_is_valid_path (*string_p)" failed in file
>> ../../dbus/dbus-message.c line 2539.  This is normally a bug in some
>> application using the D-Bus library.
>> ---
>> health/hdp.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/health/hdp.c b/health/hdp.c
>> index 812352f..eba438a 100644
>> --- a/health/hdp.c
>> +++ b/health/hdp.c
>> @@ -2077,7 +2077,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
>> 	if (device->fr != NULL)
>> 		path = g_strdup(device->fr->path);
>> 	else
>> -		path = g_strdup("");
>> +		path = g_strdup("/");
>> 	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH, &path);
>> 	g_free(path);
>> 	dbus_message_iter_close_container(&iter, &dict);
> 
> Would it maybe make more sense to simply not include this property in
> the property list if device->fr is NULL? (after all, there's nothing
> interesting to be found at "/" from a HDP perspective)
> 

Could be, but when fr is deleted, a PropertyChanged signal is emitted for
MainChannel. Is there some way to signal that a property has been removed?