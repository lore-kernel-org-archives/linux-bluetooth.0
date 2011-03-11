Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7A43BB.4050801@nokia.com>
Date: Fri, 11 Mar 2011 17:46:03 +0200
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Change order of freeing contacts data in send_pull_part
References: <1299839095-12008-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1299839095-12008-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi,

On 03/11/2011 12:24 PM, Radoslaw Jablonski wrote:
> Moved freeing data->contacts before asynchronous data sending
> is triggered via data->cb callback.
> This data is no longer needed anyway after vcards are generated
> and freeing it later may cause race condition (because freeing
> this data need to be handled also in phonebook_req_finalize to
> avoid memory leaks when client disconnects in the middle of
> retrieving contacts from db).
> ---
>   plugins/phonebook-tracker.c |    9 ++++++---
>   1 files changed, 6 insertions(+), 3 deletions(-)
>
Please ignore this patch - these changes are not needed in
current architecture (based on offline discussion with Johan).

BR,
Radek
