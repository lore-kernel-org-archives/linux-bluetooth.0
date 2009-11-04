Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF17210.2070008@csr.com>
Date: Wed, 04 Nov 2009 12:22:40 +0000
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Tomas Winkler <tomasw@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: don't DMA to stack in btsdio driver
References: <1256143300-16149-1-git-send-email-david.vrabel@csr.com>	 <1256653711-17959-1-git-send-email-david.vrabel@csr.com> <1ba2fa240911040256p3645aac6sea271919f1e6e651@mail.gmail.com>
In-Reply-To: <1ba2fa240911040256p3645aac6sea271919f1e6e651@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Tomas Winkler wrote:
> 
>> @@ -299,9 +301,9 @@ static int btsdio_probe(struct sdio_func *func,
>>                                const struct sdio_device_id *id)
>>  {
>>        struct btsdio_data *data;
>> -       struct hci_dev *hdev;
>> +       struct hci_dev *hdev = NULL;
> 
> This kind of assignments prevent useful warning from compiler, maybe
> it's better to stage
> the error bailout.

I think that having to have an  error_foo label for each error makes
writing error handling harder not easier.  I'm not inclined to change
this, particular as I can't think of any "useful warnings" are prevented.

>>        struct sdio_func_tuple *tuple = func->tuples;
>> -       int err;
>> +       int err = -ENOMEM;
> You are assuming no other code  between 2 allocations, it's seems to
> me error prone.

Yeah, it's probably best to set err at the source of the error.  This
code is so short it doesn't make any real practical difference.  I'll
keep it in mind for the future though.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
