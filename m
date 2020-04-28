Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2616C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8DD208E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="z+KRZ5g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgD1RTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:19:15 -0400
Received: from vern.gendns.com ([98.142.107.122]:57730 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgD1RTP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 13:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I9wUxx80D81hL5x5NhcsLlXy+/1RIZIwRw7xKvsn5Aw=; b=z+KRZ5g2nGTei19HKm6cWMvQIX
        Vj6q6reWolnPxZ9MFx4IpfFEd9+8X156TFClwHNoMa2IW4IxUoGtBnRDvVB8UOYNknfvBLLG9p3Mf
        2i4SeDy8IprzfHWTrken5hEGNxD5J9+ZNiHYI1yWHy9df9A0g8iaKT663pRT18pS5ac3oZBCaSOh6
        XnIcRamapG0B8m4MXjmtjwC+8V4xsHELT5eAmAitrDC0TWGKgGVx2jWH0YRCsNQvnSPxbCCdT6FHc
        /pdHCSv8zMgwcVluM9+lugg82UCD+IuaEBBeJlaZHn6tELhguaj/Jrh3Vfcn/1LGMlZ4J5by5rmLK
        4iVbPOoA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39018 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jTTt2-00036a-PO; Tue, 28 Apr 2020 13:19:12 -0400
Subject: Re: [PATCH BlueZ v2] src/gatt-client: always check properties in
 WriteValue
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200427150153.17055-1-david@lechnology.com>
 <CABBYNZKhVUqLortqL60CNtu0MZBdtW+qqdtn6zfacOVKDezYxQ@mail.gmail.com>
 <35f37936-e737-ac35-c538-9447a00d1cbc@lechnology.com>
 <CABBYNZKYXjKDb77988uFE6hQvW-R2es=Y4rZfNML9zFciOmuRg@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <685ddf1b-c824-9c45-298f-97b70cbf975f@lechnology.com>
Date:   Tue, 28 Apr 2020 12:19:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZKYXjKDb77988uFE6hQvW-R2es=Y4rZfNML9zFciOmuRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 4/28/20 12:03 PM, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Tue, Apr 28, 2020 at 7:39 AM David Lechner <david@lechnology.com> wrote:
>>
>> On 4/27/20 11:28 AM, Luiz Augusto von Dentz wrote:
>>> Hi David,
>>>
>>> On Mon, Apr 27, 2020 at 8:07 AM David Lechner <david@lechnology.com> wrote:
>>>>
>>>> This modifies the GATT client characteristic WriteValue D-Bus method to
>>>> always check that the characteristic supports the requested type of
>>>> write by checking for the corresponding property before attempting to
>>>> write.
>>>>
>>>> Before this change, if the "type" option was used and it was set to
>>>> "reliable" or "request", then BlueZ would attempt the write even if the
>>>> characteristic does not support that write type. On the other hand, if
>>>> "type" was set to "command" or was not specified, the method would
>>>> return a org.bluez.Error.NotSupported error without attempting to write.
>>>>
>>>> After this change, the WriteValue method will consistently return
>>>> org.bluez.Error.NotSupported if the corresponding property flag is not
>>>> set for all types of writes.
>>>> ---
>>>>
>>>> v2 changes:
>>>> - remove extra check of test variable not NULL
>>>> - fix one line over 80 chars
>>>>
>>>>    src/gatt-client.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>>>> index a9bfc2802..f80742fbb 100644
>>>> --- a/src/gatt-client.c
>>>> +++ b/src/gatt-client.c
>>>> @@ -1016,8 +1016,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>>>>            *     - If value is larger than MTU - 3: long-write
>>>>            *   * "write-without-response" property set -> write command.
>>>>            */
>>>> -       if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
>>>> -                       || (type && !strcasecmp(type, "reliable"))) {
>>>> +       if ((!type || !strcasecmp(type, "reliable")) && chrc->ext_props &
>>>> +                               BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {
>>>>                   supported = true;
>>>>                   chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
>>>>                                                   true, value, value_len, offset,
>>>> @@ -1026,8 +1026,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>>>>                           return NULL;
>>>>           }
>>>>
>>>> -       if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
>>>> -                       (type && !strcasecmp(type, "request"))) {
>>>> +       if ((!type || !strcasecmp(type, "request")) && chrc->props &
>>>> +                                               BT_GATT_CHRC_PROP_WRITE) {
>>>>                   uint16_t mtu;
>>>>
>>>>                   supported = true;
>>>> --
>>>> 2.17.1
>>>
>>> As far I can remember this is on purpose so the application can
>>> overwrite the type if it needs to disabling the checks on the client
>>> side, though the kernel can still return not supported, so if we want
>>> to change this it will now not be possible to overwrite it anymore.
>>>
>>
>> If this is the case, does it make sense to make the following change
>> instead so that write without response can also be forced?
>>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index f80742fbb..3153f571f 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -1050,8 +1050,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>>                           return NULL;
>>           }
>>
>> -       if ((type && strcasecmp(type, "command")) || offset ||
>> -                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
>> +       if ((type && strcasecmp(type, "command")) || offset || (!type &&
>> +                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
>>                   goto fail;
>>
>>           supported = true;
> 
> Yes, that is probably one of the use cases to use the type to force
> sending a command if the client don't care about the response but the
> server don't mark write without response as supported, is that what
> you are after? That sounds like a bug since it appears the intention
> was to allow commands all along.
> 

I just noticed the inconsistency here while trying to implement
writeValueWithResponse() and writeValueWithoutResponse() in the Web
Bluetooth API for the Chromium browser and thought that it should
probably all be one way or the other.

FWIW, in the particular case I am working with, the device has both
the WRITE and WRITE_WITHOUT_RESP properties set so I am using "type"
to force writing without response since write with response would
be selected otherwise.

I will send a proper patch to fix the write without response case.
