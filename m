Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876E368D6F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021631; cv=none; b=GD5d7QFjL037LnYcfWUVohb4wAfgGr34+0yBx1Cne4W+hIlqDfJorHod796FU24AgCoOsjYA2DFLj1r3Ex+VTJ+sGybtFpauSfpKMYRm9jJQeN6jNPXiagKH9EeXHzjhUZLFFCKMdeeT1/0aRDa2GoyWuAqRDa74QfSQDj0WxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021631; c=relaxed/simple;
	bh=1V/Ez3WKzYEA/N6YMvF/nL9C7iLyuGt49p69la6yvQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3+n2hIc7UohJ1Q+keILsCsVPlW1P4W8kXHUkD+Kaaiz+UUlHgtMX2I79O/ZRJ0+j2LWZ3DaH5dUawUCb52fBEvSzvu4SAlRpkZlOcn7Vf1H2e10jk7tSfGHvUQArfruV0BoO1pjPNNR3EoBy8V+VYNDBw8XluYg+jNdMgX654U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=GgAbizua; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="GgAbizua"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2974273f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781021626; x=1781626426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgrmfBC+ByaSjPmpzscQtbPdsSCH+GPmpEBS3nsxw9U=;
        b=GgAbizua+rEHK2/Oi5nGgQue5O6usoiEnpSUdtIHuq0GdFZZjNs+fphKSQJJeqzqTg
         LJkoO1FTwarInDtg1nMLlhkh4TzTM5VALUWp/Qqyne0VmTDgiebnQHLVnkeShBvjkJ8N
         6rLRQProWbjKvRdm/Y+Y/7PkxT8lzQ4/7WwGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021626; x=1781626426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgrmfBC+ByaSjPmpzscQtbPdsSCH+GPmpEBS3nsxw9U=;
        b=AEF6kI8akjote0+nxKMktdhNr1C8BZZg2xNjxpqzMGZhop3r8WP331iq3kqeAuRHqB
         jqGKoPClFpzMLF8x2srCrNrWAthmeY8vH0HEjBXzhbl40KszMpT8k/nvsvPh33Q/cXY1
         MJf0iHeqAUIFxIpqVU76Z6uV39BTZL7ohkoW598bnRrJIgc6X+O83M583GgX9yXOMtbq
         uek+PSGaxql6JWHgFn4KJQnRBufNNFxwiqG89Zf/XWdnt5PBYTV6RE1x1gJUxk8khXJ7
         nPKMpesf64UitXzTrZvmseUtE7j+v8G+SIPybnafLiuQOYXNN4MkviOE71ydOfHQ8b4c
         +tcA==
X-Gm-Message-State: AOJu0Yxdl+QuKAAB0nJyuNI80SWn5Jg8Al8NyRBgyzrBdQ5h1xc7mE3T
	/m3SLINgbAE6i2Jx0d5TJDu0RFPUy5/6BUtuhfmoPdzurBRWdi8Nx/8hJQP88DRJtAPokBuXrhH
	i0dkx
X-Gm-Gg: Acq92OEJoFfJru93AT53dX5aoJt7h9aeWgdAw62o4KgcDALXtP+rPElqwz5wOHv/LBp
	OsGMjJViZskSg8J35sEX/4ZDy0GBfDFIesUh//1TrIs/bGhWAHxYg24hQnsdq5C7H45jJbHUBny
	ItRy49tZySlrTl/+lBB6PMU9LYjsk0W+O3Z0DG9UWBZfbmPJEcTvlrdSSCgzb/uyzZo/aWjVZhk
	3j9AZBs/CsAEBEynyMru/Q1GHZhs6gh1AUPHKJZJyLG0e9J286fklzHSl+toOkFvRso1yGsL+iB
	n41+BTLBWOlQN5MXflSZmL/spdO8tG16mZJ6zjNCUkNhZ9VHd4NtUbAuCK5HxUyXnyORHROw77s
	fHf83rkEiJJSbiAnJO91QfN91CL7M6F39ucpO9MTP/wSYrzdss3L0O6kNHmyCD10dTElXjhx1Tz
	BaluT+UheHsY9JoyZ9cfMjmeXgLy11/pf+RBfYPGegz+Sol4GCj77E7XvNcYjmvn3X
X-Received: by 2002:adf:e509:0:b0:441:239e:2bb8 with SMTP id ffacd0b85a97d-460304f0ad9mr25532379f8f.7.1781021626059;
        Tue, 09 Jun 2026 09:13:46 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm59604474f8f.22.2026.06.09.09.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:13:45 -0700 (PDT)
Message-ID: <1ec8bd78-5a60-4bfd-b079-a1a78207bc1c@streamunlimited.com>
Date: Tue, 9 Jun 2026 18:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/2] avdtp: Add GetConfiguration DBus function
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
 <CABBYNZKkiRaDQFUrMp65=DF-37gBnSJ0H__bj-iA4Nx2Y=Yhkw@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZKkiRaDQFUrMp65=DF-37gBnSJ0H__bj-iA4Nx2Y=Yhkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, the configuration is exposed, but it is the configuration we 
already selected or accepted.
You are right, it is to pass PTS test cases, but i think there are 2 
valid points:
1. Provide API completeness
2. Theoretically, it is "useful", you could GetConfiguration of other 
endpoints that are configured from other remote device

You are right, this API certainly won't be used and has no valid use 
case, so if this is not merged it is no big deal. But you can pass PTS 
test cases, and you can retrieve "fresh" configuration from remote devices.

It can be hidden by some configuration, but i have no idea how. Can you 
give some pointers on this?


On 6/8/26 15:59, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Mon, Jun 8, 2026 at 8:15 AM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> Change avdtp_get_configuration to accept remote SEP instead of stream a
>> and add an async callback for response/reject handling; the old function
>> was not used anywhere (unit-test just copied signature), so it was
>> changed in place.
>>
>> Add a GetConfiguration async D-Bus method to the remote SEP interface that
>> returns the retrieved configuration as a byte array.
>>
>> This can be used to pass: AVDTP/SRC/INT/SIG/SMG/BV-11-C
>> ---
>>   profiles/audio/a2dp.c  | 63 ++++++++++++++++++++++++++++++++++
>>   profiles/audio/avdtp.c | 76 ++++++++++++++++++++++++++++++++++++++++--
>>   profiles/audio/avdtp.h |  9 ++++-
>>   3 files changed, 144 insertions(+), 4 deletions(-)
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index c7e0fc75c..8dcf510ca 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -2168,11 +2168,74 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
>>          return NULL;
>>   }
>>
>> +static void get_configuration_cb(struct avdtp *session, GSList *caps,
>> +                               struct avdtp_error *err, void *user_data)
>> +{
>> +       DBusMessage *msg = user_data;
>> +       DBusMessage *reply;
>> +       DBusMessageIter iter, array;
>> +       GSList *l;
>> +
>> +       if (err) {
>> +               reply = btd_error_failed(msg, "GetConfiguration rejected");
>> +               goto done;
>> +       }
>> +
>> +       reply = dbus_message_new_method_return(msg);
>> +
>> +       dbus_message_iter_init_append(reply, &iter);
>> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> +                                       DBUS_TYPE_BYTE_AS_STRING, &array);
>> +
>> +       for (l = caps; l; l = g_slist_next(l)) {
>> +               struct avdtp_service_capability *cap = l->data;
>> +               uint8_t *ptr = (uint8_t *) cap;
>> +               int i;
>> +
>> +               for (i = 0; i < cap->length + 2; i++)
>> +                       dbus_message_iter_append_basic(&array,
>> +                                                       DBUS_TYPE_BYTE,
>> +                                                       &ptr[i]);
>> +       }
>> +
>> +       dbus_message_iter_close_container(&iter, &array);
>> +
>> +done:
>> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
>> +       dbus_message_unref(msg);
>> +       g_slist_free_full(caps, g_free);
>> +}
>> +
>> +static DBusMessage *get_configuration(DBusConnection *conn,
>> +                                               DBusMessage *msg, void *data)
>> +{
>> +       struct a2dp_remote_sep *rsep = data;
>> +       struct a2dp_channel *chan = rsep->chan;
>> +       int err;
>> +
>> +       if (chan->session == NULL)
>> +               return btd_error_not_available(msg);
>> +
>> +       err = avdtp_get_configuration(chan->session, rsep->sep,
>> +                                       get_configuration_cb,
>> +                                       dbus_message_ref(msg));
>> +       if (err < 0) {
>> +               dbus_message_unref(msg);
>> +               return btd_error_failed(msg, strerror(-err));
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static const GDBusMethodTable sep_methods[] = {
>>          { GDBUS_ASYNC_METHOD("SetConfiguration",
>>                                          GDBUS_ARGS({ "endpoint", "o" },
>>                                                  { "properties", "a{sv}" } ),
>>                                          NULL, set_configuration) },
>> +       { GDBUS_ASYNC_METHOD("GetConfiguration",
>> +                                       NULL,
>> +                                       GDBUS_ARGS({ "configuration", "ay" }),
>> +                                       get_configuration) },
> The configuration is already exposed via MediaTransport properties:
>
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.rst#arraybyte-configuration-readonly
>
> So if this is only to satisfy PTS, maybe it should be hidden behind
> main.conf:Testing, that said we do have a dedicated tool for passing
> PTS testing, avdtptest, and if you had grepped for
> AVDTP/SRC/INT/SIG/SMG/BV-11-C you would have found it is documented in
> avdtp-pts.rst:
>
> https://github.com/bluez/bluez/blob/7a0c8ebf91e69c3b2d2d48f8f4b0074fddde1fa4/doc/qualification/avdtp-pts.rst#L258
>
>>          { },
>>   };
>>
>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> index d475a545e..5f0424c81 100644
>> --- a/profiles/audio/avdtp.c
>> +++ b/profiles/audio/avdtp.c
>> @@ -348,6 +348,11 @@ struct discover_callback {
>>          void *user_data;
>>   };
>>
>> +struct getconf_callback {
>> +       avdtp_get_configuration_cb_t cb;
>> +       void *user_data;
>> +};
>> +
>>   struct avdtp_stream {
>>          GIOChannel *io;
>>          uint16_t imtu;
>> @@ -406,6 +411,7 @@ struct avdtp {
>>          char *buf;
>>
>>          struct discover_callback *discover;
>> +       struct getconf_callback *getconf;
>>          struct pending_req *req;
>>
>>          unsigned int dc_timer;
>> @@ -1093,6 +1099,24 @@ static void finalize_discovery(struct avdtp *session, int err)
>>          session->discover = NULL;
>>   }
>>
>> +static void finalize_getconf(struct avdtp *session, int err)
>> +{
>> +       struct getconf_callback *getconf = session->getconf;
>> +       struct avdtp_error avdtp_err;
>> +
>> +       if (!getconf)
>> +               return;
>> +
>> +       session->getconf = NULL;
>> +
>> +       avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
>> +
>> +       if (getconf->cb)
>> +               getconf->cb(session, NULL, &avdtp_err, getconf->user_data);
>> +
>> +       g_free(getconf);
>> +}
>> +
>>   static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
>>   {
>>          struct avdtp_local_sep *sep = stream->lsep;
>> @@ -1144,6 +1168,7 @@ static void avdtp_free(void *data)
>>          g_slist_free_full(session->seps, sep_free);
>>
>>          g_free(session->buf);
>> +       g_free(session->getconf);
>>
>>          btd_device_unref(session->device);
>>          g_free(session);
>> @@ -1162,6 +1187,7 @@ static void connection_lost(struct avdtp *session, int err)
>>          session->streams = NULL;
>>
>>          finalize_discovery(session, err);
>> +       finalize_getconf(session, err);
>>
>>          avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>>
>> @@ -3008,6 +3034,20 @@ static gboolean avdtp_parse_resp(struct avdtp *session,
>>                                  next->signal_id == AVDTP_GET_ALL_CAPABILITIES)))
>>                          finalize_discovery(session, 0);
>>                  return TRUE;
>> +       case AVDTP_GET_CONFIGURATION:
>> +               DBG("GET_CONFIGURATION request succeeded");
>> +               if (session->getconf) {
>> +                       struct getconf_callback *cb = session->getconf;
>> +                       GSList *caps;
>> +
>> +                       session->getconf = NULL;
>> +                       caps = caps_to_list(((struct getcap_resp *) buf)->caps,
>> +                                       size - sizeof(struct getcap_resp),
>> +                                       NULL, NULL, NULL);
>> +                       cb->cb(session, caps, NULL, cb->user_data);
>> +                       g_free(cb);
>> +               }
>> +               return TRUE;
>>          }
>>
>>          /* The remaining commands require an existing stream so bail out
>> @@ -3115,6 +3155,19 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
>>                  error("GET_CAPABILITIES request rejected: %s (%d)",
>>                                  avdtp_strerror(&err), err.err.error_code);
>>                  return TRUE;
>> +       case AVDTP_GET_CONFIGURATION:
>> +               if (!seid_rej_to_err(buf, size, &err))
>> +                       return FALSE;
>> +               error("GET_CONFIGURATION request rejected: %s (%d)",
>> +                               avdtp_strerror(&err), err.err.error_code);
>> +               if (session->getconf) {
>> +                       struct getconf_callback *cb = session->getconf;
>> +
>> +                       session->getconf = NULL;
>> +                       cb->cb(session, NULL, &err, cb->user_data);
>> +                       g_free(cb);
>> +               }
>> +               return TRUE;
>>          case AVDTP_OPEN:
>>                  if (!seid_rej_to_err(buf, size, &err))
>>                          return FALSE;
>> @@ -3536,18 +3589,35 @@ unsigned int avdtp_stream_add_cb(struct avdtp *session,
>>          return stream_cb->id;
>>   }
>>
>> -int avdtp_get_configuration(struct avdtp *session, struct avdtp_stream *stream)
>> +int avdtp_get_configuration(struct avdtp *session,
>> +                                       struct avdtp_remote_sep *rsep,
>> +                                       avdtp_get_configuration_cb_t cb,
>> +                                       void *user_data)
>>   {
>>          struct seid_req req;
>> +       int err;
>>
>>          if (session->state < AVDTP_SESSION_STATE_CONNECTED)
>>                  return -EINVAL;
>>
>> +       if (session->getconf)
>> +               return -EBUSY;
>> +
>>          memset(&req, 0, sizeof(req));
>> -       req.acp_seid = stream->rseid;
>> +       req.acp_seid = rsep->seid;
>>
>> -       return send_request(session, FALSE, stream, AVDTP_GET_CONFIGURATION,
>> +       err = send_request(session, FALSE, NULL, AVDTP_GET_CONFIGURATION,
>>                                                          &req, sizeof(req));
>> +       if (err < 0)
>> +               return err;
>> +
>> +       if (cb) {
>> +               session->getconf = g_new0(struct getconf_callback, 1);
>> +               session->getconf->cb = cb;
>> +               session->getconf->user_data = user_data;
>> +       }
>> +
>> +       return 0;
>>   }
>>
>>   static void copy_capabilities(gpointer data, gpointer user_data)
>> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
>> index 10c8f496b..45c54086f 100644
>> --- a/profiles/audio/avdtp.h
>> +++ b/profiles/audio/avdtp.h
>> @@ -267,8 +267,15 @@ int avdtp_set_configuration(struct avdtp *session,
>>                                  GSList *caps,
>>                                  struct avdtp_stream **stream);
>>
>> +typedef void (*avdtp_get_configuration_cb_t)(struct avdtp *session,
>> +                                               GSList *caps,
>> +                                               struct avdtp_error *err,
>> +                                               void *user_data);
>> +
>>   int avdtp_get_configuration(struct avdtp *session,
>> -                               struct avdtp_stream *stream);
>> +                               struct avdtp_remote_sep *rsep,
>> +                               avdtp_get_configuration_cb_t cb,
>> +                               void *user_data);
>>
>>   int avdtp_open(struct avdtp *session, struct avdtp_stream *stream);
>>   int avdtp_start(struct avdtp *session, struct avdtp_stream *stream);
>> --
>> 2.43.0
>>
>>
>
