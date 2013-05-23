Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NqYT_3nVHCzenwd2UOvsxnMZGY1FKzxKWbYTZt-jxn6g@mail.gmail.com>
References: <1369259656-19683-1-git-send-email-hdante@profusion.mobi>
	<CAJdJm_NqYT_3nVHCzenwd2UOvsxnMZGY1FKzxKWbYTZt-jxn6g@mail.gmail.com>
Date: Thu, 23 May 2013 11:42:14 -0300
Message-ID: <CAFAvTnOTEMDw7Pd+np6ZZq2TmsWWNm-z-AjKrcUABGsKusyf0Q@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Remove proxies when client disconnects
From: Henrique Dante <hdante@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 22, 2013 at 7:35 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Henrique,
>
> On Wed, May 22, 2013 at 5:54 PM, Henrique Dante de Almeida
> <hdante@profusion.mobi> wrote:
>> Remove proxies and generate proxy_removed callbacks even when there are
>> no corresponding InterfaceRemoved signals.
>> ---
>
> I think that, for the records, it is a good idea to explain on the
> commit message at which circumstances the bug is triggered.

 "This patch fixes having zombie gdbus proxy objects when a server
disconnects without sending InterfaceRemoved signals. These objects
may interact with new server instances, for example, making
InterfaceAdded signals of new objects with the same name be filtered
out as duplicates, or staying allocated, but unused if the new server
doesn't reuse the object paths. Note that as a side-effect, the
lifetime of a gdbus proxy becomes stricter: it lives at most for the
duration of a single connection to a single instance of a server
process."

>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
