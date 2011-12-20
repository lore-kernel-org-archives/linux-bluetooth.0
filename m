Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324414682.1965.130.camel@aeonflux>
References: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
	<1324414682.1965.130.camel@aeonflux>
Date: Tue, 20 Dec 2011 19:02:29 -0200
Message-ID: <CAA37ika0HPrGURF+oCaDJUYcW2m+ScNVXd75cPkj7wFbF7WfWQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove global mutex hci_task_lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 20, 2011 at 6:58 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Ulisses,
>
>> The hci_task_lock mutex (previously a lock) was supposed to protect the
>> register/unregister of HCI protocols against RX/TX tasks. This will not
>> be needed anymore because SCO and L2CAP will always be compiled.
>>
>> Moreover, with the recent move of RX/TX to workqueues per device the
>> global hci_task_lock was causing starvation between different HCI
>> devices.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>> =A0net/bluetooth/hci_core.c | =A0 21 +--------------------
>> =A01 files changed, 1 insertions(+), 20 deletions(-)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index d6382db..b45b745 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -61,8 +61,6 @@ static void hci_rx_work(struct work_struct *work);
>> =A0static void hci_cmd_work(struct work_struct *work);
>> =A0static void hci_tx_work(struct work_struct *work);
>>
>> -static DEFINE_MUTEX(hci_task_lock);
>> -
>> =A0/* HCI device list */
>> =A0LIST_HEAD(hci_dev_list);
>> =A0DEFINE_RWLOCK(hci_dev_list_lock);
>> @@ -1800,8 +1798,7 @@ EXPORT_SYMBOL(hci_recv_stream_fragment);
>>
>> =A0/* ---- Interface to upper protocols ---- */
>>
>> -/* Register/Unregister protocols.
>> - * hci_task_lock is used to ensure that no tasks are running. */
>> +/* Register/Unregister protocols. */
>> =A0int hci_register_proto(struct hci_proto *hp)
>> =A0{
>> =A0 =A0 =A0 int err =3D 0;
>> @@ -1811,15 +1808,11 @@ int hci_register_proto(struct hci_proto *hp)
>> =A0 =A0 =A0 if (hp->id >=3D HCI_MAX_PROTO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 mutex_lock(&hci_task_lock);
>> -
>> =A0 =A0 =A0 if (!hci_proto[hp->id])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_proto[hp->id] =3D hp;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EEXIST;
>>
>> - =A0 =A0 mutex_unlock(&hci_task_lock);
>> -
>> =A0 =A0 =A0 return err;
>> =A0}
>
> This only works fine because we are registering the protocols from the
> module init. So what I like to see is that we get rid of this altogether
> and just call directly into the specific event functions for L2CAP and
> SCO since there are the only users anyway. Making them replaceable was a
> nice idea, but it is not practical anymore.

Exactly, I'm on it right now.

> Regards
>
> Marcel

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
