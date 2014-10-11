Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org>
References: <1412991237-20847-1-git-send-email-fons@spotify.com> <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Sat, 11 Oct 2014 13:14:12 +0200
Message-ID: <CAHF=Y4o7BE5hVzNgyXR0_jGPqNLnfjj1MgzuTU0iB-tvvgKa3A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *wor=
k)
>>               conn->state =3D BT_CLOSED;
>>               break;
>>       }
>> +
>> +     if (test_and_clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type=
);
>
> do we really need this one? The hci_conn_timeout should trigger when the =
connection establishment has a timeout and that is really non of the concer=
ns here. And in case we hit an idle disconnect timeout, we are still ending=
 up in hci_conn_del eventually, right? If not, I am having the slight feeli=
ng that you might have uncovered a bug that we should fix.

It's probably just lack of familiarity with the code, but it wasn't
all that clear to me that hci_conn_del is called after
hci_conn_timeout kicks in. I removed it.

>
>>
>>               err =3D hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
>>       }
>> @@ -2748,12 +2758,12 @@ static int unpair_device(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>>       }
>>
>>       if (cp->disconnect) {
>> +             /* Only lookup the connection in the BR/EDR since the
>> +              * LE connection was already looked up earlier.
>> +              */
>>               if (cp->addr.type =3D=3D BDADDR_BREDR)
>>                       conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>>                                                      &cp->addr.bdaddr);
>> -             else
>> -                     conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK,
>> -                                                    &cp->addr.bdaddr);
>>       } else {
>>               conn =3D NULL;
>>       }
>
> I know that Johan told you to do it this way, but seeing the patch now ma=
kes me a bit uneasy. The usage of uninitilized_var in this case can lead to=
 errors in the future. The logic that the compiler is wrong here is not obv=
ious. Which means a week from now all of us have forgotten why we did it.
>
> So here is what I would do to make this easier.
>
>         if (cp->addr.type =3D=3D BDADDR_BREDR) {
>                 if (cp->disconnect) {
>                         conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>                                                        &cp->addr.bdaddr);
>                 else
>                         conn =3D NULL;
>
>                 err =3D hci_remove_link_key(hdev, &cp->addr.bdaddr);
>         } else {
>                 conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK,
>                                                &cp->addr.bdaddr);
>                 if (conn) {
>                         set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags=
);
>
>                         if (!cp->disconnect)
>                                 conn =3D NULL;
>                 }
>
>                 ...
>
>                 hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
>
>                 err =3D hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type)=
;
>         }
>
> Add some minor comments on why we set conn =3D NULL and this should be a =
simpler block. Mainly because the difference between BR/EDR and LE are cont=
ained in a single spot and not spread out over two places.
>
> This already takes into account my comment from above to just set the PAR=
AM_REMOVAL flag no matter if we actually be asked to disconnect or not.

Yep, I agree, what you propose is way cleaner. Thanks.


V4 takes care of your remarks.


--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
