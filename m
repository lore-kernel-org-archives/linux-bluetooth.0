Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429080304.GC21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-12-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429080304.GC21742@t440s.lan>
Date: Tue, 29 Apr 2014 12:44:37 +0200
Message-ID: <CAN_7+YYPmk36HyUV_W5LEkO=zjfT6E20XzAwDL7qghFTf2N2tw@mail.gmail.com>
Subject: Re: [PATCH 10/36] android/gatt: Add ATT msg handler
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:03 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> +     if (device->server_id)
>> +             g_attrib_unregister(device->attrib, device->server_id);
>
> I think the consistent style for async operation id checks is id > 0

Fix in v2
>
>> +     dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
>> +                                             GATTRIB_ALL_HANDLES,
>> +                                             att_handler, dev, NULL);
>> +     if (!dev->server_id)
>> +             error("gatt: Could not attache to server");
>
> And id == 0 here

Fix in v2
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Łukasz
