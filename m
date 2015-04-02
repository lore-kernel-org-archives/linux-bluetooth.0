Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <551CA5BC.5040307@gmail.com>
References: <551CA5BC.5040307@gmail.com>
Date: Wed, 1 Apr 2015 19:49:03 -0700
Message-ID: <CAHrH25Tq4cQhiaGu7HnTu1ep1XNd85UJJr-FbcGnyx5c9W9Evw@mail.gmail.com>
Subject: Re: How to get the hci_dev from an adv instance's work struct in a
 linked list?
From: Arman Uguray <armansito@chromium.org>
To: Florian Grandel <fgrandel@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> On Wed, Apr 1, 2015 at 7:13 PM, Florian Grandel <fgrandel@gmail.com> wrote:
> Hi!
>
> I got quite far today refactoring from
>
> struct hci_dev { ... struct adv_info adv_instance; ... };
>
> to
>
> struct hci_dev { ... struct list_head adv_instances; ... };
>
> But in the end I got stuck on refactoring the adv timeout callback.
> Originally it looked like this:
>
> static void adv_timeout_expired(struct work_struct *work)
> {
>   struct hci_dev *hdev = container_of(work, struct hci_dev,
>                                       adv_instance.timeout_exp.work);
>   ...
> }
>
> But now I would have to construct a pointer to the hci_dev struct from a
> list entry:
>
> static void adv_timeout_expired(struct work_struct *work)
> {
>   struct adv_info *adv_instance = container_of(work, struct adv_info,
>                                                timeout_exp.work);
>   ...
> }
>
> I couldn't find a way to get the list head of the adv info list entry so
> that I could retrieve its containing hci_dev structure, though.
>

Once simple solution is to add a struct hci_dev pointer to struct
adv_info. Once you get the pointer to the instance then you can obtain
the hci_dev pointer that way.

> How would I construct the required hci_dev struct from the work pointer in
> this case? Any ideas?
>
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
