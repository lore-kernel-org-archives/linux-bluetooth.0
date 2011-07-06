Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309967827-23772-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309967827-23772-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Wed, 6 Jul 2011 18:39:37 +0200
Message-ID: <CADUB2Y47hPbSuYobJVar5+LWntda5=CsOUzWDuxKfxTbth_cDA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] Fix invalid memory read when pulling phone book
From: Radek <radoslawjablonski@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Jul 6, 2011 at 5:57 PM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
>
> Data contacts are freed already in finalize function which is called
> in query_result callback function. Calling free_data_contacts(data)
> twice causes invalid memory read when dereferencing data->contacts.
> ---
>  plugins/phonebook-tracker.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index d396203..7a1a003 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1154,7 +1154,6 @@ static void send_pull_part(struct phonebook_data *data,
>        data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
>                        data->newmissedcalls, lastpart, data->user_data);
>
> -       free_data_contacts(data);

This free_data_contacts is used here for scenarios when there is more than
one part of data to send (for clearing data of contacts that are already fetched
from db).
So simply removing this will cause very weird behaviour - every part
of new vcard
data will have "old" data on the beginning..

To avoid these invalid reads some more sophisticated changes in
phonebook_tracker
logic will be needed - contacts data should be cleared only from one
place in the code
(now free_data_contacts is called from 2 places..)

BR,
Radek
