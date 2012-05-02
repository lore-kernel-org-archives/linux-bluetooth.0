Return-Path: <cyrus@holtmann.org>
Message-id: <867ED1B9D6CB4EF3A2D0D64A55AB021C@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1335783741-7398-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZ+DeySnQQvmgu9i9YX8_KHw50vnQigqiJnSetyLFHMjtA@mail.gmail.com>
In-reply-to: <CABBYNZ+DeySnQQvmgu9i9YX8_KHw50vnQigqiJnSetyLFHMjtA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/3] gobex: Add callback and userdata parameter to
 g_obex_cancel_transfer()
Date: Wed, 02 May 2012 18:57:33 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Wednesday, May 02, 2012 6:02 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 1/3] gobex: Add callback and userdata parameter to 
g_obex_cancel_transfer()

> Hi Jaganath,
>
> On Mon, Apr 30, 2012 at 2:02 PM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> +free:
>> +       transfer_free(transfer);
>> +       return ret;
>>  }
>
> Just be completely save here name the label something else than free
> (e.g. done).

Ok, I will rename it to done and send patch.

Thanks,
Jaganath 

