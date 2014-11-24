Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416859553-11027-1-git-send-email-armansito@chromium.org>
References: <1416859553-11027-1-git-send-email-armansito@chromium.org>
Date: Mon, 24 Nov 2014 22:57:05 +0200
Message-ID: <CABBYNZ+osKB3Muyq8=H9s3jm7yNrx4L-7JLUYBgQU4E6EAp_CA@mail.gmail.com>
Subject: Re: [PATCH Bluez v3 0/2] unit/test-gatt: Add initial server role tests.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Nov 24, 2014 at 10:05 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set adds the "Server Configuration" and "Discover All Primary
> Services" test cases using bt_gatt_server.
>
> *v1: - Removed COEX test type for now.
>      - Added macro for the first incoming "Exchange MTU" request PDU for
>        server tests.
>
> *v2: Fixed compile warning.
>
> *v3: Added test case description from the TS to the commit messages.
>
> Arman Uguray (2):
>   unit/test-gatt: Add /TP/GAC/SR/BV-01-C test
>   unit/test-gatt: Add /TP/GAD/SR/BV-01-C test
>
>  unit/test-gatt.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> --
> 2.1.0.rc2.206.gedb03e5

Applied, thanks.


-- 
Luiz Augusto von Dentz
