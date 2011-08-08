Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 8 Aug 2011 11:32:07 -0400
Message-ID: <CAJdJm_OmwPrc_3nT3zOSa0PLQBfr8hzyXuWHj=JJXYdWagoG7w@mail.gmail.com>
Subject: [RFC] New mgmt API for Features Exchange (was: Re: Security level for
 Primary Services discovery during pairing)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: VISHWANATH KM <a21174@motorola.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 8, 2011 at 10:59 AM, VISHWANATH KM <a21174@motorola.com> wrote:
>> I think you have two options:
>>
>> 1) Always use CreateDevice(). Then if you want to issue SMP pairing,
>> you can change the BT_IO_SECLEVEL when connection with bt_io_connect()
>> (I haven't tested this lately, but I remember it used to work).
>>
>> 2) Extend the kernel Management API to allow Features Exchange. See
>> doc/mgmt-api.txt for the existing commands, to have an idea on how it
>> works (I recommend first sending an API proposal here to the list).
>
> Option 2 sounds better, where we use CreatePairedDevice and after the LE ACL
> is established we can do LE Read Remote features, (similar to what we do for
> BR i.e we do HCI Read Remote features in conn complete ) and if Encryption
> feature bit is set then we trigger SMP else we don't, pls let me know if any
> comments, if this sounds ok then i will mail the changes to this maillist
> for further review

Let's hear others opinions. Johan, Marcel, Gustavo?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
