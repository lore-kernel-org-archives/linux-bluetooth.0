Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110325133237.GA6600@jh-x301>
References: <1301059143-14614-1-git-send-email-sancane@gmail.com>
	<20110325133237.GA6600@jh-x301>
Date: Fri, 25 Mar 2011 14:47:51 +0100
Message-ID: <AANLkTimEenNDyt3Q6wSoeqiA83hQ4Xth=2dUTf1J9knH@mail.gmail.com>
Subject: Re: [PATCH] Emit missing signal when data channel is reconnected.
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

See coments below.

2011/3/25 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Fri, Mar 25, 2011, Santiago Carot-Nemesio wrote:
>> Reconnections of data channels should be indicated to others
>> applications by using the appropriate signal.
>> ---
>>  health/hdp.c |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/health/hdp.c b/health/hdp.c
>> index 3c2dce1..b06fe17 100644
>> --- a/health/hdp.c
>> +++ b/health/hdp.c
>> @@ -510,14 +510,23 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
>>       }
>>
>>       fd = mcap_mdl_get_fd(dc_data->hdp_chann->mdl);
>> -     if (fd < 0)
>> +     if (fd < 0) {
>>               reply = g_dbus_create_error(dc_data->msg,
>>                                               ERROR_INTERFACE ".HealthError",
>>                                               "Cannot get file descriptor");
>> +             g_dbus_send_message(dc_data->conn, reply);
>> +             return;
>> +     }
>>

This is not a memory leak fix, if fd is less than 0, then reconnection
was not succesfully and then we reply with an error response to the
application but we dont not emit the CahnnelConnected signal. (return
statement).

>>       reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD, &fd,
>>                                                       DBUS_TYPE_INVALID);
>>       g_dbus_send_message(dc_data->conn, reply);

At this point we have a valid file descriptor and we can send the signal.

>> +
>> +     g_dbus_emit_signal(dc_data->conn,
>> +                     device_get_path(dc_data->hdp_chann->dev->dev),
>> +                     HEALTH_DEVICE, "ChannelConnected",
>> +                     DBUS_TYPE_OBJECT_PATH,
>> +                     &dc_data->hdp_chann->path, DBUS_TYPE_INVALID);
>>  }
>>
>>  static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
>
> Looks like this patch is doing two things:
>
> 1. Fix the memory leak/missing g_dbus_send_message call for the return
> value from g_dbus_create_error.
>
> 2. Add sending of the "ChannelConnected" signal.
>
> Could you please split it into two separate patches?
>
> Johan
>
