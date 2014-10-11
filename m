Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0025B704-1B18-4B1E-B27D-DF84AA2F9201@holtmann.org>
References: <1413026054-5913-1-git-send-email-fons@spotify.com> <0025B704-1B18-4B1E-B27D-DF84AA2F9201@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Sat, 11 Oct 2014 16:30:48 +0200
Message-ID: <CAHF=Y4oqcDKpPySM-qgscD8-=oTrm01Y_KnezTZt4irJ8C1FPg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Defer connection-parameter removal when unpairing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>       if (cp->addr.type == BDADDR_BREDR) {
>> +             if (cp->disconnect)
>> +                     conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>> +                                                    &cp->addr.bdaddr);
>> +             else
>> +                     conn = NULL; /* Avoid disconnecting later on*/
>> +
>
> I do not think this is a comment style that is valid in the network subsystem coding style and even if it is valid, it would be pretty unusual.

Excuse my ignorance, but Where is the network subsystem coding style
documented? I haven't been able to find it.

> Generally I would do comment on the whole code. So something like this:
>         /* When disconnect of the the connection is requested,
>          * then look up the connection. If the remote device is
>          * connected, it will be later used to terminate the
>          * link.
>          *
>          * Setting it to NULL explicitly will cause no
>          * termination of the link.
>          */
>         if (cp->disconnect)
>                 conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>                                                &cp->addr.bdaddr);
>         else
>                 conn = NULL;
>
>>               err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
>>       } else {
>>               u8 addr_type;
>>
>> +             conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
>> +                                            &cp->addr.bdaddr);
>> +             if (conn) {
>> +                     /* Defer clearing up the connection parameters
>> +                      * until closing to give a chance of keeping
>> +                      * them if a repairing happens.
>> +                      */
>> +                     set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
>> +
>> +                     if (!cp->disconnect)
>> +                             conn = NULL; /* Avoid disconnecting later on*/
>
> And here I would do this:
>
>                 /* If disconnection is not requested, then clear the
>                  * connection variable so that that the link is not
>                  * terminated.
>                  */
>                 if (!cp->disconnect)
>                         conn = NULL;

Thanks, I submitted V5 to correct this.



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
