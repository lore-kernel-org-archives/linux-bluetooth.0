Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430782094-18396-1-git-send-email-armansito@chromium.org>
References: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Date: Tue, 5 May 2015 15:22:56 +0300
Message-ID: <CABBYNZKvtC7mpo7-XyjFKJtyyYM7TO+CcC2SO-18gzKjKOu5_Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix clang compile errors/warnings
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, May 5, 2015 at 2:28 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set fixes some clang compile errors and warnings. These do
> not cover errors that are produced when BlueZ for Android is compiled
> using clang (i.e. passing --disable-android to ./bootstrap-configure).
>
> Arman Uguray (4):
>   plugins/policy: Fix clang compile error
>   tools/smp-tester: Remove unused variable.
>   tools/mgmt-tester: Remove unused set_adv_data_2
>   tools/gatt-service: Fix clang compile error
>
>  plugins/policy.c     |  8 ++++----
>  tools/gatt-service.c |  4 +---
>  tools/mgmt-tester.c  | 46 +++++++++++++++++++---------------------------
>  tools/smp-tester.c   |  9 ---------
>  4 files changed, 24 insertions(+), 43 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
