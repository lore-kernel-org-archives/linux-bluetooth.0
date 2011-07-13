Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310580766.21109.96.camel@aeonflux>
References: <4e1da4a5.04bfec0a.4243.00d9@mx.google.com> <1310580766.21109.96.camel@aeonflux>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 13 Jul 2011 14:27:25 -0400
Message-ID: <CALJ2SBL=Fdcmrbrs69pQybXxMq1yh4=Gzmx4Xa32_qnFwDe-YA@mail.gmail.com>
Subject: Re: [RFC 1/3] Bluetooth: Implement Read RSSI command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 13, 2011 at 2:12 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andreson,
>
>> This patch implements helper functions to make Read RSSI command
>> interceptable by MGMT Interface. It adds a new wrapper in HCI layer and
>> add a hook to call mgmt_read_rssi_complete when MGMT Interface has been
>> loaded.
>>
>> Read RSSI command is defined on Part E, section 7.5.4 of Bluetooth 4.0
>> Spec.
>
> I think that I mentioned this before. This is not something I like to
> see at all. 1:1 copies of HCI commands is pointless.
>
> If you need RSSI results, then something like proper interval and
> thresholds should be supported. Also with future Bluetooth SIG work on
> having controller driven notifications in this area.

Note that even the RSSI and TX Power are implemented, it is not
possible to userspace request a RSSI or TX Power actively. If
userspace wants to receive RSSI and TX Power from the kernel, it must
add to the "monitored commands" and wait for the responses. Read RSSI
and TX Power Level are not being parsed on mgmt_control().
Maybe I should change the commit message of this patch and the next one.

New Management commands were implemented in the last RFC patch to
monitor selected commands.

Regards,

Anderson Briglia

>
> Regards
>
> Marcel
>
>
>



-- 
INdT - Instituto Nokia de tecnologia
+55 2126 1122
+55 92 8423 3183
