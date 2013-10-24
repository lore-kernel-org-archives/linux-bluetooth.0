Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 24 Oct 2013 10:28:17 +0300
Message-ID: <CABBYNZ+hv90YH3=1jXtbvj88chX0w5-cNOK9XG8vrBqz7EMziQ@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Enable av interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 24, 2013 at 10:10 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> For some reason get av interface was missing from hal-bluetooth and from
> hal test tool.
>
> PS: Not sure that haltest is fully implemented, Jerzy please comment here.
>
> Andrei Emeltchenko (2):
>   android: haltest: Enable av interface in test tool
>   android: Enable AV interface
>
>  android/client/if-bt.c  |    2 +-
>  android/hal-bluetooth.c |    3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> --
> 1.7.10.4

Pushed, thanks.


-- 
Luiz Augusto von Dentz
