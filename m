Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMXE1-odnk+eVKjmz2jsZS0-Nj93RnVe4mmGL0y6cWjfrw4CPg@mail.gmail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	<1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
	<CAMXE1-odnk+eVKjmz2jsZS0-Nj93RnVe4mmGL0y6cWjfrw4CPg@mail.gmail.com>
Date: Fri, 27 Jan 2012 18:20:29 +0100
Message-ID: <CANq1E4QgCGuzEFtW5uL=nMqPPYonGFX8AG-JfS0VPVdyVAMgPw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Introduce to_hci_conn
From: David Herrmann <dh.herrmann@googlemail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei

On Fri, Jan 27, 2012 at 6:01 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi David,
>
>> This avoids using the dev_set/get_drvdata() functions to retrieve a
>> pointer to our own structure. We can use simple pointer arithmetic here.
>> The drvdata field is actually not needed by any other code-path but this
>> makes the code more consistent with hci_dev.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> =A0net/bluetooth/hci_sysfs.c =A0 =A0 =A0 =A0| =A0 10 ++++------
>> =A02 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h
>> b/include/net/bluetooth/hci_core.h
>> index 9780f42..8784da1 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -612,6 +612,7 @@ static inline struct hci_dev *hci_dev_hold(struct
>> hci_dev *d)
>> =A0#define hci_dev_unlock(d) =A0 =A0 =A0mutex_unlock(&d->lock)
>>
>> =A0#define to_hci_dev(d) container_of(d, struct hci_dev, dev)
>> +#define to_hci_conn(c) container_of(c, struct hci_conn, dev)
>>
>> =A0static inline void *hci_get_drvdata(struct hci_dev *hdev)
>> =A0{
>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>> index 2a0243a..17e6cd4 100644
>> --- a/net/bluetooth/hci_sysfs.c
>> +++ b/net/bluetooth/hci_sysfs.c
>> @@ -33,19 +33,19 @@ static inline char *link_typetostr(int type)
>>
>> =A0static ssize_t show_link_type(struct device *dev, struct device_attri=
bute
>> *attr, char *buf)
>> =A0{
>> - =A0 =A0 =A0 struct hci_conn *conn =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct hci_conn *conn =3D to_hci_conn(dev);
>
> I personally think it was more readable before.

I didn't write it to make it more readable but to make it conform to
other subsystems using the drvdata field. I think using a pointer in a
structure if we could also use container_of is a waste of memory.
Anyway, in this case we will keep the drvdata field anyway as we
cannot remove it so I have no objections if you drop this patch.
Personally I'd prefer to_hci_conn, though, as we are no driver but a
bus so "get_drvdata" sounds not right here.

Regards
David

> --Andrei
