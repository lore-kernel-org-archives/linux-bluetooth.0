Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120816122510.GA23760@x220>
References: <1344498980-2829-1-git-send-email-mikel.astiz.oss@gmail.com>
	<20120816122510.GA23760@x220>
Date: Fri, 17 Aug 2012 11:07:34 +0200
Message-ID: <CANT-zCVS+ps7vzhXuG8HgZNjU+dZQb=VsRgOnWeJkovs=nVszQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v2] mgmt-api: Add reason to device disconnect event
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Aug 16, 2012 at 2:25 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Thu, Aug 09, 2012, Mikel Astiz wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> Extend the management API with the disconnect reason, as now reported
>> by the Kernel in MGMT_EV_DEVICE_DISCONNECTED.
>> ---
>> Updated userland patch to test the recently submitted Kernel patches regarding ACL disconnect reason.
>>
>>  doc/mgmt-api.txt  |   16 ++++++++++++++++
>>  lib/mgmt.h        |    6 ++++++
>>  monitor/control.c |   19 +++++++++++++++----
>>  src/mgmt.c        |   13 ++++++++-----
>>  4 files changed, 45 insertions(+), 9 deletions(-)
>
> Seems like you're missing an update to tools/btmgmt.c?

Indeed. I will integrate the changes in the next version of the patch.

>> --- a/monitor/control.c
>> +++ b/monitor/control.c
>> @@ -226,18 +226,29 @@ static void mgmt_device_disconnected(uint16_t len, const void *buf)
>>  {
>>       const struct mgmt_ev_device_disconnected *ev = buf;
>>       char str[18];
>> +     uint8_t reason;
>> +     uint16_t l;
>
> I suppose size_t would be more appropriate instead of uint16_t as that's
> the return type of sizeof(). The variable name is also a bit
> uninformative and I'd have used something like consumed_len or
> parsed_len, but if this the convention in rest of the btmon code then I
> wont object to it.

I will rename the variable to consumed_len but I would rather leave it
as uint16_t in order to match the type of len.

>> --- a/src/mgmt.c
>> +++ b/src/mgmt.c
>> @@ -510,18 +510,21 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
>>  static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
>>                                                               size_t len)
>>  {
>> -     struct mgmt_addr_info *ev = buf;
>> +     struct mgmt_ev_device_disconnected *ev = buf;
>>       struct controller_info *info;
>>       char addr[18];
>>
>> -     if (len < sizeof(*ev)) {
>> +     if (len < sizeof(struct mgmt_addr_info)) {
>>               error("Too small device_disconnected event");
>>               return;
>>       }
>>
>> -     ba2str(&ev->bdaddr, addr);
>> +     if (len < sizeof(*ev))
>> +             memset((char *) buf + len, 0, sizeof(*ev) - len);
>
> I don't like how this assumes that there is usable space after the end
> of the buffer given to this function. Could you instead use a temporary
> "uint8_t reason" variable like you do for btmon?

I will change this one too.

Cheers,
Mikel
