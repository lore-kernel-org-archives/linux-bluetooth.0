Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110427235723.GA3378@jh-x301>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
	<1303945480-25756-7-git-send-email-johan.hedberg@gmail.com>
	<BANLkTikpQZ9MLvfnCH7oDMN2+_+M=M-QNQ@mail.gmail.com>
	<20110427235723.GA3378@jh-x301>
Date: Wed, 27 Apr 2011 20:00:42 -0400
Message-ID: <BANLkTinwFdcBAsHAhQXQzg0U_8DLMeCd0w@mail.gmail.com>
Subject: Re: [PATCH 7/7] Bluetooth: Fix link key persistent storage criteria
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 27, 2011 at 7:57 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Apr 27, 2011, Anderson Lizardo wrote:
>> > +       if (new_key && !hci_persistent_key(hdev, conn, type, old_key_type)) {
>> > +               list_del(&key->list);
>> > +               kfree(key);
>> > +               return 0;
>>
>> Just to make sure, is this condition possible?
>>
>> * new_key parameter not zero
>> * old_key variable not NULL
>>
>> If so, "key" will point to an entry from hdev->link_keys , which will
>> be freed on the if() above without removing it from the list.
>
> Do you see the list_del call there? :)

Ok, I failed to see it :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
