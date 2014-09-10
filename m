Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 10 Sep 2014 14:53:00 +0300
Message-ID: <CABBYNZKk=-ZzWSSH=eAtAr-Y+oHmijrPdodZLp4PjU6MxZtSzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] android/hf-client: API fixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Sep 10, 2014 at 2:11 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Couple of fixes to hf-client api.
>
> Those patches previously where a part of bigger set
> [PATCH 00/39] android: HF Client initial implementation
> but on Luiz request I split it into smaller sets.
>
> Lukasz Rymanowski (4):
>   android/hal-ipc-api: Use 2 bytes for location in dial memory
>   android/hal-ipc-api: Use Tone instead of Code DTMF
>   android/hal-ipc-api: Add missing peer features parameter
>   android/hal-ipc-api: Fix define for HF-Client
>
>  android/hal-ipc-api.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> --
> 1.8.4

First thanks for flooding my inbox, and second congrats for sending
almost 60 emails to the list in one day.


-- 
Luiz Augusto von Dentz
