Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
References: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Sep 2017 16:04:02 +0300
Message-ID: <CABBYNZJrvFOMti3v7RX6HoOeKvQON3KbYEzEZBAAS+NW47=eQQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/6] Improve around advertise of bluetoothctl
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Sep 25, 2017 at 7:21 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> This patch set fixes bugs of advertising.c and refactors
> advertise-related code.
>
> Changes since v1:
>  - Merge 5th and 6th patches into a new patch
>
> ERAMOTO Masaya (5):
>   client: Fix memory leak of advertise command
>   client: Fix core dump when using set-advertise-name
>   client: Prevent to pass invalid ad type to D-Bus
>   client: Use existing function for parsing argument
>   client: Use new parse_argument() instead of parse_argument_XX()
>
>  client/advertising.c |  14 +++++--
>  client/main.c        | 107 ++++++++++++---------------------------------------
>  2 files changed, 35 insertions(+), 86 deletions(-)
>
> --
> 2.7.4

Applied, thanks.

Note that Ive changed it a little bit since I did push a patch
removing the const char * const construct. Also this consolidation of
parsing might actually be better put into an argument struct to be
part of the command table e.g.:

struct bt_shell_arg {
   const char **options;
   bool required;
};

The options array can be used for both parsing and auto complete that
way we can have a function that parses them before the actual callback
of cmd_table, though I think this should go directly to bt_shell so
every tool would have the same logic.

-- 
Luiz Augusto von Dentz
