Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418222823-13749-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418222823-13749-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 16 Dec 2014 12:09:18 +0100
Message-ID: <CAMudyAt6B160AnsRDWV05Aqexj0H1kWYScjFC0+15rzUEi+j+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] android/bluetooth: Enable privacy mode on starup
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 10 December 2014 at 15:46, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> This set add support for privacy mode in BfA.
> This is in order to follow Android Lollipop
>
> v2: Typo fix (important one) in patch 3/4.
>
> Lukasz Rymanowski (4):
>   android/bluetooth: Start keep IRK for adapter
>   android/bluetooth: Store IRK when storing adapter config
>   android/bluetooth: Load IRK on adapter start
>   android/bluetooth: Enable LE privacy mode on BfA startup
>

ping

>  android/bluetooth.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> --
> 1.8.4
>
