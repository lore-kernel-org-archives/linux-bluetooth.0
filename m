Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416613119-1842-1-git-send-email-armansito@chromium.org>
References: <1416613119-1842-1-git-send-email-armansito@chromium.org>
Date: Mon, 24 Nov 2014 20:22:24 +0200
Message-ID: <CABBYNZ+xEBD2z3yFX3qatVxLcshPuq5LSUefk168m9=H245NPg@mail.gmail.com>
Subject: Re: [PATCH Bluez v2 0/2] unit/test-gatt: Add initial server role tests.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Sat, Nov 22, 2014 at 1:38 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set adds the "Server Configuration" and "Discover All Primary
> Services" test cases using bt_gatt_server.
>
> *v1: - Removed COEX test type for now.
>      - Added macro for the first incoming "Exchange MTU" request PDU for
>        server tests.
>
> *v2: Fix compile warning.
>
> Arman Uguray (2):
>   unit/test-gatt: Add /TP/GAC/SR/BV-01-C test case.
>   unit/test-gatt: Add /TP/GAD/SR/BV-01-C test case.
>
>  unit/test-gatt.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> --
> 2.1.0.rc2.206.gedb03e5

I would have applied the changes but we are also quoting the test
specification in the patch description, so lets keep it consistent for
the server tests as well.


-- 
Luiz Augusto von Dentz
