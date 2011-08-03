Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBfA5wPvE8Xvm-sEgY=Po8LrX=hDHVeckmqaCmi0wTWQ3w@mail.gmail.com>
References: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <CAKT1EBeh+BxAkt-k+CchSMGwV--RgtiPkhi=JqAajgLYF0CiOw@mail.gmail.com>
 <20110803202550.GF28119@joana> <CAKT1EBfA5wPvE8Xvm-sEgY=Po8LrX=hDHVeckmqaCmi0wTWQ3w@mail.gmail.com>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 3 Aug 2011 17:52:43 -0400
Message-ID: <CALJ2SB+9iH1n7NooLhVnrLrvn8q9t6XokNWEGOxKLY7PH=xLsA@mail.gmail.com>
Subject: Re: [RFC 0/7] RSSI Monitor
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 3, 2011 at 4:52 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Gustavo,
>
> On Wed, Aug 3, 2011 at 5:25 PM, Gustavo Padovan <padovan@profusion.mobi> =
wrote:
>> * Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-08-03 16:36:43=
 -0300]:
>>
>>> Hi Briglia/Marcel/Padovan:
>>>
>>> On Tue, Aug 2, 2011 at 3:35 PM, Anderson Briglia
>>> <anderson.briglia@openbossa.org> wrote:
>>> > This RFC is about RSSI monitoring since controllers do not have a spe=
cific
>>> > command for this and we need it for Proximity Profile, at least.
>>> >
>>> > The RFC implements a mechanism to set threshold levels in order to se=
nd
>>> > alerts to userspace when a RSSI value reaches one of the configured t=
hresholds.
>>> >
>>> > Management Interface contains a list of RSSI Monitors. Elements are i=
nserted
>>> > or deleted from this list using two new Management commands: Enable a=
nd Disable
>>> > RSSI Monitor.
>>> >
>>> > A timer was added to do HCI Read RSSI requests to the controller and =
get RSSI
>>> > values updated. If there is monitored connection (eg.: RSSI Monitor l=
ist size >
>>> > 0), the timer is reseted after two seconds and the RSSI for each moni=
tored conn
>>> > is updated. Using the RSSI value, a Management Event is sent if one o=
f the
>>> > thresholds were reached and the alert is different from the last one =
sent.
>>> >
>>> > Userspace is responsible to add and remove RSSI Monitors. Each monito=
r must
>>> > have low and high thresholds values for RSSI. A RSSI Monitor is disab=
led when
>>> > the connection is no longer available or the userspace sends a comman=
d to
>>> > remove it. If there is no RSSI Monitor remaining in the list, the RSS=
I Read
>>> > polling timer is removed.
>>>
>>> Should be the entries persistent across connections? In the suggested
>>> approach the RSSI threshold monitor for a given address is
>>> automatically removed when the connection is lost.
>>> By other hand, persistence introduces another problem: trust that the
>>> userspace will disable the monitor.
>>
>> Is it really worth? There are some reconnections to justify the persiste=
nt
>> entry? The wast of memory worth the savings in interactions between
>> kernel-userpace through the mgmt?
>>
>> =A0 =A0 =A0 =A0Gustavo
>>
>
> It saves logic in the userspace. Memory is not critical, how many
> keyfobs a "normal" user will have?
> Removing automatically means the kernel and userspace will be out of
> sync, there isn't an event notifying that an entry was removed.
>
> For Proximity, the RSSI threshold needs to be calculated, remote's Tx
> power(read using ATT) is an input. In theory, Tx Power will not change
> in the next connection, meaning that an additional logic can be added
> in the Proximity Monitor to avoid enable/disable the RSSI threshold
> monitor if the new calculated RSSI threshold doesn't change.

Please, correct me if I'm wrong, but this persistency will be used to
save one command from userspace to kernel? I mean, Proximity
application still needs to tell to the kernel that it needs to start a
RSSI monitoring even if the thresholds had not changed. For example,
if a connection with the same remote address is established but we do
not want to use Proximity, userspace needs to tell to Management that
no RSSI monitoring should be started for that connection. In this
case, Management will not be able to enable/disable RSSI monitors
automatically.

IMHO, the userspace should be responsible to enable/disable RSSI monitors.

>
> Regards,
> Claudio
>



--=20
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
