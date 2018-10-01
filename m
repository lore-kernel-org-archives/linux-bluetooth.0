Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56186C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B597208AE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIDKaUpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B597208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeJBBKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:10:30 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42664 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBBKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 21:10:30 -0400
Received: by mail-pf1-f174.google.com with SMTP id l9-v6so9831967pff.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Z4mKQr10dwzUAzTTlaJWGoJ2SHKLY1N6YiEJVaM1tc=;
        b=gIDKaUpkbIdBpGXmCcO3UN7KFR14ZRWJqiNtxddd9PQN/rmfTFYbMjg0K0AxcIX/Ya
         aNIvcN8LhTckB5PAyVDdIcstaBg7TMVx56Xjqcf3abMA1rcrAbMIZBP6110q9OkAnvS2
         gPKix5DEuHU6bmgDF8Yc+k93E9gYNrndnJpi8DPJMOj2bhxWZgn8uuk/7iTZbbT0Avfe
         naICyMHn6ZuQvN0tN15loBPgdxAdYcQtu6EK7tYuyk8ehehJLZZ0okPw4inKvFyViZwi
         iBwOyE1yYACn5y61cdTbZdfueF38wVnS03+t2dGNxhbrGQTxiSSY63ET1NG0n2gbloTT
         jkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Z4mKQr10dwzUAzTTlaJWGoJ2SHKLY1N6YiEJVaM1tc=;
        b=oL+pZoeOjYQGDSgOT8vGaDWWbTz73aI8DhxfFD8ENBfY7zF4sYBo1dOpRSRG8OTO+C
         brJwvAA09m93C939LZ4MdxN0i19rh29zvwRG9elRDQBUeIrIdIQUvtWa3nqUyFiZo1QF
         pPXy8JuWVAURzc9dH/npOH96W7UhdiJB/ssn90N9jLRAyn/YUymIRIB9aNv1tUJdEBGw
         szlSAjRmR2BjdAt6FVAfCjrY9bIXuEWD/g/N/WQnBKexxgQC5HaLmgenFdae3HWes6u8
         hHk8vUe8+vL7658GoqUW7YrA+FXB3HxPbJFcB0bPtUl7Dar7uo4P9lmMND1aD53qsAlQ
         MkwA==
X-Gm-Message-State: ABuFfoil7VNj9a/FDbhfOQbzacAKJw1NtWt0kwrVNLngCmp4WJFxVm+R
        tbPREOPMjUO/Y2yITJ/exnTi8zOHZ9H7H2Dv+H/PHIh3SQs=
X-Google-Smtp-Source: ACcGV62Om+lNFVLODWSf3zyn3Ijj2ybyc2iXfM6mwUL5O5P9tklkUi9NweuW/3htEVZyro9rNjlDF2CSQHVxp5fnTdY=
X-Received: by 2002:a62:565c:: with SMTP id k89-v6mr12574476pfb.212.1538418684775;
 Mon, 01 Oct 2018 11:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:890c:0:0:0:0 with HTTP; Mon, 1 Oct 2018 11:31:24
 -0700 (PDT)
In-Reply-To: <CABBYNZKOij42rhG59VPyLTcdzA9se1BUX_RVhG7n4u6hvNn=HA@mail.gmail.com>
References: <20181001111338.11634-1-luiz.dentz@gmail.com> <CABBYNZKOij42rhG59VPyLTcdzA9se1BUX_RVhG7n4u6hvNn=HA@mail.gmail.com>
From:   Sukesh Srikakula <sukeshs@google.com>
Date:   Mon, 1 Oct 2018 11:31:24 -0700
Message-ID: <CAE+ULpCT0uW607yjg1D2dvkVXrmufa2_hwoAfDf2MPpM8c80WQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix not cleaning up device state properly
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the patch.
But, I am still seeing the issue even after applying the patch.
btd_gatt_database_att_disconnected() is bailing out at the first
check, get_dst_info(). So, att_disconnected() is not getting called.

Here is the log message
daemon.debug bluetoothd[3913]:
src/gatt-database.c:btd_gatt_database_att_disconnected()
daemon.err bluetoothd[3913]: gatt: bt_io_get: getpeername: Transport
endpoint is not connected (107)
daemon.debug bluetoothd[3913]: attrib/gattrib.c:g_attrib_unref()
0x20669f0: g_attrib_unref=0
daemon.debug bluetoothd[3913]: src/device.c:device_free() 0x2064518
daemon.debug bluetoothd[3913]: plugins/policy.c:disconnect_cb() reason 3
daemon.debug bluetoothd[3913]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 7B:01:A4:6B:09:2C
type 2 status 0xe
daemon.debug bluetoothd[3913]: src/adapter.c:resume_discovery()

Regards,
Sukesh.

On Mon, Oct 1, 2018 at 4:44 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 2:13 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> If the device is removed locally device_free would end up calling
>> bt_att_unref which won't trigger any disconnect callback necessary
>> to remove device states.
>> ---
>>  src/device.c        |  3 +++
>>  src/gatt-database.c | 24 ++++++++++++++++++++++++
>>  src/gatt-database.h |  2 ++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/src/device.c b/src/device.c
>> index ef5b8f86a..5ddfb9266 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -580,6 +580,9 @@ static void gatt_server_cleanup(struct btd_device *device)
>>
>>         bt_gatt_server_unref(device->server);
>>         device->server = NULL;
>> +
>> +       btd_gatt_database_att_disconnected(
>> +                       btd_adapter_get_database(device->adapter), device->att);
>>  }
>>
>>  static void attio_cleanup(struct btd_device *device)
>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>> index abcf7b759..bdabcb4d6 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -3349,6 +3349,30 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>>         state->pending = NULL;
>>  }
>>
>> +void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
>> +                                               struct bt_att *att)
>> +{
>> +       struct device_state *state;
>> +       bdaddr_t bdaddr;
>> +       uint8_t bdaddr_type;
>> +
>> +       DBG("");
>> +
>> +       if (!get_dst_info(att, &bdaddr, &bdaddr_type))
>> +               return;
>> +
>> +       state = find_device_state(database, &bdaddr, bdaddr_type);
>> +       if (!state)
>> +               return;
>> +
>> +       if (state->disc_id) {
>> +               bt_att_unregister_disconnect(att, state->disc_id);
>> +               state->disc_id = 0;
>> +       }
>> +
>> +       att_disconnected(0, state);
>> +}
>> +
>>  static void restore_ccc(struct btd_gatt_database *database,
>>                         const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
>>  {
>> diff --git a/src/gatt-database.h b/src/gatt-database.h
>> index a6c3139c4..9e7cda8c2 100644
>> --- a/src/gatt-database.h
>> +++ b/src/gatt-database.h
>> @@ -25,5 +25,7 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
>>  struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
>>  void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>>                                                 struct bt_att *att);
>> +void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
>> +                                               struct bt_att *att);
>>
>>  void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
>> --
>> 2.17.1
>>
>
>
>
> --
> Luiz Augusto von Dentz
