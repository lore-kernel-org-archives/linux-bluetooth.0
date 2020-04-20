Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63FC3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3657B2074F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDTShr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:37:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52446 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgDTShq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 14:37:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: scerveau)
        with ESMTPSA id 536E62A0FFE
Subject: Re: [PATCH 1/1] add hog ref before adding to instances
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200420135112.6749-1-scerveau@collabora.com>
 <20200420135112.6749-2-scerveau@collabora.com>
 <CABBYNZJGFLEQoNqu=Z6pOxTzQ=jUpX1qxYu+rMZo4PyDW51QHQ@mail.gmail.com>
From:   scerveau <scerveau@collabora.com>
Message-ID: <ff94c0ef-5778-8f96-3e91-b4e6ddb66d29@collabora.com>
Date:   Mon, 20 Apr 2020 20:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJGFLEQoNqu=Z6pOxTzQ=jUpX1qxYu+rMZo4PyDW51QHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,

Thanks but see my comment below.

On 20/4/20 19:21, Luiz Augusto von Dentz wrote:
> Hi Stéphane,
> 
> On Mon, Apr 20, 2020 at 9:39 AM Stéphane Cerveau <scerveau@collabora.com> wrote:
>>
>> To avoid a double hog free, need to add a ref
>> when adding the hog to the slist.
>>
>> This bug has been reproduced with gamepad-8718
>> which was connecting/disconnecting frantically.
>>
>> Fix also a typo in the method hog_attach_instance
>> ---
>>   profiles/input/hog-lib.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>> index 9c5c814a7..b9b5d565c 100644
>> --- a/profiles/input/hog-lib.c
>> +++ b/profiles/input/hog-lib.c
>> @@ -1357,7 +1357,7 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
>>          return hog;
>>   }
>>
>> -static void hog_attach_instace(struct bt_hog *hog,
>> +static void hog_attach_instance(struct bt_hog *hog,
>>                                  struct gatt_db_attribute *attr)
>>   {
>>          struct bt_hog *instance;
>> @@ -1373,14 +1373,14 @@ static void hog_attach_instace(struct bt_hog *hog,
>>          if (!instance)
>>                  return;
>>
>> -       hog->instances = g_slist_append(hog->instances, instance);
>> +       hog->instances = g_slist_append(hog->instances, bt_hog_ref(instance));
> 
> That sounds like like a double ref since bt_hog_new already does add a

Yes but in `hog_attach_instance`, `hog_new` is used and not `bt_hog_new` 
which is indeed reffing. So I dont think there is double ref in this method.

Unfortunately when I was preparing the patch, I noticed that another 
instance was added to slist and here you are totally right there is a 
double reference. I will remove this from the initial patch.



> reference, so chances are that you may be fixing the the symptom not
> the real problem which seems that we cannot unref the instances
> because they are not removed from the parent as it they should, in
> fact we might need to redesign it a little bit since bt_hog might
> actually be inefficient when there are multiple instances as it does
> allocate a new uhid instance of each of then so we might do something
> like:
> 
> struct bt_hog_instance {
>      struct bt_hog *parent;
>      struct gatt_db_attribute *attr;
>      struct gatt_primary *primary;
>      GAttrib *attrib;
>      GSList *reports;
>      gboolean has_report_id;
>      uint16_t bcdhid;
>      uint8_t bcountrycode;
>      uint16_t proto_mode_handle;
>      uint16_t ctrlpt_handle;
>      uint8_t flags;
>      unsigned int getrep_att;
>      uint16_t getrep_id;
>      unsigned int setrep_att;
>      uint16_t setrep_id;
> }
> 
> That way the instances are indenpendent of the bt_hog which should be
> 1:1 to a device, while we can have multple instances of
> bt_hog_instance, if you don't have time to do the rework then lets
> just add a parent pointer added to bt_hog so we can can remove child
> instances and resolve the double free.
> 
>>   }
>>
>>   static void foreach_hog_service(struct gatt_db_attribute *attr, void *user_data)
>>   {
>>          struct bt_hog *hog = user_data;
>>
>> -       hog_attach_instace(hog, attr);
>> +       hog_attach_instance(hog, attr);
>>   }
>>
>>   static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
>> @@ -1528,7 +1528,7 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
>>                          primary->range.end, find_included_cb, instance);
>>
>>          bt_hog_attach(instance, hog->attrib);
>> -       hog->instances = g_slist_append(hog->instances, instance);
>> +       hog->instances = g_slist_append(hog->instances, bt_hog_ref(instance));
>>   }
>>
>>   static void primary_cb(uint8_t status, GSList *services, void *user_data)
>> --
>> 2.17.1
>>
> 
> 
