Return-Path: <cyrus@holtmann.org>
Message-ID: <4E574A35.30106@comarch.pl>
Date: Fri, 26 Aug 2011 09:24:37 +0200
From: =?UTF-8?B?UmFmYcWCIE1pY2hhbHNraQ==?= <rafal.michalski@comarch.pl>
MIME-Version: 1.0
To: johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Refactoring address fields handled in vcard
 module
References: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan
> This patch introduces phonebook_addr struct for more intuitive
> handling address fields from backend. Now address fields are managed
> by linked list (wrapped by structure) and it is used for printing vCard
> address fields, instead of buffers set (combined with g_strsplit
> and snprintf functions).
> ---
>  plugins/phonebook-tracker.c |   72 +++++++++++++++++++++++++++++++++++++-----
>  plugins/vcard.c             |   70 +++++++++++++++++++----------------------
>  plugins/vcard.h             |    7 +++-
>  3 files changed, 101 insertions(+), 48 deletions(-)
>   

I want to ask about patches review:

[PATCH obexd 1/2] Refactoring address fields handled in vcard module
[PATCH obexd 2/2] Fix semicolon delimiter issue in address fields

Did you have time to take a look at these patches ?

And please ignore patch I've sent earlier: "[PATCH obexd v2] Support for 
Quoted Printable encoding".
I will send new improved version later, with additional escaping 
semicolons only (since it is required
by vCard 2.1), if these two above patches accepted.

Best Regards

Rafał Michalski
