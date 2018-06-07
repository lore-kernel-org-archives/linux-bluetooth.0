Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOvzQrvFQO_RM6M==T27PW=WLE1sXjF2jKn1ihhbRu7gTMZwKg@mail.gmail.com>
References: <CAOvzQrvFQO_RM6M==T27PW=WLE1sXjF2jKn1ihhbRu7gTMZwKg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Jun 2018 10:42:45 +0300
Message-ID: <CABBYNZKSn6YwLifxDh4UeoWWPiFu2kBKo-roZjYg8DmytvvMUA@mail.gmail.com>
Subject: Re: Codec support other than Bluez
To: Gladwin Simendy <gladwinsimendy@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gladwin,

On Thu, Jun 7, 2018 at 10:25 AM, Gladwin Simendy
<gladwinsimendy@gmail.com> wrote:
> Hi,
>
> I have been checking the Bluez source for using APTx codec with phone.
> But after making connection with Bluez, I can find only SBC codec in
> get capabilities and APTx is not found.
>
> Is there anything which I need to enable or change the default SBC
> before using APTx codec for Bluez?

You would have to register an endpoint with APTx support, it seems
that it is available via libavcodec nowadays so we could perhaps
enable it in PulseAudio at some point.

-- 
Luiz Augusto von Dentz
