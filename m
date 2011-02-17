Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110217172531.GJ10543@joana>
References: <4d5d2589.8f7edc0a.5af6.27dd@mx.google.com>
	<20110217172531.GJ10543@joana>
Date: Thu, 17 Feb 2011 15:04:03 -0300
Message-ID: <AANLkTin=WAPByfnx6HbcCPy+82u1e=XkPgcNdPENTogA@mail.gmail.com>
Subject: Re: [RFCv2 3/4] Bluetooth: Use ERR_PTR to return error from hci_connect
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Feb 17, 2011 at 2:25 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> @@ -459,8 +459,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>>               le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>>               if (!le)
>>                       le = hci_conn_add(hdev, LE_LINK, dst);
>> -             if (!le)
>> -                     return NULL;
>> +             else
>> +                     return ERR_PTR(-EBUSY);
>> +             if (IS_ERR(le))
>> +                     return le;
>
> I prefer this instead:
>
>                le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>                if (le)
>                        return ERR_PTR(-EBUSY);
>
>                le = hci_conn_add(hdev, LE_LINK, dst);
>                if (!le)
>                        return ERR_PTR(-ENOMEM);

I think the code above (besides the "if (le)" typo) is not equivalent
to the original one. See:

>>               le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>>               if (!le)
>>                       le = hci_conn_add(hdev, LE_LINK, dst);
>> -             if (!le)
>> -                     return NULL;

if hci_conn_hash_lookup_ba() returns NULL, it should call
hci_conn_add(), and if that fails, then return NULL (or some
ERR_PTR()).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
