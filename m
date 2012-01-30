Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4QgCGuzEFtW5uL=nMqPPYonGFX8AG-JfS0VPVdyVAMgPw@mail.gmail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	<1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
	<CAMXE1-odnk+eVKjmz2jsZS0-Nj93RnVe4mmGL0y6cWjfrw4CPg@mail.gmail.com>
	<CANq1E4QgCGuzEFtW5uL=nMqPPYonGFX8AG-JfS0VPVdyVAMgPw@mail.gmail.com>
Date: Mon, 30 Jan 2012 19:37:31 -0200
Message-ID: <CAA37ikZ7-6E3LoPxw58WoYGi9bFPvZqE0c_awMSOobONF19vuw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Introduce to_hci_conn
From: Ulisses Furquim <ulisses@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>, johan.hedberg@gmail.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Jan 27, 2012 at 3:20 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Andrei
>
> On Fri, Jan 27, 2012 at 6:01 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
>> Hi David,
>>
>>> This avoids using the dev_set/get_drvdata() functions to retrieve a
>>> pointer to our own structure. We can use simple pointer arithmetic here=
.
>>> The drvdata field is actually not needed by any other code-path but thi=
s
>>> makes the code more consistent with hci_dev.
>>>
>>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>>> ---
>>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>>> =A0net/bluetooth/hci_sysfs.c =A0 =A0 =A0 =A0| =A0 10 ++++------
>>> =A02 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h
>>> b/include/net/bluetooth/hci_core.h
>>> index 9780f42..8784da1 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -612,6 +612,7 @@ static inline struct hci_dev *hci_dev_hold(struct
>>> hci_dev *d)
>>> =A0#define hci_dev_unlock(d) =A0 =A0 =A0mutex_unlock(&d->lock)
>>>
>>> =A0#define to_hci_dev(d) container_of(d, struct hci_dev, dev)
>>> +#define to_hci_conn(c) container_of(c, struct hci_conn, dev)
>>>
>>> =A0static inline void *hci_get_drvdata(struct hci_dev *hdev)
>>> =A0{
>>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>>> index 2a0243a..17e6cd4 100644
>>> --- a/net/bluetooth/hci_sysfs.c
>>> +++ b/net/bluetooth/hci_sysfs.c
>>> @@ -33,19 +33,19 @@ static inline char *link_typetostr(int type)
>>>
>>> =A0static ssize_t show_link_type(struct device *dev, struct device_attr=
ibute
>>> *attr, char *buf)
>>> =A0{
>>> - =A0 =A0 =A0 struct hci_conn *conn =3D dev_get_drvdata(dev);
>>> + =A0 =A0 =A0 struct hci_conn *conn =3D to_hci_conn(dev);
>>
>> I personally think it was more readable before.
>
> I didn't write it to make it more readable but to make it conform to
> other subsystems using the drvdata field. I think using a pointer in a
> structure if we could also use container_of is a waste of memory.
> Anyway, in this case we will keep the drvdata field anyway as we
> cannot remove it so I have no objections if you drop this patch.
> Personally I'd prefer to_hci_conn, though, as we are no driver but a
> bus so "get_drvdata" sounds not right here.
>
> Regards
> David
>
>> --Andrei

Using container_of is pretty much common in the kernel. Maybe the
macro names can be better? I think the series is an improvement but
Marcel is the best one to rule on this.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
