Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzKE_5c--JS+FbWS23w_hs_MG9kYkGF_U_5isPM1WF_AFQ@mail.gmail.com>
References: <1316422359-16167-1-git-send-email-sancane@gmail.com>
	<1316422359-16167-2-git-send-email-sancane@gmail.com>
	<CAJdJm_M=19tbUqYFztW8EJM5qCOdy00ddZ6rRMtgtQ0hcN55YA@mail.gmail.com>
	<CACLukzKE_5c--JS+FbWS23w_hs_MG9kYkGF_U_5isPM1WF_AFQ@mail.gmail.com>
Date: Mon, 19 Sep 2011 10:39:09 -0400
Message-ID: <CAJdJm_PhQVMgMR-iKGwEx89=_J=J_pumSfZU8qovz_mtYks=TA@mail.gmail.com>
Subject: Re: [PATCH 1/9] Load device driver if thermometer service attribute
 appears in GATT
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 19, 2011 at 8:57 AM, Santiago Carot <sancane@gmail.com> wrote:
>>>  static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
>>>  {
>>> -       return thermometer_register(connection, device);
>>> +       struct att_primary *tattr;
>>> +       GSList *l, *primaries;
>>> +
>>> +       primaries = btd_device_get_primaries(device);
>>> +
>>> +       l = g_slist_find_custom(primaries, HEALTH_THERMOMETER_SVC_UUID,
>>> +                                                       primary_uuid_cmp);
>>
>> I think this is incorrect. You should compare against the 128-bit
>> UUID, not the 16-bit one. I.e. use HEALTH_THERMOMETER_UUID here.
>
> Are you sure?. In my tests, the function btd_device_get_primaries only
> gives me 16-bit UUIDs. If I try the 128-bit ones it doesn't work. That
> the reason wich I did this. Do you have any idea for this?

A bug maybe? See the proximity monitor manager.c, it uses 128-bit
string. Claudio, any comments?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
